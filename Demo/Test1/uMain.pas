unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DuiVCLComponent;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FDuiForm: TDDuiForm;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  FDuiForm := TDDuiForm.Create(Self);
  FDuiForm.SkinXmlFile := 'login.xml';
  FDuiForm.SkinFolder := '\skin\QQNewRes\';
  FDuiForm.InitUI;
end;

end.
