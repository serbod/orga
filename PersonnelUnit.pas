unit PersonnelUnit;

interface
uses Classes, Contnrs, SysUtils, DbUnit;

type
  // Вид свойства персонала
  TPersDataType = class(TDBItem)
  public
    Name: string;
    FullName: string;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  // Список видов свойств персонала
  TPersDataTypesList = class(TDBItemList)
  public
    constructor Create(); reintroduce;
    function NewItem(): TDbItem; override;
    procedure UpdateItem(AName, AFullName: string);
    function GetItemByIndex(Index: Integer): TPersDataType;
  end;

  // Свойство персоны
  TPersDataItem = class(TDbItem)
  public
    OwnerID: integer;
    DataTypeID: Integer;
    Name: string;
    Text: string;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
    function GetName(): string;
  end;

  // Список свойств персоны
  TPersDataList = class(TDbItemList)
  public
    OwnerID: integer;
    FileName: string;
    constructor Create(); reintroduce;
    procedure LoadList();
    procedure SaveList();
    //procedure Sort();
    //function AddItem(AItem: TContactItem): integer;
    procedure UpdateItem(Name, Value: string);
    function GetItemByName(AName: string): TPersDataItem;
    function NewItem(): TDbItem; override;
  end;

  // Персона
  TPersItem = class(TDbItem)
  public
    ParentID: integer;
    TreeLevel: integer; // for sorting
    ItemType: integer; // 0-normal item, 1-group
    Desc: string;
    Text: string;
    HavePhoto: boolean;
    Photo: TObject;
    Author: string;
    Timestamp: TDateTime;
    DataList: TPersDataList;
    constructor Create();
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
    destructor Destroy(); override;
    function GetDataByName(AName: string): string;
  end;

  // Список персон
  TPersList = class(TDbItemList)
  public
    FileName: string;
    constructor Create(); reintroduce;
    function NewItem(): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    //function AddItem(AItem: TPersItem): integer;
    //function GetItemByID(ItemID: integer): TPersItem;
  end;

implementation
uses MainFunc;

//===========================================
// TPersDataType
//===========================================
function TPersDataType.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='name' then
    result:=self.Name
  else if FName='full_name' then
    result:=self.FullName
  else
    result:='';
end;

procedure TPersDataType.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='name' then
    self.Name:=FValue
  else if FName='full_name' then
    self.FullName:=FValue;
end;


//===========================================
// TPersDataTypesList
//===========================================
constructor TPersDataTypesList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('pers_data_types');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='pers_data_types';
      AddField('id','I');
      AddField('name','S');
      AddField('full_name','S');
    end;
  end;

  inherited Create(ti);
end;

function TPersDataTypesList.NewItem(): TDbItem;
var
  NewItem: TPersDataType;
begin
  NewItem:=TPersDataType.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

procedure TPersDataTypesList.UpdateItem(AName, AFullName: string);
var
  i: integer;
  Item: TPersDataType;
begin
  if Length(AFullName)=0 then AFullName:=AName;
  for i:=0 to self.Count-1 do
  begin
    Item:=(Items[i] as TPersDataType);
    if (Item.Name=AName) then
    begin
      Item.FullName:=AFullName;
      Exit;
    end;
  end;
  Item:=(self.NewItem() as TPersDataType);
  Item.Name:=AName;
  Item.FullName:=AFullName;
end;

function TPersDataTypesList.GetItemByIndex(Index: Integer): TPersDataType;
begin
  if Index < self.Count then
    result:=(self.Items[Index] as TPersDataType)
  else
    result:=nil;
end;

//===========================================
// TPersDataItem
//===========================================
function TPersDataItem.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='owner_id' then
    result:=IntToStr(self.OwnerID)
  else if FName='name' then
    result:=self.Name
  else if FName='data_type_id' then
    result:=IntToStr(self.DataTypeID)
  else if FName='text' then
    result:=self.Text
  else
    result:='';
end;

procedure TPersDataItem.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='owner_id' then
    self.OwnerID:=StrToIntDef(FValue, 0)
  else if FName='name' then
    self.Name:=FValue
  else if FName='data_type_id' then
    self.DataTypeID:=StrToIntDef(FValue, 0)
  else if FName='text' then
    self.Text:=FValue;
end;

function TPersDataItem.GetName(): string;
var
  Item: TDbItem;
begin
  result:=Self.Name;
  if Result <> '' then Exit;
  Item:=DbDriver.GetDBItem('pers_data_types~'+self.GetValue('data_type_id'));
  if not Assigned(Item) then Exit;
  Self.Name:=Item.Name;
  Result:=Item.Name;
  FreeAndNil(Item);
end;

//===========================================
// TPersDataList
//===========================================
constructor TPersDataList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('personnel_data');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='personnel_data';
      AddField('id','I');
      AddField('owner_id','L:personnel');
      AddField('data_type_id','L:pers_data_types');
      AddField('name','S');
      AddField('text','S');
    end;
  end;

  inherited Create(ti);
end;

function TPersDataList.NewItem(): TDbItem;
var
  NewItem: TPersDataItem;
begin
  NewItem:=TPersDataItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

procedure TPersDataList.LoadList();
begin
  DbDriver.GetTable(self);
end;

procedure TPersDataList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function TPersDataList.GetItemByName(AName: string): TPersDataItem;
var
  i: integer;
begin
  result:=nil;
  for i:=0 to self.Count-1 do
  begin
    if (self.Items[i] as TPersDataItem).Name = AName then
    begin
      result:=(self.Items[i] as TPersDataItem);
      Exit;
    end;
  end;
end;

