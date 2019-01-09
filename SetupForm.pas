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
    btninit: TButton;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    edtPackageName: TEdit;
    Panel3: TPanel;
    Button1: TButton;
    procedure btninitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
uses uGlobal;


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

procedure TfrmSetup.Button1Click(Sender: TObject);
begin
  systemMgr.packageName := edtPackageName.Text;
  mgr.Save(mmoTypeConvert.Lines.CommaText);
end;

end.

