program javaTools;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uTableMgr in 'uTableMgr.pas',
  udbMgr in 'udbMgr.pas',
  uConnectionMgr in 'uConnectionMgr.pas',
  uMsg in 'uMsg.pas',
  uAbortForm in 'uAbortForm.pas' {frmAbort},
  SetupForm in 'SetupForm.pas' {frmSetup},
  uConst in 'uConst.pas',
  uTypeConvert in 'uTypeConvert.pas',
  uConfigMgr in 'uConfigMgr.pas',
  uMyToolsMgr in 'uMyToolsMgr.pas',
  uSystemMgr in 'uSystemMgr.pas',
  uGlobal in 'uGlobal.pas',
  uConnParamMgr in 'uConnParamMgr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
