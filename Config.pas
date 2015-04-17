unit Config;

interface
uses SysUtils, Forms, IniFiles;

type
  TConfig = class(TMemIniFile)
  private
    function GetValue(const Name: string): string;
    procedure SetValue(const Name, Value: string);
  public
    constructor Create();
    property Values[const Name: string]: string read GetValue write SetValue; default;
  end;

var
  csMain: string = 'Main';

implementation
uses Main, MainFunc;

constructor TConfig.Create();
begin
  inherited Create('orga.ini');
  Values['DataDir']:=Application.ExeName+'\Data\';
  Values['HomePath']:=ExtractFileDir(ParamStr(0));
  Values['BasePath']:=Values['HomePath']+'\Data\';
  Values['UserName']:='Admin';
  Values['LocalDbName']:='orga_local';
  Values['LocalDbType']:=DbTypeCSV;
end;

function TConfig.GetValue(const Name: string): string;
begin
  result:=self.ReadString(csMain, Name, '');
end;

procedure TConfig.SetValue(const Name, Value: string);
begin
  self.WriteString(csMain, Name, Value);
end;

end.
