program MenuDemo;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  DuiConst,
  DuiWindowImplBase,
  Duilib,
  DuiMenu;

type

  TFrameWindowWnd = class(TDuiWindowImplBase)
  private
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TFrameWindowWnd }

constructor TFrameWindowWnd.Create;
begin
  inherited Create('menutestskin.xml', 'skin\TestAppRes');
  CreateWindow(0, '', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
end;

destructor TFrameWindowWnd.Destroy;
begin
  inherited;
end;

procedure TFrameWindowWnd.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
end;

procedure TFrameWindowWnd.DoInitWindow;
begin
  inherited;
  Writeln(Format('Delphi PaintManagerUI = %p', [Pointer(PaintManagerUI)]));
end;

procedure TFrameWindowWnd.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
  pMenu: CMenuWnd;
  point: TPoint;
begin
  inherited;
{$IFNDEF UseLowVer}
  LType := Msg.sType;
{$ELSE}
  LType := DuiStringToString(Msg.sType);
{$ENDIF}
  LCtlName := Msg.pSender.Name;
  if LType = DUI_MSGTYPE_CLICK then
  begin
    if LCtlName = 'btn_menu' then
    begin
      pMenu := CMenuWnd.CppCreate(Handle, PaintManagerUI);
      point := msg.ptMouse;
      ClientToScreen(Handle, point);
      pMenu.Init(nil, 'menutest.xml', '', point);
    end;
  end else if LType = DUI_MSGTYPE_MENUITEMCLICK then
  begin
    Writeln(Format('Type=%s, Name=%s, Text=%s', [LType, LCtlName, Msg.pSender.Text]));
    MessageBox(Handle, PChar(Format('点击了"%s"菜单项', [LCtlName])), '菜单点击', 0);
  end;
end;

var
  FrameWindowWnd: TFrameWindowWnd;

begin
  try
    ReportMemoryLeaksOnShutdown := True;
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
