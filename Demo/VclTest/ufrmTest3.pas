unit ufrmTest3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DDuilibComponent, Duilib, StdCtrls,
  ExtCtrls, DuiConst;

type
  TForm3 = class(TForm)
    DDuiForm1: TDDuiForm;
    btn1: TButton;
    tmr1: TTimer;
    procedure DDuiForm1InitWindow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnTest(Sender: TNotifyUI; var Handled: Boolean);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses frmChat;

procedure TForm3.btn1Click(Sender: TObject);
begin
  ShowMessage('我是按钮');
end;

procedure TForm3.DDuiForm1InitWindow(Sender: TObject);
var
  LCtl: CNativeControlUI;
begin
  Writeln('DDuiForm1InitWindow');

  LCtl := CNativeControlUI.CppCreate(0);
  // 先这样
  LCtl.SetManager(DDuiForm1.DUI.PaintManagerUI, DDuiForm1.DUI.PaintManagerUI.GetRoot, False);
  LCtl.Name := btn1.Name;
  LCtl.SetNativeHandle(btn1.Handle);
  LCtl.Visible := True;
  LCtl.SetPos(Rect(1, 1, btn1.Width, btn1.Height), False);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  DDuiForm1.AddObjectEvent(DUI_MSGTYPE_CLICK, 'friendbtn', OnTest);
end;

procedure TForm3.OnTest(Sender: TNotifyUI; var Handled: Boolean);
begin
  Form2.Show;
end;

procedure TForm3.tmr1Timer(Sender: TObject);
begin
  Writeln('我是定时器');
end;

end.