procedure TPersDataList.UpdateItem(Name, Value: string);
var
  DataItem: TPersDataItem;
begin
  if Name='' then Exit;
  DataItem:=GetItemByName(Name);

  if Value='' then
  begin
    if Assigned(DataItem) then self.Remove(DataItem);
    Exit;
  end;

  if not Assigned(DataItem) then
  begin
    DataItem:=TPersDataItem.Create();
    DataItem.OwnerID:=self.OwnerID;
    DataItem.Name:=Name;
    DataItem.DataTypeID:=glPersonnelDataTypes.GetItemIDByName(Name);
    self.Add(DataItem);
  end;
  DataItem.Text:=Value;
end;

//===========================================
// TPersItem
//===========================================
constructor TPersItem.Create();
begin
  self.DataList:=TPersDataList.Create();
end;

destructor TPersItem.Destroy();
begin
  FreeAndNil(self.DataList);
end;

function TPersItem.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='parent_id' then
    result:=IntToStr(self.ParentID)
  else if FName='tree_level' then
    result:=IntToStr(self.TreeLevel)
  else if FName='item_type' then
    result:=IntToStr(self.ItemType)
  else if FName='name' then
    result:=self.Name
  else if FName='text' then
    result:=self.Text
  else if FName='author' then
    result:=self.Author
  else if FName='timestamp' then
    result:=DateTimeToStr(self.Timestamp)
  else
    result:='';
end;

procedure TPersItem.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='parent_id' then
    self.ParentID:=StrToIntDef(FValue, 0)
  else if FName='tree_level' then
    self.TreeLevel:=StrToIntDef(FValue, 0)
  else if FName='item_type' then
    self.ItemType:=StrToIntDef(FValue, 0)
  else if FName='name' then
    self.Name:=FValue
  else if FName='text' then
    self.Text:=FValue
  else if FName='author' then
    self.Author:=FValue
  else if FName='timestamp' then
    self.Timestamp:=StrToDateTimeDef(FValue, self.Timestamp);
end;

function TPersItem.GetDataByName(AName: string): string;
var
  DataItem: TPersDataItem;
begin
  result:='';
  if not Assigned(self.DataList) then Exit;
  DataItem:=self.DataList.GetItemByName(AName);
  if Assigned(DataItem) then result:=DataItem.Text;
end;

//===========================================
// TPersList
//===========================================
constructor TPersList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('personnel');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='personnel';
      AddField('id','I');
      AddField('parent_id','L:personnel');
      AddField('tree_level','I');
      AddField('item_type','I');
      AddField('name','S');
      AddField('text','S');
      AddField('author','S');
      AddField('timestamp','D');
    end;
  end;

  inherited Create(ti);
end;

procedure TPersList.LoadList();
var
  sl: TStringList;
  i, n: integer;
  PrevID: integer;
  Item: TPersItem;
  TmpDI: TPersDataItem;
  AllPersData: TPersDataList;
begin
  DbDriver.GetTable(self);

  for i:=0 to self.Count-1 do
  begin
    Item:=(self.Items[i] as TPersItem);
    Item.DataList.OwnerID:=Item.ID;
    //if LastID <= NewItem.ID then LastID:=NewItem.ID+1;
  end;

  // Add Pers data items
  AllPersData:=TPersDataList.Create();
  AllPersData.OwnsObjects:=true;
  AllPersData.LoadList();

  Item:=nil;
  PrevID:=-1;
  for n:=AllPersData.Count-1 downto 0 do
  begin
    TmpDI:=TPersDataItem(AllPersData[n]);
    if PrevID<>TmpDI.OwnerID then
    begin
      PrevID:=TmpDI.OwnerID;
      Item:=(self.GetItemByID(PrevID) as TPersItem);
    end;
    if Assigned(Item) then Item.DataList.Add(TmpDI)
    else AllPersData.Delete(n);
  end;

  AllPersData.OwnsObjects:=false;
  AllPersData.Free();
end;

procedure TPersList.SaveList();
var
  sl: TStringList;
  i,n: integer;
  TmpItem: TPersItem;
  AllPersData: TPersDataList;
begin
  // Save items
  DbDriver.SetTable(self);

  // Fill related info list
  AllPersData:=TPersDataList.Create();
  AllPersData.OwnsObjects:=false;

  for i:=0 to self.Count-1 do
  begin
    TmpItem:=TPersItem(self.Items[i]);
    for n:=0 to TmpItem.DataList.Count-1 do
    begin
      AllPersData.Add(TmpItem.DataList[n]);
    end;
  end;

  // Save related info
  AllPersData.SaveList();
  AllPersData.Free();
end;

function TPersList.NewItem(): TDbItem;
var
  NewItem: TPersItem;
begin
  NewItem:=TPersItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

{function TPersList.AddItem(AItem: TPersItem): Integer;
begin
  AItem.ID:=LastID;
  Inc(LastID);
  Add(AItem);
end;}

{function TPersList.GetItemByID(ItemID: integer): TPersItem;
var
  i: integer;
  Item: TPersItem;
begin
  result:=nil;
  for i:=0 to self.Count-1 do
  begin
    Item:=(self.Items[i] as TPersItem);
    if Item.ID=ItemID then
    begin
      Result:=Item;
      Exit;
    end;
  end;
end; }

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  {> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
   < 0 (negative)	Item1 is greater than Item2}

  result := TPersItem(Item1).TreeLevel - TPersItem(Item2).TreeLevel;
  if result=0 then result := AnsiCompareStr(TPersItem(Item1).Desc, TPersItem(Item2).Desc);
end;

procedure TPersList.Sort();
begin
  inherited Sort(@CompareFunc);
end;


end.
