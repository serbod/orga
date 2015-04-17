unit ContactsFrame;

interface

uses
  SysUtils, Controls, Forms, ExtCtrls, ComCtrls, StdCtrls, ValEdit,
  Classes, Grids, ToolWin, ContactsUnit, Menus, MiscFunc, Windows;

type
  TFrameContacts = class(TFrame)
    toolbarContacts: TToolBar;
    tbRefreshList: TToolButton;
    tbLoadList: TToolButton;
    tbSaveList: TToolButton;
    panRight: TPanel;
    gbContactMain: TGroupBox;
    gbContactExtra: TGroupBox;
    tvContacts: TTreeView;
    Splitter8: TSplitter;
    vledExtraData: TValueListEditor;
    lbContData1: TLabel;
    edContData1: TEdit;
    lbContData2: TLabel;
    edContData2: TEdit;
    lbContData3: TLabel;
    edContData3: TEdit;
    cmboxContType: TComboBox;
    lbContType: TLabel;
    lbName: TLabel;
    edName: TEdit;
    ToolButton1: TToolButton;
    tbAddItem: TToolButton;
    tbDelItem: TToolButton;
    pmContListPopup: TPopupMenu;
    mAddItem: TMenuItem;
    mAddSubItem: TMenuItem;
    mDiv1: TMenuItem;
    mDelItem: TMenuItem;
    tbSaveItem: TToolButton;
    N1: TMenuItem;
    mExpandAll: TMenuItem;
    mCollapseAll: TMenuItem;
    mExpandSel: TMenuItem;
    tbEditList: TToolButton;
    pmTablesMenu: TPopupMenu;
    mContactsTable: TMenuItem;
    mContDataTable: TMenuItem;
    mContDataTypeTable: TMenuItem;
    procedure cmboxContTypeChange(Sender: TObject);
    procedure toolbarContactsClick(Sender: TObject);
    procedure ContListPopupClick(Sender: TObject);
    procedure tvContactsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvContactsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvContactsChange(Sender: TObject; Node: TTreeNode);
    procedure TablesMenuClick(Sender: TObject);
  private
    { Private declarations }
    ItemsList: TContactsList;
    SelectedItem: TContactItem;
    procedure ReadSelectedItem();
    procedure WriteSelectedItem();
    procedure RefreshItemsList(SelectedOnly: boolean = false);
    procedure NewItem(ASubItem: boolean = false);
    procedure DelSelectedItem();
    procedure LoadList();
    procedure SaveList();
    procedure ChangeContType(NewType: integer = -1);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation
uses Main, MainFunc, DbUnit;
{$R *.dfm}

//===========================================
constructor TFrameContacts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align:=alClient;
  if not Assigned(ItemsList) then ItemsList:=TContactsList.Create();
  //ItemsList.FileName:=glBasePath+'\Contacts.lst';
  self.LoadList();
end;

destructor TFrameContacts.Destroy();
begin
  ItemsList.Free();
  inherited Destroy();
end;

//===========================================
// List operations
//===========================================
procedure TFrameContacts.RefreshItemsList(SelectedOnly: boolean = false);
var
  Item: TContactItem;
  tn, ptn: TTreeNode;
  i: integer;

function GetTreeNodeByID(ItemID: integer): TTreeNode;
var
  n: integer;
begin
  result:=nil;
  if ItemID < 0 then Exit;
  for n:=0 to tvContacts.Items.Count-1 do
  begin
    if TContactItem(tvContacts.Items[n].Data).ID = ItemID then
    begin
      result:=tvContacts.Items[n];
      Exit;
    end;
  end;
end;

begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedItem) then Exit;
    for i:=0 to tvContacts.Items.Count-1 do
    begin
      Item:=TContactItem(tvContacts.Items[i].Data);
      if Item=SelectedItem then
      begin
        tn:=tvContacts.Items[i];
        tn.Text:=Item.Name;
        Exit;
      end;
    end;
    Exit;
  end;

  tvContacts.Items.BeginUpdate();
  tvContacts.Items.Clear();
  ItemsList.Sort();
  for i:=0 to ItemsList.Count-1 do
  begin
    Item:=TContactItem(ItemsList[i]);
    tn:=tvContacts.Items.AddChild(GetTreeNodeByID(Item.ParentID), Item.Name);
    tn.Data:=Item;
    if Item=SelectedItem then
    begin
      tn.Selected:=true;
      tn.Focused:=true;
    end;
  end;
  tvContacts.Items.EndUpdate();
end;

