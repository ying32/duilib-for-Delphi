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
    function DoCreateControl(pstrStr: string): CControlUI; override;
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
  CreateDuiWindow(0, 'NativeControl测试');
end;

destructor TDuiNativeControlTest.Destroy;
begin
  if Assigned(FButton) then FButton.Free;
  inherited;
end;

function TDuiNativeControlTest.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
  if pstrStr = 'NativeControl' then
  begin
    FButton := TButton.Create(nil);
    FButton.ParentWindow := Handle;
    FButton.Left := 100;
    FButton.Top := 100;
    FButton.Caption := '按钮1';
    FButton.OnClick := ButtonClick;
    CNativeControlUI.CppCreate(FButton.Handle);
  end;
end;

procedure TDuiNativeControlTest.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_COMMAND then
  begin
    Writeln(Format('FButton Ptr=%p, FButton.Handle=%.8x', [Pointer(FButton), FButton.Handle]));
    Writeln(Format('Msg.WParam=%.8x, Msg.LParam=%.8x', [Msg.WParam, Msg.LParam]));
    if Msg.LParam = FButton.Handle then
      FButton.WindowProc(Msg);
  end;
end;

procedure TDuiNativeControlTest.DoInitWindow;
begin
  inherited;

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
