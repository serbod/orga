unit PersonListFrame;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  DbUnit, PersonnelUnit;

type
  TFramePersonList = class(TFrame)
    lvPersonnel: TListView;
    panToolbar: TPanel;
    edFilterText: TEdit;
    btnFilterClear: TBitBtn;
    tmr100ms: TTimer;
    procedure lvPersonnelData(Sender: TObject; Item: TListItem);
    procedure tmr100msTimer(Sender: TObject);
    procedure lvPersonnelSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure edFilterTextChange(Sender: TObject);
  private
    { Private declarations }
    FItemsList: TPersList;
    FFilteredItemsList: TPersList;
    FOnItemSelected: TItemSelectedEvent;
    FPrevFilterText: string;
    FSelectedItem: TPersItem;
    procedure UpdateFilteredList();
    procedure SetSelectedItem(const Value: TPersItem);
  public
    { Public declarations }
    NeedRefresh: Boolean;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure RefreshList(AForced: Boolean = True);

    property ItemsList: TPersList read FItemsList;
    property SelectedItem: TPersItem read FSelectedItem write SetSelectedItem;

    property OnItemSelected: TItemSelectedEvent read FOnItemSelected write FOnItemSelected;
  end;

implementation

{$R *.dfm}

uses
  EnterpiseControls;

{ TFramePersonList }

procedure TFramePersonList.AfterConstruction;
begin
  inherited;
  FItemsList := TPersList.Create();
  FFilteredItemsList := TPersList.Create();
  FFilteredItemsList.OwnsObjects := False;
end;

procedure TFramePersonList.BeforeDestruction;
begin
  FreeAndNil(FFilteredItemsList);
  FreeAndNil(FItemsList);
  inherited;
end;

procedure TFramePersonList.edFilterTextChange(Sender: TObject);
begin
  NeedRefresh := True;
end;

procedure TFramePersonList.lvPersonnelData(Sender: TObject; Item: TListItem);
var
  n: Integer;
begin
  if Assigned(Item) then
  begin
    n := Item.Index;
    if n < FFilteredItemsList.Count then
      PersonToListItem(FFilteredItemsList[n] as TPersItem, Item);
  end;
end;

procedure TFramePersonList.lvPersonnelSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  n: Integer;
begin
  if Selected and Assigned(Item) then
  begin
    n := Item.Index;
    if n < FFilteredItemsList.Count then
    begin
      FSelectedItem := FFilteredItemsList[n] as TPersItem;
      if Assigned(OnItemSelected) then OnItemSelected(Self, FSelectedItem);
    end;
  end;
end;

procedure TFramePersonList.RefreshList(AForced: Boolean);
begin
  if AForced then
    NeedRefresh := True;

  if NeedRefresh or (FPrevFilterText <> edFilterText.Text) then
  begin
    UpdateFilteredList();
    FPrevFilterText := edFilterText.Text;
  end;

  if NeedRefresh or (lvPersonnel.Items.Count <> FFilteredItemsList.Count) then
  begin
    lvPersonnel.Items.Count := FFilteredItemsList.Count;
    lvPersonnel.Refresh;
  end;
  NeedRefresh := False;
end;

procedure TFramePersonList.SetSelectedItem(const Value: TPersItem);
begin
  FSelectedItem := Value;
end;

procedure TFramePersonList.tmr100msTimer(Sender: TObject);
begin
  RefreshList(False);
end;

procedure TFramePersonList.UpdateFilteredList();
var
  i: Integer;
  Item: TPersItem;
  sFilter: string;
begin
  sFilter := LowerCase(Trim(edFilterText.Text));
  FFilteredItemsList.Clear();
  for i := 0 to ItemsList.Count-1 do
  begin
    Item := ItemsList[i] as TPersItem;
    if Item.ItemType = TPersItemType.Person then
    begin
      if (sFilter = '') or Item.ContainsText(sFilter) then
        FFilteredItemsList.Add(Item);
    end;
  end;
end;

end.
