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
  Wke,
  DuiWkeBrowser;

type
  TWkeBrowserWindow = class(TDuiWindowImplBase)
  private
    FWkeWebbrowser: TWkeWebbrowser;
    procedure OnTitleChanged(Sender: TObject; const ATitle: string);
    procedure OnURLChanged(Sender: TObject; const AURL: string);
    procedure OnDocumentReady(Sender: TObject);
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

function JsMessageBox(es: jsExecState): JsValue;
begin
  Writeln(jsArgCount(es));
  MessageBox(0, PChar(JScript.ToTempString(es, JScript.Arg(es, 0))),
                PChar(JScript.ToTempString(es, JScript.Arg(es, 1))),
                0);
  Result := JScript.String_(es, '这是一个返回值测试');
end;

function JsFunc2(es: jsExecState): jsValue;
begin
  Result := JScript.Arg(es, 0);
end;

constructor TWkeBrowserWindow.Create;
begin
  inherited Create('WkebrowserWindow.xml', 'skin');
  FWkeWebbrowser := TWkeWebbrowser.Create;
  FWkeWebbrowser.OnTitleChanged := OnTitleChanged;
  FWkeWebbrowser.OnURLChanged := OnURLChanged;
  FWkeWebbrowser.OnDocumentReady := OnDocumentReady;
  CreateWindow(0, 'wke浏览器', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);

  JScript.BindFunction('jsMessageBox', JsMessageBox, 2);
  JScript.BindFunction('JsFunc2', JsFunc2, 1);
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
begin
  inherited;

  FWkeWebbrowser.InitWkeWebBrowser(FindControl('webbrowser'));
  FWkeWebbrowser.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36';

  //FWkeWebbrowser.Navigate('http://www.baidu.com');
//  FWkeWebbrowser.Navigate('http://www.oschina.net');
  FWkeWebbrowser.LoadFile('skin\testhtml.html');


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

procedure TWkeBrowserWindow.OnDocumentReady(Sender: TObject);
begin
  Writeln('加载完成');
end;

procedure TWkeBrowserWindow.OnTitleChanged(Sender: TObject;
  const ATitle: string);
begin
  Writeln('title=', ATitle);
end;

procedure TWkeBrowserWindow.OnURLChanged(Sender: TObject; const AURL: string);
begin
  Writeln('url=', AURL);
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
