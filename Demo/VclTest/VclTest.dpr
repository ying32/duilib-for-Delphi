program VclTest;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  Duilib,
  ufrmVclTest in 'ufrmVclTest.pas' {Form1},
  DDuilibComponent in '..\..\DDuilib\DDuilibComponent.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;


end.
