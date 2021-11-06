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
    FFieldNames: array of string;
    FFieldTypes: array of string;
    FFieldsCount: Integer;
    FLastID: Integer;
    // если переданное значение больше текущего LastID, то оно становится текущим
    procedure SetLastID(AValue: Integer);
    function GetField(AIndex: Integer): string;
    function GetType(AIndex: Integer): string;
    function GetFieldsCount(): Integer;
  public
    DBName: string; // Имя базы данных
    TableName: string; // Имя таблицы
    KeyFieldName: string; // Имя ключевого поля (ID)
    // Признак, того, что таблица соответствует своему аналогу в базе данных
    Checked: Boolean;
    constructor Create();
    // Список имен полей таблицы
    property Fields[AIndex: Integer]: string read GetField;
    // Список типов полей таблицы
    property Types[AIndex: Integer]: string read GetType;
    // Количество полей
    property FieldsCount: Integer read GetFieldsCount;
    // Создает поле с указаным именем и типом
    procedure AddField(const AFieldName, AFieldType: string);
    // Возвращает номер поля по его имени
    function FieldIndex(FName: string): Integer;

    property LastID: Integer read FLastID write SetLastID;
  end;

  // элемент таблицы БД, один ряд таблицы
  TDbItem = class(TObject)
  protected
    // Массив значений (полей) элемента
    FValues: array of string;
    // Инициализирует массив значений, заполняет их пустыми значениями
    procedure InitValues();
    procedure GetLocal();
    procedure SetLocal();
    procedure GetGlobal();
    procedure SetGlobal();
  public
    ID: Integer; // идентификатор элемента
    Name: string; // строковое представление значения
    Actual: Boolean; // признак соответствия данных элемента и БД
    TimeStamp: TDateTime; // дата последнего изменения
    DbTableInfo: TDbTableInfo; // информация о таблице
    // Возвращает значение по имени колонки
    // Должно быть переопределено в потомках
    function GetValue(const FName: string): string; virtual;
    // Возвращает DBItem по имени колонки
    // Должно быть переопределено в потомках
    // function GetDBItem(FName: string): TDBItem; virtual;
    // Устанавливает значение по имени колонки
    // Должно быть переопределено в потомках
    procedure SetValue(const FName, FValue: string); virtual;
    // доступ к значению поля по его имени
    property Values[const FName: string]: string read GetValue write SetValue; default;
    //
    function GetInteger(const FName: string): Integer;
    procedure SetInteger(const FName: string; Value: Integer);
    // скопировать все свойства из другого элемента
    procedure Assign(AOther: TDbItem);
  end;

  // Список однотипных элементов базы данных
  // Проще говоря - таблица
  TDbItemList = class(TObjectList)
  public
    DbTableInfo: TDbTableInfo;
    constructor Create(ADbTableInfo: TDbTableInfo); virtual;
    function AddItem(AItem: TDbItem; SetNewID: Boolean): Integer;
    function GetItemByID(ItemID: Integer): TDbItem;
    function GetItemByName(ItemName: string; Wildcard: Boolean = False): TDbItem;
    function GetItemIDByName(ItemName: string; Wildcard: Boolean = False): Integer;
    function GetItemNameByID(ItemID: Integer): string;
    function NewItem(ASetNewID: Boolean): TDbItem; virtual;
    procedure LoadLocal();
    procedure SaveLocal();
  end;

  TItemSelectedEvent = procedure(Sender: TObject; DbItem: TDbItem) of object;

  // Драйвер базы данных - для доступа к хранилищу данных
  // Это базовый класс, должен быть переопределено для конкретных видов БД
  TDbDriver = class(TObject)
  public
    DBName: string;
    // Список описаний таблиц TDbTableInfo
    TablesList: TObjectList;
    constructor Create();
    destructor Destroy(); override;
    // Открывает указанную базу данных
    function Open(ADbName: string): Boolean; virtual; abstract;
    // Закрывает указанную базу данных
    function Close(): Boolean; virtual; abstract;
    // Возвращает описание таблицы по ее имени
    function GetDbTableInfo(TableName: String): TDbTableInfo;
    // Заполняет указанную таблицу элементами из базы данных, по заданному фильтру
    // Фильтр в виде comma-delimited string как поле=значение
    function GetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; virtual; abstract;
    // Заполняет базу данных элементами из указанной таблицы, по заданному фильтру
    function SetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; virtual; abstract;
    // Возвращает DBItem по значению вида Table_name~id
    // Должно быть переопределено в потомках
    function GetDBItem(FValue: string): TDbItem; virtual; abstract;
    function SetDBItem(FItem: TDbItem): Boolean; virtual; abstract;
  end;

  TDbDriverSQLite = class(TDbDriver)
  private
    db: TMkSqLite;
    Active: Boolean;
    procedure CheckTable(TableInfo: TDbTableInfo);
  public
    constructor Create();
    // destructor Destroy(); override;
    function Open(ADbName: string): Boolean; override;
    function Close(): Boolean; override;
    function GetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; override;
    function SetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; override;
    function GetDBItem(FValue: string): TDbItem; override;
    function SetDBItem(FItem: TDbItem): Boolean; override;
  end;

  TDbDriverCSV = class(TDbDriver)
  private
    dbPath: string;
    procedure CheckTable(TableInfo: TDbTableInfo);
  public
    function Open(ADbName: string): Boolean; override;
    function Close(): Boolean; override;
    function GetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; override;
    function SetTable(AItemList: TDbItemList; Filter: string = ''): Boolean; override;
    function GetDBItem(FValue: string): TDbItem; override;
    function SetDBItem(FItem: TDbItem): Boolean; override;
  end;

