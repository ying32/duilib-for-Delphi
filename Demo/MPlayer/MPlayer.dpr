program MPlayer;

{$R *.dres}

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMPlayer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMPlayer, frmMPlayer);
  Application.Run;
end.
