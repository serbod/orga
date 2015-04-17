unit MiscFunc;

interface
uses SysUtils, Windows, Dialogs;

function ShiftPressed(): boolean;
function SelectFilename(sFileName: string = ''; sFilter: string = ''): string;
function CopySingleFile(SrcName, DestName: string): boolean;

// Возвращает имя пользователя windows
function GetWinUserName(): string;
// Возвращает имя компьютера
function GetWinCompName(): string;
// Возвращает список IP-адресов компьютера
function GetWinIpList(): string;


implementation

function ShiftPressed(): boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  //State:=GetKeyState(Key);
  result := ((State[VK_SHIFT] and 128) <> 0);
end;

function SelectFilename(sFileName: string = ''; sFilter: string = ''): string;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog:=TOpenDialog.Create(nil);
  OpenDialog.FileName:=sFileName;
  OpenDialog.Filter:=sFilter;
  result:='';
  if OpenDialog.Execute() then
  begin
    result:=OpenDialog.FileName;
  end;
  OpenDialog.Free();
end;

function CopySingleFile(SrcName, DestName: string): boolean;
begin
  Windows.CopyFile(PChar(SrcName), PChar(DestName), false);
end;

// Возвращает имя пользователя windows
function GetWinUserName(): string;
var
  lpBuffer: PChar;
  n: cardinal;
begin
  n:=20;
  lpBuffer:=StrAlloc(n);
  GetUserName(lpBuffer, n);
  result := String(lpBuffer);
end;

// Возвращает имя компьютера
function GetWinCompName(): string;
var
  lpBuffer: PChar;
  n: cardinal;
begin
  n:=20;
  lpBuffer:=StrAlloc(n);
  GetComputerName(lpBuffer, n);
  result := String(lpBuffer);
end;

// Возвращает список IP-адресов компьютера
function GetWinIpList(): string;
begin
  result:='127.0.0.1';
end;

end.
