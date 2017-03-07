program QQXF;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmQQXF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmQQXF, frmQQXF);
  Application.Run;
end.
