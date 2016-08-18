program PCManager;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {DDuiPCManager};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDDuiPCManager, DDuiPCManager);
  Application.Run;
end.
