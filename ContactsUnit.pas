unit ContactsUnit;

interface

uses Classes, Contnrs, SysUtils, DbUnit;

type
  // Список видов свойств контактов
  TContDataTypesList = class(TDbItemList)
  public
    constructor Create(); reintroduce;
    procedure UpdateItem(AContType: Integer; AName: string);
    function GetItemByIndex(Index: Integer): TDbItem;
  end;

  // Свойство контакта
  TContDataItem = class(TDbItem)
  public
    OwnerID: Integer;
    // Name: string; // имя свойства
    DataType: Integer;
    Text: string;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  // Список свойств контакта
  TContDataList = class(TDbItemList)
  public
    OwnerID: Integer;
    constructor Create(); reintroduce;
    function NewItem(ASetNewID: Boolean): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    // procedure Sort();
    // function AddItem(AItem: TContactItem): integer;
    procedure UpdateItem(Name, Value: string);
    function GetItemByName(AName: string): TContDataItem;
  end;

  // Контакт
  TContactItem = class(TDbItem)
  public
    ParentID: Integer;
    TreeLevel: Integer; // for sorting
    Desc: string;
    Text: string;
    ContType: Integer;
    Author: string;
    DataList: TContDataList;
    constructor Create();
    destructor Destroy(); override;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  // Список контактов
  TContactsList = class(TDbItemList)
  public
    constructor Create(); reintroduce;
    function NewItem(ASetNewID: Boolean): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    function ItemChildCount(Item: TDbItem): Integer;
  end;

implementation

uses MainFunc;

// ===========================================
// TContDataTypesList
// ===========================================
constructor TContDataTypesList.Create();
var
  ti: TDbTableInfo;
begin
  ti := DbDriver.GetDbTableInfo('cont_data_types');
  if not Assigned(ti) then
  begin
    ti := TDbTableInfo.Create();
    with ti do
    begin
      TableName := 'cont_data_types';
      AddField('id', 'I');
      AddField('cont_type', 'I');
      AddField('name', 'S');
      AddField('full_name', 'S');
    end;
  end;

  inherited Create(ti);
end;

procedure TContDataTypesList.UpdateItem(AContType: Integer; AName: string);
var
  i: Integer;
  Item: TDbItem;
begin
  for i := 0 to Count - 1 do
  begin
    Item := (Items[i] as TDbItem);
    if (Item.GetInteger('cont_type') = AContType)
      and (Item.Name = AName)
    then
      Exit;
  end;
  Item := NewItem(True);
  Item.SetInteger('cont_type', AContType);
  Item.Name := AName;
end;

function TContDataTypesList.GetItemByIndex(Index: Integer): TDbItem;
begin
  if Index < Count then
    Result := (Items[Index] as TDbItem)
  else
    Result := nil;
end;

// ===========================================
// TContactItem
// ===========================================
constructor TContactItem.Create();
begin
  self.DataList := TContDataList.Create();
end;

destructor TContactItem.Destroy();
begin
  FreeAndNil(self.DataList);
end;

function TContactItem.GetValue(const FName: string): string;
begin
  if FName = 'id' then
    Result := IntToStr(self.ID)
  else if FName = 'parent_id' then
    Result := IntToStr(self.ParentID)
  else if FName = 'tree_level' then
    Result := IntToStr(self.TreeLevel)
  else if FName = 'name' then
    Result := self.Name
  else if FName = 'text' then
    Result := self.Text
  else if FName = 'cont_type' then
    Result := IntToStr(self.ContType)
  else if FName = 'author' then
    Result := self.Author
  else if FName = 'timestamp' then
    Result := DateTimeToStr(self.Timestamp)
  else
    Result := '';
end;

procedure TContactItem.SetValue(const FName, FValue: string);
begin
  if FName = 'id' then
    self.ID := StrToIntDef(FValue, 0)
  else if FName = 'parent_id' then
    self.ParentID := StrToIntDef(FValue, 0)
  else if FName = 'tree_level' then
    self.TreeLevel := StrToIntDef(FValue, 0)
  else if FName = 'name' then
    self.Name := FValue
  else if FName = 'text' then
    self.Text := FValue
  else if FName = 'cont_type' then
    self.ContType := StrToIntDef(FValue, 0)
  else if FName = 'author' then
    self.Author := FValue
  else if FName = 'timestamp' then
    self.Timestamp := StrToDateTimeDef(FValue, self.Timestamp);
end;

// ===========================================
// TContDataItem
// ===========================================
function TContDataItem.GetValue(const FName: string): string;
begin
  if FName = 'id' then
    Result := IntToStr(self.ID)
  else if FName = 'owner_id' then
    Result := IntToStr(self.OwnerID)
  else if FName = 'name' then
    Result := self.Name
  else if FName = 'data_type' then
    Result := IntToStr(self.DataType)
  else if FName = 'text' then
    Result := self.Text
  else
    Result := '';
end;

procedure TContDataItem.SetValue(const FName, FValue: string);
begin
  if FName = 'id' then
    self.ID := StrToIntDef(FValue, 0)
  else if FName = 'owner_id' then
    self.OwnerID := StrToIntDef(FValue, 0)
  else if FName = 'name' then
    self.Name := FValue
  else if FName = 'data_type' then
    self.DataType := StrToIntDef(FValue, 0)
  else if FName = 'text' then
    self.Text := FValue;
end;

// ===========================================
// TContDataList
// ===========================================
constructor TContDataList.Create();
var
  ti: TDbTableInfo;
