unit uTableMgr;

interface

uses
  sysutils, windows, classes, uni;

type
  TTable = class(TObject)
  private
    FColumes: TStringList;
    FTableID: Integer;
    FTableName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Columes: TStringList read FColumes write FColumes;
    property TableID: Integer read FTableID write FTableID;
    property TableName: string read FTableName write FTableName;
  end;

  TColumn = class(TObject)
  private
    FtableName: string;
    FFieldNo: string;
    FFieldName: string;
    Fispri: string;
    FALenth: string;
    FIsNull_: string;
    FFieldDescript: string;
    FScaleNum: string;
    FScaleByte: string;
    FAtype: string;
    FTableDescript: string;
    FFlag: string;
    FDefaultValue: string;
  public
    property TableName: string read FTableName write FTableName;
    property TableDescript: string read FTableDescript write FTableDescript;
    property FieldNo: string read FFieldNo write FFieldNo;
    property FieldName: string read FFieldName write FFieldName;
    property Flag: string read FFlag write FFlag;
    property ispri: string read Fispri write Fispri;
    property Atype: string read FAtype write FAtype;
    property ScaleByte: string read FScaleByte write FScaleByte;
    property ALenth: string read FALenth write FALenth;
    property ScaleNum: string read FScaleNum write FScaleNum;
    property IsNull_: string read FIsNull_ write FIsNull_;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property FieldDescript: string read FFieldDescript write FFieldDescript;
  end;

  TTableMgr = class(TPersistent)
  private
    Tables: TStrings;
    function getFieldkeyValue(TableName: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateController(const TableName: string): string;
    function CreateService(const TableName: string): string;
    function CreateImpl(const TableName: string): string;
    function CreateDao(const TableName: string): string;
    function CreateEntity(const TableName: string): string;
    procedure FreeAll;
    function getEntity(TableName: string): string;
    function getMapperSelect(TableName: string): string;
    function getMapperUpdate(TableName: string): string;
    function getMapperInsert(TableName: string): string;
    function getMapperDelete(TableName: string): string;
    function getTables: string;
    procedure init;
  end;

implementation

uses
  uGlobal, uConst;

constructor TTableMgr.Create;
begin
  inherited Create;
  Tables := TStringList.Create;
end;

destructor TTableMgr.Destroy;
begin
  FreeAndNil(Tables);
  inherited Destroy;
end;

function TTableMgr.CreateEntity(const TableName: string): string;
{-------------------------------------------------------------------------------
  过程名:    TTableMgr.CreateEntity
  作者:      RO
  日期:      2019.01.09
  参数:      const TableName: string
  返回值:    创建实体对象
-------------------------------------------------------------------------------}
var
  s_entity: string;
begin
  s_entity := getEntity(TableName);
  Result := Format('package %s.entity;public class %s {%s}', [systemMgr.packageName, TableName, s_entity]);
  with TStringList.Create do
  begin
    Add(Result);
    SaveToFile(Format('%s%s.java', [systemmgr.EntityPath, TableName]));
    free;
  end;
end;

procedure TTableMgr.FreeAll;
var
  i: Integer;
begin
  for i := Tables.count - 1 downto 0 do
  begin
    TTable(tables.Objects[i]).Free;
  end;
  Tables.Clear;
end;

function TTableMgr.getEntity(TableName: string): string;
var
  i: integer;
  idx: Integer;
  s: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);

  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    if i <> Table.Columes.count - 1 then
      s := s + Format('Private %s %s;', [typeConvertMgr.getValueByName(Column.Atype), LowerCase(Column.FieldName)]) + ';'
    else
      s := s + Format('Private %s %s;', [typeConvertMgr.getValueByName(Column.Atype), LowerCase(Column.FieldName)]);
  end;
  Result := s;
end;

