unit MailUnit;

interface
uses Classes, Contnrs, SysUtils, DbUnit;

type
  TMailMsg = class(TDbItem)
  public
    From: string;
    Dest: string;
    Subj: string;
    Text: string;
    Priority: integer;
    Status: integer;
    Author: string;
    RecvDate: TDateTime;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  TMailMsgList = class(TDbItemList)
  public
    //FileName: string;
    GroupName: string;
    GroupFullName: string;
    constructor Create(ATableName: string = 'mail'); reintroduce;
    function NewItem(): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    procedure SetTableName(FName: string);
  end;

  TMailGroupsList = class(TObjectList);

implementation
uses MainFunc;

//===========================================
// TMailMsg
//===========================================
function TMailMsg.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='from' then
    result:=self.From
  else if FName='dest' then
    result:=self.Dest
  else if FName='subj' then
    result:=self.Subj
  else if FName='text' then
    result:=self.Text
  else if FName='priority' then
    result:=IntToStr(self.Priority)
  else if FName='status' then
    result:=IntToStr(self.Status)
  else if FName='author' then
    result:=self.Author
  else if FName='recv_date' then
    result:=DateTimeToStr(self.RecvDate)
  else
    result:='';
end;

procedure TMailMsg.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='from' then
    self.From:=FValue
  else if FName='dest' then
    self.Dest:=FValue
  else if FName='subj' then
    self.Subj:=FValue
  else if FName='text' then
    self.Text:=FValue
  else if FName='priority' then
    self.Priority:=StrToIntDef(FValue, 0)
  else if FName='status' then
    self.Status:=StrToIntDef(FValue, 0)
  else if FName='author' then
    self.Author:=FValue
  else if FName='recv_date' then
    self.RecvDate:=StrToDateTimeDef(FValue, self.RecvDate);
end;


//===========================================
// TMailMsgList
//===========================================
constructor TMailMsgList.Create(ATableName: string = 'mail');
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo(ATableName);
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
    TableName:=ATableName;
    AddField('id','I');
    AddField('from','S');
    AddField('dest','S');
    AddField('subj','S');
    AddField('text','S');
    AddField('priority','I');
    AddField('status','I');
    AddField('author','S');
    AddField('recv_date','D');
    end;
  end;
  inherited Create(ti);
end;

function TMailMsgList.NewItem(): TDbItem;
var
  NewItem: TMailMsg;
begin
  NewItem:=TMailMsg.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

procedure TMailMsgList.LoadList();
begin
  DbDriver.GetTable(self);
end;

procedure TMailMsgList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  result := Round(TMailMsg(Item2).RecvDate - TMailMsg(Item1).RecvDate);
end;

procedure TMailMsgList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

procedure TMailMsgList.SetTableName(FName: string);
begin
  self.DbTableInfo.TableName:=FName;
end;

end.
