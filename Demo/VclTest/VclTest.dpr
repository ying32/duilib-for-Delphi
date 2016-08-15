program VclTest;

uses
  Vcl.Forms,
  ufrmVclTest in 'ufrmVclTest.pas' {Form1},
  DDuilibComponent in '..\..\DDuilib\DDuilibComponent.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
