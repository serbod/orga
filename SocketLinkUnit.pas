unit SocketLinkUnit;

interface
uses SysUtils, Classes, DbUnit;

type
  TClientLink = class(TObject)
  public
    HostName: string;
    HostPort: string;
    function SendDbItem(DbItem: TDbItem): boolean;
  end;

  TServerLink = class(TObject)
  public
    HostName: string;
    HostPort: string;
  end;

  TSyTcpClientOptions = record
    DestHost: string;
    DestPort: string;
    Timeout: integer;
  end;

  TSyTcpClientThread = class(TThread)
  private
    Options: TSyTcpClientOptions;
    SendResult: integer;
    Data: pointer;
    DataSize: integer;
    procedure Event(EventType: cardinal; Str: string);
  public
    constructor Create(AOptions: TSyTcpClientOptions);
    destructor Destroy(); override;
    procedure Execute(); override;
    function SendData(Data: Pointer; Size: integer): boolean;
  end;


implementation

uses SynSock, BlckSock;

//==== TClientLink ===
function TClientLink.SendDbItem(DbItem: TDbItem): boolean;
begin
end;

//==== TSyTcpClientThread ===
constructor TSyTcpClientThread.Create(AOptions: TSyTcpClientOptions);
begin
  self.Options:=AOptions;
  self.FreeOnTerminate:=true;
  inherited Create(false);
end;

destructor TSyTcpClientThread.Destroy();
begin
  inherited Destroy();
end;

procedure TSyTcpClientThread.Execute();
var
  Sock: TTCPBlockSocket;
begin
  Sock:=TTCPBlockSocket.Create();
  try
    Sock.Connect(Options.DestHost, Options.DestPort);
    while Sock.LastError = 0 do
    begin
      Event(1, Sock.RecvPacket(Options.Timeout));
    end;
    Event(0, Sock.GetErrorDescEx());
  finally
    Sock.Free();
  end;
end;

function TSyTcpClientThread.SendData(Data: Pointer; Size: integer): boolean;
var
  i: integer;
begin
  Result:=false;
  i:=self.Options.Timeout;
  while (SendResult<>0) and (i>0) do
  begin
    Dec(i);
    Sleep(1);
  end;
  if SendResult<>0 then Exit;
  self.Data:=Data;
  self.DataSize:=Size;
  Result:=true;
end;

procedure TSyTcpClientThread.Event(EventType: cardinal; Str: string);
begin
  case EventType of
  0: Exit; // Error
  1: Exit;
  2: Exit;
  else
  end;
end;

end.
