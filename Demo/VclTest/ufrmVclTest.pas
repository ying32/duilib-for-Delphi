unit ufrmVclTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DDuilibComponent, StdCtrls, Duilib,
  ExtCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    DDuiApp1: TDDuiApp;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
//    FDuiApp: TDDuiApp;
//    FDuiForm: TDDuiForm;
    hInstRich: THandle;
  public
    procedure WndProc(var Msg: TMessage); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  frmChat, ufrmTest3, ufrmWebbrowser;

procedure TForm1.btn1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  form4.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  hInstRich := LoadLibrary('Riched20.dll');
//  FDuiApp := TDDuiApp.Create(nil);
//  FDuiForm := TDDuiForm.Create(Self);

//  FDuiForm.SkinFolder := '\skin\QQRes\';
//  FDuiForm.SkinXml := 'main_frame.xml';
//  FDuiForm.SkinFolder := 'skin\TestAppRes';
//  FDuiForm.SkinXml := 'test1.xml';
// 动态创建组件需要手动调用下,非动态则不需要
//  FDuiForm.InitDuiComponent;

//  FDuiForm.DUI.Show;
  // 默认的这个类是去掉标题栏的，所以要重新补回
  //SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or WS_CAPTION);
  //SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  FDuiApp.Free;
  FreeLibrary(hInstRich);
end;

procedure TForm1.WndProc(var Msg: TMessage);
begin
  inherited;
end;

end.