procedure TFrameContacts.LoadList();
begin
  tvContacts.Items.Clear();
  SelectedItem:=nil;
  ItemsList.Clear();
  ItemsList.LoadList();
  RefreshItemsList();
end;

procedure TFrameContacts.SaveList();
begin
  ItemsList.SaveList();
end;

procedure TFrameContacts.NewItem(ASubItem: boolean = false);
var
  Item: TContactItem;
  tn: TTreeNode;
  i: integer;
begin
  Item:=TContactItem.Create();
  Item.ParentID:=-1;
  Item.Name:='Новый контакт';
  Item.ContType:=1;
  Item.Author:=conf['UserName'];
  Item.Timestamp:=Now();
  Item.DataList:=TContDataList.Create();
  self.ItemsList.AddItem(Item);
  Item.DataList.OwnerID:=Item.ID;

  if ASubItem then
  begin
    tn:=tvContacts.Items.AddChild(tvContacts.Selected, Item.Name);
    if Assigned(tvContacts.Selected) and Assigned(tvContacts.Selected.Data) then
    begin
      Item.ParentID:=TContactItem(tvContacts.Selected.Data).ID;
    end;
  end
  else
  begin
    tn:=tvContacts.Items.Add(tvContacts.Selected, Item.Name);
  end;
  tn.Data:=Item;
  Item.TreeLevel:=tn.Level;

  self.SelectedItem:=Item;
  ReadSelectedItem();
end;

procedure TFrameContacts.DelSelectedItem();
begin
  //
  if ItemsList.ItemChildCount(SelectedItem)>0 then
  begin
    if Application.MessageBox(PChar('Удалить все подчиненные элементы?'), PChar('Предупреждение'), MB_YESNO) = IDNO	then Exit;
    Application.MessageBox(PChar('А вот хрен!'), PChar('Предупреждение'), MB_OK);
    Exit;
  end;
  ItemsList.Remove(SelectedItem);
  tvContacts.Items.Delete(tvContacts.Selected);
  //RefreshItemsList();
end;

//----
procedure TFrameContacts.ReadSelectedItem();
var
  Item: TContactItem;
  i: integer;
  DataItem: TContDataItem;
begin
  if not Assigned(self.SelectedItem) then Exit;
  Item:=self.SelectedItem;
  if not Assigned(Item.DataList) then Exit;

  edName.Text:=Item.Name;
  edContData1.Text:='';
  edContData2.Text:='';
  edContData3.Text:='';
  ChangeContType(Item.ContType-1);

  //for i:=vledExtraData.RowCount-1 downto 1 do vledExtraData.DeleteRow(i);
  for i:=0 to Item.DataList.Count-1 do
  begin
    DataItem:=(Item.DataList[i] as TContDataItem);
    if lbContData1.Caption=DataItem.Name then edContData1.Text:=DataItem.Text
    else if lbContData2.Caption=DataItem.Name then edContData2.Text:=DataItem.Text
    else if lbContData3.Caption=DataItem.Name then edContData3.Text:=DataItem.Text
    else
    begin
      vledExtraData.Values[DataItem.Name]:=DataItem.Text;
    end;
  end;
end;

//----
procedure TFrameContacts.WriteSelectedItem();
var
  Item: TContactItem;
  i: integer;

begin
  if not Assigned(self.SelectedItem) then Exit;
  Item:=self.SelectedItem;
  Item.ContType:=cmboxContType.ItemIndex+1;
  Item.Name:=edName.Text;

  if not Assigned(Item.DataList) then Exit;
  Item.DataList.UpdateItem(lbContData1.Caption, edContData1.Text);
  Item.DataList.UpdateItem(lbContData2.Caption, edContData2.Text);
  Item.DataList.UpdateItem(lbContData3.Caption, edContData3.Text);

  for i:=0 to vledExtraData.Strings.Count-1 do
  begin
    Item.DataList.UpdateItem(vledExtraData.Strings.Names[i], vledExtraData.Strings.ValueFromIndex[i]);
  end;
  RefreshItemsList(true);
end;

procedure TFrameContacts.ChangeContType(NewType: integer = -1);
var
  i, n: integer;
  Item: TDbItem;
