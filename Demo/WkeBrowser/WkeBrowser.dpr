program WkeBrowser;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Duilib,
  DuiConst,
  DuiWindowImplBase,
  DuiWkeBrowser;

type
  TWkeBrowserWindow = class(TDuiWindowImplBase)
  private
    FWkeWebbrowser: TWkeWebbrowser;
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TWkeBrowserWindow }

constructor TWkeBrowserWindow.Create;
begin
  inherited Create('WkebrowserWindow.xml', 'skin');
  FWkeWebbrowser := TWkeWebbrowser.Create;
  CreateWindow(0, 'wkeä¯ÀÀÆ÷', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
end;

destructor TWkeBrowserWindow.Destroy;
begin
  FWkeWebbrowser.Free;
  inherited;
end;

function TWkeBrowserWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  if pstrStr = 'NativeControl' then
    Exit(CNativeControlUI.CppCreate);
  Result := nil;
end;

procedure TWkeBrowserWindow.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;

end;

procedure TWkeBrowserWindow.DoInitWindow;
var
  pControl: CNativeControlUI;
begin
  inherited;
  pControl := CNativeControlUI(FindControl('webbrowser'));
  if pControl <> nil then
  begin
    FWkeWebbrowser.SetWkeWebbrowserUI(pControl);
    FWkeWebbrowser.Navigate('http://www.baidu.com');
  end;
end;

procedure TWkeBrowserWindow.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType = DUI_MSGTYPE_CLICK then
  begin
    if Msg.pSender.Name = 'closebtn' then
      DuiApplication.Terminate;
  end;
end;

var
  WkeBrowserWindow: TWkeBrowserWindow;

begin
  try
    DuiApplication.Initialize;
    WkeBrowserWindow := TWkeBrowserWindow.Create;
    WkeBrowserWindow.CenterWindow;
    WkeBrowserWindow.Show;
    DuiApplication.Run;
    WkeBrowserWindow.Free;
  except
    on E: Exception do
      Writeln(E.Message);
  end;
end.
