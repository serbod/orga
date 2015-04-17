{
Модуль подсистемы базы данных.

!! в TDbItem массив значений больше необходимого

}
unit DbUnit;

interface
uses SysUtils, Classes, Contnrs, MkSqLite3, MkSqLite3Api;

type
  // Информация о таблице БД
  // - сведения о колонках и типах данных в колонках
  // - название таблицы
  TDbTableInfo = class(TObject)
  private
    AFieldNames: array of string;
    AFieldTypes: array of string;
    AFieldsCount: integer;
    function GetField(Index: integer): string;
    function GetType(Index: integer): string;
    function GetFieldsCount(): integer;
  public
    DBName: string; // Имя базы данных
    TableName: string; // Имя таблицы
    KeyFieldName: string; // Имя ключевого поля (ID)
    // Признак, того, что таблица соответствует своему аналогу в базе данных
    Checked: boolean;
    constructor Create();
    // Список имен полей таблицы
    property Fields[Index: integer]: string read GetField;
    // Список типов полей таблицы
    property Types[Index: integer]: string read GetType;
    // Количество полей
    property FieldsCount: integer read GetFieldsCount;
    // Создает поле с указаным именем и типом
    procedure AddField(const FieldName, FieldType: string);
    // Возвращает номер поля по его имени
    function FieldIndex(FName: string): Integer;
  end;

  // элемент таблицы БД, один ряд таблицы
  TDbItem = class(TObject)
  private
    // Массив значений (полей) элемента
    FValues: array of string;
    // Инициализирует массив значений, заполняет их пустыми значениями
    procedure InitValues();
  public
    ID: integer;  // идентификатор элемента
    Name: string; // строковое представление значения
    Actual: boolean; // признак соответствия данных элемента и БД
    TimeStamp: TDateTime; // дата последнего изменения
    DbTableInfo: TDbTableInfo; // информация о таблице
    // Возвращает значение по имени колонки
    // Должно быть переопределено в потомках
    function GetValue(const FName: string): string; virtual;
    // Возвращает DBItem по имени колонки
    // Должно быть переопределено в потомках
    //function GetDBItem(FName: string): TDBItem; virtual;
    // Устанавливает значение по имени колонки
    // Должно быть переопределено в потомках
    procedure SetValue(const FName, FValue: string); virtual;
    // доступ к значению поля по его имени
    property Values[const FName: string]: string read GetValue write SetValue; default;
    //
    function GetInteger(const FName: string): integer;
    procedure SetInteger(const FName: string; Value: integer);
  protected
    procedure GetLocal();
    procedure SetLocal();
    procedure GetGlobal();
    procedure SetGlobal();
  end;

  // Список однотипных элементов базы данных
  // Проще говоря - таблица
  TDbItemList = class(TObjectList)
  protected
    ALastID: integer;
  public
    DbTableInfo: TDbTableInfo;
    constructor Create(ADbTableInfo: TDbTableInfo); virtual;
    function AddItem(AItem: TDbItem; SetNewID: boolean = false): integer;
    function GetItemByID(ItemID: integer): TDbItem;
    function GetItemByName(ItemName: string; Wildcard: Boolean = false): TDbItem;
    function GetItemIDByName(ItemName: string; Wildcard: Boolean = false): Integer;
    function GetItemNameByID(ItemID: integer): string;
    function NewItem(): TDbItem; virtual;
    procedure LoadLocal();
    procedure SaveLocal();
  end;

  // Драйвер базы данных - для доступа к хранилищу данных
  // Это базовый класс, должен быть переопределено для конкретных видов БД
  TDbDriver = class(TObject)
  public
    DbName: string;
    // Список описаний таблиц TDbTableInfo
    TablesList: TObjectList;
    constructor Create();
    destructor Destroy(); override;
    // Открывает указанную базу данных
    function Open(ADbName: string): boolean; virtual; abstract;
    // Закрывает указанную базу данных
    function Close(): boolean; virtual; abstract;
    // Возвращает описание таблицы по ее имени
    function GetDbTableInfo(TableName: String): TDbTableInfo;
    // Заполняет указанную таблицу элементами из базы данных, по заданному фильтру
    // Фильтр в виде comma-delimited string как поле=значение
    function GetTable(AItemList: TDbItemList; Filter: string=''): boolean; virtual; abstract;
    // Заполняет базу данных элементами из указанной таблицы, по заданному фильтру
    function SetTable(AItemList: TDbItemList; Filter: string=''): boolean; virtual; abstract;
    // Возвращает DBItem по значению вида Table_name~id
    // Должно быть переопределено в потомках
    function GetDBItem(FValue: string): TDBItem; virtual; abstract;
    function SetDBItem(FItem: TDBItem): boolean; virtual; abstract;
  end;

  TDbDriverSQLite = class(TDbDriver)
  private
    db: TMkSqLite;
    Active: boolean;
    procedure CheckTable(TableInfo: TDbTableInfo);
  public
    constructor Create();
    //destructor Destroy(); override;
    function Open(ADbName: string): boolean; override;
    function Close(): boolean; override;
    function GetTable(AItemList: TDbItemList; Filter: string=''): boolean; override;
    function SetTable(AItemList: TDbItemList; Filter: string=''): boolean; override;
    function GetDBItem(FValue: string): TDBItem; override;
    function SetDBItem(FItem: TDBItem): boolean; override;
  end;

  TDbDriverCSV = class(TDbDriver)
  private
    dbPath: string;
    procedure CheckTable(TableInfo: TDbTableInfo);
  public
    function Open(ADbName: string): boolean; override;
    function Close(): boolean; override;
    function GetTable(AItemList: TDbItemList; Filter: string=''): boolean; override;
    function SetTable(AItemList: TDbItemList; Filter: string=''): boolean; override;
    function GetDBItem(FValue: string): TDBItem; override;
    function SetDBItem(FItem: TDBItem): boolean; override;
  end;