implementation

uses MainFunc;

// === TDbTableInfo ===
procedure TDbTableInfo.SetLastID(AValue: Integer);
begin
  if FLastID < AValue then
    FLastID := AValue;
end;

function TDbTableInfo.GetField(AIndex: Integer): string;
begin
  Result := '';
  if (AIndex >= FFieldsCount) or (AIndex < 0) then
    Exit;
  Result := FFieldNames[AIndex];
end;

function TDbTableInfo.GetType(AIndex: Integer): string;
begin
  Result := '';
  if (AIndex >= FFieldsCount) or (AIndex < 0) then
    Exit;
  Result := FFieldTypes[AIndex];
end;

function TDbTableInfo.GetFieldsCount(): Integer;
begin
  Result := FFieldsCount;
end;

procedure TDbTableInfo.AddField(const AFieldName, AFieldType: string);
var
  i: Integer;
  s: string;
begin
  for i := 0 to FFieldsCount - 1 do
  begin
    if FFieldNames[i] = AFieldName then
      Exit;
  end;

  Inc(FFieldsCount);
  SetLength(FFieldNames, FFieldsCount);
  SetLength(FFieldTypes, FFieldsCount);
  FFieldNames[FFieldsCount - 1] := AFieldName;
  s := AFieldType;
  if Length(s) < 1 then
    s := 'S';
  FFieldTypes[FFieldsCount - 1] := s;
end;

