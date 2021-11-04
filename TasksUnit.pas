unit TasksUnit;

interface

uses Classes, Contnrs, SysUtils, DbUnit;

type
  TTaskItem = class(TDbItem)
  public
    Desc: string;
    Text: string;
    Priority: Integer;
    // 0-none, 1-normal, 2-urgent, 3-critical, 4-completed, 5-paused
    Status: Integer;
    PersonID: Integer;
    DepartID: Integer;
    Author: string;
    BeginDate: TDateTime;
    EndDate: TDateTime;
    function GetValue(const AName: string): string; override;
    procedure SetValue(const AName, AValue: string); override;
    procedure FromString(Str: string);
    function ToString(): string;
  end;

  TTaskFilterType = (None, Person, Department);

  TTaskList = class(TDbItemList)
  private
    FilterID: Integer;
    FilterType: TTaskFilterType;
  public
    BeginDate: TDateTime;
    EndDate: TDateTime;
    constructor Create(); reintroduce;
    function NewItem(): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    // Filter type: 0-none, 1-person, 2-depart
    procedure SetFilter(AFilterType: TTaskFilterType; AFilterID: Integer);
  end;

type
  TStringArray = array of string;

function TaskStatusToPriority(AValue: Integer): Integer;

implementation

uses MainFunc;

function TaskStatusToPriority(AValue: Integer): Integer;
begin
  // 0-none, 1-normal, 2-urgent, 3-critical, 4-completed, 5-paused
  case AValue of
    1: Result := 10;
    2: Result := 11;
    3: Result := 12;
    4: Result := 5;
    5: Result := 1;
  else
    Result := 0;
  end;
end;

// === TTaskItem ===
function TTaskItem.GetValue(const AName: string): string;
begin
  if AName = 'id' then
    Result := IntToStr(self.ID)
  else if AName = 'name' then
    Result := self.Name
  else if AName = 'text' then
    Result := self.Text
  else if AName = 'priority' then
    Result := IntToStr(self.Priority)
  else if AName = 'status' then
    Result := IntToStr(self.Status)
  else if AName = 'person_id' then
    Result := IntToStr(self.PersonID)
  else if AName = 'depart_id' then
    Result := IntToStr(self.DepartID)
  else if AName = 'author' then
    Result := self.Author
  else if AName = 'begin_date' then
    Result := DateTimeToStr(self.BeginDate)
  else if AName = 'end_date' then
    Result := DateTimeToStr(self.EndDate)
  else
    Result := '';
end;

procedure TTaskItem.SetValue(const AName, AValue: string);
begin
  if AName = 'id' then
    self.ID := StrToIntDef(AValue, 0)
  else if AName = 'name' then
    self.Name := AValue
  else if AName = 'text' then
    self.Text := AValue
  else if AName = 'priority' then
    self.Priority := StrToIntDef(AValue, 0)
  else if AName = 'status' then
    self.Status := StrToIntDef(AValue, 0)
  else if AName = 'person_id' then
    self.PersonID := StrToIntDef(AValue, 0)
  else if AName = 'depart_id' then
    self.DepartID := StrToIntDef(AValue, 0)
  else if AName = 'author' then
    self.Author := AValue
  else if AName = 'begin_date' then
    self.BeginDate := StrToDateTime(AValue)
  else if AName = 'end_date' then
    self.EndDate := StrToDateTime(AValue);
end;

procedure TTaskItem.FromString(Str: string);
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create();
  try
    sl.CommaText := StringReplace(Str, '~>', #13 + #10, [rfReplaceAll]);

    i := 0;
    Self.ID := StrToIntDef(sl[i], 0);
    Inc(i);
    Self.Desc := sl[i];
    Inc(i);
    Self.Text := sl[i];
    Inc(i);
    Self.Priority := StrToIntDef(sl[i], 0);
    Inc(i);
    Self.Status := StrToIntDef(sl[i], 0);
    Inc(i);
    Self.PersonID := StrToIntDef(sl[i], 0);
    Inc(i);
    Self.DepartID := StrToIntDef(sl[i], 0);
    Inc(i);
    Self.Author := sl[i];
    Inc(i);
    if sl[i] <> '' then
      Self.BeginDate := StrToDateTime(sl[i]);
    Inc(i);
    if sl[i] <> '' then
      Self.EndDate := StrToDateTime(sl[i]);

  finally
    sl.Free();
  end;
end;

function TTaskItem.ToString(): string;
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Add(IntToStr(Self.ID));
    sl.Add(Self.Desc);
    sl.Add(Self.Text);
    sl.Add(IntToStr(Self.Priority));
    sl.Add(IntToStr(Self.Status));
    sl.Add(IntToStr(Self.PersonID));
    sl.Add(IntToStr(Self.DepartID));
    sl.Add(Self.Author);
    sl.Add(DateTimeToStr(Self.BeginDate));
    sl.Add(DateTimeToStr(Self.EndDate));
    Result := StringReplace(sl.CommaText, #13 + #10, '~>', [rfReplaceAll]);
  finally
    sl.Free();
  end;
end;

// === TTaskList ===
constructor TTaskList.Create();
var
  ti: TDbTableInfo;
begin
  ti := DbDriver.GetDbTableInfo('tasks');
  if not Assigned(ti) then
  begin
    ti := TDbTableInfo.Create();
    with ti do
    begin
      TableName := 'tasks';
      AddField('id', 'I');
      AddField('name', 'S');
      AddField('text', 'S');
      AddField('priority', 'I');
      AddField('status', 'I');
      AddField('person_id', 'L:personnel');
      AddField('depart_id', 'I');
      AddField('author', 'S');
      AddField('begin_date', 'D');
      AddField('end_date', 'D');
    end;
  end;

  inherited Create(ti);
end;

procedure TTaskList.LoadList();
var
  sFilter: string;
begin
  if self.FilterType = TTaskFilterType.Person then
    sFilter := 'person_id=' + IntToStr(self.FilterID)
  else
  if self.FilterType = TTaskFilterType.Department then
    sFilter := 'depart_id=' + IntToStr(self.FilterID);
  DbDriver.GetTable(self, sFilter);
end;

procedure TTaskList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  Result := TaskStatusToPriority(TTaskItem(Item2).Status) - TaskStatusToPriority(TTaskItem(Item1).Status);
  if Result <> 0 then Exit;

  if TTaskItem(Item2).BeginDate > TTaskItem(Item1).BeginDate then
    Result := -1
  else if TTaskItem(Item2).BeginDate < TTaskItem(Item1).BeginDate then
    Result := 1;
end;

procedure TTaskList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

function TTaskList.NewItem(): TDbItem;
var
  NewItem: TTaskItem;
begin
  NewItem := TTaskItem.Create();
  self.AddItem(NewItem, True);
  Result := NewItem;
end;

procedure TTaskList.SetFilter(AFilterType: TTaskFilterType; AFilterID: Integer);
begin
  self.FilterType := AFilterType;
  self.FilterID := AFilterID;
  self.LoadList();
end;

end.