function TTableMgr.getFieldkeyValue(TableName: string): string;
{-------------------------------------------------------------------------------
  过程名:    TTableMgr.getFieldkeyValue
  作者:      RO
  日期:      2019.01.09
  参数:      TableName: string
  返回值:    生成无注解@Results部分
-------------------------------------------------------------------------------}
var
  i: integer;
  idx: Integer;
  sname: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);
  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    sname := sname + Format('@Result(property = "%0:s",  column = "%0:s")', [Column.FieldName]) + ',';
    if i = Table.Columes.count - 1 then
    begin
      sname := sname + Format('@Result(property = "%0:s",  column = "%0:s")', [Column.FieldName]);
    end;
  end;
  Result := Format('@Results({%s})', [sname]);
end;

function TTableMgr.getMapperDelete(TableName: string): string;
var
  i: integer;
  idx: Integer;
  skey: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);

  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    if Column.ispri = '1' then
      skey := Column.FieldName;
  end;
  Result := Format('Delete from %s where %s=#{%s}', [TableName, skey, skey]);
  Result := Format('@Delete("%s")', [Result]);
  Result := Format('%s %s', [Result, getFieldkeyValue(TableName)]);
end;

function TTableMgr.getMapperInsert(TableName: string): string;
var
  i: integer;
  idx: Integer;
  sname, svalue: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);
  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    sname := sname + Column.FieldName + ',';
    svalue := svalue + Format('#{%s}', [Column.FieldName]) + ',';
    if i = Table.Columes.count - 1 then
    begin
      sname := sname + Column.FieldName;
      svalue := svalue + Format('#{%s}', [Column.FieldName]);
    end;
  end;
  Result := Format('Insert into %s(%s) Values(%s)', [TableName, sname, svalue]);
  Result := Format('@Insert("%s")', [Result]);
  Result := Format('%s %s', [Result, getFieldkeyValue(TableName)]);  //+ @results
end;

function TTableMgr.getMapperSelect(TableName: string): string;
var
  i: integer;
  idx: Integer;
  sname, svalue: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);
  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    sname := sname + Column.FieldName + ',';
    svalue := svalue + Format('#{%s}', [Column.FieldName]) + ',';
    if i = Table.Columes.count - 1 then
    begin
      sname := sname + Column.FieldName;
    end;
  end;
  Result := Format('Select %s From %s', [sname, TableName]);
  Result := Format('@Select("%s")', [Result]);
  Result := Format('%s %s', [Result, getFieldkeyValue(TableName)]);   //+ @results
end;

function TTableMgr.getMapperUpdate(TableName: string): string;
var
  i: integer;
  idx: Integer;
  sname, sWhere: string;
  Table: TTable;
  Column: TColumn;
begin
  Result := '';
  idx := Tables.IndexOf(TableName);
  if idx = -1 then
    exit;
  table := TTable(tables.Objects[idx]);

  for i := 0 to Table.Columes.count - 1 do
  begin
    Column := TColumn(Table.Columes.Objects[i]);
    if Column.ispri = '0' then
    begin
      sname := sname + Format('%0:s=#{%0:s}', [Column.FieldName]) + ',';
      if i = Table.Columes.count - 1 then
      begin
        if Column.ispri = '0' then
          sname := sname + Format('%0:s=#{%0:s}', [Column.FieldName]);
      end;
    end;
    if Column.ispri = '1' then
    begin
      sWhere := Format('%0:s=#{%0:s}', [Column.FieldName]);
    end;
  end;
  Result := Format('Update %s set From %s where %s', [TableName, sname, sWhere]);
  Result := Format('@Update("%s")', [Result]);
  Result := Format('%s %s', [Result, getFieldkeyValue(TableName)]);   //+ @results
end;

function TTableMgr.getTables: string;
begin
  Result := Tables.CommaText;
end;

procedure TTableMgr.init;
var
  Query: TuniQuery;
  sSql, s_table: string;
  table: TTable;
  Column: TColumn;
