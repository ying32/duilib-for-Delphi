program Project1;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  ufrmDesignerTemplate in 'ufrmDesignerTemplate.pas' {frmDesignerTemplate},
  ufrmMain in 'ufrmMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
