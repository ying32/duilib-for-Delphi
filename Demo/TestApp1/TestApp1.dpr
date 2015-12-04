program TestApp1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  DuiConst,
  DuiWindowImplBase,
  Duilib,
  DuilibHelper;

type

  TFrameWindowWnd = class(TDuiWindowImplBase)
  private
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TFrameWindowWnd }

constructor TFrameWindowWnd.Create;
begin
  inherited Create('test1.xml', 'skin\TestAppRes');
  CreateWindow(0, '这是一个最简单的测试用exe，修改test1.xml就可以看到效果', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
  Writeln('handle=', Handle);
  SetWindowLongPtr(Handle, GWL_STYLE, GetWindowLongPtr(Handle, GWL_STYLE) or WS_CAPTION or WS_SYSMENU);
end;

destructor TFrameWindowWnd.Destroy;
begin

  inherited;
end;

procedure TFrameWindowWnd.DoHandleMessage(var Msg: TMessage);
begin
  inherited;

end;

procedure TFrameWindowWnd.DoInitWindow;
begin
  inherited;

end;

procedure TFrameWindowWnd.DoNotify(var Msg: TNotifyUI);
begin
  inherited;

end;

var
  FrameWindowWnd: TFrameWindowWnd;

begin
  try
    DuiApplication.Initialize;
    FrameWindowWnd := TFrameWindowWnd.Create;
    FrameWindowWnd.CenterWindow;
    FrameWindowWnd.Show;
    DuiApplication.Run;
    FrameWindowWnd.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