begin
  ti := DbDriver.GetDbTableInfo('contacts_data');
  if not Assigned(ti) then
  begin
    ti := TDbTableInfo.Create();
    with ti do
    begin
      TableName := 'contacts_data';
      AddField('id', 'I');
      AddField('owner_id', 'L:contacts');
      AddField('name', 'S');
      AddField('text', 'S');
      AddField('data_type', 'L:cont_data_types');
    end;
  end;

  inherited Create(ti);
end;

function TContDataList.NewItem(ASetNewID: Boolean): TDbItem;
var
  NewItem: TContDataItem;
begin
  NewItem := TContDataItem.Create();
  self.AddItem(NewItem, ASetNewID);
  Result := NewItem;
end;

procedure TContDataList.LoadList();
begin
  DbDriver.GetTable(self);
end;

procedure TContDataList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function TContDataList.GetItemByName(AName: string): TContDataItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to self.Count - 1 do
  begin
    if (self.Items[i] as TContDataItem).Name = AName then
    begin
      Result := (self.Items[i] as TContDataItem);
      Exit;
    end;
  end;
end;

procedure TContDataList.UpdateItem(Name, Value: string);
var
  DataItem: TContDataItem;
begin
  if Name = '' then
    Exit;
  DataItem := GetItemByName(Name);

  if Value = '' then
  begin
    if Assigned(DataItem) then
      self.Remove(DataItem);
    Exit;
  end;

  if not Assigned(DataItem) then
  begin
    DataItem := TContDataItem.Create();
    DataItem.OwnerID := self.OwnerID;
    DataItem.Name := Name;
    self.Add(DataItem);
  end;
  DataItem.Text := Value;
end;

// ===========================================
// TContactsList
// ===========================================
constructor TContactsList.Create();
var
  ti: TDbTableInfo;
begin
  ti := DbDriver.GetDbTableInfo('contacts');
  if not Assigned(ti) then
  begin
    ti := TDbTableInfo.Create();
    with ti do
    begin
      TableName := 'contacts';
      AddField('id', 'I');
      AddField('parent_id', 'L:contacts');
      AddField('tree_level', 'I');
      AddField('name', 'S');
      AddField('text', 'S');
      AddField('cont_type', 'I');
      AddField('author', 'S');
      AddField('timestamp', 'D');
    end;
  end;

  inherited Create(ti);
end;

function TContactsList.NewItem(ASetNewID: Boolean): TDbItem;
var
  NewItem: TContactItem;
begin
  NewItem := TContactItem.Create();
  AddItem(NewItem, ASetNewID);
  Result := NewItem;
end;

procedure TContactsList.LoadList();
var
  i, n: Integer;
  PrevID: Integer;
  TmpItem: TContactItem;
  TmpDI: TContDataItem;
  AllContData: TContDataList;
begin
  DbDriver.GetTable(self);

  for i := 0 to self.Count - 1 do
  begin
    TmpItem := TContactItem(self.Items[i]);
    TmpItem.DataList.OwnerID := TmpItem.ID;
  end;

  // Add contact data items
  TmpItem := nil;
  PrevID := -1;
  AllContData := TContDataList.Create();
  AllContData.OwnsObjects := True;
  AllContData.LoadList();
  for n := AllContData.Count - 1 downto 0 do
  begin
    TmpDI := TContDataItem(AllContData[n]);
    if PrevID <> TmpDI.OwnerID then
    begin
      PrevID := TmpDI.OwnerID;
      TmpItem := (self.GetItemByID(TmpDI.OwnerID) as TContactItem);
    end;
    if Assigned(TmpItem) then
      TmpItem.DataList.Add(TmpDI)
    else
      AllContData.Delete(n);
  end;

  AllContData.OwnsObjects := False;
  AllContData.Free();
end;

procedure TContactsList.SaveList();
var
  i, n: Integer;
  TmpItem: TContactItem;
  AllContData: TContDataList;
begin
  DbDriver.SetTable(self);

  // Collect and save related info
  AllContData := TContDataList.Create();
  AllContData.OwnsObjects := False;
  // AllContData.FileName:=StringReplace(self.FileName, '.lst', '_data.lst', [rfIgnoreCase]);

  for i := 0 to self.Count - 1 do
  begin
    TmpItem := TContactItem(self.Items[i]);
    for n := 0 to TmpItem.DataList.Count - 1 do
    begin
      AllContData.Add(TmpItem.DataList[n]);
    end;
  end;

  // Save related info
  AllContData.SaveList();
  AllContData.Free();
end;

{ function TContactsList.AddItem(AItem: TContactItem): Integer;
  begin
  AItem.ID:=LastID;
  Inc(LastID);
  Add(AItem);
  end; }

{ function TContactsList.GetItemByID(ItemID: integer): TContactItem;
  var
  i: integer;
  Item: TContactItem;
  begin
  result:=nil;
  for i:=0 to self.Count-1 do
  begin
  Item:=(self.Items[i] as TContactItem);
  if Item.ID=ItemID then
  begin
  Result:=Item;
  Exit;
  end;
  end;
  end; }

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  { > 0 (positive)	Item1 is less than Item2
    0	Item1 is equal to Item2
    < 0 (negative)	Item1 is greater than Item2 }

  Result := TContactItem(Item1).TreeLevel - TContactItem(Item2).TreeLevel;
  if Result = 0 then
    Result := AnsiCompareStr(TContactItem(Item1).Desc, TContactItem(Item2).Desc);
end;

procedure TContactsList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

function TContactsList.ItemChildCount(Item: TDbItem): Integer;
var
  i, ID: Integer;
begin
  Result := 0;
  ID := Item.ID;
  for i := 0 to self.Count - 1 do
  begin
    if (self.GetItem(i) as TContactItem).ParentID = ID then
      Inc(Result);
  end;
end;

end.
