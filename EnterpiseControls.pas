(*
Элементы управления для объектов предприятия (персонал, структура, задачи, итд..)
*)
unit EnterpiseControls;

interface

uses
  SysUtils, Controls, ComCtrls, Forms,
  PersonnelUnit, TasksUnit, LocalOrdersUnit, DbUnit;

function IsIntInArray(AValue: Integer; AArray: array of Integer): Boolean;

function TaskStateToIconIndex(ATask: TTaskItem): Integer;
procedure TaskToListItem(AItem: TTaskItem; li: TListItem);
{ Заполнение визуального списка задач из списка элементов ItemsList }
procedure RefreshTasksList(lvTasks: TListView; ItemsList: TTaskList;
  SelectedGroupID: Integer; SelectedItem: TTaskItem; SelectedOnly: Boolean);

procedure PersonToListItem(AItem: TPersItem; li: TListItem);
{ Заполнение визуального списка персон из списка элементов ItemsList
  SelectedGroupID - элементы фильтруются по данной группе и ее подгруппам
  SelectedOnly - обновить только выбраный элемент }
procedure RefreshPersonItemsList(lvPersonnel: TListView; ItemsList: TPersList;
  SelectedGroupID: Integer; SelectedItem: TPersItem; SelectedOnly: Boolean = False);
{ Заполнение визуального дерева подразделений из списка элементов ItemsList }
procedure RefreshPersGroupsTree(tvPersonnel: TTreeView; ItemsList: TPersList;
  SelectedGroup: TPersItem; SelectedOnly: Boolean = False);

procedure LocOrdToListItem(AItem: TLocOrderItem; li: TListItem);
{ Заполнение визуального списка записок из списка элементов ItemsList }
procedure RefreshLocOrdList(lv: TListView; ItemsList: TLocOrderList;
  SelectedGroupID: Integer; SelectedItem: TLocOrderItem; SelectedOnly: Boolean);


procedure ShowPersListDialog(ItemSelectedEvent: TItemSelectedEvent);


implementation

uses
  ItemSelectDialog, PersonListFrame;

var
  PersListForm: TFormItemSelect;
  PersListFrame: TFramePersonList;

function IsIntInArray(AValue: Integer; AArray: array of Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(AArray) to High(AArray) do
  begin
    if AValue = AArray[i] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TaskStateToIconIndex(ATask: TTaskItem): Integer;
begin
  // 0-none, 1-normal, 2-urgent, 3-critical, 4-completed, 5-paused
  case ATask.Status of
    1: Result := 7;   // pinned-note-small
    2: Result := 8;   // fire
    3: Result := 9;   // fire-big
    4: Result := 10;  // tick-small
    5: Result := 11;  // pause-small
  else
    Result := -1;
  end;
end;

procedure PersonToListItem(AItem: TPersItem; li: TListItem);
begin
  li.SubItems.Clear();
  li.Data := AItem;
  li.Caption := AItem.Name;
  li.SubItems.Add(AItem.GetDataByName('Должность'));
  li.SubItems.Add(AItem.Text);
end;

procedure TaskToListItem(AItem: TTaskItem; li: TListItem);
begin
  li.SubItems.Clear();
  li.Data := AItem;
  li.StateIndex := TaskStateToIconIndex(AItem);
  li.Caption := AItem.Name;
  li.SubItems.Add(FormatDateTime('DD.MM.YY', AItem.BeginDate));
  li.SubItems.Add(AItem.Author);
end;

procedure RefreshPersonItemsList(lvPersonnel: TListView; ItemsList: TPersList;
  SelectedGroupID: Integer; SelectedItem: TPersItem; SelectedOnly: Boolean);
var
  Item: TPersItem;
  li: TListItem;
  i, ii: Integer;
  SelectedGroupIDArray: array of Integer;
begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedItem) then
      Exit;
    for i := 0 to lvPersonnel.Items.Count - 1 do
    begin
      Item := TPersItem(lvPersonnel.Items[i].Data);
      if Item = SelectedItem then
      begin
        li := lvPersonnel.Items[i];
        PersonToListItem(Item, li);
        Exit;
      end;
    end;
    Exit;
  end;

  // list of selected subgroups
  SelectedGroupIDArray := [SelectedGroupID];
  for i := 0 to ItemsList.Count - 1 do
  begin
    Item := TPersItem(ItemsList[i]);
    if Item.ItemType = TPersItemType.Group then
    begin
      if IsIntInArray(Item.ParentID, SelectedGroupIDArray) then
      begin
        SelectedGroupIDArray := SelectedGroupIDArray + [Item.ID];
      end;
    end;
  end;

  lvPersonnel.Items.BeginUpdate();
  lvPersonnel.Items.Clear();
  // ItemsList.Sort();
  for i := 0 to ItemsList.Count - 1 do
  begin
    Item := TPersItem(ItemsList[i]);
    if Item.ItemType <> TPersItemType.Person then
      Continue;
    if (Item.ParentID <> -1) and not IsIntInArray(Item.ParentID, SelectedGroupIDArray) then
      Continue;
    if not Assigned(SelectedItem) then
      SelectedItem := Item;
    li := lvPersonnel.Items.Add;
    PersonToListItem(Item, li);
    if Item = SelectedItem then
    begin
      li.Selected := True;
      li.Focused := True;
    end;
  end;
  lvPersonnel.Items.EndUpdate();
end;

procedure RefreshPersGroupsTree(tvPersonnel: TTreeView; ItemsList: TPersList;
  SelectedGroup: TPersItem; SelectedOnly: Boolean);
