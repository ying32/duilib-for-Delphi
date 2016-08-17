program Test1;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  Duilib,
  uMain in 'uMain.pas' {Form1},
  DuiVCLComponent in 'DuiVCLComponent.pas';

{$R *.res}
var
  FDuiForm: TDDuiForm;
begin
  CPaintManagerUI.SetInstance(HInstance);
  FDuiForm := TDDuiForm.Create(nil);
  FDuiForm.SkinXmlFile := 'login.xml';
  FDuiForm.SkinFolder := '\skin\QQNewRes\';
  FDuiForm.InitUI;
  FDuiForm.Form.Show;
//  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TForm1, Form1);
  CPaintManagerUI.MessageLoop;
end.
