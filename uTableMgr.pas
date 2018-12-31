unit uTableMgr;

interface
uses sysutils,windows,classes;

type
  TTableMgr = class(TPersistent)
  public
    function getTables: TStringList;
  end;

implementation

function TTableMgr.getTables: TStringList;
begin
  // TODO -cMM: TTableMgr.getTables default body inserted
end;

end.
