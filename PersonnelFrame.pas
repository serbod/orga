unit PersonnelFrame;

interface

uses
  SysUtils, Forms, StdCtrls, ComCtrls, Grids, ValEdit, Classes, ToolWin, Controls,
  ExtCtrls, PersonnelUnit, TasksUnit, LocalOrdersUnit, Menus, jpeg;

type
  TFramePersonnel = class(TFrame)
    panCentral: TPanel;
    panTop: TPanel;
    Splitter1: TSplitter;
    panBottom: TPanel;
    tvPersonnel: TTreeView;
    lvPersonnel: TListView;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    gbEmployeeInfo: TGroupBox;
    toolbarPersonnel: TToolBar;
    tbRefreshList: TToolButton;
    tbLoadList: TToolButton;
    tbSaveList: TToolButton;
    vledPersInfo: TValueListEditor;
    ToolButton1: TToolButton;
    tbTableEdit: TToolButton;
    ToolButton3: TToolButton;
    pmPersTree: TPopupMenu;
    pmPersList: TPopupMenu;
    mAddGroup: TMenuItem;
    mAddSubGroup: TMenuItem;
    mDelGroup: TMenuItem;
    N1: TMenuItem;
    mExpandSel: TMenuItem;
    mExpandAll: TMenuItem;
    mCollapseAll: TMenuItem;
    mAddItem: TMenuItem;
    mDelItem: TMenuItem;
    mSaveItem: TMenuItem;
    pcPersInfo: TPageControl;
    tsEmpInfo: TTabSheet;
    tsPersTasks: TTabSheet;
    tsPersOrders: TTabSheet;
    gbPersTaskInfo: TGroupBox;
    lvPersTasks: TListView;
    Splitter4: TSplitter;
    memoPersTaskText: TMemo;
    imgPersPhoto: TImage;
    gbEmployeePhoto: TGroupBox;
    pmPersInfo: TPopupMenu;
    mPersInfoPropsList: TMenuItem;
    mPersInfoWrite: TMenuItem;
    N4: TMenuItem;
    mPersInfoSetPhoto: TMenuItem;
    mPersInfoDelPhoto: TMenuItem;
    pmTableSelector: TPopupMenu;
    mTablePers: TMenuItem;
    mTablePersData: TMenuItem;
    mTablePersDataTypes: TMenuItem;
    N6: TMenuItem;
    mTablePersTasks: TMenuItem;
    mTablePersLocalOrders: TMenuItem;
    lvPersLocalOrders: TListView;
    Splitter5: TSplitter;
    gbPersLocalOrdersInfo: TGroupBox;
    memoPersLocalOrderText: TMemo;
    procedure toolbarPersonnelClick(Sender: TObject);
    procedure PersTreePopupClick(Sender: TObject);
    procedure PersListPopupClick(Sender: TObject);
    procedure PersInfoPopupClick(Sender: TObject);
    procedure tvPersonnelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvPersonnelDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvPersonnelChange(Sender: TObject; Node: TTreeNode);
    procedure lvPersonnelChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure tvPersonnelEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure lvPersTasksChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure mTableSelectorClick(Sender: TObject);
    procedure lvPersLocalOrdersSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
    ItemsList: TPersList;
    SelectedItem: TPersItem;
    SelItemTasks: TTaskList;
    SelItemLocalOrders: TLocOrderList;
    SelectedGroup: TPersItem;
    procedure ReadSelectedItem();
    procedure ReadSelectedGroup();
    procedure WriteSelectedItem();
    procedure RefreshItemsList(SelectedOnly: boolean = false);
    procedure RefreshGroupsList(SelectedOnly: boolean = false);
    procedure NewItem(ASubItem: boolean = true);
    procedure NewItemGroup(ASubItem: boolean = false);
    procedure LoadList();
    procedure SaveList();
    procedure ChangeItemType(NewType: integer = -1);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation
uses Main, MainFunc, MiscFunc;
{$R *.dfm}

//===========================================
constructor TFramePersonnel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align:=alClient;
  if not Assigned(ItemsList) then ItemsList:=TPersList.Create();
  ItemsList.FileName:=conf['BasePath']+'\Personnel.lst';
  self.LoadList();
end;

destructor TFramePersonnel.Destroy();
begin
  ItemsList.Free();
  inherited Destroy();
end;

