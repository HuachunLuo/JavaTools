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
    procedure btninitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
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

end.

