program webbrowser;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  Classes,
  SysUtils,
  Variants,
  ActiveX,
  DuiConst,
  Duilib,
  DuiActiveX,
  DuiWindowImplBase,
  SHDocVw;

type

  TWebbrowserWindow = class(TDuiWindowImplBase)
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
  public
    constructor Create;
  end;

{ TWebbrowserWindow }

constructor TWebbrowserWindow.Create;
begin
  inherited Create('WebbrowserWindow.xml', 'skin');
  CreateWindow(0, 'ä¯ÀÀÆ÷', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
end;

procedure TWebbrowserWindow.DoInitWindow;
var
  pActiveXUI: CActiveXUI;
  pWebBrowser: IWebBrowser2;
begin
  inherited;
  pActiveXUI := CActiveXUI(FindControl('ie'));
  if pActiveXUI <> nil then
  begin
    pActiveXUI.GetControl(IID_IWebBrowser2, pWebBrowser);
    if pWebBrowser <> nil then
      pWebBrowser.Navigate('http://git.oschina.net/ying32/Duilib-for-Delphi', NULL, NULL, NULL, NULL);
  end;
end;

procedure TWebbrowserWindow.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType = DUI_MSGTYPE_CLICK then
  begin
    if Msg.pSender.Name = 'closebtn' then
      DuiApplication.Terminate;
  end;
end;

var
  WebbrowserWindow: TWebbrowserWindow;

begin
  try
    DuiApplication.Initialize;
    CoInitialize(nil);
    WebbrowserWindow := TWebbrowserWindow.Create;
    WebbrowserWindow.CenterWindow;
    WebbrowserWindow.Show;
    DuiApplication.Run;
    WebbrowserWindow.Free;
    CoUninitialize;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
