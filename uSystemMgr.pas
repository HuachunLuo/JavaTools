unit uSystemMgr;

interface

uses
  SysUtils, Classes, IniFiles;

type
  TMySystemMgr = class(TObject)
  private
    FConfigFile: string;
    FControllerPath: string;
    FConvertFile: string;
    FDaoPath: string;
    FEntityPath: string;
    FEnv: TIniFile;
    FImplPath: string;
    FPath: string;
    FServicePath: string;
    function GetpackageName: string;
    procedure SetpackageName(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function getDefaultConnectionParamName: string;
    procedure init;
    property ConfigFile: string read FConfigFile write FConfigFile;
    property ControllerPath: string read FControllerPath;
    property ConvertFile: string read FConvertFile write FConvertFile;
    property DaoPath: string read FDaoPath;
    property EntityPath: string read FEntityPath write FEntityPath;
    property Path: string read FPath write FPath;
    property Env: TIniFile read FEnv write FEnv;
    property ImplPath: string read FImplPath;
    property packageName: string read GetpackageName write SetpackageName;
    property ServicePath: string read FServicePath;
  end;

implementation

uses
  forms;

constructor TMySystemMgr.Create;
begin
  inherited Create;

end;

destructor TMySystemMgr.Destroy;
begin
  FreeAndNil(FEnv);
  inherited Destroy;
end;

function TMySystemMgr.getDefaultConnectionParamName: string;
begin
  Result := FEnv.ReadString('MAIN', 'DBDefault', '');
end;

function TMySystemMgr.GetpackageName: string;
begin
  Result := FEnv.ReadString('COMMON', 'package', '');
  ;
end;

procedure TMySystemMgr.init;
begin
  FPath := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)); // ChangeFileExt(GetModuleName(0), '.txt')
  //entity
  FEntityPath := IncludeTrailingBackslash(FPath + 'Entity');
  ForceDirectories(FEntityPath);
  //Controller
  FControllerPath := IncludeTrailingBackslash(FPath + 'Controller');
  ForceDirectories(FControllerPath);
  //dao
  FDaoPath := IncludeTrailingBackslash(FPath + 'Dao');
  ForceDirectories(FDaoPath);
  //service
  FServicePath := IncludeTrailingBackslash(FPath + 'Service');
  ForceDirectories(FServicePath);
  //impl
  FImplPath := IncludeTrailingBackslash(FPath + 'Impl');
  ForceDirectories(FImplPath);

  ConfigFile := ChangeFileExt(Application.ExeName, '.ini');
  if not FileExists(ConfigFile) then
  begin
    with TStringList.Create do
    begin
      Add('[DB]');
      Add(Format('%s=%s %d %s %s %s', ['conn1', '127.0.0.1', 1433, 'mytest', 'sa', '1nihao']));
      Add('[MAIN]');
      Add('DBDefault=conn1');
      Add('[COMMON]');
      Add('package=cn.robert');
      SaveToFile(ConfigFile);
      Free;
    end;
  end;
  FEnv := TIniFile.Create(ConfigFile);

  ConvertFile := ChangeFileExt(Application.ExeName, '.txt');
  if not FileExists(ConvertFile) then
  begin
    with TStringList.Create do
    begin
      Add('varchar=String');
      Add('CHAR=String');
      Add('numeric=Float');
      Add('int=Integer');
      Add('date=Date');
      Add('datetime=Date');
      SaveToFile(ConvertFile);
      Free;
    end;
  end;
end;

procedure TMySystemMgr.SetpackageName(const Value: string);
begin
  FEnv.WriteString('COMMON', 'package', Value);
  ;
end;

end.