//===========================================
// List operations
//===========================================
procedure TFramePersonnel.RefreshGroupsList(SelectedOnly: boolean = false);
var
  Item: TPersItem;
  tn, ptn: TTreeNode;
  i: integer;

function GetTreeNodeByID(ItemID: integer): TTreeNode;
var
  n: integer;
begin
  result:=nil;
  if ItemID < 0 then Exit;
  for n:=0 to tvPersonnel.Items.Count-1 do
  begin
    if TPersItem(tvPersonnel.Items[n].Data).ID = ItemID then
    begin
      result:=tvPersonnel.Items[n];
      Exit;
    end;
  end;
end;

begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedGroup) then Exit;
    for i:=0 to tvPersonnel.Items.Count-1 do
    begin
      Item:=TPersItem(tvPersonnel.Items[i].Data);
      if Item=SelectedGroup then
      begin
        tn:=tvPersonnel.Items[i];
        tn.Text:=Item.Name;
        Exit;
      end;
    end;
    Exit;
  end;

  tvPersonnel.Items.BeginUpdate();
  tvPersonnel.Items.Clear();
  ItemsList.Sort();
  for i:=0 to ItemsList.Count-1 do
  begin
    Item:=TPersItem(ItemsList[i]);
    if Item.ItemType<>1 then Continue;
    tn:=tvPersonnel.Items.AddChild(GetTreeNodeByID(Item.ParentID), Item.Name);
    tn.Data:=Item;
    if Item=SelectedGroup then
    begin
      tn.Selected:=true;
      tn.Focused:=true;
    end;
  end;
  tvPersonnel.Items.EndUpdate();
end;

procedure TFramePersonnel.RefreshItemsList(SelectedOnly: boolean = false);
var
  Item: TPersItem;
  li: TListItem;
  i: integer;
begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedItem) then Exit;
    for i:=0 to lvPersonnel.Items.Count-1 do
    begin
      Item:=TPersItem(lvPersonnel.Items[i].Data);
      if Item=SelectedItem then
      begin
        li:=lvPersonnel.Items[i];
        li.SubItems.Clear();
        li.Caption:=''; // Activity
        li.SubItems.Add(Item.Name);
        li.SubItems.Add(Item.GetDataByName('Должность'));
        li.SubItems.Add(Item.Text);
        Exit;
      end;
    end;
    Exit;
  end;

  lvPersonnel.Items.BeginUpdate();
  lvPersonnel.Items.Clear();
  //ItemsList.Sort();
  for i:=0 to ItemsList.Count-1 do
  begin
    Item:=TPersItem(ItemsList[i]);
    if Item.ItemType<>0 then Continue;
    if Item.ParentID <> SelectedGroup.ID then Continue;
    if not Assigned(SelectedItem) then SelectedItem:=Item;
    li:=TListItem.Create(lvPersonnel.Items);
    li.Caption:=''; // Activity
    li.SubItems.Add(Item.Name);
    li.SubItems.Add(Item.GetDataByName('Должность'));
    li.SubItems.Add(Item.Text);
    li.Data:=Item;
    lvPersonnel.Items.AddItem(li);
    if Item=SelectedItem then
    begin
      li.Selected:=true;
      li.Focused:=true;
    end;
  end;
  lvPersonnel.Items.EndUpdate();
end;

procedure TFramePersonnel.LoadList();
begin
  tvPersonnel.Items.Clear();
  lvPersonnel.Items.Clear();
  SelectedItem:=nil;
  SelectedGroup:=nil;
  ItemsList.Clear();
  ItemsList.LoadList();
  RefreshGroupsList();
end;

procedure TFramePersonnel.SaveList();
begin
  ItemsList.SaveList();
end;

procedure TFramePersonnel.NewItemGroup(ASubItem: boolean = false);
var
  Item: TPersItem;
  tn: TTreeNode;
  i: integer;
