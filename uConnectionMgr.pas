{*******************************************************}
{                                                       }
{       JavaMybatisTools                                }
{                                                       }
{       ��Ȩ���� (C) 2018 ����������                    }
{

������Ҫ�õ� UniDAC�ؼ�.



*******************************************************}

unit uConnectionMgr;

interface

uses
  UniProvider, uni, SQLServerUniProvider, SysUtils, Classes;

type
  TConnectionMgr = class(TObject)
  private
    Fconnection: TuniConnection;
    FisConnection: Boolean;
    FQuery: TUniQuery;
    FTables: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function conn(const ConnectionName: string): Boolean;
    function getConns: string;
    function getEntity(TableName: string): string;
    function getMapperDelete(TableName: string): string;
    function getMapperInsert(TableName: string): string;
    function getMapperSelect(TableName: string): string;
    function getMapperUpdate(TableName: string): string;
    function getTables(isRefered: boolean = False): TStringList;
    property Connection: TuniConnection read Fconnection write Fconnection;
    property isConnection: Boolean read FisConnection write FisConnection;
  end;

implementation

uses
  uMsg, uTypeConvert, IniFiles, uGlobal, uConnParamMgr;

constructor TConnectionMgr.Create;
begin
  inherited;
  Fconnection := TUniConnection.Create(nil);
  FQuery := TUniQuery.create(nil);
  FQuery.Connection := Fconnection;
  FTables := TStringList.Create();
end;

destructor TConnectionMgr.Destroy;
begin
  FreeAndNil(FTables);
  FreeAndNil(FQuery);
  FreeAndNil(Fconnection);
  inherited;
end;

function TConnectionMgr.conn(const ConnectionName: string): Boolean;
//�������ݿ�
var
  connParam: TConnectionParam;
begin
  Fconnection.Connected := False;


  try
    connParam := ConnectionParamMgr.getConnParam(ConnectionName);
    Result := True;
    Fconnection.Server := connParam.server;
    Fconnection.Username := connParam.username;
    Fconnection.Port := connParam.port;
    Fconnection.Password := connParam.PassWord;
    Fconnection.Database := connParam.dbname;
    Fconnection.SpecificOptions.Add('SQL Server.Direct=False');
    Fconnection.SpecificOptions.Add(Format('SQL Server.ConnectionTimeOut=%d', [5 * 1000]));
    Fconnection.SpecificOptions.Add('SQL Server.UseUniCode=true');
    Fconnection.providerName := 'SQL Server';
    Fconnection.LoginPrompt := False;
    try
      Fconnection.Connected := True;
      FTables.Clear;
    except
      result := False;
    end;
  finally
    FreeAndNil(connParam);
    FisConnection := Result;
  end;
end;

function TConnectionMgr.getConns: string;
//ȡ����������
var
  ini: TIniFile;
  Section: TStringList;
begin
  ini := Systemmgr.Env;
  Section := TstringList.Create();
  ini.ReadSection('DB', Section);
  result := Section.CommaText;
  Section.Free;
end;

function TConnectionMgr.getEntity(TableName: string): string;
//ȡ��ʵ��ű�
var
  s_Sql: string;
  s: string;
  mgr: TTypeConvertMgr;

  function typeConvert(Atext: string): string;
  begin
    Result := '';

  end;

