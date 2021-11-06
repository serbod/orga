unit MiscFunc;

interface

uses SysUtils, Windows, Dialogs;

function ShiftPressed(): Boolean;
function SelectFilename(sFileName: string = ''; sFilter: string = ''): string;
function CopySingleFile(SrcName, DestName: string): Boolean;

// Возвращает имя пользователя windows
function GetWinUserName(): string;
// Возвращает имя компьютера
function GetWinCompName(): string;
// Возвращает список IP-адресов компьютера
function GetWinIpList(): string;

implementation

function ShiftPressed(): Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  // State:=GetKeyState(Key);
  Result := ((State[VK_SHIFT] and 128) <> 0);
end;

function SelectFilename(sFileName: string = ''; sFilter: string = ''): string;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  OpenDialog.FileName := sFileName;
  OpenDialog.Filter := sFilter;
  Result := '';
  if OpenDialog.Execute() then
  begin
    Result := OpenDialog.FileName;
  end;
  OpenDialog.Free();
end;

function CopySingleFile(SrcName, DestName: string): Boolean;
begin
  Windows.CopyFile(PChar(SrcName), PChar(DestName), False);
end;

// Возвращает имя пользователя windows
function GetWinUserName(): string;
var
  lpBuffer: PChar;
  n: cardinal;
begin
  n := 20;
  lpBuffer := StrAlloc(n);
  GetUserName(lpBuffer, n);
  Result := String(lpBuffer);
end;

// Возвращает имя компьютера
function GetWinCompName(): string;
var
  lpBuffer: PChar;
  n: cardinal;
begin
  n := 20;
  lpBuffer := StrAlloc(n);
  GetComputerName(lpBuffer, n);
  Result := String(lpBuffer);
end;

// Возвращает список IP-адресов компьютера
function GetWinIpList(): string;
begin
  Result := '127.0.0.1';
end;

end.
