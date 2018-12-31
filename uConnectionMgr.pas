{*******************************************************}
{                                                       }
{       JavaMybatisTools                                }
{                                                       }
{       版权所有 (C) 2018 动力工作室                    }
{

开发需要用到 UniDAC控件.



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
    function conn(server: string; port: Integer; dbname, username, pwd: string): Boolean;
    function getEntity(TableName: string): string;
    function getMapperDelete(TableName: String): string;
    function getMapperInsert(TableName: String): string;
    function getMapperSelect(TableName: string): string;
    function getMapperUpdate(TableName: String): string;
    function getTables(isRefered: boolean = False): TStringList;
    property Connection: TuniConnection read Fconnection write Fconnection;
    property isConnection: Boolean read FisConnection write FisConnection;
  end;

implementation

uses
  uMsg;

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

function TConnectionMgr.conn(server: string; port: Integer; dbname, username, pwd: string): Boolean;
//连接数据库
begin
  try
    Result := True;
    Fconnection.Server := server;
    Fconnection.Username := username;
    Fconnection.Port := port;
    Fconnection.Password := pwd;
    Fconnection.Database := dbname;
    Fconnection.SpecificOptions.Add('SQL Server.Direct=False');
    Fconnection.SpecificOptions.Add(Format('SQL Server.ConnectionTimeOut=%d', [5 * 1000]));
    Fconnection.SpecificOptions.Add('SQL Server.UseUniCode=true');
    Fconnection.providerName := 'SQL Server';
    Fconnection.LoginPrompt := False;
    try
      Fconnection.Connected := True;
    except
      result := False;
    end;
  finally
    FisConnection := Result;
  end;
end;

function TConnectionMgr.getEntity(TableName: string): string;
//取得实体脚本
var
  s_Sql: string;
  s: string;
begin
  Result := '';
  s_Sql := Format('SELECT ''private '' + aType +'' ''+ x.name + '';'' as S_Private FROM (' + #13#10 + 'SELECT a.name,' + #13#10 + '       CASE' + #13#10 + '     WHEN UPPER(b.name)=''CHAR'' THEN ''String''' + #13#10 + '     WHEN UPPER(b.name)=''varchar'' THEN ''String''' + #13#10 + '     WHEN UPPER(b.name)=''numeric'' THEN ''Float''' + #13#10 + '     WHEN UPPER(b.name)=''int'' THEN ''Integer''' + #13#10 + '     WHEN UPPER(b.name)=''date'' THEN ''Date''' + #13#10 + '     WHEN UPPER(b.name)=''datetime'' THEN ''Date''' + #13#10 + '     END AS aType' + #13#10 + '     FROM sys.columns a' + #13#10 + '  LEFT JOIN sys.types b ON a.system_type_id=b.system_type_id' + #13#10 + 'WHERE OBJECT_ID(%s)=a.OBJECT_ID' + #13#10 + ') x', [QuotedStr(TableName)]);
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
        s := FieldByName('S_Private').AsString;
        Add(s);
        Next;
      end;
    end;
    Result := CommaText;
    Free;
  end;
end;

function TConnectionMgr.getMapperDelete(TableName: String): string;
//生成@Delete语句
var
  s_Sql: string;
  s, skey: string;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 +
  '        b.COLUMN_NAME as keyName' + #13#10 +
  'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 +
  '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 +
  '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 +
  ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

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

function TConnectionMgr.getMapperInsert(TableName: String): string;
//生成@Insert语句
var
  s_Sql: string;
  s, skey: string;
  list_name, list_value: TStringList;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 +
  '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 +
  '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 +
  '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 +
  ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

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
        list_value.Add(Format('#{%s}',[FieldByName('column_name').AsString]));
        Next;
      end;
    end;
    Result := Format('INSERT INTO %s(%s) VALUES(%s)', [TableName,list_name.CommaText, list_value.CommaText]);
  finally
    list_name.Free;
    list_value.Free
  end;
end;

function TConnectionMgr.getMapperSelect(TableName: string): string;
//生成MyBatis中的@Select语句
var
  s_Sql: string;
  s, skey: string;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 +
  '        b.COLUMN_NAME as keyName' + #13#10 + 'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 +
  '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 +
  '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 +
  ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

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

function TConnectionMgr.getMapperUpdate(TableName: String): string;
//生成MyBatis中的@Update语句
var
  s_Sql: string;
  s, skey: string;
  list_name, list_value: TStringList;
begin
  Result := '';
  s_Sql := Format('SELECT  a.COLUMN_NAME  ,' + #13#10 +
  '        b.COLUMN_NAME as keyName' + #13#10 +
  'FROM    INFORMATION_SCHEMA.COLUMNS a' + #13#10 +
  '        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE b ON a.TABLE_CATALOG = b.TABLE_CATALOG' + #13#10 +
  '                                                           AND b.TABLE_NAME = a.TABLE_NAME' + #13#10 +
  ' WHERE   a.TABLE_NAME = %s', [QuotedStr(TableName)]);

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
        list_name.Add(Format('%s=#{%s}',[FieldByName('column_name').AsString,FieldByName('column_name').AsString]));
        skey := FieldByName('keyName').AsString;
        Next;
      end;
    end;
    Result := Format('Update %s Set %s Where %s=#{%s} ',[TableName,list_name.CommaText,skey,skey]);
  finally
    list_name.Free;
    list_value.Free
  end;
end;

function TConnectionMgr.getTables(isRefered: boolean = False): TStringList;
//取得所有表的结构
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

