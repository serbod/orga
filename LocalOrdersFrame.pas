unit LocalOrdersFrame;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ToolWin, LocalOrdersUnit, Menus,
  ActnList, ImgList, Buttons, System.ImageList, System.Actions,
  DbUnit;

type
  TFrameLocalOrders = class(TFrame)
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
    alLocalOrders: TActionList;
    actNew: TAction;
    actApply: TAction;
    pmLocOrdersList: TPopupMenu;
    actListLoad: TAction;
    actListSave: TAction;
    mNewItem: TMenuItem;
    mApply: TMenuItem;
    btnSelectReply: TButton;
    bbtnSignOn: TBitBtn;
    actSignOn: TAction;
    actSelectAnswer: TAction;
    pmNoteText: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    btnToPerson: TButton;
    procedure actNewExecute(Sender: TObject);
    procedure lvOrdersListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btnSignOnClick(Sender: TObject);
    procedure btnToPersonClick(Sender: TObject);
  private
    { Private declarations }
    ItemsList: TLocOrderList;
    SelectedItem: TLocOrderItem;
    function GetNameOfPersonByID(AID: Integer): string;
    procedure ReadSelectedItem();
    procedure WriteSelectedItem();
    procedure RefreshItemsList(SelectedOnly: Boolean = False);
    procedure NewItem();
    procedure LoadList();
    procedure SaveList();
    procedure OnItemSelectedHandler(Sender: TObject; DbItem: TDbItem);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation

uses Main, MainFunc, EnterpiseControls;

const
  iIconSign: Integer = 16;
  iIconUnSign: Integer = 15;
  sCaptSign: string = 'Подписать';
  sCaptUnSign: string = 'Отменить';

{$R *.dfm}


  // ===========================================
constructor TFrameLocalOrders.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align := alClient;
  if not Assigned(ItemsList) then
    ItemsList := TLocOrderList.Create();
  LoadList();
end;

destructor TFrameLocalOrders.Destroy();
begin
  ItemsList.Free();
  inherited Destroy();
end;

function TFrameLocalOrders.GetNameOfPersonByID(AID: Integer): string;
var
  TmpItem: TDbItem;
  s: string;
begin
  Result := '';
  TmpItem := DbDriver.GetDBItem('personnel~' + IntToStr(AID));
  if Assigned(TmpItem) then
  begin
    Result := TmpItem.Name;
   { // не работает, потому что DbDriver.GetDBItem возвращает нетипизированный TDbItem
    s := (TmpItem as TPersItem).GetDataByName('Должность');
    if s <> '' then
      Result := Result + ' (' + s + ')'; }
    FreeAndNil(TmpItem);
  end;
end;

// ===========================================
// List operations
// ===========================================
procedure TFrameLocalOrders.RefreshItemsList(SelectedOnly: Boolean = False);
begin
  RefreshLocOrdList(lvOrdersList, ItemsList, -1, SelectedItem, SelectedOnly);
end;

procedure TFrameLocalOrders.LoadList();
begin
  lvOrdersList.Items.Clear();
  SelectedItem := nil;
  ItemsList.Clear();
  ItemsList.LoadList();
  //RefreshItemsList();
  RefreshLocOrdList(lvOrdersList, ItemsList, -1, SelectedItem, False);
end;

procedure TFrameLocalOrders.SaveList();
begin
  ItemsList.SaveList();
end;

procedure TFrameLocalOrders.NewItem();
var
  Item: TLocOrderItem;
  tn: TListItem;
begin
  Item := TLocOrderItem.Create();
  //Item.Dest := 'кому-то';
  Item.Author := conf['UserName'];
  Item.Timestamp := Now();
  ItemsList.Add(Item);

  tn := lvOrdersList.Items.Add();
  tn.Data := Item;

  SelectedItem := Item;
  ReadSelectedItem();
end;

procedure TFrameLocalOrders.OnItemSelectedHandler(Sender: TObject;
  DbItem: TDbItem);
begin
  if Assigned(SelectedItem) then
  begin
    SelectedItem.ToPersID := DbItem.ID;
    lbTo.Caption := GetNameOfPersonByID(SelectedItem.ToPersID);
  end;
end;

procedure TFrameLocalOrders.ReadSelectedItem();
var
  Item: TLocOrderItem;
  Avail: Boolean;
  i: Integer;
  s: string;
begin
  if not Assigned(self.SelectedItem) then
    Exit;
  Item := self.SelectedItem;

  // Set availability
  Avail := (conf['UserName'] = Item.Author);
  memoText.Enabled := Avail;
  memoReply.Enabled := Avail;

  lbFrom.Caption := GetNameOfPersonByID(Item.FromPersID);
  lbTo.Caption := GetNameOfPersonByID(Item.ToPersID);
  memoText.Text := Item.Text;
  memoReply.Text := Item.Reply;

  if Item.Signed then
    i := iIconUnSign
  else
    i := iIconSign;
  if Item.Signed then
    s := sCaptUnSign
  else
    s := sCaptSign;
  bbtnSignOn.ImageIndex := i;
  bbtnSignOn.Caption := s;
  // lbPeriod.Caption:=''+DateTimeToStr(Item.BeginDate)+' - '+DateTimeToStr(Item.EndDate);
  // TextEditor.RawText:=Item.Text;
  // TextEditor.LoadFromFile(self.MsgBoardList.FileName+'.data\'+IntToStr(Item.ID)+'.rtf');
end;

procedure TFrameLocalOrders.WriteSelectedItem();
begin
  if not Assigned(self.SelectedItem) then
    Exit;
  // self.SelectedMBItem.Author:=glUserName;
  self.SelectedItem.Text := memoText.Text;
  // TextEditor.SaveToFile(self.MsgBoardList.FileName+'.data\'+IntToStr(self.SelectedMBItem.ID)+'.rtf');
  self.SelectedItem.Reply := memoReply.Text;
  // if TextEditor.Lines.Count>0 then self.SelectedMBItem.Desc:=TextEditor.Lines[0];
  RefreshItemsList(True);
end;

// ===========================================
// Action handlers
// ===========================================
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
  if not Assigned(Item) then
    Exit;
  if not Assigned(Item.Data) then
    Exit;
  AItem := TLocOrderItem(Item.Data);
  if AItem = SelectedItem then
    Exit;
  WriteSelectedItem();
  SelectedItem := AItem;
  ReadSelectedItem()
end;

procedure TFrameLocalOrders.btnSignOnClick(Sender: TObject);
var
  i: Integer;
  s: string;
begin
  if not Assigned(SelectedItem) then
    Exit;
  if SelectedItem.Signed = False then
  begin
    SelectedItem.Signed := True;
    i := iIconUnSign;
    s := sCaptUnSign;
  end
  else
  begin
    SelectedItem.Signed := False;
    i := iIconSign;
    s := sCaptSign;
  end;
  bbtnSignOn.ImageIndex := i;
  bbtnSignOn.Caption := s;
  WriteSelectedItem();
end;

procedure TFrameLocalOrders.btnToPersonClick(Sender: TObject);
begin
  ShowPersListDialog(OnItemSelectedHandler);
end;

end.
