unit UserOptionsFrame;

interface

uses
  SysUtils, Controls, Forms, Classes, ToolWin, ComCtrls, StdCtrls, ExtCtrls;

type
  TFrameUserOptions = class(TFrame)
    toolbarUserOptions: TToolBar;
    tbApply: TToolButton;
    tbHelp: TToolButton;
    panCenter: TPanel;
    gbDbOptions: TGroupBox;
    Label1: TLabel;
    edDbName: TEdit;
    Label2: TLabel;
    comboxDbType: TComboBox;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbHostName: TLabel;
    lbUserName: TLabel;
    lbIpList: TLabel;
    procedure tbApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses Main, MainFunc, MiscFunc, DbUnit;


{$R *.dfm}

//===========================================
constructor TFrameUserOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  self.Align:=alClient;

  edDbName.Text:=conf['LocalDbName'];

  comboxDbType.Items.Add(DbTypeCSV);
  comboxDbType.Items.Add(DbTypeSQLite);
  comboxDbType.ItemIndex:=0;
  if (DbDriver is TDbDriverCSV) then comboxDbType.ItemIndex:=0;
  if (DbDriver is TDbDriverSQLite) then comboxDbType.ItemIndex:=1;

  lbUserName.Caption:=GetWinUserName();
  lbHostName.Caption:=GetWinCompName();
  lbIpList.Caption:=GetWinIpList();
end;

procedure TFrameUserOptions.tbApplyClick(Sender: TObject);
begin
  if comboxDbType.Text = DbTypeCSV then
  begin
    if (DbDriver is TDbDriverCSV) then Exit;
    DbDriver.Free();
    DbDriver:=TDbDriverCSV.Create();
    DbDriver.Open(edDbName.Text);
  end
  else if comboxDbType.Text = DbTypeSQLite then
  begin
    if (DbDriver is TDbDriverSQLite) then Exit;
    DbDriver.Free();
    DbDriver:=TDbDriverSQLite.Create();
    DbDriver.Open(edDbName.Text);
  end;
end;

end.