implementation
uses MainFunc;

// === TDbTableInfo ===
function TDbTableInfo.GetField(Index: integer): string;
begin
  result:='';
  if (Index >= AFieldsCount) or (Index<0) then Exit;
  result:=AFieldNames[Index];
end;

function TDbTableInfo.GetType(Index: integer): string;
begin
  result:='';
  if (Index >= AFieldsCount) or (Index<0) then Exit;
  result:=AFieldTypes[Index];
end;

function TDbTableInfo.GetFieldsCount(): integer;
begin
  result:=self.AFieldsCount;
end;

procedure TDbTableInfo.AddField(const FieldName, FieldType: string);
var
  i: Integer;
  s: string;
begin
  for i:=0 to AFieldsCount-1 do
  begin
    if AFieldNames[i] = FieldName then Exit;
  end;

  Inc(AFieldsCount);
  SetLength(AFieldNames, AFieldsCount);
  SetLength(AFieldTypes, AFieldsCount);
  AFieldNames[AFieldsCount-1]:=FieldName;
  s:=FieldType;
  if Length(s)<1 then s:='S';
  AFieldTypes[AFieldsCount-1]:=s;
end;

function TDbTableInfo.FieldIndex(FName: string): Integer;
var i: Integer;
begin
  result:=-1;
  for i:=0 to AFieldsCount do
  begin
    if AFieldNames[i] = FName then
    begin
      result:=i;
      Exit;
    end;
  end;
end;

constructor TDbTableInfo.Create();
begin
  self.Checked:=false;
  self.AFieldsCount:=0;
  SetLength(AFieldNames, AFieldsCount);
  SetLength(AFieldTypes, AFieldsCount);
//  AddField('id','I');
//  AddField('name','S');
//  AddField('timestamp','D');
end;

// === TDbItem ===
procedure TDbItem.GetLocal();
begin
end;

procedure TDbItem.SetLocal();
begin
end;

procedure TDbItem.GetGlobal();
begin
end;

procedure TDbItem.SetGlobal();
begin
end;

procedure TDbItem.InitValues();
var i: Integer;
begin
  SetLength(Self.FValues, Self.DbTableInfo.FieldsCount);
  for i:=0 to Self.DbTableInfo.FieldsCount-1 do Self.FValues[i]:='';
end;

function TDbItem.GetValue(const FName: string): string;
var i: Integer;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='timestamp' then
    result:=DateTimeToStr(self.Timestamp)
  else if FName='name' then
    result:=self.Name
  else
  begin
    if Length(Self.FValues)=0 then InitValues();
    i:=Self.DbTableInfo.FieldIndex(FName);
    if i<0 then result:='' else result:=Self.FValues[i];
  end;
