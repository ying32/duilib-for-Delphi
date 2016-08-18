unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DuiVCLComponent, Duilib, DuiConst;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FDuiForm: TDDuiForm;
    FComb: CComboUI;

    procedure OnNotify(Sender: TObject; var Msg: TNotifyUI);
    procedure OnSetBtnClick(Sender: TObject; var Msg: TNotifyUI);
    procedure OnDuiDynCreate(Sender: TObject; AMgr: CPaintManagerUI; var ARoot: CControlUI);
    procedure OnListDeleteClick(Sender: TObject; var Msg: TNotifyUI);
    procedure OnInitWindow(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ufrmTest2;


procedure TForm1.FormCreate(Sender: TObject);
begin
  FDuiForm := TDDuiForm.Create(Self);
  FDuiForm.OnNotify := OnNotify;
  FDuiForm.OnInitWindow := OnInitWindow;
  FDuiForm.AddObjectClick('setbtn', OnSetBtnClick);
  FDuiForm.AddObjectClick('delete', OnListDeleteClick);
//  FDuiForm.SkinKind := skDynCreate;
  FDuiForm.OnDynCreate := OnDuiDynCreate;
  FDuiForm.SkinXmlFile := 'login.xml';
  FDuiForm.SkinFolder := '\skin\QQNewRes\';
  FDuiForm.InitUI;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Writeln('mouse down');
end;

procedure TForm1.OnDuiDynCreate(Sender: TObject; AMgr: CPaintManagerUI;
  var ARoot: CControlUI);
var
  LCtl: CHorizontalLayoutUI;
begin
  Writeln('动态创建事件');
  AMgr.SetCaptionRect(Rect(0, 0, 0, 36));
  AMgr.SetInitSize(400, 300);
  //AMgr.Layered := False;
  // 不知道他这个怎么操作的
  ARoot := CVerticalLayoutUI.CppCreate;
  ARoot.Visible := True;
  ARoot.BkColor := ColorToRGB(clBtnFace);
  ARoot.SetManager(AMgr, nil, False);
  LCtl := CHorizontalLayoutUI.CppCreate;
  LCtl.SetManager(AMgr, ARoot, False);
  LCtl.BkColor := ColorToRGB(clRed);

  //ARoot.SetManager(nil, nil, True);
end;

procedure TForm1.OnInitWindow(Sender: TObject);
begin
  FComb := FDuiForm.FindControl<CComboUI>('users');

end;

procedure TForm1.OnListDeleteClick(Sender: TObject; var Msg: TNotifyUI);
begin
  Writeln('删除按钮.Parent=', Msg.wParam, '   ', Msg.lParam);
  Writeln('FComb.Index=', FComb.CurSel);
  if FComb.CurSel <> -1 then
  begin
    FComb.RemoveAt(FComb.CurSel);
    FComb.CurSel := -1;
  end;
end;

procedure TForm1.OnNotify(Sender: TObject; var Msg: TNotifyUI);
begin
//  Writeln('type:' + Msg.sType.ToString + ', name:' + Msg.pSender.Name);
end;

procedure TForm1.OnSetBtnClick(Sender: TObject; var Msg: TNotifyUI);
begin
  //ShowMessage('设置');
  Form2.Show;
end;

end.