begin
  Item:=TPersItem.Create();
  Item.ParentID:=-1;
  Item.Name:='Новая группа';
  Item.ItemType:=1;  // 0-Item, 1-Group
  Item.Author:=conf['UserName'];
  Item.Timestamp:=Now();
  Item.DataList:=TPersDataList.Create();
  self.ItemsList.AddItem(Item);
  Item.DataList.OwnerID:=Item.ID;

  if ASubItem then
  begin
    tn:=tvPersonnel.Items.AddChild(tvPersonnel.Selected, Item.Name);
    if Assigned(tvPersonnel.Selected) and Assigned(tvPersonnel.Selected.Data) then
    begin
      Item.ParentID:=TPersItem(tvPersonnel.Selected.Data).ID;
    end;
  end
  else
  begin
    tn:=tvPersonnel.Items.Add(tvPersonnel.Selected, Item.Name);
  end;
  tn.Data:=Item;
  Item.TreeLevel:=tn.Level;

  self.SelectedGroup:=Item;
  ReadSelectedGroup();
end;

procedure TFramePersonnel.NewItem(ASubItem: boolean = true);
var
  Item: TPersItem;
  tn: TTreeNode;
  i: integer;
begin
  if not Assigned(SelectedGroup) then Exit;
  Item:=TPersItem.Create();
  Item.ParentID:=-1;
  Item.Name:='Новый сотрудник';
  Item.ItemType:=0;  // 0-Item, 1-Group
  Item.Author:=conf['UserName'];
  Item.Timestamp:=Now();
  Item.DataList:=TPersDataList.Create();
  self.ItemsList.AddItem(Item);
  Item.DataList.OwnerID:=Item.ID;

  if ASubItem then
  begin
    if Assigned(tvPersonnel.Selected) and Assigned(tvPersonnel.Selected.Data) then
    begin
      Item.ParentID:=TPersItem(tvPersonnel.Selected.Data).ID;
      Item.TreeLevel:=tvPersonnel.Selected.Level+1;
    end;
  end
  else
  begin
  end;

  self.SelectedItem:=Item;
  ReadSelectedGroup();
  ReadSelectedItem();
end;

//----
procedure TFramePersonnel.ReadSelectedGroup();
var
  Item, Item2: TPersItem;
  lvItem: TListItem;
  i: integer;
begin
  if not Assigned(self.SelectedGroup) then Exit;
  Item:=self.SelectedGroup;
  if Item.ItemType<>1 then Exit;

  vledPersInfo.Strings.Clear();
  SelectedItem:=nil;
  RefreshItemsList();
  ReadSelectedItem();
end;

//----
procedure TFramePersonnel.ReadSelectedItem();
var
  Item, Item2: TPersItem;
  lvItem: TListItem;
  i: integer;
  DataItem: TPersDataItem;
  PersDataType: TPersDataType;
  TaskItem: TTaskItem;
  LocOrder: TLocOrderItem;
  ImgFileName: string;
begin
  if not Assigned(self.SelectedItem) then Exit;
  Item:=self.SelectedItem;
  if Item.ItemType<>0 then Exit;
  if not Assigned(Item.DataList) then Exit;

  // Fill data types names
  vledPersInfo.Strings.Clear();
  if vledPersInfo.Strings.Count=0 then
  begin
    for i:=0 to glPersonnelDataTypes.Count-1 do
    begin
      PersDataType:=(glPersonnelDataTypes[i] as TPersDataType);
      vledPersInfo.InsertRow(PersDataType.Name, '', true);
      vledPersInfo.ItemProps[PersDataType.Name].KeyDesc:=PersDataType.FullName;
    end;
  end;

  // Fill pes data values
  //for i:=vledExtraData.RowCount-1 downto 1 do vledExtraData.DeleteRow(i);
  for i:=0 to Item.DataList.Count-1 do
  begin
    DataItem:=(Item.DataList[i] as TPersDataItem);
    begin
      vledPersInfo.Values[DataItem.GetName()]:=DataItem.Text;
    end;
  end;

  // Load image
  ImgFileName:=conf['BasePath']+'Personnel.lst.data\'+IntToStr(Item.ID)+'.jpg';
  if FileExists(ImgFileName) then
  begin
    imgPersPhoto.Picture.LoadFromFile(ImgFileName);
    imgPersPhoto.Visible:=true;
  end
  else
  begin
    imgPersPhoto.Visible:=false;
  end;

  // Fill tasks list
  lvPersTasks.Clear();
  memoPersTaskText.Text:='';
  if not Assigned(SelItemTasks) then
  begin
    // !!! переделать
    SelItemTasks:=TTaskList.Create();
  end;
  SelItemTasks.Clear();
  SelItemTasks.SetFilter(1, Item.ID);
  SelItemTasks.Sort();

  for i:=0 to SelItemTasks.Count-1 do
  begin
    TaskItem:=(SelItemTasks[i] as TTaskItem);
    lvItem:=TListItem.Create(lvPersTasks.Items);
    lvItem.Data:=TaskItem;
    lvItem.Caption:=IntToStr(TaskItem.Priority);
    lvItem.SubItems.Add(IntToStr(TaskItem.Status));
    lvItem.SubItems.Add(TaskItem.Name);
    lvPersTasks.Items.AddItem(lvItem);
  end;
  if lvPersTasks.Items.Count>0 then lvPersTasks.ItemIndex:=0;

  // Fill local orders list
  lvPersLocalOrders.Clear();
  memoPersLocalOrderText.Text:='';
  if not Assigned(SelItemLocalOrders) then
  begin
    // !!! переделать
    SelItemLocalOrders:=TLocOrderList.Create();
  end;
  SelItemLocalOrders.Clear();
  SelItemLocalOrders.SetFilter('from='+IntToStr(Item.ID));
  SelItemLocalOrders.Sort();

  for i:=0 to SelItemLocalOrders.Count-1 do
  begin
    //LocOrder: TLocOrderItem
    LocOrder:=(SelItemLocalOrders[i] as TLocOrderItem);
    lvItem:=TListItem.Create(lvPersLocalOrders.Items);
    lvItem.Data:=LocOrder;
    lvItem.Caption:='';
    if LocOrder.Signed then lvItem.Caption:='S';
    lvItem.SubItems.Add(LocOrder.GetValue('Timestamp'));
    lvItem.SubItems.Add(LocOrder.Dest);
    lvItem.SubItems.Add(LocOrder.Text);
    lvPersLocalOrders.Items.AddItem(lvItem);
  end;
  if lvPersLocalOrders.Items.Count>0 then lvPersLocalOrders.ItemIndex:=0;