end;

//function TDbItem.GetDBItem(FName: string): TDBItem;
//begin
//  result:=nil;
//  if FName='id' then result:=self;
//end;

procedure TDbItem.SetValue(const FName, FValue: string);
var i: Integer;
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='timestamp' then
    self.Timestamp:=StrToDateTimeDef(FValue, self.Timestamp)
  else if FName='name' then
    self.Name:=FValue
  else
  begin
    if Length(Self.FValues)=0 then InitValues();
    i:=Self.DbTableInfo.FieldIndex(FName);
    if i>=0 then Self.FValues[i]:=FValue;
  end;
end;

function TDbItem.GetInteger(const FName: string): integer;
begin
  result:=StrToIntDef(self.GetValue(FName), 0);
end;

procedure TDbItem.SetInteger(const FName: string; Value: integer);
begin
  self.SetValue(FName, IntToStr(Value));
end;

// === TDbItemList ===
constructor TDbItemList.Create(ADbTableInfo: TDbTableInfo);
begin
  self.DbTableInfo:=ADbTableInfo;
end;

procedure TDbItemList.LoadLocal();
begin
  DbDriver.GetTable(self);
end;

procedure TDbItemList.SaveLocal();
begin
  DbDriver.SetTable(self);
end;

function TDbItemList.AddItem(AItem: TDbItem; SetNewID: boolean = false): integer;
begin
  if SetNewID then
  begin
    Inc(self.ALastID);
    AItem.ID:=self.ALastID;
  end
  else
  begin
    if self.ALastID < AItem.ID then self.ALastID := AItem.ID;
  end;
  AItem.DbTableInfo:=self.DbTableInfo;
  result:=self.Add(AItem);
end;

function TDbItemList.GetItemByID(ItemID: integer): TDbItem;
var
  i: integer;
begin
  for i:=0 to self.Count-1 do
  begin
    if (self.Items[i] as TDbItem).ID = ItemID then
    begin
      result := (self.Items[i] as TDbItem);
      Exit;
    end;
  end;
  result := nil;
end;

function TDbItemList.GetItemByName(ItemName: string; Wildcard: Boolean = false): TDbItem;
var
  i: integer;
begin
  if Wildcard then
  begin
    for i:=0 to self.Count-1 do
    begin
      if Pos(ItemName, (self.Items[i] as TDbItem).Name) > 0 then
      begin
        result := (self.Items[i] as TDbItem);
        Exit;
      end;
    end;
  end

  else
  begin
    for i:=0 to self.Count-1 do
    begin
      if (self.Items[i] as TDbItem).Name = ItemName then
      begin
        result := (self.Items[i] as TDbItem);
        Exit;
      end;
    end;
  end;
  result := nil;
end;

function TDbItemList.GetItemIDByName(ItemName: string; Wildcard: Boolean = false): Integer;
var
  Item: TDbItem;
begin
  Result:=-1;
  Item:=Self.GetItemByName(ItemName, Wildcard);
  if Assigned(Item) then Result:=Item.ID;
end;

function TDbItemList.GetItemNameByID(ItemID: integer): string;
var
  Item: TDbItem;
begin
  Result:='';
  Item:=Self.GetItemByID(ItemID);
  if Assigned(Item) then Result:=Item.Name;
end;

function TDbItemList.NewItem(): TDbItem;
var
  NewItem: TDbItem;
begin
  NewItem:=TDbItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

// === TDbDriver ===
constructor TDbDriver.Create();
begin
  self.TablesList:=TObjectList.Create(false);
end;

destructor TDbDriver.Destroy();
begin
  self.Close();
  self.TablesList.Free();
end;

function TDbDriver.GetDbTableInfo(TableName: String): TDbTableInfo;
var
  i: integer;
begin
  Result:=nil;
  for i:=0 to Self.TablesList.Count-1 do
  begin
    if (Self.TablesList[i] as TDbTableInfo).TableName = TableName then
    begin
      Result:=(Self.TablesList[i] as TDbTableInfo);
      Exit;
    end;
  end;
end;

// === TDbDriverSQLite ===
constructor TDbDriverSQLite.Create();
begin
  inherited Create();
  self.Active:=false;
end;

