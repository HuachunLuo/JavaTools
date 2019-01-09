unit uTypeConvert;

interface
uses SysUtils,Classes;

type
  TTypeConvertMgr = class(TObject)
  private
    FPath: string;
    FList:TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateDefaultFile;
    function DefineCount: Integer;
    function getValueByName(const AText: String): String;
    function Load: string;
    procedure Save(AText: string);
  end;

implementation
uses uGlobal;

constructor TTypeConvertMgr.Create;
begin
  inherited;
  FList := TStringList.Create;

  FPath := ChangeFileExt(GetModuleName(0), '.ini');
  FList.LoadFromFile(systemMgr.ConvertFile);


  
end;

destructor TTypeConvertMgr.Destroy;
begin
  inherited;
  FList.Free;
end;

function TTypeConvertMgr.DefineCount: Integer;
begin
  result := FList.Count;
end;

procedure TTypeConvertMgr.CreateDefaultFile;
begin
  if not FileExists(Fpath) then
  begin
    with FList do
    begin
      Add('varchar=String');
      Add('CHAR=String');
      Add('numeric=Float');
      Add('int=Integer');
      Add('date=Date');
      Add('datetime=Date');
      SaveToFile(FPath);
    end;
  end;
end;

function TTypeConvertMgr.getValueByName(const AText: String): String;
var
  idx: Integer;
begin
  Result := '';

  Result :=  FList.Values[AText];
//  idx :=  FList.IndexOf(AText);
//  if idx = -1 then exit;
//
//  FList.ValueFromIndex[idx];
end;

function TTypeConvertMgr.Load: string;
begin
  Result := FList.CommaText;
end;

procedure TTypeConvertMgr.Save(AText: string);
begin
  FList.CommaText := AText;
  FList.SaveToFile(systemMgr.ConvertFile);
end;

end.

