unit uGlobal;

interface

uses
  SysUtils, Classes, uSystemMgr, uTableMgr, uConnectionMgr,uTypeConvert,uConnParamMgr;

var
  systemMgr: TMySystemMgr;
  TableMgr: TTableMgr;
  ConnectionMgr: TConnectionMgr;
  typeConvertMgr:TTypeConvertMgr;
  ConnectionParamMgr:TConnectionParamMgr;

implementation

initialization
  systemMgr := TMySystemMgr.Create;
  systemMgr.Init;
  ConnectionMgr := TConnectionMgr.Create;
  TableMgr := TTableMgr.Create;
  typeConvertMgr:=TTypeConvertMgr.Create;
  ConnectionParamMgr:=TConnectionParamMgr.Create;

finalization
  FreeAndNil(ConnectionParamMgr);
  FreeAndNil(typeConvertMgr);
  FreeAndNil(TableMgr);
  FreeAndNil(ConnectionMgr);
  FreeAndNil(systemMgr);

end.

