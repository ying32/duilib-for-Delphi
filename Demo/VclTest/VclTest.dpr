program VclTest;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  Duilib,
  ufrmVclTest in 'ufrmVclTest.pas' {Form1},
  DDuilibComponent in '..\..\DDuilib\DDuilibComponent.pas',
  frmChat in 'frmChat.pas' {Form2};

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;


end.
