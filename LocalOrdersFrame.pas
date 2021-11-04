unit LocalOrdersFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ToolWin, LocalOrdersUnit, Menus,
  ActnList, ImgList, Buttons, System.ImageList, System.Actions;

type
  TFrameLocalOrders = class(TFrame)
    toolbarLocOrders: TToolBar;
    tbLoadList: TToolButton;
    tbSaveList: TToolButton;
    tbApply: TToolButton;
    panRight: TPanel;
    lvOrdersList: TListView;
    Splitter1: TSplitter;
    gbInfo: TGroupBox;
    gbReply: TGroupBox;
    gbText: TGroupBox;
    memoText: TMemo;
    memoReply: TMemo;
    lbFromText: TLabel;
    lbToText: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    gbList: TGroupBox;
    ActionList1: TActionList;
    actNew: TAction;
    actApply: TAction;
    pmLocOrdersList: TPopupMenu;
    actListLoad: TAction;
    actListSave: TAction;
    mNewItem: TMenuItem;
    mApply: TMenuItem;
    btnSelectReply: TButton;
    bbtnSignOn: TBitBtn;
    ilSignOnIcons: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure actNewExecute(Sender: TObject);
    procedure lvOrdersListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btnSignOnClick(Sender: TObject);
  private
    { Private declarations }
    ItemsList: TLocOrderList;
    SelectedItem: TLocOrderItem;
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

const iIconSign: integer = 1;
const iIconUnSign: integer = 0;
const sCaptSign: string = 'Подписать';
const sCaptUnSign: string = 'Отменить';

{$R *.dfm}

//===========================================
constructor TFrameLocalOrders.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align:=alClient;
  if not Assigned(ItemsList) then ItemsList:=TLocOrderList.Create();
  self.LoadList();
end;

destructor TFrameLocalOrders.Destroy();
begin
  ItemsList.Free();
  inherited Destroy();
end;

//===========================================
// List operations
//===========================================
procedure TFrameLocalOrders.RefreshItemsList(SelectedOnly: boolean = false);
var
  Item: TLocOrderItem;
  tn: TListItem;
  i: integer;
begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedItem) then Exit;
    for i:=0 to lvOrdersList.Items.Count-1 do
    begin
      Item:=TLocOrderItem(lvOrdersList.Items[i].Data);
      if Item=SelectedItem then
      begin
        tn:=lvOrdersList.Items[i];
        tn.SubItems.Clear();
        if Item.Signed then tn.Caption:='S' else tn.Caption:='';
        tn.SubItems.Add(Item.From);
        Exit;
      end;
    end;
    Exit;
  end;

  lvOrdersList.Items.Clear();
  ItemsList.Sort();
  for i:=0 to ItemsList.Count-1 do
  begin
    Item:=TLocOrderItem(ItemsList[i]);
    tn:=lvOrdersList.Items.Add();
    //tn.Caption:='';
    if Item.Signed then tn.Caption:='S';
    tn.SubItems.Add(Item.From);
    tn.Data:=Item;
    if Item=SelectedItem then
    begin
      tn.Selected:=true;
      tn.Focused:=true;
    end;
  end;
end;

procedure TFrameLocalOrders.LoadList();
begin
  lvOrdersList.Items.Clear();
  SelectedItem:=nil;
  ItemsList.Clear();
  ItemsList.LoadList();
  RefreshItemsList();
end;

procedure TFrameLocalOrders.SaveList();
begin
  ItemsList.SaveList();
end;

procedure TFrameLocalOrders.NewItem();
var
  Item: TLocOrderItem;
  tn: TListItem;
  i: integer;
begin
  Item:=TLocOrderItem.Create();
  Item.Dest:='кому-то';
  Item.Author:=conf['UserName'];
  Item.Timestamp:=Now();
  self.ItemsList.Add(Item);

  tn:=lvOrdersList.Items.Add();
  tn.Data:=Item;

  self.SelectedItem:=Item;
  ReadSelectedItem();
end;

procedure TFrameLocalOrders.ReadSelectedItem();
var
  Item: TLocOrderItem;
  Avail: boolean;
  i: integer;
  s: string;
  Image: TBitmap;
begin
  if not Assigned(self.SelectedItem) then Exit;
  Item:=self.SelectedItem;

  // Set availability
  Avail:=(conf['UserName']=Item.Author);
  memoText.Enabled:=Avail;
  memoReply.Enabled:=Avail;

  lbFrom.Caption:=Item.From;
  lbTo.Caption:=Item.Dest;
  memoText.Text:=Item.Text;
  memoReply.Text:=Item.Reply;

  if Item.Signed then i:=iIconUnSign else i:=iIconSign;
  if Item.Signed then s:=sCaptUnSign else s:=sCaptSign;
  Image:=bbtnSignOn.Glyph;
  ilSignOnIcons.GetBitmap(i, Image);
  bbtnSignOn.Glyph:=Image;
  bbtnSignOn.Caption:=s;
  //lbPeriod.Caption:=''+DateTimeToStr(Item.BeginDate)+' - '+DateTimeToStr(Item.EndDate);
  //TextEditor.RawText:=Item.Text;
  //TextEditor.LoadFromFile(self.MsgBoardList.FileName+'.data\'+IntToStr(Item.ID)+'.rtf');
end;

procedure TFrameLocalOrders.WriteSelectedItem();
begin
  if not Assigned(self.SelectedItem) then Exit;
  //self.SelectedMBItem.Author:=glUserName;
  self.SelectedItem.Text:=memoText.Text;
  //TextEditor.SaveToFile(self.MsgBoardList.FileName+'.data\'+IntToStr(self.SelectedMBItem.ID)+'.rtf');
  self.SelectedItem.Reply:=memoReply.Text;
  //if TextEditor.Lines.Count>0 then self.SelectedMBItem.Desc:=TextEditor.Lines[0];
  RefreshItemsList(true);
end;

//===========================================
// Action handlers
//===========================================
procedure TFrameLocalOrders.actNewExecute(Sender: TObject);
begin
  if Sender = actNew then
  begin
    self.NewItem();
  end
  else if Sender = actApply then
  begin
    self.WriteSelectedItem();
  end
  else if Sender = actListLoad then
  begin
    self.LoadList();
  end
  else if Sender = actListSave then
  begin
    self.SaveList();
  end;

end;

procedure TFrameLocalOrders.lvOrdersListChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  AItem: TLocOrderItem;
begin
  if not Assigned(Item) then Exit;
  if not Assigned(Item.Data) then Exit;
  AItem:=TLocOrderItem(Item.Data);
  if AItem=SelectedItem then Exit;
  WriteSelectedItem();
  SelectedItem:=AItem;
  ReadSelectedItem()
end;

procedure TFrameLocalOrders.btnSignOnClick(Sender: TObject);
var
  i: integer;
  s: string;
  Image: TBitmap;
begin
  if not Assigned(self.SelectedItem) then Exit;
  if self.SelectedItem.Signed = false then
  begin
    self.SelectedItem.Signed:=true;
    i:=iIconUnSign;
    s:=sCaptUnSign;
  end
  else
  begin
    self.SelectedItem.Signed:=false;
    i:=iIconSign;
    s:=sCaptSign;
  end;
  Image:=bbtnSignOn.Glyph;
  ilSignOnIcons.GetBitmap(i, Image);
  bbtnSignOn.Glyph:=Image;
  bbtnSignOn.Caption:=s;
  WriteSelectedItem();
end;

end.
