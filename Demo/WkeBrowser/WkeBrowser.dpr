program WkeBrowser;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

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
    FEdtURL: CEditUI;
    FBtnGo: CButtonUI;
    FTitle: CLabelUI;
  private
    FWkeWebbrowser: TWkeWebbrowser;
    procedure OnTitleChanged(Sender: TObject; const ATitle: string);
    procedure OnURLChanged(Sender: TObject; const AURL: string);
    procedure OnDocumentReady(Sender: TObject);
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TWkeBrowserWindow }



{$IFDEF UseVcFastCall}
function JsMessageBox(es: jsExecState): JsValue;
{$ELSE}
function JsMessageBox(p1, p2, es: jsExecState): JsValue;
{$ENDIF}
begin
  {$IFDEF UseVcFastCall}
    ProcessVcFastCall;
  {$ENDIF}

  MessageBox(0, PChar(es.ToTempString(es.Arg(0))),
                PChar(es.ToTempString(es.Arg(1))),
                0);
  Result := es.String_('这是一个返回值测试');
end;

{$IFDEF UseVcFastCall}
function JsFunc2(es: jsExecState): jsValue;
{$ELSE}
function JsFunc2(p1, p2, es: jsExecState): jsValue;
{$ENDIF}
begin
  {$IFDEF UseVcFastCall}
     ProcessVcFastCall;
  {$ENDIF}
  Result := es.Arg(0);
end;

{$IFDEF UseVcFastCall}
function externalSuperCall(es: jsExecState): jsValue;
{$ELSE}
function externalSuperCall(p1, p2, es: jsExecState): jsValue;
{$ENDIF}
begin
  {$IFDEF UseVcFastCall}
     ProcessVcFastCall;
  {$ENDIF}
  Writeln('argcount=', es.Arg(0));
  Writeln('call ok.');
  Result := es.Int(0);
end;


{$IFDEF UseVcFastCall}
function externalObj(es: jsExecState): jsValue;
{$ELSE}
function externalObj(p1, p2, es: jsExecState): jsValue;
{$ENDIF}
var
  v: jsValue;
begin
  {$IFDEF UseVcFastCall}
     ProcessVcFastCall;
  {$ENDIF}
  Writeln('argcount=', es.Arg(0));
  Writeln('call ok2222.');
  v :=  es.GetGlobal('SuperCall');
  if es.IsFunction(v) then
    Writeln('is function')
  else Writeln('is not funtion');
  Result := es.Int(1);

end;

procedure jsfinalize(data: PjsData); cdecl;
begin
  Dispose(data);
  Writeln('js finalize.');
end;

function jsGetProperty(es: jsExecState; AObject: jsValue; propertyName: PAnsiChar): jsValue; cdecl;
begin
  Writeln('property name=', string(propertyName));
  if propertyName = 'SuperCall' then
  begin
    Exit(es.Function_(es.GetData(AObject)));
  end;
  Result := es.Undefined;
end;

function jsCallAsFunction(es: jsExecState; AObject: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
begin
  Writeln('call func......');
end;

constructor TWkeBrowserWindow.Create;
var
 es: jsExecState;
 obj: jsValue;
 testobj: PjsData;
begin
  inherited Create('WkebrowserWindow.xml', 'skin');
  FWkeWebbrowser := TWkeWebbrowser.Create;
  FWkeWebbrowser.OnTitleChanged := OnTitleChanged;
  FWkeWebbrowser.OnURLChanged := OnURLChanged;
  FWkeWebbrowser.OnDocumentReady := OnDocumentReady;
  CreateWindow(0, 'wke浏览器', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);

   New(testobj);
   testobj.finalize := jsfinalize;
   StrCopy(testobj.typeName, 'Object');
   testobj.propertyGet := jsGetProperty;
   testobj.callAsFunction := jsCallAsFunction;
   es := wkeGlobalExec(FWkeWebbrowser.WebView);
   obj := es.Object_(testobj);
   es.SetGlobal('external', obj);

                            //jsMessageBox
  JScript.BindFunction('jsMessageBox', JsMessageBox, 2);
  JScript.BindFunction('JsFunc2', JsFunc2, 1);

  //JScript.BindGetter('external', externalObj);
  //JScript.BindFunction('SuperCall', externalSuperCall, 2);
 // JScript.BindFunction('SuperCall', externalSuperCall, 2);
end;

destructor TWkeBrowserWindow.Destroy;
begin
  FWkeWebbrowser.Free;
  inherited;
end;

procedure TWkeBrowserWindow.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;

end;

procedure TWkeBrowserWindow.DoInitWindow;
begin
  inherited;
  FEdtURL := CEditUI(FindControl('edturl'));
  FBtnGo := CButtonUI(FindControl('btngo'));
  FTitle := CLabelUI(FindControl('title'));
  FWkeWebbrowser.InitWkeWebBrowser(FindControl('webbrowser'));
  FWkeWebbrowser.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36';
  FWkeWebbrowser.LoadFile('skin\testhtml.html');
end;

procedure TWkeBrowserWindow.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType.m_pstr = DUI_MSGTYPE_CLICK then
  begin
    if Msg.pSender.Name = 'closebtn' then
      DuiApplication.Terminate
    else if Msg.pSender = FBtnGo then
    begin
      Writeln(FEdtURL.Text);
      if FEdtURL.Text <> '' then
        FWkeWebbrowser.Load(FEdtURL.Text);
    end;
  end else if Msg.sType.m_pstr = DUI_MSGTYPE_RETURN then
  begin
    if FEdtURL.Text <> '' then
      FWkeWebbrowser.Load(FEdtURL.Text);
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
  FTitle.Text := ATitle;
end;

procedure TWkeBrowserWindow.OnURLChanged(Sender: TObject; const AURL: string);
begin
  Writeln('url=', AURL);
  FEdtURL.Text := AURL;
end;

var
  WkeBrowserWindow: TWkeBrowserWindow;

exports
  JsMessageBox;

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
