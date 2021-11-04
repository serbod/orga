unit MsgBoardFrame;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ToolWin, MsgBoardUnit,
  TextEditorFrame;

type
  TFrameMsgBoard = class(TFrame)
    toolbarMsgBoard: TToolBar;
    tbRefresh: TToolButton;
    tbLoad: TToolButton;
    panRight: TPanel;
    panTop: TPanel;
    Splitter4: TSplitter;
    tvMsgBoardList: TTreeView;
    panLeft: TPanel;
    panItemInfo: TPanel;
    lbAuthorName: TLabel;
    lbAuthorText: TLabel;
    tbSave: TToolButton;
    ToolButton1: TToolButton;
    tbAdd: TToolButton;
    tbDel: TToolButton;
    TextEditor: TFrameTextEditor;
    //procedure tbFontStyleClick(Sender: TObject);
    procedure tvMsgBoardListChange(Sender: TObject; Node: TTreeNode);
    procedure tbMsgBoardClick(Sender: TObject);
  private
    { Private declarations }
    MsgBoardList: TMsgBoardList;
    SelectedMBItem: TMsgBoardItem;
    procedure ReadSelectedItem();
    procedure WriteSelectedItem();
    procedure RefreshItemsList(SelectedOnly: boolean = false);
    procedure NewItem();
    procedure LoadList();
    procedure SaveList();
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation

uses Main, MainFunc;

{$R *.dfm}

//===========================================
constructor TFrameMsgBoard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align:=alClient;
  if not Assigned(MsgBoardList) then MsgBoardList:=TMsgBoardList.Create();
  MsgBoardList.FileName:=conf['BasePath']+'Msg_Board.lst';
  self.LoadList();
end;

destructor TFrameMsgBoard.Destroy();
begin
  MsgBoardList.Free();
  inherited Destroy();
end;

//===========================================
// List operations
//===========================================
procedure TFrameMsgBoard.RefreshItemsList(SelectedOnly: boolean = false);
var
  MBItem: TMsgBoardItem;
  tn: TTreeNode;
  i: integer;
begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedMBItem) then Exit;
    for i:=0 to tvMsgBoardList.Items.Count-1 do
    begin
      MBItem:=TMsgBoardItem(tvMsgBoardList.Items[i].Data);
      if MBItem=SelectedMBItem then
      begin
        tn:=tvMsgBoardList.Items[i];
        tn.Text:=MBItem.Desc;
        Exit;
      end;
    end;
    Exit;
  end;

  tvMsgBoardList.Items.Clear();
  MsgBoardList.Sort();
  for i:=0 to MsgBoardList.Count-1 do
  begin
    MBItem:=TMsgBoardItem(MsgBoardList[i]);
    tn:=tvMsgBoardList.Items.Add(nil, MBItem.Desc);
    tn.Data:=MBItem;
    if MBItem=SelectedMBItem then
    begin
      tn.Selected:=true;
      tn.Focused:=true;
    end;
  end;
end;

procedure TFrameMsgBoard.LoadList();
begin
  tvMsgBoardList.Items.Clear();
  SelectedMBItem:=nil;
  MsgBoardList.Clear();
  MsgBoardList.LoadList();
  RefreshItemsList();
end;

procedure TFrameMsgBoard.SaveList();
begin
  MsgBoardList.SaveList();
end;

procedure TFrameMsgBoard.NewItem();
var
  Item: TMsgBoardItem;
  tn: TTreeNode;
  i: integer;
begin
  Item:=TMsgBoardItem.Create();
  Item.Desc:='Новое объявление';
  Item.Priority:=1;
  Item.Author:=conf['UserName'];
  Item.BeginDate:=Now();
  Item.EndDate:=Now();
  self.MsgBoardList.Add(Item);

  tn:=tvMsgBoardList.Items.Add(nil, Item.Desc);
  tn.Data:=Item;

  self.SelectedMBItem:=Item;
  ReadSelectedItem();
end;

procedure TFrameMsgBoard.ReadSelectedItem();
var
  Item: TMsgBoardItem;
  Avail: boolean;
begin
  if not Assigned(self.SelectedMBItem) then Exit;
  Item:=self.SelectedMBItem;

  // Set availability
  Avail:=(conf['UserName']=Item.Author);
  TextEditor.Enabled:=Avail;

  lbAuthorText.Caption:=Item.Author;
  //lbPeriod.Caption:=''+DateTimeToStr(Item.BeginDate)+' - '+DateTimeToStr(Item.EndDate);
  //TextEditor.RawText:=Item.Text;
  TextEditor.LoadFromFile(self.MsgBoardList.FileName+'.data\'+IntToStr(Item.ID)+'.rtf');
end;

procedure TFrameMsgBoard.WriteSelectedItem();
begin
  if not Assigned(self.SelectedMBItem) then Exit;
  //self.SelectedMBItem.Author:=glUserName;
  self.SelectedMBItem.Text:=TextEditor.Lines.Text;
  TextEditor.SaveToFile(self.MsgBoardList.FileName+'.data\'+IntToStr(self.SelectedMBItem.ID)+'.rtf');
  self.SelectedMBItem.Desc:='';
  if TextEditor.Lines.Count>0 then self.SelectedMBItem.Desc:=TextEditor.Lines[0];
  RefreshItemsList(true);
end;

//===========================================
// Text operations
//===========================================
{procedure TFrameMsgBoard.tbFontStyleClick(Sender: TObject);
var
  b: boolean;
begin

  if Sender = tbBold then
  begin
    if fsBold	in reMsgText.SelAttributes.Style then
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style - [fsBold]
    else
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style + [fsBold];
  end

  else if Sender = tbItalic then
  begin
    if fsItalic	in reMsgText.SelAttributes.Style then
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style - [fsItalic]
    else
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style + [fsItalic];
  end

  else if Sender = tbUnderline then
  begin
    if fsUnderline	in reMsgText.SelAttributes.Style then
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style - [fsUnderline]
    else
      reMsgText.SelAttributes.Style := reMsgText.SelAttributes.Style + [fsUnderline];
  end

  else if Sender = tbFont then
  begin
  end

  else if Sender = tbColor then
  begin
  end;
end;}


//===========================================
// Action handlers
//===========================================
procedure TFrameMsgBoard.tvMsgBoardListChange(Sender: TObject;
  Node: TTreeNode);
var
  Item: TMsgBoardItem;
begin
  if not Assigned(Node) then Exit;
  if not Assigned(Node.Data) then Exit;
  Item:=TMsgBoardItem(Node.Data);
  if Item=SelectedMBItem then Exit;
  WriteSelectedItem();
  SelectedMBItem:=Item;
  ReadSelectedItem()
end;

procedure TFrameMsgBoard.tbMsgBoardClick(Sender: TObject);
begin
  if Sender=tbAdd then
  begin
    NewItem();
  end

  else if Sender=tbDel then
  begin
    //NewItem();
  end

  else if Sender=tbRefresh then
  begin
    RefreshItemsList();
  end

  else if Sender=tbLoad then
  begin
    LoadList();
  end

  else if Sender=tbSave then
  begin
    SaveList();
  end;

end;

end.
