unit MsgBoardUnit;

interface
uses Classes, Contnrs, SysUtils, DbUnit;

type
  TMsgBoardItem = class(TDbItem)
  public
    Desc: string;
    Text: string;
    Priority: integer;
    Author: string;
    BeginDate: TDateTime;
    EndDate: TDateTime;
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  TMsgBoardList = class(TDbItemList)
  private
    //LastID: integer;
    //function CompareFunc(Item1, Item2: Pointer): Integer;
  public
    BeginDate: TDateTime;
    EndDate: TDateTime;
    FileName: string;
    constructor Create(); reintroduce;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    //function AddItem(AItem: TMsgBoardItem): integer;
    function NewItem(): TDbItem; override;
  end;


implementation
uses MainFunc;

// === TMsgBoardItem ===
function TMsgBoardItem.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='desc' then
    result:=self.Desc
  else if FName='text' then
    result:=self.Text
  else if FName='priority' then
    result:=IntToStr(self.Priority)
  else if FName='author' then
    result:=self.Author
  else if FName='begin_date' then
    result:=DateTimeToStr(self.BeginDate)
  else if FName='end_date' then
    result:=DateTimeToStr(self.EndDate)
  else
    result:='';
end;

procedure TMsgBoardItem.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='desc' then
    self.Desc:=FValue
  else if FName='text' then
    self.Text:=FValue
  else if FName='priority' then
    self.Priority:=StrToIntDef(FValue, 0)
  else if FName='author' then
    self.Author:=FValue
  else if FName='begin_date' then
    self.BeginDate:=StrToDateTime(FValue)
  else if FName='end_date' then
    self.EndDate:=StrToDateTime(FValue);
end;

// === TMsgBoardList ===
constructor TMsgBoardList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('msg_board');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='msg_board';
      AddField('id','I');
      AddField('desc','S');
      AddField('text','S');
      AddField('priority','I');
      AddField('author','S');
      AddField('begin_date','D');
      AddField('end_date','D');
    end;
  end;
  inherited Create(ti);
end;

procedure TMsgBoardList.LoadList();
begin
  DbDriver.GetTable(self);
end;

procedure TMsgBoardList.SaveList();
begin
  DbDriver.SetTable(self);
end;

{function TMsgBoardList.AddItem(AItem: TMsgBoardItem): Integer;
begin
  AItem.ID:=LastID;
  Inc(LastID);
  Add(AItem);
end;}

function TMsgBoardList.NewItem(): TDbItem;
var
  NewItem: TMsgBoardItem;
begin
  NewItem:=TMsgBoardItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  result := TMsgBoardItem(Item2).Priority - TMsgBoardItem(Item1).Priority;
end;

procedure TMsgBoardList.Sort();
begin
  inherited Sort(@CompareFunc);
end;


end.