begin
  FreeAll;
  sSql := Format(Sql_AllTable, []);

  Query := TUniQuery.Create(nil);
  try
    with Query do
    begin
      Connection := ConnectionMgr.Connection;
      Sql.Add(sSql);
      open;
      First;
      while not eof do
      begin
        s_table := FieldByName('TableName').AsString;
        if Length(s_table) <> 0 then
        begin
          table := TTable.Create;
          table.TableName := s_table;
          Tables.AddObject(s_table, Table);
        end;

        Column := TColumn.Create;
        with Column do
        begin
          TableDescript := FieldByName('TableDescript').AsString;
          FieldNo := FieldByName('FieldNo').AsString;
          FieldName := FieldByName('FieldName').AsString;
          Flag := FieldByName('Flag').AsString;
          ispri := FieldByName('ispri').AsString;
          Atype := FieldByName('Atype').AsString;
          ScaleByte := FieldByName('ScaleByte').AsString;
          ALenth := FieldByName('ALenth').AsString;
          ScaleNum := FieldByName('ScaleNum').AsString;
          IsNull_ := FieldByName('IsNull_').AsString;
          DefaultValue := FieldByName('DefaultValue').AsString;
          FieldDescript := FieldByName('FieldDescript').AsString;
          table.Columes.AddObject(FieldName, Column);
        end;
        next;
      end;
    end;

  finally
    FreeAndNil(Query);
  end;
end;

constructor TTable.Create;
begin
  inherited Create;
  FColumes := TStringList.Create();
end;

destructor TTable.Destroy;
var
  i: Integer;
begin
  for i := FColumes.count - 1 downto 0 do
  begin
    TColumn(FColumes.Objects[i]).Free;
  end;
  FreeAndNil(FColumes);
  inherited Destroy;
end;

function TTableMgr.CreateController(const TableName: string): string;
{-------------------------------------------------------------------------------
  过程名:    TTableMgr.CreateController
  作者:      RO
  日期:      2019.01.09
  参数:      const TableName: string
  返回值:    创建Controller对象
-------------------------------------------------------------------------------}
var
  s_package: string;
begin
  s_package := Format('package %s.controller;', [systemMgr.packageName]);

  Result := Format('%s public class %1:sController {}', [s_package, TableName]);
  with TStringList.Create do
  begin
    Add(Result);
    SaveToFile(Format('%s%s.java', [systemmgr.controllerPath, TableName]));
    free;
  end;
end;

function TTableMgr.CreateDao(const TableName: string): string;
{-------------------------------------------------------------------------------
  过程名:    TTableMgr.CreateDao
  作者:      RO
  日期:      2019.01.09
  参数:      const TableName: string
  返回值:    创建Dao对象
-------------------------------------------------------------------------------}
var
  s_package: string;
begin
  s_package := Format('package %s.dao;', [systemMgr.packageName]);

  Result := Format('%0:s @Mapper public interface %1:sDao{%2:s %3:s %4:s %5:s};', [s_package, TableName, getMapperSelect(TableName), getMapperInsert(TableName), getMapperUpdate(TableName), getMapperDelete(TableName)]);
  with TStringList.Create do
  begin
    Add(Result);
    SaveToFile(Format('%s%s.java', [systemmgr.DaoPath, TableName]));
    free;
  end;
end;

function TTableMgr.CreateImpl(const TableName: string): string;

{-------------------------------------------------------------------------------
  过程名:    TTableMgr.CreateImpl
  作者:      RO
  日期:      2019.01.09
  参数:      const TableName: string
  返回值:    创建实现对象
-------------------------------------------------------------------------------}
var
  s_package: string;
begin
  s_package := Format('package %s.Serviceimpl;', [systemMgr.packageName]);

  Result := Format('%0:s @Service public class %1:sImpl implements %1:sService {}', [s_package, TableName]);
  with TStringList.Create do
  begin
    Add(Result);
    SaveToFile(Format('%s%s.java', [systemmgr.ImplPath, TableName]));
    free;
  end;

end;

function TTableMgr.CreateService(const TableName: string): string;
{-------------------------------------------------------------------------------
  过程名:    TTableMgr.CreateService
  作者:      RO
  日期:      2019.01.09
  参数:      const TableName: string
  返回值:    创建服务对象
-------------------------------------------------------------------------------}
var
  s_package: string;
begin
  s_package := Format('package %s.Service;', [systemMgr.packageName]);

  Result := Format('%0:s public interface %1:sService {}', [s_package, TableName]);
  with TStringList.Create do
  begin
    Add(Result);
    SaveToFile(Format('%s%s.java', [systemmgr.ServicePath, TableName]));
    free;
  end;
end;

end.

