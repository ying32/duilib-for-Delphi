program NativeControl;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  Classes,
  SysUtils,
  StdCtrls,
  Duilib,
  DuiConst,
  DuiWindowImplBase;

type
  TDuiNativeControlTest = class(TDuiWindowImplBase)
  private
    FButton: TButton;
    procedure ButtonClick(Sender: TObject);
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TDuiNativeControlTest }

procedure TDuiNativeControlTest.ButtonClick(Sender: TObject);
begin
   MessageBox(0, '单击了按钮', '消息', 0);
end;

constructor TDuiNativeControlTest.Create;
begin
  inherited Create('NativeControlTest.xml', 'skin');

  // 之前创建
  FButton := TButton.Create(nil);
  FButton.Caption := '按钮1';
  FButton.OnClick := ButtonClick;

  CreateDuiWindow(0, 'NativeControl测试');
end;

destructor TDuiNativeControlTest.Destroy;
begin
  FButton.Free;
  inherited;
end;

procedure TDuiNativeControlTest.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_COMMAND then
  begin
    // 在WM_COMMAND中接收
    if Msg.LParam = FButton.Handle then
      FButton.WindowProc(Msg);
  end;
end;

procedure TDuiNativeControlTest.DoInitWindow;
var
  LNativeCtl: CNativeControlUI;
begin
  inherited;
  LNativeCtl := CNativeControlUI(FindControl('test1'));
  if LNativeCtl <> nil then
  begin
    // 这个只能使用delphi设置parent
    FButton.ParentWindow := Handle;
    LNativeCtl.SetNativeHandle(FButton.Handle);
  end;
end;

procedure TDuiNativeControlTest.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
end;


var
  DuiNativeControlTest: TDuiNativeControlTest;

begin
  try
    DuiApplication.Initialize;
    DuiNativeControlTest := TDuiNativeControlTest.Create;
    DuiNativeControlTest.CenterWindow;
    DuiNativeControlTest.Show;
    DuiApplication.Run;
    DuiNativeControlTest.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
