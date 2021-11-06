unit TableEditForm;

interface

uses
  SysUtils, Controls, Forms, DbUnit, ToolWin, ComCtrls, ExtCtrls, ValEdit,
  Classes, Grids;

type
  TfrmTableEdit = class(TForm)
    sgTable: TStringGrid;
    vleItemEdit: TValueListEditor;
    Splitter1: TSplitter;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    tbNewItem: TToolButton;
    tbSaveItem: TToolButton;
    tbDeleteItem: TToolButton;
    tbCopyItem: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgTableSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    CurItem: TDbItem;
    procedure ReadItem(ARow: Integer);
    procedure SaveItem(Item: TDbItem);
    procedure CopyItem(Item: TDbItem);
  public
    { Public declarations }
    DbItemList: TDbItemList;
    procedure ReadList();
  end;

var
  frmTableEdit: TfrmTableEdit;

implementation

uses Main;

{$R *.dfm}


procedure TfrmTableEdit.ReadList();
var
  Item: TDbItem;
  i, n, m: Integer;
  fn, s: string;
  ti: TDbTableInfo;
  Len: array of Integer;
begin
  if not Assigned(DbItemList) then
    Exit;

  ti := DbItemList.DbTableInfo;

  // ItemEdit
  vleItemEdit.Strings.Clear();
  for i := 0 to ti.FieldsCount - 1 do
  begin
    vleItemEdit.InsertRow('[' + ti.Types[i] + '] ' + ti.Fields[i], '', true);
  end;

  sgTable.Visible := false;
  sgTable.ColWidths[0] := 32;
  sgTable.RowCount := DbItemList.Count + 1;
  // колонки
  sgTable.ColCount := ti.FieldsCount + 1;
  for i := 0 to sgTable.ColCount - 1 do
  begin
    if i = 0 then
    begin
      sgTable.Cells[i, 0] := '№';
    end
    else
    begin
      fn := ti.Fields[i - 1];
      sgTable.Cells[i, 0] := fn;
    end;
  end;
  SetLength(Len, ti.FieldsCount);
  for i := 0 to ti.FieldsCount - 1 do
    Len[i] := 0;

  // строки
  for n := 0 to DbItemList.Count - 1 do
  begin
    Item := (DbItemList[n] as TDbItem);
    for i := 0 to sgTable.ColCount - 1 do
    begin
      if i = 0 then
      begin
        sgTable.Cells[i, n + 1] := IntToStr(n + 1);
      end
      else
      begin
        fn := ti.Fields[i - 1];
        s := Item.GetValue(fn);
        sgTable.Cells[i, n + 1] := s;
        Inc(Len[i - 1], Length(s));
      end;
    end;
  end;

  n := DbItemList.Count;
  if n = 0 then
    n := 1;
  for i := 0 to ti.FieldsCount - 1 do
  begin
    m := Round(Len[i] / n * 8);
    if m < 24 then
      m := 24;
    sgTable.ColWidths[i + 1] := m;
  end;
  SetLength(Len, 0);

  sgTable.Visible := true;
end;

procedure TfrmTableEdit.ReadItem(ARow: Integer);
var
  Item: TDbItem;
  i: Integer;
  fn: string;
  ti: TDbTableInfo;
begin
  if ARow < 1 then
    Exit;
  ti := DbItemList.DbTableInfo;
  Item := (DbItemList[ARow - 1] as TDbItem);
  CurItem := Item;

  vleItemEdit.Strings.Clear();
  for i := 0 to ti.FieldsCount - 1 do
  begin
    fn := ti.Fields[i];
    vleItemEdit.InsertRow('[' + ti.Types[i] + '] ' + fn, Item.GetValue(fn), true);
  end;
end;

procedure TfrmTableEdit.SaveItem(Item: TDbItem);
var
  i: Integer;
  fn: string;
  ti: TDbTableInfo;
begin
  if not Assigned(Item) then
    Exit;
  ti := DbItemList.DbTableInfo;

  for i := 0 to ti.FieldsCount - 1 do
  begin
    fn := ti.Fields[i];
    Item.SetValue(fn, vleItemEdit.Values['[' + ti.Types[i] + '] ' + fn]);
  end;

end;

procedure TfrmTableEdit.CopyItem(Item: TDbItem);
var
  NewItem: TDbItem;
  i: Integer;
  fn: string;
  ti: TDbTableInfo;
begin
  if not Assigned(Item) then
    Exit;
  ti := DbItemList.DbTableInfo;
  NewItem := DbItemList.NewItem(false);

  for i := 0 to ti.FieldsCount - 1 do
  begin
    fn := ti.Fields[i];
    if fn = 'id' then
      Continue;
    NewItem.SetValue(fn, Item.GetValue(fn));
  end;
end;

procedure TfrmTableEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release();
end;

procedure TfrmTableEdit.sgTableSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  ReadItem(ARow);
end;

procedure TfrmTableEdit.ToolButtonClick(Sender: TObject);
begin
  if Sender = tbNewItem then
  begin
    DbItemList.NewItem(True);
    ReadList();
  end
  else if Sender = tbCopyItem then
  begin
    CopyItem(CurItem);
    ReadList();
  end
  else if Sender = tbSaveItem then
  begin
    SaveItem(CurItem);
    ReadList();
  end
  else if Sender = tbDeleteItem then
  begin
    DbItemList.Delete(sgTable.Row - 1);
    ReadList();
  end;

end;

end.