begin
  if NewType<>-1 then
    cmboxContType.ItemIndex:=NewType
  else
    NewType:=cmboxContType.ItemIndex;

  if NewType = -1 then Exit;

  lbContData1.Caption:='';
  lbContData2.Caption:='';
  lbContData3.Caption:='';
  //if vledExtraData.RowCount>1 then
  //  for i:=vledExtraData.RowCount-1 downto 1 do vledExtraData.DeleteRow(i);
  vledExtraData.Strings.Clear();
  n:=0;
  for i:=0 to glContactDataTypes.Count-1 do
  begin
    Item:=glContactDataTypes.GetItemByIndex(i);
    if Item.GetInteger('cont_type')<>NewType+1 then Continue;
    if n=0 then lbContData1.Caption:=Item.Name
    else if n=1 then lbContData2.Caption:=Item.Name
    else if n=2 then lbContData3.Caption:=Item.Name
    else
    begin
      vledExtraData.InsertRow(Item.Name, '', true);
    end;
    Inc(n);
  end;
  edContData1.Visible:=(Length(lbContData1.Caption)>0);
  edContData2.Visible:=(Length(lbContData2.Caption)>0);
  edContData3.Visible:=(Length(lbContData3.Caption)>0);
end;

//===========================================
// Action handlers
//===========================================

procedure TFrameContacts.cmboxContTypeChange(Sender: TObject);
begin
  ChangeContType();
end;

procedure TFrameContacts.toolbarContactsClick(Sender: TObject);
begin
  if Sender=tbLoadList then
  begin
    self.LoadList();
  end
  else if Sender=tbSaveList then
  begin
    self.SaveList();
  end
  else if Sender=tbRefreshList then
  begin
    self.RefreshItemsList();
  end
  else if Sender=tbAddItem then // Add
  begin
    self.NewItem();
  end
  else if Sender=tbDelItem then // Del
  begin
    DelSelectedItem();
  end
  else if Sender=tbSaveItem then // Write selected item
  begin
    self.WriteSelectedItem();
  end
  else if Sender=tbEditList then // Edit items list
  begin
    //MainFunc.OpenTableEdit(self.SelectedItem.DataList);
    //MainFunc.OpenTableEdit(self.ItemsList);
  end;

end;

procedure TFrameContacts.ContListPopupClick(Sender: TObject);
begin
  tvContacts.Items.BeginUpdate();
  if Sender=mAddItem then
  begin
    self.NewItem();
  end
  else if Sender=mAddSubItem then
  begin
    self.NewItem(true);
  end
  else if Sender=mDelItem then
  begin
    DelSelectedItem();
  end
  else if Sender=mExpandSel then
  begin
    if not Assigned(tvContacts.Selected) then Exit;
    tvContacts.Selected.Expand(true);
  end
  else if Sender=mExpandAll then
  begin
    tvContacts.FullExpand();
  end
  else if Sender=mCollapseAll then
  begin
    tvContacts.FullCollapse();
  end;
  tvContacts.Items.EndUpdate();
end;

function CanDrop(dst, src: TObject; X, Y: integer): boolean;
var
  dst_node: TTreeNode;
begin
  result:=false;
  if (src is TTreeView) and (dst is TTreeView) then
  begin
    dst_node:=((dst as TTreeView).GetNodeAt(X, Y) as TTreeNode);
    //if dst_node = nil then Exit;
    //if not dst_node.IsGroup then Exit;
    result:=true;
  end;
end;

procedure TFrameContacts.tvContactsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := CanDrop(Sender, Source, X, Y);
end;

procedure TFrameContacts.tvContactsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DragNode: TTreeNode;
  dst_node: TTreeNode;
begin
  if CanDrop(Sender, Source, X, Y) then
  begin
    DragNode:=(Source as TTreeView).Selected;
    if not Assigned(DragNode) then Exit;
    dst_node:=(Sender as TTreeView).GetNodeAt(X,Y);
    if dst_node = nil then
      DragNode.MoveTo(nil, naAdd)
    else if ShiftPressed() then
      DragNode.MoveTo(dst_node, naAddChild)
    else
      DragNode.MoveTo(dst_node, naAdd);
    if Assigned(DragNode.Data) then
      TContactItem(DragNode.Data).TreeLevel:=DragNode.Level;
  end;
end;

procedure TFrameContacts.tvContactsChange(Sender: TObject;
  Node: TTreeNode);
begin
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then Exit;
  if SelectedItem = TContactItem(Node.Data) then Exit;
  WriteSelectedItem();
  SelectedItem:=TContactItem(Node.Data);
  ReadSelectedItem();
end;

procedure TFrameContacts.TablesMenuClick(Sender: TObject);
begin
  if Sender = mContactsTable then
  begin
    MainFunc.OpenTableEdit(self.ItemsList);
  end
  else if Sender = mContDataTable then
  begin
    MainFunc.OpenTableEdit(self.SelectedItem.DataList);
  end
  else if Sender = mContDataTypeTable then
  begin
    MainFunc.OpenTableEdit(glContactDataTypes);
  end;
end;

end.
