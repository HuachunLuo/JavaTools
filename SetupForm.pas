unit SetupForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, uTypeConvert;

type
  TfrmSetup = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    mmoTypeConvert: TMemo;
    Panel2: TPanel;
    btnSave: TButton;
    btninit: TButton;
    TabSheet2: TTabSheet;
    Panel4: TPanel;
    edtConnectionString: TEdit;
    lbConfigs: TListBox;
    Label1: TLabel;
    btnAdd: TButton;
    edtConfigName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnsaveConfig: TButton;
    procedure btninitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lbConfigsDblClick(Sender: TObject);
  private
    Mgr: TTypeConvertMgr;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;
  Path: string;

implementation


{$R *.dfm}

procedure TfrmSetup.btninitClick(Sender: TObject);
begin
  with mmoTypeConvert.Lines do
  begin
    clear;
    Add('varchar=String');
    Add('CHAR=String');
    Add('numeric=Float');
    Add('int=Integer');
    Add('date=Date');
    Add('datetime=Date');
  end;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
begin
  mgr.Free;
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  Mgr := TTypeConvertMgr.Create;
  mmoTypeConvert.Lines.CommaText := mgr.Load;
end;

procedure TfrmSetup.btnSaveClick(Sender: TObject);
begin
  mgr.Save(mmoTypeConvert.Lines.CommaText);
end;

procedure TfrmSetup.btnAddClick(Sender: TObject);
begin
  lbConfigs.Items.Add(Format('%s=%s',[edtConfigName.Text,edtConnectionString.Text]));
end;

procedure TfrmSetup.lbConfigsDblClick(Sender: TObject);
var
  sName,sValue:String;
begin
  sName := lbConfigs.Items.Names[lbConfigs.ItemIndex];
  edtConnectionString.text := lbConfigs.Items.Values[sName];
  edtConfigName.Text := sName;
end;

end.

