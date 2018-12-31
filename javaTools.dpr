program javaTools;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uTableMgr in 'uTableMgr.pas',
  udbMgr in 'udbMgr.pas',
  uConnectionMgr in 'uConnectionMgr.pas',
  uMsg in 'uMsg.pas',
  uAbortForm in 'uAbortForm.pas' {frmAbort};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
