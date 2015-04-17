unit MailboxFrame;

interface

uses
  SysUtils, Classes, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, ToolWin, MailUnit;

type
  TFrameMailbox = class(TFrame)
    toolbarMailbox: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    panLeft: TPanel;
    panRight: TPanel;
    Splitter1: TSplitter;
    tvMsgGroups: TTreeView;
    Splitter2: TSplitter;
    lvMessages: TListView;
    toolbarMsg: TToolBar;
    tbNewMsg: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    richedMsgText: TRichEdit;
    panMailHeader: TPanel;
    lbFromLabel: TLabel;
    lbTopicLabel: TLabel;
    lbFromText: TLabel;
    lbTopicText: TLabel;
    procedure tvMsgGroupsChange(Sender: TObject; Node: TTreeNode);
    procedure lvMessagesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
    //IsLoaded: boolean;
    GroupsList: TMailGroupsList;
    SelectedMMsgList: TMailMsgList;
    SelectedMMsg: TMailMsg;
    procedure ReadMaildir();
    procedure RefreshMMsgList();
    procedure RefreshMMsg();
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation
uses Main, MainFunc;

// =================================
constructor TFrameMailbox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(GroupsList) then GroupsList:=TMailGroupsList.Create();
  //IsLoaded:=false;
  ReadMaildir();
end;

destructor TFrameMailbox.Destroy();
begin
  GroupsList.Free();
  inherited Destroy();
end;

// =================================
procedure TFrameMailbox.ReadMaildir();
var
  MML: TMailMsgList;
  i: integer;
begin
  SelectedMMsg:=nil;
  SelectedMMsgList:=nil;
  GroupsList.Clear();
  tvMsgGroups.Items.Clear();

  // Inbox
  MML:=TMailMsgList.Create('mail_inbox');
  MML.GroupFullName:='Входящие';
  GroupsList.Add(MML);
  // Outbox
  MML:=TMailMsgList.Create('mail_outbox');
  MML.GroupFullName:='Исходящие';
  GroupsList.Add(MML);
  // Sent
  MML:=TMailMsgList.Create('mail_sent');
  MML.GroupFullName:='Отправленные';
  GroupsList.Add(MML);
  // Drafts
  MML:=TMailMsgList.Create('mail_drafts');
  MML.GroupFullName:='Черновики';
  GroupsList.Add(MML);
  // Trash
  MML:=TMailMsgList.Create('mail_trash');
  MML.GroupFullName:='Удаленные';
  GroupsList.Add(MML);

  for i:=0 to GroupsList.Count-1 do
  begin
    MML:=TMailMsgList(GroupsList[i]);
    with tvMsgGroups.Items.Add(nil, MML.GroupFullName) do
    begin
      Data:=MML;
    end;
    MML.Clear();
    MML.LoadList();
  end;

  tvMsgGroups.Selected:=tvMsgGroups.TopItem;

end;

{$R *.dfm}

procedure TFrameMailbox.tvMsgGroupsChange(Sender: TObject;
  Node: TTreeNode);
begin
  SelectedMMsg:=nil;
  //SelectedMMsgList:=nil;
  if not Assigned(Node.Data) then Exit;
  if (SelectedMMsgList=TMailMsgList(Node.Data))
  or (TMailMsgList(Node.Data)=nil)
  then Exit;
  SelectedMMsgList:=TMailMsgList(Node.Data);
  RefreshMMsgList();
end;

procedure TFrameMailbox.RefreshMMsgList();
var
  MMsg: TMailMsg;
  li: TListItem;
  i: integer;
begin
  if not Assigned(SelectedMMsgList) then Exit;

  lvMessages.Clear();
  SelectedMMsgList.Sort();
  for i:=0 to SelectedMMsgList.Count-1 do
  begin
    MMsg:=TMailMsg(SelectedMMsgList[i]);
    li:=lvMessages.Items.Add();
    li.Data:=MMsg;
    li.Caption:=MMsg.From;
    li.SubItems.Add(MMsg.Subj);
    li.SubItems.Add(DateTimeToStr(MMsg.RecvDate));
    if MMsg=SelectedMMsg then
    begin
      li.Selected:=true;
      li.Focused:=true;
    end;
  end;
end;

procedure TFrameMailbox.RefreshMMsg();
begin
  if not Assigned(SelectedMMsg) then Exit;

  lbFromText.Caption:=SelectedMMsg.From;
  lbTopicText.Caption:=SelectedMMsg.Subj;
  richedMsgText.Text:=SelectedMMsg.Text;
end;

procedure TFrameMailbox.lvMessagesChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if not Assigned(Item.Data) then Exit;
  SelectedMMsg := TMailMsg(Item.Data);
  RefreshMMsg();
end;

end.
