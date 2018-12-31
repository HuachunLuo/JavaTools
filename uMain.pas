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
    edtServer: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    edtPort: TEdit;
    edtDBName: TEdit;
    edtUserName: TEdit;
    edtPassWord: TEdit;
    lbTables: TListBox;
    PopupMenu1: TPopupMenu;
    mirefres: TMenuItem;
    mmoContext: TMemo;
    getEntity: TMenuItem;
    miMapperSelect: TMenuItem;
    miSelect: TMenuItem;
    miInsert: TMenuItem;
    miUpdate: TMenuItem;
    miDelete: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getEntityClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miInsertClick(Sender: TObject);
    procedure mirefresClick(Sender: TObject);
    procedure miSelectClick(Sender: TObject);
    procedure miUpdateClick(Sender: TObject);
  private
    connMgr: TConnectionMgr;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if not connMgr.isConnection then
    connMgr.conn(edtServer.Text, StrToInt(edtPort.Text), edtDBName.Text, edtUserName.Text, edtPassWord.Text);

  if connMgr.isConnection then
  begin
    sbStatus.Panels[1].Text := '已连接';
    lbTables.Items.CommaText := connMgr.getTables.CommaText;
  end
  else
    sbStatus.Panels[1].Text := '未连接';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  connMgr.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  sbStatus.Panels[1].Text := '未连接';
  connMgr := TConnectionMgr.Create;
end;

procedure TfrmMain.getEntityClick(Sender: TObject);
//生成实体类
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then
    exit;

  tableName := lbTables.Items.Names[lbTables.itemindex];

  mmoContext.Lines.CommaText := connMgr.getEntity(tableName);

end;

procedure TfrmMain.miDeleteClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then    exit;
  tableName := lbTables.Items.Names[lbTables.itemindex];
  mmoContext.Text := connMgr.getMapperDelete(tableName);
end;

procedure TfrmMain.miInsertClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then    exit;
  tableName := lbTables.Items.Names[lbTables.itemindex];
  mmoContext.text := connMgr.getMapperInsert(tableName);
end;

procedure TfrmMain.mirefresClick(Sender: TObject);
begin
  if connMgr.isConnection then
  begin
    sbStatus.Panels[1].Text := '已连接';
    lbTables.Items.Clear;
    lbTables.Items.CommaText := connMgr.getTables(true).CommaText;
  end
  else
    sbStatus.Panels[1].Text := '未连接';
end;

procedure TfrmMain.miSelectClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then    exit;
  tableName := lbTables.Items.Names[lbTables.itemindex];
  mmoContext.text := connMgr.getMapperSelect(tableName);
end;

procedure TfrmMain.miUpdateClick(Sender: TObject);
var
  tableName: string;
begin
  if lbTables.SelCount = 0 then    exit;
  tableName := lbTables.Items.Names[lbTables.itemindex];
  mmoContext.text := connMgr.getMapperUpdate(tableName);
end;

end.

