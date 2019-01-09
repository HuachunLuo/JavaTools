unit uSystemMgr;

interface

uses
  SysUtils, Classes, IniFiles;

type
  TMySystemMgr = class(TObject)
  private
    FConfigFile: string;
    FConvertFile: string;
    FEnv: TIniFile;
    FPath: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure init;
    property ConfigFile: string read FConfigFile write FConfigFile;
    property ConvertFile: string read FConvertFile write FConvertFile;
    property Path: string read FPath write FPath;
    property Env: TIniFile read FEnv write FEnv;

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

procedure TMySystemMgr.init;
begin
  FPath := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)); // ChangeFileExt(GetModuleName(0), '.txt')
  ConfigFile := ChangeFileExt(Application.ExeName, '.ini');
  if not FileExists(ConfigFile) then
  begin
    with TStringList.Create do
    begin
      Add('[DB]');
      Add(Format('%s=%s:%d,%s %s %s', ['conn1', '127.0.0.1', 1433, 'mytest', 'sa', '1nihao']));
      Add('[MAIN]');
      Add('DBDefault=conn1');
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

end.

