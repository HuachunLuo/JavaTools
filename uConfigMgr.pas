unit uConfigMgr;

interface
uses SysUtils,Classes;

type
  TConfigMgr = class(TObject)
  private
    FList:TStrings;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TConfigMgr.Create;
begin
  inherited;
    FList := TStringList.Create;
  
//  FPath := ChangeFileExt(GetModuleName(0), '.txt');
//  FList.LoadFromFile(fpath);
  // TODO -cMM: TConfigMgr.Create default body inserted
end;

destructor TConfigMgr.Destroy;
begin
  inherited;
  // TODO -cMM: TConfigMgr.Destroy default body inserted
end;

end.
