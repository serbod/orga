unit LocalOrdersUnit;

interface
uses Classes, Contnrs, SysUtils, DbUnit;

type
  // Служебная записка
  TLocOrderItem = class(TDbItem)
  public
    From: string;
    Dest: string;
    Text: string;
    Reply: string;
    Author: string;
    Signed: boolean;
    //constructor Create();
    //destructor Destroy();
    function GetValue(const FName: string): string; override;
    procedure SetValue(const FName, FValue: string); override;
  end;

  // Список служебных записок
  TLocOrderList = class(TDbItemList)
  private
    Filter: string;
  public
    FileName: string;
    constructor Create(); reintroduce;
    function NewItem(): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    procedure SetFilter(AFilter: string);
  end;

implementation
uses MainFunc;

//===========================================
// TLocOrderItem
//===========================================
function TLocOrderItem.GetValue(const FName: string): string;
begin
  if FName='id' then
    result:=IntToStr(self.ID)
  else if FName='from' then
    result:=self.From
  else if FName='dest' then
    result:=self.Dest
  else if FName='text' then
    result:=self.Text
  else if FName='reply' then
    result:=self.Reply
  else if FName='author' then
    result:=self.Author
  else if FName='signed' then
    result:=BoolToStr(self.Signed)
  else if FName='timestamp' then
    result:=DateTimeToStr(self.Timestamp)
  else
    result:='';
end;

procedure TLocOrderItem.SetValue(const FName, FValue: string);
begin
  if FName='id' then
    self.ID:=StrToIntDef(FValue, 0)
  else if FName='from' then
    self.From:=FValue
  else if FName='dest' then
    self.Dest:=FValue
  else if FName='text' then
    self.Text:=FValue
  else if FName='reply' then
    self.Reply:=FValue
  else if FName='author' then
    self.Author:=FValue
  else if FName='signed' then
    self.Signed:=(FValue<>'0')
  else if FName='timestamp' then
    self.Timestamp:=StrToDateTimeDef(FValue, self.Timestamp);
end;

//===========================================
// TLocOrderList
//===========================================
constructor TLocOrderList.Create();
var
  ti: TDbTableInfo;
begin
  ti:=DbDriver.GetDbTableInfo('loc_orders');
  if not Assigned(ti) then
  begin
    ti:=TDbTableInfo.Create();
    with ti do
    begin
      TableName:='loc_orders';
      AddField('id','I');
      AddField('from','S');
      AddField('dest','S');
      AddField('text','S');
      AddField('reply','S');
      AddField('author','S');
      AddField('signed','B');
      AddField('timestamp','D');
    end;
  end;
  inherited Create(ti);
  self.Filter:='';
end;

function TLocOrderList.NewItem(): TDbItem;
var
  NewItem: TLocOrderItem;
begin
  NewItem:=TLocOrderItem.Create();
  self.AddItem(NewItem, true);
  result:=NewItem;
end;

procedure TLocOrderList.LoadList();
begin
  DbDriver.GetTable(self, Filter);
end;

procedure TLocOrderList.SaveList();
begin
  DbDriver.SetTable(self);
end;

function CompareFunc(Item1, Item2: Pointer): Integer;
begin
  {> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
   < 0 (negative)	Item1 is greater than Item2}

  result := Round(TLocOrderItem(Item1).Timestamp - TLocOrderItem(Item2).Timestamp);
  //if result=0 then result := AnsiCompareStr(TLocOrderItem(Item1).Desc, TLocOrderItem(Item2).Desc);
end;

procedure TLocOrderList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

procedure TLocOrderList.SetFilter(AFilter: string);
begin
  self.Filter:=AFilter;
  self.LoadList();
end;

end.
