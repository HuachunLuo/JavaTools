unit uConnParamMgr;

interface

uses
  SysUtils, Classes, IniFiles;

type
  TConnectionParam = class(TObject)
  private
    FDbName: string;
    FPassWord: string;
    FPort: Integer;
    FServer: string;
    FUserName: string;
    procedure SetPassWord(const Value: string);
    procedure SetServer(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(const ConnectionName: string);
    function ToString: string;
    property DbName: string read FDbName write FDbName;
    property PassWord: string read FPassWord write SetPassWord;
    property Port: Integer read FPort write FPort;
    property Server: string read FServer write SetServer;
    property UserName: string read FUserName write SetUserName;
  end;

  TConnectionParamMgr = class(TObject)
  private
    FEnv: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;
    function getconns: string;
    function getDefaultConnection: TConnectionParam;
    function getConnParam(ConnectionName: string): TConnectionParam;
    function Write(Param: TConnectionParam): Boolean;
  end;

implementation
uses uGlobal;

constructor TConnectionParam.Create(const ConnectionName: string);
begin
  with TStringList.Create do
  begin
    CommaText := ConnectionName;
    FServer := strings[0];
    FPort := StrToInt(strings[1]);
    FDbName := strings[2];
    FUserName := strings[3];
    FPassWord := strings[4];
    Free;
  end;
  // TODO -cMM: TConnectionParam.Create default body inserted
end;

procedure TConnectionParam.SetPassWord(const Value: string);
begin
  FPassWord := Value;
end;

procedure TConnectionParam.SetServer(const Value: string);
begin
  FServer := Value;
end;

procedure TConnectionParam.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TConnectionParam.ToString: string;
begin
  Result := Format('%s %d %s %s %s', [FServer, FPort, FDbName, FUserName, FPassWord]);
end;

constructor TConnectionParamMgr.Create;
begin
  inherited;
  FEnv := SystemMgr.Env;
end;

destructor TConnectionParamMgr.Destroy;
begin
  inherited;
  // TODO -cMM: TConnectionParamMgr.Destroy default body inserted
end;

function TConnectionParamMgr.getconns: string;
var
  Section: TStringList;
begin
  Section := TStringList.Create;
  FEnv.ReadSection('DB', Section);
  Result := Section.CommaText;
  Section.Free;
end;

function TConnectionParamMgr.getDefaultConnection: TConnectionParam;
begin
  Result := TConnectionParam.Create(FEnv.ReadString('MAIN', 'DBDefault', ''));
end;

function TConnectionParamMgr.getConnParam(ConnectionName: string):
    TConnectionParam;
var
  sConn: string;
begin
  Result := nil;
  sConn := FEnv.ReadString('DB', ConnectionName, '');
  if sConn = '' then
    exit;

  Result := TConnectionParam.Create(sConn);
end;

function TConnectionParamMgr.Write(Param: TConnectionParam): Boolean;
var
  sParam:String;
begin
  sParam := Param.ToString;
  FEnv.WriteString('DB',Param.FServer,sParam);
end;

end.

