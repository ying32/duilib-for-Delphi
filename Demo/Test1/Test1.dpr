program Test1;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  Duilib,
  uMain in 'uMain.pas' {Form1},
  DuiVCLComponent in 'DuiVCLComponent.pas';

{$R *.res}



begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