function TDbTableInfo.FieldIndex(FName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FFieldsCount-1 do
  begin
    if FFieldNames[i] = FName then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

constructor TDbTableInfo.Create();
begin
  self.Checked := False;
  FLastID := 0;
  FFieldsCount := 0;
  SetLength(FFieldNames, FFieldsCount);
  SetLength(FFieldTypes, FFieldsCount);
  // AddField('id','I');
  // AddField('name','S');
  // AddField('timestamp','D');
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

procedure TDbItem.Assign(AOther: TDbItem);
var
  i: Integer;
  sField: string;
begin
  Self.DbTableInfo := AOther.DbTableInfo;
  Self.ID := AOther.ID;
  Self.Name := AOther.Name;
  Self.Actual := AOther.Actual;
  Self.TimeStamp := AOther.TimeStamp;
  for i := 0 to DbTableInfo.FieldsCount-1 do
  begin
    sField := DbTableInfo.Fields[i];
    SetValue(sField, AOther.GetValue(sField));
  end;
end;

procedure TDbItem.InitValues();
var
  i: Integer;
begin
  SetLength(FValues, DbTableInfo.FieldsCount);
  for i := 0 to DbTableInfo.FieldsCount - 1 do
    FValues[i] := '';
end;

function TDbItem.GetValue(const FName: string): string;
var
  i: Integer;
begin
  if FName = 'id' then
    Result := IntToStr(self.ID)
  else if FName = 'timestamp' then
    Result := DateTimeToStr(self.TimeStamp)
  else if FName = 'name' then
    Result := self.Name
  else
  begin
    if Length(FValues) = 0 then
      InitValues();
    i := DbTableInfo.FieldIndex(FName);
    if i < 0 then
      Result := ''
    else
      Result := FValues[i];
  end;
end;

// function TDbItem.GetDBItem(FName: string): TDBItem;
// begin
// result:=nil;
// if FName='id' then result:=self;
// end;

procedure TDbItem.SetValue(const FName, FValue: string);
var
  i: Integer;
begin
  if FName = 'id' then
    self.ID := StrToIntDef(FValue, 0)
  else if FName = 'timestamp' then
    self.TimeStamp := StrToDateTimeDef(FValue, self.TimeStamp)
  else if FName = 'name' then
    self.Name := FValue
  else
  begin
    if Length(FValues) = 0 then
      InitValues();
    i := DbTableInfo.FieldIndex(FName);
    if i >= 0 then
      FValues[i] := FValue;
  end;
end;

function TDbItem.GetInteger(const FName: string): Integer;
begin
  Result := StrToIntDef(self.GetValue(FName), 0);
end;

procedure TDbItem.SetInteger(const FName: string; Value: Integer);
begin
  self.SetValue(FName, IntToStr(Value));
end;

// === TDbItemList ===
constructor TDbItemList.Create(ADbTableInfo: TDbTableInfo);
begin
  self.DbTableInfo := ADbTableInfo;
end;

procedure TDbItemList.LoadLocal();
begin
  DbDriver.GetTable(self);
end;

procedure TDbItemList.SaveLocal();
begin
  DbDriver.SetTable(self);
end;

function TDbItemList.AddItem(AItem: TDbItem; SetNewID: Boolean): Integer;
begin
  if SetNewID then
  begin
    AItem.ID := DbTableInfo.LastID + 1;
    DbTableInfo.LastID := AItem.ID;
  end
  else
  begin
    DbTableInfo.LastID := AItem.ID;
  end;
  AItem.DbTableInfo := DbTableInfo;
  Result := Add(AItem);
end;

function TDbItemList.GetItemByID(ItemID: Integer): TDbItem;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if (Items[i] as TDbItem).ID = ItemID then
    begin
      Result := (Items[i] as TDbItem);
      Exit;
    end;
  end;
  Result := nil;
end;

function TDbItemList.GetItemByName(ItemName: string; Wildcard: Boolean = False): TDbItem;
var
  i: Integer;
begin
  if Wildcard then
  begin
    for i := 0 to Count - 1 do
    begin
      if Pos(ItemName, (Items[i] as TDbItem).Name) > 0 then
      begin
        Result := (Items[i] as TDbItem);
        Exit;
      end;
    end;
  end

  else
  begin
    for i := 0 to Count - 1 do
    begin
      if (Items[i] as TDbItem).Name = ItemName then
      begin
        Result := (Items[i] as TDbItem);
        Exit;
      end;
    end;
  end;
  Result := nil;
end;

function TDbItemList.GetItemIDByName(ItemName: string; Wildcard: Boolean = False): Integer;
var
  Item: TDbItem;
begin
  Result := -1;
  Item := GetItemByName(ItemName, Wildcard);
  if Assigned(Item) then
    Result := Item.ID;
end;

function TDbItemList.GetItemNameByID(ItemID: Integer): string;
var
  Item: TDbItem;
begin
  Result := '';
  Item := GetItemByID(ItemID);
  if Assigned(Item) then
    Result := Item.Name;
end;

function TDbItemList.NewItem(ASetNewID: Boolean): TDbItem;
var
  NewItem: TDbItem;
begin
  NewItem := TDbItem.Create();
  AddItem(NewItem, ASetNewID);
  Result := NewItem;
end;

// === TDbDriver ===
constructor TDbDriver.Create();
begin
  TablesList := TObjectList.Create(False);
end;

destructor TDbDriver.Destroy();
begin
  self.Close();
  self.TablesList.Free();
end;

function TDbDriver.GetDbTableInfo(TableName: String): TDbTableInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to self.TablesList.Count - 1 do
  begin
    if (self.TablesList[i] as TDbTableInfo).TableName = TableName then
    begin
      Result := (self.TablesList[i] as TDbTableInfo);
      Exit;
    end;
  end;
end;

// === TDbDriverSQLite ===
constructor TDbDriverSQLite.Create();
begin
  inherited Create();
  self.Active := False;
end;

procedure TDbDriverSQLite.CheckTable(TableInfo: TDbTableInfo);
var
  rs: IMkSqlStmt;
  s, sn, st, sql: string;
  i: Integer;
begin
  if not Assigned(db) then
    Exit;
  if TableInfo.Checked then
    Exit;
  if self.TablesList.IndexOf(TableInfo) >= 0 then
    Exit;

  // sql:='SELECT * FROM sqlite_master WHERE type=''table'' and name='''+TableInfo.TableName+'''';
  // DebugSQL(sql);
  rs := db.SchemaTableInfo(TableInfo.TableName);
  if rs.rowCount <= 0 then
  begin
    s := '';
    for i := 0 to TableInfo.FieldsCount - 1 do
    begin
      sn := TableInfo.Fields[i];
      st := TableInfo.Types[i];
      if Length(s) > 0 then
        s := s + ',';
      s := s + '''' + sn + '''';
      if sn = 'id' then
      begin
        s := s + ' INTEGER PRIMARY KEY NOT NULL';
        TableInfo.KeyFieldName := sn;
      end
      else if st = 'I' then
        s := s + ' INTEGER NOT NULL'
      else if st = 'S' then
        s := s + ' TEXT NOT NULL'
      else if st = 'B' then
        s := s + ' INTEGER NOT NULL'
      else if st = 'D' then
        s := s + ' TEXT NOT NULL'
      else if st = '' then // nothing;
      else if st[1] = 'L' then
        s := s + ' INTEGER NOT NULL';
    end;
    rs.Close();
    sql := 'CREATE TABLE ''' + TableInfo.TableName + ''' (' + s + ')';
    DebugSQL(sql);
    rs := db.Exec(sql);
  end;
  rs.Close();

  TableInfo.Checked := True;
  self.TablesList.Add(TableInfo);
end;

function TDbDriverSQLite.Open(ADbName: string): Boolean;
begin
  DBName := ADbName;
  Result := True;
  if Assigned(db) then
    FreeAndNil(db);
  try
    db := TMkSqLite.Create(nil);
    db.DBName := ExtractFileDir(ParamStr(0)) + '\Data\' + ADbName + '.sqlite';
    db.Open();
  except
    Close();
    Result := False;
  end;
  Active := Result;
end;

function TDbDriverSQLite.Close(): Boolean;
begin
  Result := True;
  TablesList.Clear();
  if not Active then
    Exit;
  if not Assigned(db) then
    Exit;
  db.Close();
  FreeAndNil(db);
end;

function TDbDriverSQLite.GetTable(AItemList: TDbItemList; Filter: string = ''): Boolean;
var
  rs: IMkSqlStmt;
  ID, n, m: Integer;
  Item: TDbItem;
  fn, sql: string;
  fl: TStringList;
begin
  Result := False;
  if not Active then
    Exit;
  if not Assigned(AItemList) then
    Exit;
  if not Assigned(db) then
    Exit;

  CheckTable(AItemList.DbTableInfo);

  fl := TStringList.Create(); // filters
  fl.CommaText := Filter;

  sql := 'SELECT * FROM "' + AItemList.DbTableInfo.TableName + '"';
  // filters
  if fl.Count > 0 then
    sql := sql + ' WHERE ';
  for m := 0 to fl.Count - 1 do
  begin
    if m > 0 then
      sql := sql + ' AND ';
    sql := sql + '"' + fl.Names[m] + '"="' + fl.ValueFromIndex[m] + '"';
  end;

  DebugSQL(sql);
  rs := db.Exec(sql);
  while not rs.eof do
  begin
    ID := rs.ValueOf['id'];
    AItemList.DbTableInfo.LastID := ID;

    Item := AItemList.GetItemByID(ID);
    if not Assigned(Item) then
      Item := AItemList.NewItem(False);
    for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
    begin
      fn := AItemList.DbTableInfo.GetField(n);
      Item.SetValue(fn, rs.ValueOf[fn]);
    end;
    rs.Next();
  end;
  Result := True;
end;

function TDbDriverSQLite.SetTable(AItemList: TDbItemList; Filter: string = ''): Boolean;
var
  i, n: Integer;
  Item: TDbItem;
  fn, iv, vl, sql: string;
begin
  Result := False;
  if not Active then
    Exit;
  if not Assigned(AItemList) then
    Exit;
  if not Assigned(db) then
    Exit;
  CheckTable(AItemList.DbTableInfo);

  for i := 0 to AItemList.Count - 1 do
  begin
    vl := '';
    Item := (AItemList[i] as TDbItem);
    for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
    begin
      fn := AItemList.DbTableInfo.GetField(n);
      iv := Item.GetValue(fn);
      if n > 0 then
        vl := vl + ',';
      vl := vl + '"' + iv + '"';
      // vl:=vl+fn+'='''+iv+'''';
    end;
    sql := 'INSERT OR REPLACE INTO "' + AItemList.DbTableInfo.TableName + '" VALUES (' + vl + ')';
    DebugSQL(sql);
    // sql:='UPDATE '+AItemList.DbTableInfo.TableName+' SET '+vl+' WHERE ROWID='+IntToStr(Item.ID);
    db.Exec(sql);
  end;
end;

function TDbDriverSQLite.GetDBItem(FValue: String): TDbItem;
var
  sTableName, sItemID, fn, sql: string;
  i: Integer;
  TableInfo: TDbTableInfo;
  rs: IMkSqlStmt;
begin
  Result := nil;
  if not Assigned(db) then
    Exit;
  i := Pos('~', FValue);
  sTableName := Copy(FValue, 1, i - 1);
  sItemID := Copy(FValue, i + 1, MaxInt);
  TableInfo := self.GetDbTableInfo(sTableName);
  if not Assigned(TableInfo) then
    Exit;

  sql := 'SELECT * FROM ' + TableInfo.TableName + ' WHERE id="' + sItemID + '"';
  DebugSQL(sql);
  rs := db.Exec(sql);
  if not rs.eof then
  begin
    Result := TDbItem.Create();
    for i := 0 to TableInfo.FieldsCount - 1 do
    begin
      fn := TableInfo.GetField(i);
      Result.SetValue(fn, rs.ValueOf[fn]);
    end;
  end;
end;

function TDbDriverSQLite.SetDBItem(FItem: TDbItem): Boolean;
var
  n: Integer;
  TableInfo: TDbTableInfo;
  fn, iv, vl, sql: string;
begin
  Result := False;
  if not Active then
    Exit;
  if not Assigned(FItem) then
    Exit;
  if not Assigned(db) then
    Exit;

  TableInfo := FItem.DbTableInfo;
  if not Assigned(TableInfo) then
    Exit;
  CheckTable(TableInfo);

  vl := '';
  for n := 0 to TableInfo.FieldsCount - 1 do
  begin
    fn := TableInfo.GetField(n);
    iv := FItem.GetValue(fn);
    if n > 0 then
      vl := vl + ',';
    vl := vl + '"' + iv + '"';
    // vl:=vl+fn+'='''+iv+'''';
  end;
  sql := 'INSERT OR REPLACE INTO "' + TableInfo.TableName + '" VALUES (' + vl + ')';
  DebugSQL(sql);
  // sql:='UPDATE '+AItemList.DbTableInfo.TableName+' SET '+vl+' WHERE ROWID='+IntToStr(Item.ID);
  db.Exec(sql);

  Result := True;
end;

// === TDbDriverCSV ===
function TDbDriverCSV.Open(ADbName: string): Boolean;
begin
  self.DBName := ADbName;
  self.dbPath := ExtractFileDir(ParamStr(0)) + '\Data\';
  Result := True;
end;

function TDbDriverCSV.Close(): Boolean;
begin
  Result := True;
end;

procedure TDbDriverCSV.CheckTable(TableInfo: TDbTableInfo);
begin
  if TableInfo.Checked then
    Exit;
  if self.TablesList.IndexOf(TableInfo) >= 0 then
    Exit;

  TableInfo.Checked := True;
  self.TablesList.Add(TableInfo);
end;

function TDbDriverCSV.GetTable(AItemList: TDbItemList; Filter: string = ''): Boolean;
var
  sl, vl, fl: TStringList;
  i, n, m, ID: Integer;
  Item: TDbItem;
  fn: string;
  FilterOk: Boolean;
begin
  Result := False;
  if not Assigned(AItemList) then
    Exit;
  CheckTable(AItemList.DbTableInfo);
  fn := self.dbPath + '\' + AItemList.DbTableInfo.TableName + '.lst';
  if not FileExists(fn) then
    Exit;
  sl := TStringList.Create();
  try
    sl.LoadFromFile(fn);
  except
    sl.Free();
    Exit;
  end;

  vl := TStringList.Create(); // row values
  fl := TStringList.Create(); // filters
  try
    fl.CommaText := Filter;

    // первая строка - список колонок!
    for i := 1 to sl.Count - 1 do
    begin
      vl.Clear();
      vl.CommaText := StringReplace(sl[i], '~>', #13 + #10, [rfReplaceAll]);
      if vl.Count = 0 then
        Continue;
      if vl.Count < AItemList.DbTableInfo.FieldsCount then
        Continue; // !!

      ID := StrToInt(vl[0]);
      AItemList.DbTableInfo.LastID := ID;

      // check filters
      FilterOk := True;
      if fl.Count > 0 then
      begin
        for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
        begin
          fn := AItemList.DbTableInfo.GetField(n);
          for m := 0 to fl.Count - 1 do
          begin
            if fl.Names[m] = fn then
            begin
              if fl.ValueFromIndex[m] <> vl[n] then
                FilterOk := False;
              Break;
            end;
          end;
        end;
      end;

      if not FilterOk then
        Continue;
      // Create new item
      Item := AItemList.GetItemByID(ID);
      if not Assigned(Item) then
        Item := AItemList.NewItem(False);

      // fill item values
      for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
      begin
        fn := AItemList.DbTableInfo.GetField(n);
        Item.SetValue(fn, vl[n]);
      end;
    end;
  finally
    fl.Free();
    vl.Free();
    sl.Free();
  end;
  Result := True;
end;

function TDbDriverCSV.SetTable(AItemList: TDbItemList; Filter: string = ''): Boolean;
var
  sl, vl: TStringList;
  i, n: Integer;
  Item: TDbItem;
  fn: string;
begin
  Result := False;
  if not Assigned(AItemList) then
    Exit;
  CheckTable(AItemList.DbTableInfo);

  sl := TStringList.Create();
  vl := TStringList.Create();
  try
    // columns headers
    for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
    begin
      fn := AItemList.DbTableInfo.GetField(n);
      vl.Add(fn);
    end;
    sl.Add(vl.CommaText);

    // rows
    for i := 0 to AItemList.Count - 1 do
    begin
      vl.Clear();
      Item := (AItemList[i] as TDbItem);
      for n := 0 to AItemList.DbTableInfo.FieldsCount - 1 do
      begin
        fn := AItemList.DbTableInfo.GetField(n);
        vl.Add(Item.GetValue(fn));
      end;
      sl.Add(StringReplace(vl.CommaText, #13 + #10, '~>', [rfReplaceAll]));
    end;

    sl.SaveToFile(self.dbPath + '\' + AItemList.DbTableInfo.TableName + '.lst');
  finally
    vl.Free();
    sl.Free();
  end;
end;

function TDbDriverCSV.GetDBItem(FValue: String): TDbItem;
var
  sTableName, sItemID: string;
  i: Integer;
  TableInfo: TDbTableInfo;
  ItemList: TDbItemList;
  Filter: string;
begin
  Result := nil;
  i := Pos('~', FValue);
  sTableName := Copy(FValue, 1, i - 1);
  sItemID := Copy(FValue, i + 1, MaxInt);
  TableInfo := self.GetDbTableInfo(sTableName);
  if not Assigned(TableInfo) then
    Exit;
  try
    ItemList := TDbItemList.Create(TableInfo);
    Filter := 'id=' + sItemID;

    if GetTable(ItemList, Filter) then
    begin
      if ItemList.Count > 0 then
      begin
        Result := TDbItem.Create();
        Result.Assign(ItemList[0] as TDbItem);
      end;
    end;
  finally
    FreeAndNil(ItemList);
  end;
end;

function TDbDriverCSV.SetDBItem(FItem: TDbItem): Boolean;
var
  AItemList: TDbItemList;
  AItem: TDbItem;
  i: Integer;
  fn: string;
begin
  Result := False;
  AItemList := TDbItemList.Create(FItem.DbTableInfo);
  try
    GetTable(AItemList);
    AItem := AItemList.GetItemByID(FItem.ID);
    if not Assigned(AItem) then
    begin
      FreeAndNil(AItemList);
      Exit;
    end;
    for i := 0 to FItem.DbTableInfo.FieldsCount - 1 do
    begin
      fn := FItem.DbTableInfo.GetField(i);
      AItem.Values[fn] := FItem.Values[fn];
    end;
    SetTable(AItemList);
  finally
    FreeAndNil(AItemList);
  end;
  Result := True;
end;

end.
