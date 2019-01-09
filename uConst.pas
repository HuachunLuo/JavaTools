unit uConst;

interface

const
  Sql_AllTable='SELECT' + #13#10 +
'    tableName       = case when a.colorder=1 then d.name else '''' end,' + #13#10 +
'    tableDescript     = case when a.colorder=1 then isnull(f.value,'''') else '''' end,' + #13#10 +
'    fieldNo   = a.colorder,' + #13#10 +
'    FieldName     = a.name,' + #13#10 +
'    Flag       = case when COLUMNPROPERTY( a.id,a.name,''IsIdentity'')=1 then ''1''else ''0'' end,' + #13#10 +
'    ispri       = case when exists(SELECT 1 FROM sysobjects where xtype=''PK'' and parent_obj=a.id and name in (' + #13#10 +
'                     SELECT name FROM sysindexes WHERE indid in( SELECT indid FROM sysindexkeys WHERE id = a.id AND colid=a.colid))) then ''1'' else ''0'' end,' + #13#10 +
'    atype       = b.name,' + #13#10 +
'    scaleByte = a.length,' + #13#10 +
'    aLenth       = COLUMNPROPERTY(a.id,a.name,''PRECISION''),' + #13#10 +
'    ScaleNum   = isnull(COLUMNPROPERTY(a.id,a.name,''Scale''),0),' + #13#10 +
'    isNull_     = case when a.isnullable=1 then 1 else 0 end,' + #13#10 +
'    defaultValue     = isnull(e.text,''''),' + #13#10 +
'    FieldDescript   = isnull(g.[value],'''')' + #13#10 +
'FROM' + #13#10 +
'    syscolumns a' + #13#10 +
'left join systypes b on a.xusertype=b.xusertype' + #13#10 +
'inner join sysobjects d on a.id=d.id  and d.xtype=''U'' and  d.name<>''dtproperties''' + #13#10 +
'left join  syscomments e on a.cdefault=e.id' + #13#10 +
'left join  sys.extended_properties   g on a.id=G.major_id and a.colid=g.minor_id' + #13#10 +
'left join  sys.extended_properties f on d.id=f.major_id and f.minor_id=0' + #13#10 +
'where 0=0 --d.name=''users''    --如果只查询指定表,加上此where条件，tablename是要查询的表名；去除where条件查询所有的表信息' + #13#10 +
'order by a.id,a.colorder' ;

implementation

end.
