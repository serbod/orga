unit TasksUnit;

interface
uses Classes, Contnrs, SysUtils, DbUnit;

type
  TTaskItem = class(TDbItem)
  public
    Desc: string;
    Text: string;
    Priority: integer;
    Status: integer;
    PersonID: integer;
    DepartID: integer;
    Author: string;
    BeginDate: TDateTime;
    EndDate: TDateTime;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  TTaskList = class(TDbItemList)
  private
    AFilterID: integer;
    AFilterType: integer;
  public
    BeginDate: TDateTime;
    EndDate: TDateTime;
    constructor Create(); reintroduce;
    function NewItem(): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    // Filter type: 0-none, 1-person, 2-depart
    procedure SetFilter(FilterType, FilterID: integer);
  end;

type
  TStringArray = array of string;

implementation
uses MainFunc;

// === TTaskItem ===
function TTaskItem.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='name' then
    result:=self.Name
  else if FName='text' then
    result:=self.Text
  else if FName='priority' then
    result:=IntToStr(self.Priority)
  else if FName='status' then
    result:=IntToStr(self.Status)
  else if FName='person_id' then
    result:=IntToStr(self.PersonID)
  else if FName='depart_id' then
    result:=IntToStr(self.DepartID)
  else if FName='author' then
    result:=self.Author
  else if FName='begin_date' then
    result:=DateTimeToStr(self.BeginDate)
  else if FName='end_date' then
    result:=DateTimeToStr(self.EndDate)
  else
    result:='';
end;

procedure TTaskItem.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='name' then
    self.Name:=FValue
  else if FName='text' then
    self.Text:=FValue
  else if FName='priority' then
    self.Priority:=StrToIntDef(FValue, 0)
  else if FName='status' then
    self.Status:=StrToIntDef(FValue, 0)
  else if FName='person_id' then
    self.PersonID:=StrToIntDef(FValue, 0)
  else if FName='depart_id' then
    self.DepartID:=StrToIntDef(FValue, 0)
  else if FName='author' then
    self.Author:=FValue
  else if FName='begin_date' then
    self.BeginDate:=StrToDateTime(FValue)
  else if FName='end_date' then
    self.EndDate:=StrToDateTime(FValue);
end;

// === TTaskList ===
constructor TTaskList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('tasks');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='tasks';
      AddField('id','I');
      AddField('name','S');
      AddField('text','S');
      AddField('priority','I');
      AddField('status','I');
      AddField('person_id','L:personnel');
      AddField('depart_id','I');
      AddField('author','S');
      AddField('begin_date','D');
      AddField('end_date','D');
    end;
  end;

  inherited Create(ti);
end;

procedure StringToItem(Str: string; Task: TTaskItem);
var
  sl: TStringList;
  i: integer;
begin
  sl:=TStringList.Create();
  sl.CommaText:=StringReplace(Str, '~>', #13+#10, [rfReplaceAll]);

  i:=0;
  Task.ID:=StrToIntDef(sl[i], 0);
  Inc(i);
  Task.Desc:=sl[i];
  Inc(i);
  Task.Text:=sl[i];
  Inc(i);
  Task.Priority:=StrToIntDef(sl[i], 0);
  Inc(i);
  Task.Status:=StrToIntDef(sl[i], 0);
  Inc(i);
  Task.PersonID:=StrToIntDef(sl[i], 0);
  Inc(i);
  Task.DepartID:=StrToIntDef(sl[i], 0);
  Inc(i);
  Task.Author:=sl[i];
  Inc(i);
  if sl[i]<>'' then Task.BeginDate:=StrToDateTime(sl[i]);
  Inc(i);
  if sl[i]<>'' then Task.EndDate:=StrToDateTime(sl[i]);

  sl.Free();
end;

function ItemToString(Task: TTaskItem): string;
var
  sl: TStringList;
begin
  sl:=TStringList.Create();
  sl.Add(IntToStr(Task.ID));
  sl.Add(Task.Desc);
  sl.Add(Task.Text);
  sl.Add(IntToStr(Task.Priority));
  sl.Add(IntToStr(Task.Status));
  sl.Add(IntToStr(Task.PersonID));
  sl.Add(IntToStr(Task.DepartID));
  sl.Add(Task.Author);
  sl.Add(DateTimeToStr(Task.BeginDate));
  sl.Add(DateTimeToStr(Task.EndDate));
  result:=StringReplace(sl.CommaText, #13+#10, '~>', [rfReplaceAll]);
  sl.Free();
end;

procedure TTaskList.LoadList();
var
  sFilter: string;
begin
  if self.AFilterType=1 then sFilter:='person_id='+IntToStr(self.AFilterID);
  DbDriver.GetTable(self, sFilter);
end;

procedure TTaskList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  result := TTaskItem(Item2).Priority - TTaskItem(Item1).Priority;
end;

procedure TTaskList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

function TTaskList.NewItem(): TDbItem;
var
  NewItem: TTaskItem;
begin
  NewItem:=TTaskItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

procedure TTaskList.SetFilter(FilterType, FilterID: integer);
begin
  self.AFilterType:=FilterType;
  self.AFilterID:=FilterID;
  self.LoadList();
end;

end.
