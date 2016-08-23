program PCManager;

{I DDuilib.inc}

uses
  Forms,
  uMain in 'uMain.pas' {DDuiPCManager};

{$R *.res}

begin
  Application.Initialize;
{$IFDEF UNICODE}
  Application.MainFormOnTaskbar := True;
{$ENDIF}
  Application.CreateForm(TDDuiPCManager, DDuiPCManager);
  Application.Run;
end.
