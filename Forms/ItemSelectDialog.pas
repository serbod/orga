unit ItemSelectDialog;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DbUnit;

type
  TFormItemSelect = class(TForm)
    panBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FSelectedItem: TDbItem;
    FOnItemSelected: TItemSelectedEvent;
  public
    { Public declarations }
    property SelectedItem: TDbItem read FSelectedItem;
    procedure OnItemSelectedHandler(Sender: TObject; DbItem: TDbItem);
    property OnItemSelected: TItemSelectedEvent read FOnItemSelected write FOnItemSelected;
  end;

var
  FormItemSelect: TFormItemSelect;

implementation

{$R *.dfm}

uses Main;

{ TFormItemSelect }

procedure TFormItemSelect.btnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TFormItemSelect.btnOKClick(Sender: TObject);
begin
  Close();
  if Assigned(OnItemSelected) then OnItemSelected(Self, FSelectedItem);
end;

procedure TFormItemSelect.OnItemSelectedHandler(Sender: TObject; DbItem: TDbItem);
begin
  FSelectedItem := DbItem;
  btnOK.Enabled := True;
end;

end.