var
  Item: TPersItem;
  tn: TTreeNode;
  i: Integer;

  function GetTreeNodeByID(ItemID: Integer): TTreeNode;
  var
    n: Integer;
  begin
    Result := nil;
    if ItemID < 0 then
      Exit;
    for n := 0 to tvPersonnel.Items.Count - 1 do
    begin
      if TPersItem(tvPersonnel.Items[n].Data).ID = ItemID then
      begin
        Result := tvPersonnel.Items[n];
        Exit;
      end;
    end;
  end;

begin
  if SelectedOnly then
  begin
    if not Assigned(SelectedGroup) then
      Exit;
    for i := 0 to tvPersonnel.Items.Count - 1 do
    begin
      Item := TPersItem(tvPersonnel.Items[i].Data);
      if Item = SelectedGroup then
      begin
        tn := tvPersonnel.Items[i];
        tn.Text := Item.Name;
        Exit;
      end;
    end;
    Exit;
  end;

  tvPersonnel.Items.BeginUpdate();
  tvPersonnel.Items.Clear();
  ItemsList.Sort();
  for i := 0 to ItemsList.Count - 1 do
  begin
    Item := TPersItem(ItemsList[i]);
    if Item.ItemType <> TPersItemType.Group then
      Continue;
    tn := tvPersonnel.Items.AddChild(GetTreeNodeByID(Item.ParentID), Item.Name);
    tn.Data := Item;
    if Item = SelectedGroup then
    begin
      tn.Selected := True;
      tn.Focused := True;
    end;
  end;
  tvPersonnel.Items.EndUpdate();
end;

procedure RefreshTasksList(lvTasks: TListView; ItemsList: TTaskList;
  SelectedGroupID: Integer; SelectedItem: TTaskItem; SelectedOnly: Boolean);
var
  Task: TTaskItem;
  li: TListItem;
  i: Integer;
  //SelectedGroupIDArray: array of Integer;
begin
  if SelectedOnly then
  begin
    for i:=0 to ItemsList.Count-1 do
    begin
      Task := TTaskItem(ItemsList[i]);
      if Task = SelectedItem then
      begin
        li := lvTasks.Items[i];
        li.SubItems.Clear();
        TaskToListItem(Task, li);
        Exit;
      end;
    end;
    Exit;
  end;

  lvTasks.Clear();
  ItemsList.Sort();
  for i := 0 to ItemsList.Count-1 do
  begin
    Task := TTaskItem(ItemsList[i]);

    if (SelectedGroupID <> -1) and (Task.DepartID <> SelectedGroupID) then
      Continue;

    li := lvTasks.Items.Add();
    TaskToListItem(Task, li);
    if not Assigned(SelectedItem) then
      SelectedItem := Task;
    if Task = SelectedItem then
    begin
      li.Selected := True;
      li.Focused := True;
    end;
  end;
end;

procedure LocOrdToListItem(AItem: TLocOrderItem; li: TListItem);
begin
  li.SubItems.Clear();
  li.Data := AItem;
  if AItem.Signed then
  begin
    li.ImageIndex := 16; // tick-circle
    li.Caption := 'S';
  end
  else
  begin
    li.ImageIndex := 15; // question-white
    li.Caption := '';
  end;
  li.SubItems.Add(AItem.GetValue('timestamp'));
  li.SubItems.Add(AItem.Author);
  li.SubItems.Add(AItem.Text);
end;

procedure RefreshLocOrdList(lv: TListView; ItemsList: TLocOrderList;
  SelectedGroupID: Integer; SelectedItem: TLocOrderItem; SelectedOnly: Boolean);
var
  LocOrder: TLocOrderItem;
  li: TListItem;
  i: Integer;
  //SelectedGroupIDArray: array of Integer;
begin
  if SelectedOnly then
  begin
    for i:=0 to ItemsList.Count-1 do
    begin
      LocOrder := ItemsList[i] as TLocOrderItem;
      if LocOrder = SelectedItem then
      begin
        li := lv.Items[i];
        LocOrdToListItem(LocOrder, li);
        Exit;
      end;
    end;
    Exit;
  end;

  lv.Clear();
  ItemsList.Sort();
  for i := 0 to ItemsList.Count-1 do
  begin
    LocOrder := ItemsList[i] as TLocOrderItem;

    {if (SelectedGroupID <> -1) and (LocOrder.DepartID <> SelectedGroupID) then
      Continue; }

    li := lv.Items.Add();
    LocOrdToListItem(LocOrder, li);
    if not Assigned(SelectedItem) then
      SelectedItem := LocOrder;
    if LocOrder = SelectedItem then
    begin
      li.Selected := True;
      li.Focused := True;
    end;
  end;
end;


procedure ShowPersListDialog(ItemSelectedEvent: TItemSelectedEvent);
begin
  if not Assigned(PersListForm) then
  begin
    PersListForm := TFormItemSelect.Create(Application.MainForm);
    PersListFrame := TFramePersonList.Create(PersListForm);
    //PersListForm.Width := PersListFrame.Width;
    //PersListForm.Height := PersListFrame.Height;
    PersListFrame.Parent := PersListForm;
    PersListFrame.Align := alClient;
  end;
  PersListFrame.OnItemSelected := PersListForm.OnItemSelectedHandler;
  PersListFrame.ItemsList.Clear();
  PersListFrame.ItemsList.LoadList();
  PersListFrame.RefreshList();
  PersListForm.OnItemSelected := ItemSelectedEvent;
  PersListForm.Show();
end;

initialization
  PersListForm := nil;
  PersListFrame := nil;
end.
