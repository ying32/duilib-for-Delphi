unit ufrmTest2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DuiVCLComponent, Duilib;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FDuiForm: TDDuiForm;
    procedure OnNotify(Sender: TObject; var Msg: TNotifyUI);
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.WndParent := GetDesktopWindow;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FDuiForm := TDDuiForm.Create(Self);
  FDuiForm.OnNotify := OnNotify;
  FDuiForm.SkinXmlFile := 'login.xml';
  FDuiForm.SkinFolder := '\skin\QQNewRes\';
  FDuiForm.InitUI;
end;

procedure TForm2.OnNotify(Sender: TObject; var Msg: TNotifyUI);
begin

end;

end.
