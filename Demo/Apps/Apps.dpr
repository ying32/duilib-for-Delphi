program Apps;

uses
  DuiWindowImplBase,
  uMain in 'uMain.pas';

{$R *.res}

begin
  DuiApplication.Initialize;
  AppsWindow := TAppsWindow.Create;
  AppsWindow.Show;
  AppsWindow.Show;
  DuiApplication.Run;
  AppsWindow.Free;
end.
