program Project1;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  ufrmDesignerTemplate in 'ufrmDesignerTemplate.pas' {frmDesignerTemplate},
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uPropertyClass in 'uPropertyClass.pas',
  ufrmImageEditor in 'ufrmImageEditor.pas' {frm_ImageEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tfrm_ImageEditor, frm_ImageEditor);
  Application.Run;
end.
