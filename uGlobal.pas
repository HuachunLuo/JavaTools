unit uGlobal;

interface

uses
  SysUtils, Classes, uSystemMgr, uTableMgr, uConnectionMgr,uTypeConvert;

var
  systemMgr: TMySystemMgr;
  TableMgr: TTableMgr;
  ConnectionMgr: TConnectionMgr;
  typeConvertMgr:TTypeConvertMgr;

implementation

initialization
  systemMgr := TMySystemMgr.Create;
  ConnectionMgr := TConnectionMgr.Create;
  TableMgr := TTableMgr.Create;
  typeConvertMgr:=TTypeConvertMgr.Create;

finalization
  FreeAndNil(typeConvertMgr);
  FreeAndNil(TableMgr);
  FreeAndNil(ConnectionMgr);
  FreeAndNil(systemMgr);

end.

