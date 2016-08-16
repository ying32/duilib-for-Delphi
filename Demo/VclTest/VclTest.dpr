program VclTest;

{$APPTYPE CONSOLE}

uses
  Forms,
  Duilib,
  ufrmVclTest in 'ufrmVclTest.pas' {Form1},
  DDuilibComponent in '..\..\DDuilib\DDuilibComponent.pas',
  frmChat in 'frmChat.pas' {Form2},
  ufrmTest3 in 'ufrmTest3.pas' {Form3},
  ufrmWebbrowser in 'ufrmWebbrowser.pas' {Form4};

{$R *.res}


begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;


end.