procedure TDbDriverSQLite.CheckTable(TableInfo: TDbTableInfo);
var
  rs: IMkSqlStmt;
  s, sn, st, sql: string;
  i: integer;
begin
  if not Assigned(db) then Exit;
  if TableInfo.Checked then Exit;
  if Self.TablesList.IndexOf(TableInfo)>=0 then Exit;

  //sql:='SELECT * FROM sqlite_master WHERE type=''table'' and name='''+TableInfo.TableName+'''';
  //DebugSQL(sql);
  rs:=db.SchemaTableInfo(TableInfo.TableName);
  if rs.rowCount<=0 then
  begin
    s:='';
    for i:=0 to TableInfo.FieldsCount-1 do
    begin
      sn:=TableInfo.Fields[i];
      st:=TableInfo.Types[i];
      if Length(s)>0 then s:=s+',';
      s:=s+''''+sn+'''';
      if sn='id' then
      begin
        s:=s+' INTEGER PRIMARY KEY NOT NULL';
        TableInfo.KeyFieldName:=sn;
      end
      else if st='I' then s:=s+' INTEGER NOT NULL'
      else if st='S' then s:=s+' TEXT NOT NULL'
      else if st='B' then s:=s+' INTEGER NOT NULL'
      else if st='D' then s:=s+' TEXT NOT NULL'
      else if st='' then // nothing;
      else if st[1]='L' then s:=s+' INTEGER NOT NULL';
    end;
    rs.close();
    sql:='CREATE TABLE '''+TableInfo.TableName+''' ('+s+')';
    DebugSQL(sql);
    rs:=db.Exec(sql);
  end;
  rs.close();

  TableInfo.Checked:=true;
  Self.TablesList.Add(TableInfo);
end;

function TDbDriverSQLite.Open(ADbName: string): boolean;
begin
  DbName:= ADbName;
  result:=true;
  if Assigned(db) then FreeAndNil(db);
  try
    db:=TMkSqLite.Create(nil);
    db.dbName:=ExtractFileDir(ParamStr(0))+'\Data\'+ADbName+'.sqlite';
    db.Open();
  except
    Close();
    result:=false;
  end;
  Active:=result;
end;

function TDbDriverSQLite.Close(): boolean;
begin
  result:=true;
  TablesList.Clear();
  if not Active then Exit;
  if not Assigned(db) then Exit;
  db.close();
  FreeAndNil(db);
end;

function TDbDriverSQLite.GetTable(AItemList: TDbItemList; Filter: string=''): boolean;
var
  rs: IMkSqlStmt;
  i, n, m: integer;
  Item: TDbItem;
  fn, sql: string;
  fl: TStringList;
  FilterOk: boolean;
begin
  result:=false;
  if not Active then Exit;
  if not Assigned(AItemList) then Exit;
  if not Assigned(db) then Exit;

  CheckTable(AItemList.DbTableInfo);

  fl:=TStringList.Create(); // filters
  fl.CommaText:=Filter;

  sql:='SELECT * FROM "'+AItemList.DbTableInfo.TableName+'"';
  // filters
  if fl.Count > 0 then sql:=sql+' WHERE ';
  for m:=0 to fl.Count-1 do
  begin
    if m>0 then sql:=sql+' AND ';
    sql:=sql+'"'+fl.Names[m]+'"="'+fl.ValueFromIndex[m]+'"';
  end;

  DebugSQL(sql);
  rs:=db.Exec(sql);
  while not rs.eof do
  begin
    i := rs.ValueOf['id'];

    Item := AItemList.GetItemByID(i);
    if not Assigned(Item) then Item:=AItemList.NewItem();
    for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
    begin
      fn:=AItemList.DbTableInfo.GetField(n);
      Item.SetValue(fn, rs.ValueOf[fn]);
    end;
    rs.Next();
  end;
  result:=true;
end;

function TDbDriverSQLite.SetTable(AItemList: TDbItemList; Filter: string=''): boolean;
var
  i, n: integer;
  Item: TDbItem;
  fn, iv, vl, sql: string;
begin
  result:=false;
  if not Active then Exit;
  if not Assigned(AItemList) then Exit;
  if not Assigned(db) then Exit;
  CheckTable(AItemList.DbTableInfo);

  for i:=0 to AItemList.Count-1 do
  begin
    vl:='';
    Item:=(AItemList[i] as TDbItem);
    for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
    begin
      fn:=AItemList.DbTableInfo.GetField(n);
      iv:=Item.GetValue(fn);
      if n > 0 then vl:=vl+',';
      vl:=vl+'"'+iv+'"';
      //vl:=vl+fn+'='''+iv+'''';
    end;
    sql:='INSERT OR REPLACE INTO "'+AItemList.DbTableInfo.TableName+'" VALUES ('+vl+')';
    DebugSQL(sql);
    //sql:='UPDATE '+AItemList.DbTableInfo.TableName+' SET '+vl+' WHERE ROWID='+IntToStr(Item.ID);
    db.exec(sql);
  end;
end;

function TDbDriverSQLite.GetDBItem(FValue: String): TDbItem;
var
  sTableName, sItemID, fn, sql: string;
  i: Integer;
  TableInfo: TDbTableInfo;
  rs: IMkSqlStmt;
begin
  Result:=nil;
  if not Assigned(db) then Exit;
  i:=Pos('~', FValue);
  sTableName:=Copy(FValue, 1, i-1);
  sItemID:=Copy(FValue, i+1, MaxInt);
  TableInfo:=Self.GetDbTableInfo(sTableName);
  if not Assigned(TableInfo) then Exit;

  sql:='SELECT * FROM '+TableInfo.TableName+' WHERE id="'+sItemID+'"';
  DebugSQL(sql);
  rs:=db.Exec(sql);
  if not rs.eof then
  begin
    Result:=TDbItem.Create();
    for i:=0 to TableInfo.FieldsCount-1 do
    begin
      fn:=TableInfo.GetField(i);
      Result.SetValue(fn, rs.ValueOf[fn]);
    end;
  end;
end;

function TDbDriverSQLite.SetDBItem(FItem: TDBItem): boolean;
var
  n: integer;
  Item: TDbItem;
  TableInfo: TDbTableInfo;
  fn, iv, vl, sql: string;
begin
  result:=false;
  if not Active then Exit;
  if not Assigned(FItem) then Exit;
  if not Assigned(db) then Exit;

  TableInfo:=FItem.DbTableInfo;
  if not Assigned(TableInfo) then Exit;
  CheckTable(TableInfo);

  vl:='';
  for n:=0 to TableInfo.FieldsCount-1 do
  begin
    fn:=TableInfo.GetField(n);
    iv:=FItem.GetValue(fn);
    if n > 0 then vl:=vl+',';
    vl:=vl+'"'+iv+'"';
    //vl:=vl+fn+'='''+iv+'''';
  end;
  sql:='INSERT OR REPLACE INTO "'+TableInfo.TableName+'" VALUES ('+vl+')';
  DebugSQL(sql);
  //sql:='UPDATE '+AItemList.DbTableInfo.TableName+' SET '+vl+' WHERE ROWID='+IntToStr(Item.ID);
  db.exec(sql);

  result:=true;
end;

// === TDbDriverCSV ===
function TDbDriverCSV.Open(ADbName: string): boolean;
begin
  self.DbName:=ADbName;
  self.dbPath:=ExtractFileDir(ParamStr(0))+'\Data\';
  result:=true;
end;

function TDbDriverCSV.Close(): boolean;
begin
  result:=true;
end;

procedure TDbDriverCSV.CheckTable(TableInfo: TDbTableInfo);
begin
  if TableInfo.Checked then Exit;
  if Self.TablesList.IndexOf(TableInfo)>=0 then Exit;

  TableInfo.Checked:=true;
  Self.TablesList.Add(TableInfo);
end;

function TDbDriverCSV.GetTable(AItemList: TDbItemList; Filter: string=''): boolean;
var
  sl, vl, fl: TStringList;
  i, n, m, id: integer;
  Item: TDbItem;
  fn: string;
  FilterOk: boolean;
begin
  result:=false;
  if not Assigned(AItemList) then Exit;
  CheckTable(AItemList.DbTableInfo);
  fn:=self.dbPath+'\'+AItemList.DbTableInfo.TableName+'.lst';
  if not FileExists(fn) then Exit;
  sl:=TStringList.Create();
  try
    sl.LoadFromFile(fn);
  except
    sl.Free();
    Exit;
  end;

  vl:=TStringList.Create(); // row values
  fl:=TStringList.Create(); // filters
  fl.CommaText:=Filter;

  // первая строка - список колонок!
  for i:=1 to sl.Count-1 do
  begin
    vl.Clear();
    vl.CommaText:=StringReplace(sl[i], '~>', #13+#10, [rfReplaceAll]);
    if vl.Count=0 then Continue;
    if vl.Count < AItemList.DbTableInfo.FieldsCount then Continue; //!!

    // check filters
    FilterOk:=true;
    if fl.Count>0 then
    begin
      for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
      begin
        fn:=AItemList.DbTableInfo.GetField(n);
        for m:=0 to fl.Count-1 do
        begin
          if fl.Names[m]=fn then
          begin
            if fl.ValueFromIndex[m]<>vl[n] then FilterOk:=false;
            Break;
          end;
        end;
      end;
    end;

    if not FilterOk then Continue;
    // Create new item
    id:=StrToInt(vl[0]);
    Item := AItemList.GetItemByID(id);
    if not Assigned(Item) then Item:=AItemList.NewItem();

    // fill item values
    for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
    begin
      fn:=AItemList.DbTableInfo.GetField(n);
      Item.SetValue(fn, vl[n]);
    end;
  end;
  fl.Free();
  vl.Free();
  sl.Free();
  result:=true;
end;

function TDbDriverCSV.SetTable(AItemList: TDbItemList; Filter: string=''): boolean;
var
  sl, vl: TStringList;
  i, n: integer;
  Item: TDbItem;
  fn: string;
begin
  result:=false;
  if not Assigned(AItemList) then Exit;
  CheckTable(AItemList.DbTableInfo);

  sl:=TStringList.Create();
  vl:=TStringList.Create();

  // columns headers
  for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
  begin
    fn:=AItemList.DbTableInfo.GetField(n);
    vl.Add(fn);
  end;
  sl.Add(vl.CommaText);

  // rows
  for i:=0 to AItemList.Count-1 do
  begin
    vl.Clear();
    Item:=(AItemList[i] as TDbItem);
    for n:=0 to AItemList.DbTableInfo.FieldsCount-1 do
    begin
      fn:=AItemList.DbTableInfo.GetField(n);
      vl.Add(Item.GetValue(fn));
    end;
    sl.Add(StringReplace(vl.CommaText, #13+#10, '~>', [rfReplaceAll]));
  end;

  vl.Free();
  try
    sl.SaveToFile(self.dbPath+'\'+AItemList.DbTableInfo.TableName+'.lst');
  finally
    sl.Free();
  end;

end;

function TDbDriverCSV.GetDBItem(FValue: String): TDbItem;
var
  sTableName, sItemID, fn, sql: string;
  i: Integer;
  TableInfo: TDbTableInfo;
  ItemList: TDbItemList;
  Filter: string;
begin
  Result:=nil;
  i:=Pos('~', FValue);
  sTableName:=Copy(FValue, 1, i-1);
  sItemID:=Copy(FValue, i+1, MaxInt);
  TableInfo:=Self.GetDbTableInfo(sTableName);
  if not Assigned(TableInfo) then Exit;

  ItemList:=TDbItemList.Create(TableInfo);
  Filter:='id='+sItemID;

  if not GetTable(ItemList, Filter) then Exit;
  if ItemList.Count=0 then Exit;
  result:=(ItemList[0] as TDbItem);
end;

function TDbDriverCSV.SetDBItem(FItem: TDBItem): boolean;
var
  AItemList: TDbItemList;
  AItem: TDbItem;
  i: Integer;
  fn: string;
begin
  Result:=False;
  AItemList:=TDbItemList.Create(FItem.DbTableInfo);
  Self.GetTable(AItemList);
  AItem:=AItemList.GetItemByID(FItem.ID);
  if not Assigned(AItem) then
  begin
    FreeAndNil(AItemList);
    Exit;
  end;
  for i:=0 to FItem.DbTableInfo.FieldsCount-1 do
  begin
    fn:=FItem.DbTableInfo.GetField(i);
    AItem.Values[fn]:=FItem.Values[fn];
  end;
  Self.SetTable(AItemList);
  FreeAndNil(AItemList);
  result:=true;
end;

end.
