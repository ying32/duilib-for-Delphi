//***************************************************************************
//
//       名称：DuiWkeBrowser.pas
//       日期：2015/12/16 21:48:50
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@vip.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       c++ wke内核: https://github.com/BlzFans/wke
//
//       只封装了Delphi的方法,没有做Dui消息的封装
//
//***************************************************************************
unit DuiWkeBrowser;

{$I DDuilib.inc}

interface

uses
  Windows,
  Types,
  Classes,
  Duilib,
  DuiBase,
  Wke;

type

  TTitleChangedEvent = procedure(Sender: TObject; const ATitle: string) of object;
  TURLChangedEvent = procedure(Sender: TObject; const AURL: string) of object;
  TPaintUpdatedEvent = procedure(Sender: TObject; DC: HDC; x, y, cx, cy: Integer) of object;
  TAlertBoxEvent = procedure(Sender: TObject; const AMsg: string) of object;
  TConfirmBoxEvent = procedure(Sender: TObject; const AMsg: string; var AResult: Boolean) of object;
  TPromptBoxEvent = procedure(Sender: TObject; const AMsg, ADefaultResult, AResult: string; var AReturn: Boolean) of object;
  TNavigationEvent = procedure(Sender: TObject; ANavigationType: wkeNavigationType; const AURL: string; var AResult: Boolean) of object;
  TCreateViewEvent = procedure(Sender: TObject; ANavigationType: wkeNavigationType; const AURL: string; AWindowFeatures: PwkeWindowFeatures; var AResult: TwkeWebView) of object;
  TDocumentReadyEvent = procedure(Sender: TObject) of object;
  TLoadingFinishEvent = procedure(Sender: TObject; const AURL: string; AResult: wkeLoadingResult; const AFailedReason: string) of object;
  TWindowClosingEvent = procedure(Sender: TObject; var AResult: Boolean) of object;
  TConsoleMessageEvent= procedure(Sender: TObject; var AMessage: wkeConsoleMessage) of object;

  TWkeWebbrowser = class
  private
    FWebView: TWkeWebView;
    FNativeCtrl: CNativeControlUI;
    FOnDocumentReady: TDocumentReadyEvent;
    FOnLoadingFinish: TLoadingFinishEvent;
    FOnNavigation: TNavigationEvent;
    FOnWindowClosing: TWindowClosingEvent;
    FOnCreateView: TCreateViewEvent;
    FOnWindowDestroy: TNotifyEvent;
    FOnPaintUpdated: TPaintUpdatedEvent;
    FOnPromptBox: TPromptBoxEvent;
    FOnTitleChanged: TTitleChangedEvent;
    FOnAlertBox: TAlertBoxEvent;
    FOnConfirmBox: TConfirmBoxEvent;
    FOnURLChanged: TURLChangedEvent;
    FWindowHandle: HWND;
    FUserAgent: string;
    FOnConsoleMessage: TConsoleMessageEvent;
    procedure SetUserAgent(const Value: string);
  protected
    procedure DoTitleChanged(const ATitle: string); virtual;
    procedure DoURLChanged(const AURL: string); virtual;
    procedure DoPaintUpdated(DC: HDC; x, y, cx, cy: Integer); virtual;
    procedure DoAlertBox(const AMsg: string); virtual;
    function DoConfirmBox(const AMsg: string): Boolean; virtual;
    function DoPromptBox(const AMsg, ADefaultResult, AResult: string): Boolean; virtual;
    function DoNavigation(ANavigationType: wkeNavigationType; const AURL: string): Boolean; virtual;
    function DoCreateView(ANavigationType: wkeNavigationType; const AURL: string; AWindowFeatures: PwkeWindowFeatures): wkeWebView; virtual;
    procedure DoDocumentReady; virtual;
    procedure DoLoadingFinish(const AURL: string; AResult: wkeLoadingResult; const AFailedReason: string); virtual;
    function DoWindowClosing: Boolean; virtual;
    procedure DoWindowDestroy; virtual;
    procedure DoConsoleMessage(var AMessage: wkeConsoleMessage); virtual;
  public
    destructor Destroy; override;
  public
    procedure InitWkeWebBrowser(ANativeCtrl: CControlUI);
    procedure Navigate(const AStr: string);
    procedure Load(const AStr: string);
    procedure LoadURL(const AURL: string);
    procedure LoadFile(const AFileName: string);
    procedure LoadHTML(const AHTML: string);
    procedure StopLoading;
    procedure Reload;
    function CanGoBack: Boolean;
    function GoBack: Boolean;
    function CanGoForward: Boolean;
    function GoForward: Boolean;
    procedure EditorSelectAll;
    procedure EditorCopy;
    procedure EditorCut;
    procedure EditorPaste;
    procedure EditorDelete;
    procedure SetFocus;
    procedure KillFocus;
    function RunJS(const AScript: string): jsValue;
    function GlobalExec: jsExecState;
    procedure Sleep;
    procedure Wake;
    function IsAwake: Boolean;
  public
    property WebView: TWkeWebView read FWebView;
    property WindowHandle: HWND read FWindowHandle;
    property UserAgent: string read FUserAgent write SetUserAgent;
    property OnTitleChanged: TTitleChangedEvent read FOnTitleChanged write FOnTitleChanged;
    property OnURLChanged: TURLChangedEvent read FOnURLChanged write FOnURLChanged;
    property OnPaintUpdated: TPaintUpdatedEvent read FOnPaintUpdated write FOnPaintUpdated;
    property OnAlertBox: TAlertBoxEvent read FOnAlertBox write FOnAlertBox;
    property OnConfirmBox: TConfirmBoxEvent read FOnConfirmBox write FOnConfirmBox;
    property OnPromptBox: TPromptBoxEvent read FOnPromptBox write FOnPromptBox;
    property OnNavigation: TNavigationEvent read FOnNavigation write FOnNavigation;
    property OnCreateView: TCreateViewEvent read FOnCreateView write FOnCreateView;
    property OnDocumentReady: TDocumentReadyEvent read FOnDocumentReady write FOnDocumentReady;
    property OnLoadingFinish: TLoadingFinishEvent read FOnLoadingFinish write FOnLoadingFinish;
    property OnWindowClosing: TWindowClosingEvent read FOnWindowClosing write FOnWindowClosing;
    property OnWindowDestroy: TNotifyEvent read FOnWindowDestroy write FOnWindowDestroy;
    property OnConsoleMessage: TConsoleMessageEvent read FOnConsoleMessage write FOnConsoleMessage;
  end;

