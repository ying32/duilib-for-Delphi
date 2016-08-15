unit ufrmVclTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DDuilibComponent, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    FDuiApp: TDDuiApp;
    FDuiForm: TDDuiForm;
    hInstRich: THandle;
  public
    procedure WndProc(var Msg: TMessage); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  hInstRich := LoadLibrary('Riched20.dll');
  FDuiApp := TDDuiApp.Create(nil);
  FDuiForm := TDDuiForm.Create(Self);

  FDuiForm.SkinFolder := '\skin\QQRes\';
  FDuiForm.SkinXml := 'main_frame.xml';
//  FDuiForm.SkinFolder := 'skin\TestAppRes';
//  FDuiForm.SkinXml := 'test1.xml';
  FDuiForm.InitDuiComponent;

//  FDuiForm.DUI.Show;
  // 默认的这个类是去掉标题栏的，所以要重新补回
  //SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or WS_CAPTION);
  //SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FDuiApp.Free;
  FreeLibrary(hInstRich);
end;

procedure TForm1.WndProc(var Msg: TMessage);
begin
  inherited;
  //if Msg.Msg = WM_CREATE then
  //  MessageBox(0, 'WM_CREATE', nil, 0);
end;

end.