begin
  mgr := TTypeConvertMgr.Create;
  try
    Result := '';
    if mgr.DefineCount <> 0 then
    begin
      s_Sql := Format('SELECT a.name,b.name as TypeName' + #13#10 + '     FROM sys.columns a' + #13#10 + '  LEFT JOIN sys.types b ON a.system_type_id=b.system_type_id' + #13#10 + '  WHERE OBJECT_ID(%s)=a.OBJECT_ID', [QuotedStr(TableName)]);
    end
    else
      s_Sql := Format('SELECT ''private '' + aType +'' ''+ x.name + '';'' as S_Private FROM (' + #13#10 + 'SELECT a.name,' + #13#10 + '       CASE' + #13#10 + '     WHEN UPPER(b.name)=''CHAR'' THEN ''String''' + #13#10 + '     WHEN UPPER(b.name)=''varchar'' THEN ''String''' + #13#10 + '     WHEN UPPER(b.name)=''numeric'' THEN ''Float''' + #13#10 + '     WHEN UPPER(b.name)=''int'' THEN ''Integer''' + #13#10 + '     WHEN UPPER(b.name)=''date'' THEN ''Date''' + #13#10 + '     WHEN UPPER(b.name)=''datetime'' THEN ''Date''' + #13#10 + '     END AS aType' + #13#10 + '     FROM sys.columns a' + #13#10 + '  LEFT JOIN sys.types b ON a.system_type_id=b.system_type_id' + #13#10 + ' WHERE OBJECT_ID(%s)=a.OBJECT_ID' + #13#10 + ') x', [QuotedStr(TableName)]);

    FQuery.Close;
    FQuery.SQL.Clear;

    with TStringList.Create do
    begin
      with FQuery do
      begin
        close;
        Sql.Clear;
        Sql.Add(s_Sql);
        Open;
        First;
        while not eof do
        begin
          if mgr.DefineCount <> 0 then
            s := Format('Private %s %s;', [Mgr.getValueByName(FieldByName('typename').AsString), LowerCase(FieldByName('name').AsString)])
          else
            s := FieldByName('S_Private').AsString;
          Add(s);
          Next;
        end;
      end;
      Result := CommaText;
      Free;
    end;
  finally
    Mgr.free;
  end;
end;

function TConnectionMgr.getMapperDelete(TableName: string): string;
//����@Delete���
var
  s_Sql: string;
  s, skey: string;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 + '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 + '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 + '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 + ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

  FQuery.Close;
  FQuery.SQL.Clear;
  with TStringList.Create do
  begin
    with FQuery do
    begin
      close;
      Sql.Clear;
      Sql.Add(s_Sql);
      Open;
      First;
      while not eof do
      begin
        s := FieldByName('column_name').AsString;
        skey := FieldByName('keyName').AsString;
        Add(s);
        Next;
      end;
    end;
    Result := Format('Delete * from %s where %s=#{%s}', [TableName, skey, skey]);
    Free;
  end;
end;

function TConnectionMgr.getMapperInsert(TableName: string): string;
//����@Insert���
var
  s_Sql: string;
  s, skey: string;
  list_name, list_value: TStringList;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 + '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 + '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 + '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 + ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

  FQuery.Close;
  FQuery.SQL.Clear;
  list_name := TStringList.Create;
  list_value := TStringList.Create;
  try
    with FQuery do
    begin
      close;
      Sql.Clear;
      Sql.Add(s_Sql);
      Open;
      First;
      while not eof do
      begin
        list_name.Add(FieldByName('column_name').AsString);
        list_value.Add(Format('#{%s}', [FieldByName('column_name').AsString]));
        Next;
      end;
    end;
    Result := Format('INSERT INTO %s(%s) VALUES(%s)', [TableName, list_name.CommaText, list_value.CommaText]);
  finally
    list_name.Free;
    list_value.Free
  end;
end;

function TConnectionMgr.getMapperSelect(TableName: string): string;
//����MyBatis�е�@Select���
var
  s_Sql: string;
  s, skey: string;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 + '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 + '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 + '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 + ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

  FQuery.Close;
  FQuery.SQL.Clear;
  with TStringList.Create do
  begin
    with FQuery do
    begin
      close;
      Sql.Clear;
      Sql.Add(s_Sql);
      Open;
      First;
      while not eof do
      begin
        s := FieldByName('column_name').AsString;
        skey := FieldByName('keyName').AsString;
        Add(s);
        Next;
      end;
    end;
    Result := Format('Select %s From %s where 0=0 and %s=#{%s}', [CommaText, TableName, skey, skey]);
    Free;
  end;
end;

function TConnectionMgr.getMapperUpdate(TableName: string): string;
//����MyBatis�е�@Update���
var
  s_Sql: string;
  s, skey: string;
  list_name, list_value: TStringList;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 + '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 + '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 + '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 + ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

  FQuery.Close;
  FQuery.SQL.Clear;
  list_name := TStringList.Create;
  list_value := TStringList.Create;
  try
    with FQuery do
    begin
      close;
      Sql.Clear;
      Sql.Add(s_Sql);
      Open;
      First;
      while not eof do
      begin
        list_name.Add(Format('%s=#{%s}', [FieldByName('column_name').AsString, FieldByName('column_name').AsString]));
        skey := FieldByName('keyName').AsString;
        Next;
      end;
    end;
    Result := Format('Update %s Set %s Where %s=#{%s} ', [TableName, list_name.CommaText, skey, skey]);
  finally
    list_name.Free;
    list_value.Free
  end;
end;

function TConnectionMgr.getTables(isRefered: boolean = False): TStringList;
//ȡ�����б�Ľṹ
var
  s_Sql: string;
  s: string;
begin

  if (FTables.Count = 0) or (isRefered = True) then
  begin
    FTables.Clear;
    s_Sql := Format('SELECT name,object_id FROM sys.objects WHERE type=''U''', []);
    FQuery.Close;
    FQuery.SQL.Clear;
    with FQuery do
    begin
      close;
      Sql.Clear;
      Sql.Add(s_Sql);
      Open;
      First;
      while not eof do
      begin
        s := Format('%s=%s', [FieldByName('name').AsString, FieldByName('object_id').AsString]);
        FTables.Add(s);
        Next;
      end;
    end;
  end;

  Result := FTables;
end;

end.

