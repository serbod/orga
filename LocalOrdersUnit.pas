(*
—лужебные записки - текстовые сообщени€ от сотрудника/подразделени€ другому
сотруднику/подразделению. —одержит ответ (резолюцию) с подтверждением или отказом.

Ёксперимент с полностью виртуальными свойствами, хран€щимис€ в списке значений свойств

*)
unit LocalOrdersUnit;

interface

uses Classes, Contnrs, SysUtils, DbUnit;

type
  // —лужебна€ записка
  TLocOrderItem = class(TDbItem)
  private
    function GetAuthor: string;
    function GetFromPersID: Integer;
    function GetReply: string;
    function GetSigned: Boolean;
    function GetText: string;
    function GetToPersID: Integer;
    procedure SetAuthor(const Value: string);
    procedure SetFromPersID(const Value: Integer);
    procedure SetReply(const Value: string);
    procedure SetSigned(const Value: Boolean);
    procedure SetText(const Value: string);
    procedure SetToPersID(const Value: Integer);
  public
    property FromPersID: Integer read GetFromPersID write SetFromPersID;
    property ToPersID: Integer read GetToPersID write SetToPersID;
    property Text: string read GetText write SetText;
    property Reply: string read GetReply write SetReply;
    property Author: string read GetAuthor write SetAuthor;
    property Signed: Boolean read GetSigned write SetSigned;
    // constructor Create();
    // destructor Destroy();
    //function GetValue(const FName: string): string; override;
    //procedure SetValue(const FName, FValue: string); override;
  end;

  // —писок служебных записок
  TLocOrderList = class(TDbItemList)
  private
    Filter: string;
  public
    FileName: string;
    constructor Create(); reintroduce;
    function NewItem(ASetNewID: Boolean): TDbItem; override;
    procedure LoadList();
    procedure SaveList();
    procedure Sort();
    procedure SetFilter(AFilter: string);
  end;

implementation

uses MainFunc;

const
  FIELD_ID_       = 0;
  FIELD_FROM_PERS = 1;
  FIELD_TO_PERS   = 2;
  FIELD_TEXT      = 3;
  FIELD_REPLY     = 4;
  FIELD_AUTHOR    = 5;
  FIELD_SIGNED    = 6;
  FIELD_TIMESTAMP = 7;

// ===========================================
// TLocOrderItem
// ===========================================
function TLocOrderItem.GetAuthor: string;
begin
  Result := FValues[FIELD_AUTHOR];
end;

function TLocOrderItem.GetFromPersID: Integer;
begin
  Result := StrToIntDef(FValues[FIELD_FROM_PERS], 0);
end;

function TLocOrderItem.GetReply: string;
begin
  Result := FValues[FIELD_REPLY];
end;

function TLocOrderItem.GetSigned: Boolean;
begin
  Result := (FValues[FIELD_SIGNED] <> '0');
end;

function TLocOrderItem.GetText: string;
begin
  Result := FValues[FIELD_TEXT];
end;

function TLocOrderItem.GetToPersID: Integer;
begin
  Result := StrToIntDef(FValues[FIELD_TO_PERS], 0);
end;

{function TLocOrderItem.GetValue(const FName: string): string;
begin
  if FName = 'id' then
    Result := IntToStr(self.ID)
  else if FName = 'from_pers_id' then
    Result := IntToStr(self.FromPersID)
  else if FName = 'to_pers_id' then
    Result := IntToStr(self.ToPersID)
  else if FName = 'text' then
    Result := self.Text
  else if FName = 'reply' then
    Result := self.Reply
  else if FName = 'author' then
    Result := self.Author
  else if FName = 'signed' then
    Result := BoolToStr(self.Signed)
  else if FName = 'timestamp' then
    Result := DateTimeToStr(self.Timestamp)
  else
    Result := '';
end; }

procedure TLocOrderItem.SetAuthor(const Value: string);
begin
  FValues[FIELD_AUTHOR] := Value;
end;

procedure TLocOrderItem.SetFromPersID(const Value: Integer);
begin
  FValues[FIELD_FROM_PERS] := IntToStr(Value);
end;

procedure TLocOrderItem.SetReply(const Value: string);
begin
  FValues[FIELD_REPLY] := Value;
end;

procedure TLocOrderItem.SetSigned(const Value: Boolean);
begin
  FValues[FIELD_SIGNED] := BoolToStr(Value);
end;

procedure TLocOrderItem.SetText(const Value: string);
begin
  FValues[FIELD_TEXT] := Value;
end;

procedure TLocOrderItem.SetToPersID(const Value: Integer);
begin
  FValues[FIELD_TO_PERS] := IntToStr(Value);
end;

{procedure TLocOrderItem.SetValue(const FName, FValue: string);
begin
  if FName = 'id' then
    self.ID := StrToIntDef(FValue, 0)
  else if FName = 'from_pers_id' then
    self.FromPersID := StrToIntDef(FValue, 0)
  else if FName = 'to_pers_id' then
    self.ToPersID := StrToIntDef(FValue, 0)
  else if FName = 'text' then
    self.Text := FValue
  else if FName = 'reply' then
    self.Reply := FValue
  else if FName = 'author' then
    self.Author := FValue
  else if FName = 'signed' then
    self.Signed := (FValue <> '0')
  else if FName = 'timestamp' then
    self.Timestamp := StrToDateTimeDef(FValue, self.Timestamp);
end; }

// ===========================================
// TLocOrderList
// ===========================================
constructor TLocOrderList.Create();
var
  ti: TDbTableInfo;
begin
  ti := DbDriver.GetDbTableInfo('loc_orders');
  if not Assigned(ti) then
  begin
    ti := TDbTableInfo.Create();
    with ti do
    begin
      TableName := 'loc_orders';
      AddField('id', 'I');
      AddField('from_pers_id', 'I');
      AddField('to_pers_id', 'I');
      AddField('text', 'S');
      AddField('reply', 'S');
      AddField('author', 'S');
      AddField('signed', 'B');
      AddField('timestamp', 'D');
    end;
  end;
  inherited Create(ti);
  self.Filter := '';
end;

function TLocOrderList.NewItem(ASetNewID: Boolean): TDbItem;
var
  NewItem: TLocOrderItem;
begin
  NewItem := TLocOrderItem.Create();
  AddItem(NewItem, ASetNewID);
  Result := NewItem;
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
  { > 0 (positive)	Item1 is less than Item2
    0	Item1 is equal to Item2
    < 0 (negative)	Item1 is greater than Item2 }

  Result := Round(TLocOrderItem(Item1).Timestamp - TLocOrderItem(Item2).Timestamp);
  // if result=0 then result := AnsiCompareStr(TLocOrderItem(Item1).Desc, TLocOrderItem(Item2).Desc);
end;

procedure TLocOrderList.Sort();
begin
  inherited Sort(@CompareFunc);
end;

procedure TLocOrderList.SetFilter(AFilter: string);
begin
  self.Filter := AFilter;
  self.LoadList();
end;

end.
