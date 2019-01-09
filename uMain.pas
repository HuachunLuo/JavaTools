unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, CheckLst, UniProvider,
  SQLServerUniProvider, DB, DBAccess, Uni, uConnectionMgr, Menus,
  MySQLUniProvider;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    sbStatus: TStatusBar;
    Button1: TButton;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    lbTables: TListBox;
    PopupMenu1: TPopupMenu;
    mmoContext: TMemo;
    getEntity: TMenuItem;
    miMapperSelect: TMenuItem;
    miSelect: TMenuItem;
    miInsert: TMenuItem;
    miUpdate: TMenuItem;
    miDelete: TMenuItem;
    Panel5: TPanel;
    cbUpperCase: TCheckBox;
    N1: TMenuItem;
    N2: TMenuItem;
    cbbServers: TComboBox;
    N3: TMenuItem;
    CreateEntityFile1: TMenuItem;
    CreateControllerFile1: TMenuItem;
    CreateDaoFile1: TMenuItem;
    CreateServiceFile1: TMenuItem;
    CreateImplFile1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure cbUpperCaseClick(Sender: TObject);
    procedure CreateControllerFile1Click(Sender: TObject);
    procedure CreateDaoFile1Click(Sender: TObject);
    procedure CreateEntityFile1Click(Sender: TObject);
    procedure CreateImplFile1Click(Sender: TObject);
    procedure CreateServiceFile1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getEntityClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miInsertClick(Sender: TObject);
    procedure mirefresClick(Sender: TObject);
    procedure miSelectClick(Sender: TObject);
    procedure miUpdateClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  SetupForm, uGlobal;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
var
  sConnName:String;
begin
    sbStatus.Panels[1].Text := '未连接';
  lbTables.Items.Clear;
  mmoContext.Lines.Clear;

  
  if  cbbServers.ItemIndex = -1 then   exit;
  sConnName := cbbServers.Items[cbbServers.itemindex]; 
  ConnectionMgr.conn(sConnName);

  if ConnectionMgr.isConnection then
  begin
    sbStatus.Panels[1].Text := '已连接';
    mmoContext.Lines.Clear;
    TableMgr.init;
    lbTables.Items.CommaText := TableMgr.getTables;
  end
  else
    sbStatus.Panels[1].Text := '未连接';
end;

procedure TfrmMain.cbUpperCaseClick(Sender: TObject);
begin
  if cbUpperCase.Checked then
    mmoContext.Lines.CommaText := UpperCase(mmoContext.Lines.CommaText)
  else
    mmoContext.Lines.CommaText := LowerCase(mmoContext.Lines.CommaText)
end;

procedure TfrmMain.CreateControllerFile1Click(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.text := TableMgr.CreateController(tableName);

end;

procedure TfrmMain.CreateDaoFile1Click(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.text := TableMgr.CreateDao(tableName);

end;


{-------------------------------------------------------------------------------
  过程名:    TfrmMain.CreateEntityFile1Click
  作者:      RO
  日期:      2019.01.09
  参数:      Sender: TObject
  返回值:    创建实体文件
-------------------------------------------------------------------------------}
procedure TfrmMain.CreateEntityFile1Click(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.text := TableMgr.CreateEntity(tableName);
end;

procedure TfrmMain.CreateImplFile1Click(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.text := TableMgr.CreateImpl(tableName);

end;

procedure TfrmMain.CreateServiceFile1Click(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.text := TableMgr.CreateService(tableName);

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  sbStatus.Panels[1].Text := '未连接';
  cbbServers.Items.CommaText := ConnectionMgr.getConns;
  cbbServers.Itemindex := cbbServers.Items.IndexOf(systemMgr.getDefaultConnectionParamName);
end;

procedure TfrmMain.getEntityClick(Sender: TObject);
//生成实体类
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.CommaText := TableMgr.getEntity(tableName);

end;

procedure TfrmMain.miDeleteClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.Add(TableMgr.getMapperDelete(tableName));
end;

procedure TfrmMain.miInsertClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.add(TableMgr.getMapperInsert(tableName));
end;

procedure TfrmMain.mirefresClick(Sender: TObject);
begin
  if ConnectionMgr.isConnection then
  begin
    sbStatus.Panels[1].Text := '已连接';
    lbTables.Items.Clear;
//    lbTables.Items.CommaText := connMgr.getTables(true).CommaText;
  end
  else
    sbStatus.Panels[1].Text := '未连接';
end;

procedure TfrmMain.miSelectClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.Add(TableMgr.getMapperSelect(tableName));
end;

procedure TfrmMain.miUpdateClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;
  tableName := lbTables.Items[lbTables.itemindex];
  mmoContext.Lines.Clear;
  mmoContext.Lines.Add(TableMgr.getMapperUpdate(tableName));
end;

procedure TfrmMain.N2Click(Sender: TObject);
var
  frmSetup: TFrmSetup;
begin
  frmSetup := TfrmSetup.Create(nil);
  try
    with frmSetup do
    begin
      ShowModal;
    end;
  finally
    FreeAndNil(frmSetup);
  end;

end;

end.

