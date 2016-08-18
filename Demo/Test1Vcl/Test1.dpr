program Test1;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  Duilib,
  uMain in 'uMain.pas' {Form1},
  DuiVCLComponent in 'DuiVCLComponent.pas',
  ufrmTest2 in 'ufrmTest2.pas' {Form2};

{$R *.res}



begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
