program Apps;

uses
  DuiWindowImplBase,
  uMain in 'uMain.pas';

{$R *.res}

begin
  DuiApplication.Initialize;
  AppsWindow := TAppsWindow.Create;
  AppsWindow.CenterWindow;
  AppsWindow.Show;
  DuiApplication.Run;
  AppsWindow.Free;
end.