implementation


procedure OnwkeTitleChangedCallback(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoTitleChanged(webView.GetString(title));
end;

procedure OnwkeURLChangedCallback(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoURLChanged(webView.GetString(url));
end;

procedure OnwkePaintUpdatedCallback(webView: wkeWebView; param: Pointer; DC: HDC;
   x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
begin
  TWkeWebbrowser(param).DoPaintUpdated(DC, x, y, cx, cy);
end;

procedure OnwkeAlertBoxCallback(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoAlertBox(webView.GetString(msg));
end;

function OnwkeConfirmBoxCallback(webView: wkeWebView; param: Pointer; msg: wkeString): Boolean; cdecl;
begin
  Result := TWkeWebbrowser(param).DoConfirmBox(webView.GetString(msg));
end;

function OnwkePromptBoxCallback(webView: wkeWebView; param: Pointer; msg: wkeString;
  defaultResult: wkeString; AResult: wkeString): Boolean; cdecl;
begin
  Result := TWkeWebbrowser(param).DoPromptBox(webView.GetString(msg),
    webView.GetString(defaultResult), webView.GetString(AResult));
end;

function OnwkeNavigationCallback(webView: wkeWebView; param: Pointer;
  navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;
begin
  Result := TWkeWebbrowser(param).DoNavigation(navigationType, webView.GetString(url));
end;

function OnwkeCreateViewCallback(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType;
   url: wkeString; windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
begin
  Result := TWkeWebbrowser(param).DoCreateView(navigationType, webView.GetString(url), windowFeatures);
end;

procedure OnwkeDocumentReadyCallback(webView: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebbrowser(param).DoDocumentReady;
end;

procedure OnwkeLoadingFinishCallback(webView: wkeWebView; param: Pointer; url: wkeString;
  result: wkeLoadingResult; failedReason: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoLoadingFinish(webView.GetString(url),
    result, webView.GetString(failedReason));
end;

function OnwkeWindowClosingCallback(webWindow: wkeWebView; param: Pointer): Boolean; cdecl;
begin
  Result := TWkeWebbrowser(param).DoWindowClosing;
end;

procedure OnwkeWindowDestroyCallback(webWindow: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebbrowser(param).DoWindowDestroy;
end;

procedure OnwkeConsoleMessageCallback(webView: wkeWebView; param: Pointer; var AMessage: wkeConsoleMessage); cdecl;
begin
  TWkeWebbrowser(param).DoConsoleMessage(AMessage);
end;


{ TWkeWebbrowser }

destructor TWkeWebbrowser.Destroy;
begin
  // 之所以用检测下FWindowHandle是因为主窗口释放时，这也被释放掉了
  if (FWebView <> nil) and IsWindow(FWindowHandle) then
    FWebView.DestroyWebWindow;
  inherited;
end;

procedure TWkeWebbrowser.Navigate(const AStr: string);
begin
  Load(AStr);
end;

procedure TWkeWebbrowser.Reload;
begin
  if FWebView <> nil then
    FWebView.Reload;
end;

function TWkeWebbrowser.RunJS(const AScript: string): jsValue;
begin
  Result := 0;
  if FWebView <> nil then
    Result := FWebView.RunJS(AScript);
end;

procedure TWkeWebbrowser.SetFocus;
begin
  if FWebView <> nil then
    FWebView.SetFocus;
end;

procedure TWkeWebbrowser.SetUserAgent(const Value: string);
begin
  if FUserAgent <> Value then
  begin
    if Assigned(FWebView) then
    begin
      FUserAgent := Value;
      FWebView.UserAgent := FUserAgent;
    end;
  end;
end;

procedure TWkeWebbrowser.Sleep;
begin
  if FWebView <> nil then
    FWebView.Sleep;
end;

procedure TWkeWebbrowser.StopLoading;
begin
  if FWebView <> nil then
    FWebView.StopLoading;
end;

procedure TWkeWebbrowser.Wake;
begin
  if FWebView <> nil then
    FWebView.Wake;
end;

procedure TWkeWebbrowser.DoAlertBox(const AMsg: string);
begin
  if Assigned(FOnAlertBox) then
    FOnAlertBox(Self, AMsg);
end;

function TWkeWebbrowser.DoConfirmBox(const AMsg: string): Boolean;
begin
  Result := True;
  if Assigned(FOnConfirmBox) then
    FOnConfirmBox(Self, AMsg, Result);
end;

procedure TWkeWebbrowser.DoConsoleMessage(var AMessage: wkeConsoleMessage);
begin
  if Assigned(FOnConsoleMessage) then
    FOnConsoleMessage(Self, AMessage);
end;

function TWkeWebbrowser.DoCreateView(ANavigationType: wkeNavigationType;
  const AURL: string; AWindowFeatures: PwkeWindowFeatures): wkeWebView;
begin
  Result := FWebView;
  if Assigned(FOnCreateView) then
    FOnCreateView(Self, ANavigationType, AURL, AWindowFeatures, Result);
end;

procedure TWkeWebbrowser.DoDocumentReady;
begin
  if Assigned(FOnDocumentReady) then
    FOnDocumentReady(Self);
end;

procedure TWkeWebbrowser.DoLoadingFinish(const AURL: string;
  AResult: wkeLoadingResult; const AFailedReason: string);
begin
  if Assigned(FOnLoadingFinish) then
    FOnLoadingFinish(Self, AURL, AResult, AFailedReason);
end;

function TWkeWebbrowser.DoNavigation(ANavigationType: wkeNavigationType;
  const AURL: string): Boolean;
begin
  Result := True;
  if Assigned(FOnNavigation) then
    FOnNavigation(Self, ANavigationType, AURL, Result);
end;

procedure TWkeWebbrowser.DoPaintUpdated(DC: HDC; x, y, cx, cy: Integer);
begin
  if Assigned(FOnPaintUpdated) then
    FOnPaintUpdated(Self, DC, x, y, cx, cy);
end;

function TWkeWebbrowser.DoPromptBox(const AMsg, ADefaultResult,
   AResult: string): Boolean;
begin
  Result := True;
  if Assigned(FOnPromptBox) then
    FOnPromptBox(Self, AMsg, ADefaultResult, AResult, Result);
end;

procedure TWkeWebbrowser.DoTitleChanged(const ATitle: string);
begin
  if Assigned(FOnTitleChanged) then
    FOnTitleChanged(Self, ATitle);
end;

procedure TWkeWebbrowser.DoURLChanged(const AURL: string);
begin
  if Assigned(FOnURLChanged) then
    FOnURLChanged(Self, AURL);
end;

function TWkeWebbrowser.DoWindowClosing: Boolean;
begin
  Result := True;
  if Assigned(FOnWindowClosing) then
    FOnWindowClosing(Self, Result);
end;

procedure TWkeWebbrowser.DoWindowDestroy;
begin
  if Assigned(FOnWindowDestroy) then
    FOnWindowDestroy(Self);
end;

function TWkeWebbrowser.CanGoBack: Boolean;
begin
  Result := False;
  if FWebView <> nil then
    FWebView.CanGoBack;
end;

function TWkeWebbrowser.CanGoForward: Boolean;
begin
  Result := False;
  if FWebView <> nil then
    FWebView.CanGoForward;
end;

procedure TWkeWebbrowser.EditorCopy;
begin
  if FWebView <> nil then
    FWebView.EditorCopy;
end;

procedure TWkeWebbrowser.EditorCut;
begin
  if FWebView <> nil then
    FWebView.EditorCut;
end;

procedure TWkeWebbrowser.EditorDelete;
begin
  if FWebView <> nil then
    FWebView.EditorDelete;
end;

procedure TWkeWebbrowser.EditorPaste;
begin
  if FWebView <> nil then
    FWebView.EditorPaste;
end;

procedure TWkeWebbrowser.EditorSelectAll;
begin
  if FWebView <> nil then
    FWebView.EditorSelectAll;
end;

function TWkeWebbrowser.GlobalExec: jsExecState;
begin
  Result := nil;
  if FWebView <> nil then
    Result := FWebView.GlobalExec;
end;

function TWkeWebbrowser.GoBack: Boolean;
begin
  Result := False;
  if FWebView <> nil then
    FWebView.GoBack;
end;

function TWkeWebbrowser.GoForward: Boolean;
begin
  Result := False;
  if FWebView <> nil then
    FWebView.GoForward;
end;

procedure TWkeWebbrowser.InitWkeWebBrowser(ANativeCtrl: CControlUI);
begin
  if (ANativeCtrl <> nil) and (ANativeCtrl <> FNativeCtrl) then
  begin
    FNativeCtrl := CNativeControlUI(ANativeCtrl);
    FWebView := wkeCreateWebWindow(WKE_WINDOW_TYPE_CONTROL, FNativeCtrl.GetManager.GetPaintWindow, 0, 0, 1, 1);
    FWindowHandle := FWebView.WindowHandle;
    FWebView.SetOnTitleChanged(OnwkeTitleChangedCallback, Self);
    FWebView.SetOnURLChanged(OnwkeURLChangedCallback, Self);
    FWebView.SetOnPaintUpdated(OnwkePaintUpdatedCallback, Self);
    FWebView.SetOnAlertBox(OnwkeAlertBoxCallback, Self);
    FWebView.SetOnConfirmBox(OnwkeConfirmBoxCallback, Self);
    FWebView.SetOnPromptBox(OnwkePromptBoxCallback, Self);
    FWebView.SetOnNavigation(OnwkeNavigationCallback, Self);
    FWebView.SetOnCreateView(OnwkeCreateViewCallback, Self);
    FWebView.SetOnLoadingFinish(OnwkeLoadingFinishCallback, Self);
    FWebView.SetOnWindowClosing(OnwkeWindowClosingCallback, Self);
    FWebView.SetOnWindowDestroy(OnwkeWindowDestroyCallback, Self);
    FWebView.SetOnDocumentReady(OnwkeDocumentReadyCallback, Self);
    FWebView.SetOnConsoleMessage(OnwkeConsoleMessageCallback, Self);

    FNativeCtrl.SetNativeHandle(FWindowHandle);
    FNativeCtrl.Show;
  end;
end;

function TWkeWebbrowser.IsAwake: Boolean;
begin
  Result := False;
  if FWebView <> nil then
    FWebView.IsAwake;
end;

procedure TWkeWebbrowser.KillFocus;
begin
  if FWebView <> nil then
    FWebView.KillFocus;
end;

procedure TWkeWebbrowser.Load(const AStr: string);
begin
  if Assigned(FWebView) then
    FWebView.Load(AStr);
end;

procedure TWkeWebbrowser.LoadFile(const AFileName: string);
begin
  if Assigned(FWebView) then
    FWebView.LoadFile(AFileName);
end;

procedure TWkeWebbrowser.LoadHTML(const AHTML: string);
begin
  if Assigned(FWebView) then
    FWebView.LoadHTML(AHTML);
end;

procedure TWkeWebbrowser.LoadURL(const AURL: string);
begin
  if Assigned(FWebView) then
    FWebView.LoadURL(AURL);
end;

initialization
   wkeInitialize;

finalization
   wkeFinalize;

end.