end;

//----
procedure TFramePersonnel.WriteSelectedItem();
var
  Item: TPersItem;
  i: integer;
  s, sn, s1, s2, s3: string;

begin
  if not Assigned(self.SelectedItem) then Exit;
  Item:=self.SelectedItem;
  //Item.ItemType:=0;
  //Item.Name:=edName.Text;

  if not Assigned(Item.DataList) then Exit;

  for i:=0 to vledPersInfo.Strings.Count-1 do
  begin
    sn:=vledPersInfo.Strings.Names[i];
    s:=vledPersInfo.Strings.ValueFromIndex[i];
    Item.DataList.UpdateItem(sn, s);
    if sn='Фамилия' then s1:=s
    else if sn='Имя' then s2:=s
    else if sn='Отчество' then s3:=s
    else if sn='Примечание' then Item.Text:=s;
  end;
  Item.Name:=s1+' '+s2+' '+s3;
  //Item.Name=s1+' '+Copy(s2, 1, 1)+'.'+Copy(s3,1,1)+'.';
  RefreshItemsList(true);
end;

procedure TFramePersonnel.ChangeItemType(NewType: integer = -1);
var
  i, n: integer;
  Item: TPersDataType;
begin
  if NewType = -1 then Exit;

  //if vledExtraData.RowCount>1 then
  //  for i:=vledExtraData.RowCount-1 downto 1 do vledExtraData.DeleteRow(i);
  vledPersInfo.Strings.Clear();
  n:=0;
  for i:=0 to glPersonnelDataTypes.Count-1 do
  begin
    Item:=glPersonnelDataTypes.GetItemByIndex(i);
    begin
      vledPersInfo.InsertRow(Item.Name, '', true);
    end;
    Inc(n);
  end;
end;

//===========================================
// Action handlers
//===========================================
procedure TFramePersonnel.toolbarPersonnelClick(Sender: TObject);
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
  else if Sender=tbTableEdit then // Add
  begin
    OpenTableEdit(self.ItemsList);
  end
  {else if Sender=tbDelItem then // Del
  begin
    //self.RefreshItemsList();
  end
  else if Sender=tbSaveItem then // Write selected item
  begin
    self.WriteSelectedItem();
  end};

end;

procedure TFramePersonnel.PersTreePopupClick(Sender: TObject);
begin
  tvPersonnel.Items.BeginUpdate();
  if Sender=mAddGroup then
  begin
    self.NewItemGroup();
  end
  else if Sender=mAddSubGroup then
  begin
    self.NewItemGroup(true);
  end
  else if Sender=mDelGroup then
  begin
  end
  else if Sender=mExpandSel then
  begin
    if not Assigned(tvPersonnel.Selected) then Exit;
    tvPersonnel.Selected.Expand(true);
  end
  else if Sender=mExpandAll then
  begin
    tvPersonnel.FullExpand();
  end
  else if Sender=mCollapseAll then
  begin
    tvPersonnel.FullCollapse();
  end;
  tvPersonnel.Items.EndUpdate();
end;

procedure TFramePersonnel.PersListPopupClick(Sender: TObject);
begin
  tvPersonnel.Items.BeginUpdate();
  if Sender=mAddItem then
  begin
    self.NewItem();
  end
  else if Sender=mDelItem then
  begin
  end
  else if Sender=mSaveItem then // Write selected item
  begin
    self.WriteSelectedItem();
  end;
  tvPersonnel.Items.EndUpdate();
end;

procedure TFramePersonnel.PersInfoPopupClick(Sender: TObject);
var
  sFileName: string;
begin
  if Sender=mPersInfoWrite then
  begin
    self.WriteSelectedItem();
  end
  else if Sender=mPersInfoPropsList then
  begin
    OpenTableEdit(glPersonnelDataTypes);
  end
  else if Sender=mPersInfoSetPhoto then //
  begin
    sFileName:=conf['BasePath']+'Personnel.lst.data\'+IntToStr(SelectedItem.ID)+'.jpg';
    sFileName:=SelectFilename(sFileName);
    if sFileName<>'' then
    begin
      CopySingleFile(sFileName, conf['BasePath']+'Personnel.lst.data\'+IntToStr(SelectedItem.ID)+'.jpg');
    end;
  end
  else if Sender=mPersInfoDelPhoto then //
  begin
    sFileName:=conf['BasePath']+'Personnel.lst.data\'+IntToStr(SelectedItem.ID)+'.jpg';
    if FileExists(sFileName) then DeleteFile(sFileName);
  end;
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

procedure TFramePersonnel.tvPersonnelDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := CanDrop(Sender, Source, X, Y);
end;

procedure TFramePersonnel.tvPersonnelDragDrop(Sender, Source: TObject; X,
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
      TPersItem(DragNode.Data).TreeLevel:=DragNode.Level;
  end;
end;

procedure TFramePersonnel.tvPersonnelChange(Sender: TObject;
  Node: TTreeNode);
begin
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then Exit;
  if SelectedGroup = TPersItem(Node.Data) then Exit;
  WriteSelectedItem();
  SelectedGroup:=TPersItem(Node.Data);
  ReadSelectedGroup();
end;

procedure TFramePersonnel.lvPersonnelChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (not Assigned(Item)) or (not Assigned(Item.Data)) then Exit;
  if SelectedItem = TPersItem(Item.Data) then Exit;
  WriteSelectedItem();
  SelectedItem:=TPersItem(Item.Data);
  ReadSelectedItem();
end;

procedure TFramePersonnel.tvPersonnelEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
begin
  if Assigned(Node.Data) then
  begin
    TPersItem(Node.Data).Name:=S;
  end;
end;

procedure TFramePersonnel.lvPersTasksChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  TaskItem: TTaskItem;
begin
  if (not Assigned(Item)) or (not Assigned(Item.Data)) then Exit;
  TaskItem:=TTaskItem(Item.Data);
  memoPersTaskText.Text:=TaskItem.Text;
end;

procedure TFramePersonnel.mTableSelectorClick(Sender: TObject);
begin
  if Sender = mTablePers then OpenTableEdit(self.ItemsList)
  else if Sender = mTablePersDataTypes then OpenTableEdit(glPersonnelDataTypes)
  else if Sender = mTablePersData then OpenTableEdit(self.SelectedItem.DataList)
  else if Sender = mTablePersTasks then OpenTableEdit(self.SelItemTasks)
  else if Sender = mTablePersLocalOrders then OpenTableEdit(self.SelItemLocalOrders);
end;

procedure TFramePersonnel.lvPersLocalOrdersSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  LocOrderItem: TLocOrderItem;
begin
  if (not Assigned(Item)) or (not Assigned(Item.Data)) then Exit;
  LocOrderItem:=TLocOrderItem(Item.Data);
  memoPersLocalOrderText.Text:=LocOrderItem.Text;
end;

end.
