//***************************************************************************
//
//       名称：wke.pas
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@vip.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       wke的头文件，ying32翻译至pascal
//       原本是使用BlzFans开源的，但作者已经几年没有更新了
//       现在选择国人cexer一直在维护的一个支
//       https://github.com/cexer/wke
//       注：最底部有一个屏蔽了浮点异常的代码，暂时只能这样了，不然用不了
//***************************************************************************
unit Wke;

{$I DDuilib.inc}

interface

uses
  Windows,
  Types;

const
  wkedll = 'wke.dll';



  // wkeMouseFlags
  WKE_LBUTTON = $01;
  WKE_RBUTTON = $02;
  WKE_SHIFT = $04;
  WKE_CONTROL = $08;
  WKE_MBUTTON = $10;


  // wkeKeyFlags
  WKE_EXTENDED = $0100;
  WKE_REPEAT = $4000;


  // wkeMouseMsg
  WKE_MSG_MOUSEMOVE = $0200;
  WKE_MSG_LBUTTONDOWN = $0201;
  WKE_MSG_LBUTTONUP = $0202;
  WKE_MSG_LBUTTONDBLCLK = $0203;
  WKE_MSG_RBUTTONDOWN = $0204;
  WKE_MSG_RBUTTONUP = $0205;
  WKE_MSG_RBUTTONDBLCLK = $0206;
  WKE_MSG_MBUTTONDOWN = $0207;
  WKE_MSG_MBUTTONUP = $0208;
  WKE_MSG_MBUTTONDBLCLK = $0209;
  WKE_MSG_MOUSEWHEEL = $020A;


type
  utf8 = AnsiChar;
  Putf8 = PAnsiChar;
  wchar_t = WideChar;
  Pwchar_t = PWideChar;

  jsExecState = Pointer;
  jsValue = int64;
  PjsValue = PInt64;
  wkeString = Pointer;

  wkeWebView = class;




  {$Z4+}
  wkeProxyType = (
    WKE_PROXY_NONE,
    WKE_PROXY_HTTP,
    WKE_PROXY_SOCKS4,
    WKE_PROXY_SOCKS4A,
    WKE_PROXY_SOCKS5,
    WKE_PROXY_SOCKS5HOSTNAME
  );
  TwkeProxyType = wkeProxyType;

  {$Z4+}
  wkeSettingMask = (
    WKE_SETTING_PROXY = 1
  );
  TwkeSettingMask = wkeSettingMask;

  {$Z4+}
  wkeNavigationType = (
    WKE_NAVIGATION_TYPE_LINKCLICK,
    WKE_NAVIGATION_TYPE_FORMSUBMITTE,
    WKE_NAVIGATION_TYPE_BACKFORWARD,
    WKE_NAVIGATION_TYPE_RELOAD,
    WKE_NAVIGATION_TYPE_FORMRESUBMITT,
    WKE_NAVIGATION_TYPE_OTHER
  );
  TwkeNavigationType = wkeNavigationType;

  {$Z4+}
  wkeLoadingResult = (
    WKE_LOADING_SUCCEEDED,
    WKE_LOADING_FAILED,
    WKE_LOADING_CANCELED
  );
  TwkeLoadingResult = wkeLoadingResult;

  {$Z4+}
  wkeWindowType = (
    WKE_WINDOW_TYPE_POPUP,
    WKE_WINDOW_TYPE_TRANSPARENT,
    WKE_WINDOW_TYPE_CONTROL
  );
  TwkeWindowType = wkeWindowType;

  {$Z4+}
  jsType = (
    JSTYPE_NUMBER,
    JSTYPE_STRING,
    JSTYPE_BOOLEAN,
    JSTYPE_OBJECT,
    JSTYPE_FUNCTION,
    JSTYPE_UNDEFINED
  );
  TjsType = jsType;

  wkeRect = packed record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;
  PwkeRect = ^TwkeRect;
  TwkeRect = wkeRect;

  wkeProxy = packed record
    AType: wkeProxyType;
    hostname: array[0..100-1] of AnsiChar; //char
    port: Word;
    username: array[0..50-1] of AnsiChar; //char
    password: array[0..50-1] of AnsiChar; //char
  end;
  PwkeProxy = ^TwkeProxy;
  TwkeProxy = wkeProxy;

  wkeSettings = packed record
    proxy: wkeProxy;
    mask: Longint;
  end;
  PwkeSettings = ^TwkeSettings;
  TwkeSettings = wkeSettings;

  wkeWindowFeatures = packed record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
    menuBarVisible: Boolean;
    statusBarVisible: Boolean;
    toolBarVisible: Boolean;
    locationBarVisible: Boolean;
    scrollbarsVisible: Boolean;
    resizable: Boolean;
    fullscreen: Boolean;
  end;
  PwkeWindowFeatures = ^TwkeWindowFeatures;
  TwkeWindowFeatures = wkeWindowFeatures;


//typedef void* (*FILE_OPEN) (const char* path);
  FILE_OPEN = function(path: PAnsiChar): Pointer; cdecl;
//typedef void (*FILE_CLOSE) (void* handle);
  FILE_CLOSE = procedure(handle: Pointer); cdecl;
//typedef size_t (*FILE_SIZE) (void* handle);
  FILE_SIZE = function(handle: Pointer): size_t; cdecl;
//typedef int (*FILE_READ) (void* handle, void* buffer, size_t size);
  FILE_READ = function(handle: Pointer; buffer: Pointer; size: size_t): Integer; cdecl;
//typedef int (*FILE_SEEK) (void* handle, int offset, int origin);
  FILE_SEEK = function(handle: Pointer; offset, origin: Integer): Integer; cdecl;


//typedef void (*wkeTitleChangedCallback)(wkeWebView webView, void* param, const wkeString title);
//typedef void (*wkeURLChangedCallback)(wkeWebView webView, void* param, const wkeString url);
//typedef void (*wkePaintUpdatedCallback)(wkeWebView webView, void* param, const HDC hdc, int x, int y, int cx, int cy);
//typedef void (*wkeAlertBoxCallback)(wkeWebView webView, void* param, const wkeString msg);
//typedef bool (*wkeConfirmBoxCallback)(wkeWebView webView, void* param, const wkeString msg);
//typedef bool (*wkePromptBoxCallback)(wkeWebView webView, void* param, const wkeString msg, const wkeString defaultResult, wkeString result);
//typedef bool (*wkeNavigationCallback)(wkeWebView webView, void* param, wkeNavigationType navigationType, const wkeString url);
//typedef wkeWebView (*wkeCreateViewCallback)(wkeWebView webView, void* param, wkeNavigationType navigationType, const wkeString url, const wkeWindowFeatures* windowFeatures);
//typedef void (*wkeDocumentReadyCallback)(wkeWebView webView, void* param);
//typedef void (*wkeLoadingFinishCallback)(wkeWebView webView, void* param, const wkeString url, wkeLoadingResult result, const wkeString failedReason);
//typedef bool (*wkeWindowClosingCallback)(wkeWebView webWindow, void* param);
//typedef void (*wkeWindowDestroyCallback)(wkeWebView webWindow, void* param);
  wkeTitleChangedCallback = procedure(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
  wkeURLChangedCallback = procedure(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
  wkePaintUpdatedCallback = procedure(webView: wkeWebView; param: Pointer; hdc: HDC; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
  wkeAlertBoxCallback = procedure(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
  wkeConfirmBoxCallback = function(webView: wkeWebView; param: Pointer; msg: wkeString): Boolean; cdecl;
  wkePromptBoxCallback = function(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; result: wkeString): Boolean; cdecl;
  wkeNavigationCallback = function(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;
  wkeCreateViewCallback = function(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString; windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
  wkeDocumentReadyCallback = procedure(webView: wkeWebView; param: Pointer); cdecl;
  wkeLoadingFinishCallback = procedure(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason: wkeString); cdecl;
  wkeWindowClosingCallback = function(webWindow: wkeWebView; param: Pointer): Boolean;
  wkeWindowDestroyCallback = procedure(webWindow: wkeWebView; param: Pointer); cdecl;


//typedef jsValue (*jsGetPropertyCallback)(jsExecState es, jsValue object, const char* propertyName);
  jsGetPropertyCallback = function(es: jsExecState; AObject: jsValue; propertyName: PAnsiChar): jsValue; cdecl;
//typedef bool (*jsSetPropertyCallback)(jsExecState es, jsValue object, const char* propertyName, jsValue value);
  jsSetPropertyCallback = function(es: jsExecState; AObject: jsValue; propertyName: PAnsiChar; value: jsValue): Boolean; cdecl;
//typedef jsValue (*jsCallAsFunctionCallback)(jsExecState es, jsValue object, jsValue* args, int argCount);
  jsCallAsFunctionCallback = function(es: jsExecState; AObject: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
//typedef void (*jsFinalizeCallback)(struct tagjsData* data);
  PjsData = ^TjsData;
  jsFinalizeCallback = procedure(data: PjsData); cdecl;
  jsData = packed record
    typeName: array[0..100-1] of AnsiChar; //char
    propertyGet: jsGetPropertyCallback;
    propertySet: jsSetPropertyCallback;
    finalize: jsFinalizeCallback;
    callAsFunction: jsCallAsFunctionCallback;
  end;
  TjsData = jsData;

  wkeWebView = class
  public
    class procedure Initialize;
    class procedure InitializeEx(settings: PwkeSettings);
    class procedure Configure(settings: PwkeSettings);
    class procedure Finalize;
    class procedure Update;
    class function GetVersion: Integer;
    class function GetVersionString: putf8;
    class procedure SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
    class function CreateWebView: wkeWebView;
//    class function GetWebView(name: Pchar): wkeWebView;
    procedure DestroyWebView;
    function GetName: PAnsiChar;
    procedure SetName(name: PAnsiChar);
    function IsTransparent: Boolean;
    procedure SetTransparent(transparent: Boolean);
    procedure SetUserAgent(userAgent: Putf8);
    procedure SetUserAgentW(userAgent: Pwchar_t);
    procedure LoadURL(url: Putf8);
    procedure LoadURLW(url: Pwchar_t);
    procedure PostURL(url: Putf8; postData: Pchar; postLen: Integer);
    procedure PostURLW(url: Pwchar_t; postData: Pchar; postLen: Integer);
    procedure LoadHTML(html: Putf8);
    procedure LoadHTMLW(html: Pwchar_t);
    procedure LoadFile(filename: Putf8);
    procedure LoadFileW(filename: Pwchar_t);
    procedure Load(str: Putf8);
    procedure LoadW(str: Pwchar_t);
//    function IsLoading: Boolean;
    function IsLoadingSucceeded: Boolean;
    function IsLoadingFailed: Boolean;
    function IsLoadingCompleted: Boolean;
    function IsDocumentReady: Boolean;
    procedure StopLoading;
    procedure Reload;
    function GetTitle: putf8;
    function GetTitleW: pwchar_t;
    procedure Resize(w: Integer; h: Integer);
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetContentWidth: Integer;
    function GetContentHeight: Integer;
    procedure SetDirty(dirty: Boolean);
    function IsDirty: Boolean;
    procedure AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
    procedure LayoutIfNeeded;
    procedure Paint(bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean);
    procedure Paint2(bits: Pointer; pitch: Integer);
    procedure RepaintIfNeeded;
    function GetViewDC: HDC;
    function CanGoBack: Boolean;
    function GoBack: Boolean;
    function CanGoForward: Boolean;
    function GoForward: Boolean;
    procedure EditorSelectAll;
    procedure EditorCopy;
    procedure EditorCut;
    procedure EditorPaste;
    procedure EditorDelete;
    function GetCookieW: pwchar_t;
    function GetCookie: putf8;
    procedure SetCookieEnabled(enable: Boolean);
    function IsCookieEnabled: Boolean;
    procedure SetMediaVolume(volume: Single);
    function GetMediaVolume: Single;
    function FireMouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireMouseWheelEvent(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
    function FireKeyUpEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyDownEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyPressEvent(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    procedure SetFocus;
    procedure KillFocus;
    function GetCaretRect: wkeRect;
    function RunJS(script: Putf8): jsValue;
    function RunJSW(script: Pwchar_t): jsValue;
    function GlobalExec: jsExecState;
    procedure Sleep;
    procedure Wake;
    function IsAwake: Boolean;
    procedure SetZoomFactor(factor: Single);
    function GetZoomFactor: Single;
    procedure SetEditable(editable: Boolean);
    class function GetString(AString: wkeString): putf8;
    class function GetStringW(AString: wkeString): pwchar_t;
    class procedure SetString(AString: wkeString; str: Putf8; len: size_t);
    class procedure SetStringW(AString: wkeString; str: Pwchar_t; len: size_t);
    procedure OnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
    procedure OnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
    procedure OnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
    procedure OnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
    procedure OnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
    procedure OnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
    procedure OnNavigation(callback: wkeNavigationCallback; param: Pointer);
    procedure OnCreateView(callback: wkeCreateViewCallback; param: Pointer);
    procedure OnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
    procedure OnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
    class function CreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView;
    procedure DestroyWebWindow;
    function GetWindowHandle: HWND;
    procedure OnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
    procedure OnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);
    procedure ShowWindow(show: Boolean);
    procedure EnableWindow(enable: Boolean);
    procedure MoveWindow(x: Integer; y: Integer; width: Integer; height: Integer);
    procedure MoveToCenter;
    procedure ResizeWindow(width: Integer; height: Integer);
    procedure SetWindowTitle(title: Putf8);
    procedure SetWindowTitleW(title: Pwchar_t);
  end;
  TWkeWebView = wkeWebView;


// #define JS_CALL __fastcall
//typedef jsValue (JS_CALL *jsNativeFunction) (jsExecState es);
  jsNativeFunction = function(es: jsExecState): jsValue;


//================================wkeWebView============================

procedure wkeInitialize; cdecl;
procedure wkeInitializeEx(settings: PwkeSettings); cdecl;
procedure wkeConfigure(settings: PwkeSettings); cdecl;
procedure wkeFinalize; cdecl;
procedure wkeUpdate; cdecl;
function wkeGetVersion: Integer; cdecl;
function wkeGetVersionString: putf8; cdecl;
procedure wkeSetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK); cdecl;
function wkeCreateWebView: wkeWebView; cdecl;
//function wkeGetWebView(name: Pchar): wkeWebView; cdecl;
procedure wkeDestroyWebView(webView: wkeWebView); cdecl;
function wkeGetName(webView: wkeWebView): PAnsiChar; cdecl;
procedure wkeSetName(webView: wkeWebView; name: PAnsiChar); cdecl;
function wkeIsTransparent(webView: wkeWebView): Boolean; cdecl;
procedure wkeSetTransparent(webView: wkeWebView; transparent: Boolean); cdecl;
procedure wkeSetUserAgent(webView: wkeWebView; userAgent: Putf8); cdecl;
procedure wkeSetUserAgentW(webView: wkeWebView; userAgent: Pwchar_t); cdecl;
procedure wkeLoadURL(webView: wkeWebView; url: Putf8); cdecl;
procedure wkeLoadURLW(webView: wkeWebView; url: Pwchar_t); cdecl;
procedure wkePostURL(wkeView: wkeWebView; url: Putf8; postData: Pchar; postLen: Integer); cdecl;
procedure wkePostURLW(wkeView: wkeWebView; url: Pwchar_t; postData: Pchar; postLen: Integer); cdecl;
procedure wkeLoadHTML(webView: wkeWebView; html: Putf8); cdecl;
procedure wkeLoadHTMLW(webView: wkeWebView; html: Pwchar_t); cdecl;
procedure wkeLoadFile(webView: wkeWebView; filename: Putf8); cdecl;
procedure wkeLoadFileW(webView: wkeWebView; filename: Pwchar_t); cdecl;
procedure wkeLoad(webView: wkeWebView; str: Putf8); cdecl;
procedure wkeLoadW(webView: wkeWebView; str: Pwchar_t); cdecl;
//function wkeIsLoading(webView: wkeWebView): Boolean; cdecl;
function wkeIsLoadingSucceeded(webView: wkeWebView): Boolean; cdecl;
function wkeIsLoadingFailed(webView: wkeWebView): Boolean; cdecl;
function wkeIsLoadingCompleted(webView: wkeWebView): Boolean; cdecl;
function wkeIsDocumentReady(webView: wkeWebView): Boolean; cdecl;
procedure wkeStopLoading(webView: wkeWebView); cdecl;
procedure wkeReload(webView: wkeWebView); cdecl;
function wkeGetTitle(webView: wkeWebView): putf8; cdecl;
function wkeGetTitleW(webView: wkeWebView): pwchar_t; cdecl;
procedure wkeResize(webView: wkeWebView; w: Integer; h: Integer); cdecl;
function wkeGetWidth(webView: wkeWebView): Integer; cdecl;
function wkeGetHeight(webView: wkeWebView): Integer; cdecl;
function wkeGetContentWidth(webView: wkeWebView): Integer; cdecl;
function wkeGetContentHeight(webView: wkeWebView): Integer; cdecl;
procedure wkeSetDirty(webView: wkeWebView; dirty: Boolean); cdecl;
function wkeIsDirty(webView: wkeWebView): Boolean; cdecl;
procedure wkeAddDirtyArea(webView: wkeWebView; x: Integer; y: Integer; w: Integer; h: Integer); cdecl;
procedure wkeLayoutIfNeeded(webView: wkeWebView); cdecl;
procedure wkePaint(webView: wkeWebView; bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean); cdecl;
procedure wkePaint2(webView: wkeWebView; bits: Pointer; pitch: Integer); cdecl;
procedure wkeRepaintIfNeeded(webView: wkeWebView); cdecl;
function wkeGetViewDC(webView: wkeWebView): HDC; cdecl;
function wkeCanGoBack(webView: wkeWebView): Boolean; cdecl;
function wkeGoBack(webView: wkeWebView): Boolean; cdecl;
function wkeCanGoForward(webView: wkeWebView): Boolean; cdecl;
function wkeGoForward(webView: wkeWebView): Boolean; cdecl;
procedure wkeEditorSelectAll(webView: wkeWebView); cdecl;
procedure wkeEditorCopy(webView: wkeWebView); cdecl;
procedure wkeEditorCut(webView: wkeWebView); cdecl;
procedure wkeEditorPaste(webView: wkeWebView); cdecl;
procedure wkeEditorDelete(webView: wkeWebView); cdecl;
function wkeGetCookieW(webView: wkeWebView): pwchar_t; cdecl;
function wkeGetCookie(webView: wkeWebView): putf8; cdecl;
procedure wkeSetCookieEnabled(webView: wkeWebView; enable: Boolean); cdecl;
function wkeIsCookieEnabled(webView: wkeWebView): Boolean; cdecl;
procedure wkeSetMediaVolume(webView: wkeWebView; volume: Single); cdecl;
function wkeGetMediaVolume(webView: wkeWebView): Single; cdecl;
function wkeFireMouseEvent(webView: wkeWebView; AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
function wkeFireContextMenuEvent(webView: wkeWebView; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
function wkeFireMouseWheelEvent(webView: wkeWebView; x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean; cdecl;
function wkeFireKeyUpEvent(webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
function wkeFireKeyDownEvent(webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
function wkeFireKeyPressEvent(webView: wkeWebView; charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
procedure wkeSetFocus(webView: wkeWebView); cdecl;
procedure wkeKillFocus(webView: wkeWebView); cdecl;
function wkeGetCaretRect(webView: wkeWebView): wkeRect; cdecl;
function wkeRunJS(webView: wkeWebView; script: Putf8): jsValue; cdecl;
function wkeRunJSW(webView: wkeWebView; script: Pwchar_t): jsValue; cdecl;
function wkeGlobalExec(webView: wkeWebView): jsExecState; cdecl;
procedure wkeSleep(webView: wkeWebView); cdecl;
procedure wkeWake(webView: wkeWebView); cdecl;
function wkeIsAwake(webView: wkeWebView): Boolean; cdecl;
procedure wkeSetZoomFactor(webView: wkeWebView; factor: Single); cdecl;
function wkeGetZoomFactor(webView: wkeWebView): Single; cdecl;
procedure wkeSetEditable(webView: wkeWebView; editable: Boolean); cdecl;
function wkeGetString(AString: wkeString): putf8; cdecl;
function wkeGetStringW(AString: wkeString): pwchar_t; cdecl;
procedure wkeSetString(AString: wkeString; str: Putf8; len: size_t); cdecl;
procedure wkeSetStringW(AString: wkeString; str: Pwchar_t; len: size_t); cdecl;
procedure wkeOnTitleChanged(webView: wkeWebView; callback: wkeTitleChangedCallback; callbackParam: Pointer); cdecl;
procedure wkeOnURLChanged(webView: wkeWebView; callback: wkeURLChangedCallback; callbackParam: Pointer); cdecl;
procedure wkeOnPaintUpdated(webView: wkeWebView; callback: wkePaintUpdatedCallback; callbackParam: Pointer); cdecl;
procedure wkeOnAlertBox(webView: wkeWebView; callback: wkeAlertBoxCallback; callbackParam: Pointer); cdecl;
procedure wkeOnConfirmBox(webView: wkeWebView; callback: wkeConfirmBoxCallback; callbackParam: Pointer); cdecl;
procedure wkeOnPromptBox(webView: wkeWebView; callback: wkePromptBoxCallback; callbackParam: Pointer); cdecl;
procedure wkeOnNavigation(webView: wkeWebView; callback: wkeNavigationCallback; param: Pointer); cdecl;
procedure wkeOnCreateView(webView: wkeWebView; callback: wkeCreateViewCallback; param: Pointer); cdecl;
procedure wkeOnDocumentReady(webView: wkeWebView; callback: wkeDocumentReadyCallback; param: Pointer); cdecl;
procedure wkeOnLoadingFinish(webView: wkeWebView; callback: wkeLoadingFinishCallback; param: Pointer); cdecl;
function wkeCreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView; cdecl;
procedure wkeDestroyWebWindow(webWindow: wkeWebView); cdecl;
function wkeGetWindowHandle(webWindow: wkeWebView): HWND; cdecl;
procedure wkeOnWindowClosing(webWindow: wkeWebView; callback: wkeWindowClosingCallback; param: Pointer); cdecl;
procedure wkeOnWindowDestroy(webWindow: wkeWebView; callback: wkeWindowDestroyCallback; param: Pointer); cdecl;
procedure wkeShowWindow(webWindow: wkeWebView; show: Boolean); cdecl;
procedure wkeEnableWindow(webWindow: wkeWebView; enable: Boolean); cdecl;
procedure wkeMoveWindow(webWindow: wkeWebView; x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
procedure wkeMoveToCenter(webWindow: wkeWebView); cdecl;
procedure wkeResizeWindow(webWindow: wkeWebView; width: Integer; height: Integer); cdecl;
procedure wkeSetWindowTitle(webWindow: wkeWebView; title: Putf8); cdecl;
procedure wkeSetWindowTitleW(webWindow: wkeWebView; title: Pwchar_t); cdecl;


//================================JScript============================

procedure jsBindFunction(name: Pchar; fn: jsNativeFunction; argCount: LongInt); cdecl;
procedure jsBindGetter(name: Pchar; fn: jsNativeFunction); cdecl;
procedure jsBindSetter(name: Pchar; fn: jsNativeFunction); cdecl;
function jsArgCount(es: jsExecState): Integer; cdecl;
function jsArgType(es: jsExecState; argIdx: Integer): jsType; cdecl;
function jsArg(es: jsExecState; argIdx: Integer): jsValue; cdecl;
function jsTypeOf(v: jsValue): jsType; cdecl;
function jsIsNumber(v: jsValue): Boolean; cdecl;
function jsIsString(v: jsValue): Boolean; cdecl;
function jsIsBoolean(v: jsValue): Boolean; cdecl;
function jsIsObject(v: jsValue): Boolean; cdecl;
function jsIsFunction(v: jsValue): Boolean; cdecl;
function jsIsUndefined(v: jsValue): Boolean; cdecl;
function jsIsNull(v: jsValue): Boolean; cdecl;
function jsIsArray(v: jsValue): Boolean; cdecl;
function jsIsTrue(v: jsValue): Boolean; cdecl;
function jsIsFalse(v: jsValue): Boolean; cdecl;
function jsToInt(es: jsExecState; v: jsValue): Integer; cdecl;
function jsToFloat(es: jsExecState; v: jsValue): Single; cdecl;
function jsToDouble(es: jsExecState; v: jsValue): Double; cdecl;
function jsToBoolean(es: jsExecState; v: jsValue): Boolean; cdecl;
function jsToTempString(es: jsExecState; v: jsValue): utf8; cdecl;
function jsToTempStringW(es: jsExecState; v: jsValue): wchar_t; cdecl;
function jsInt(n: Integer): jsValue; cdecl;
function jsFloat(f: Single): jsValue; cdecl;
function jsDouble(d: Double): jsValue; cdecl;
function jsBoolean(b: Boolean): jsValue; cdecl;
function jsUndefined: jsValue; cdecl;
function jsNull: jsValue; cdecl;
function jsTrue: jsValue; cdecl;
function jsFalse: jsValue; cdecl;
function jsString(es: jsExecState; str: Putf8): jsValue; cdecl;
function jsStringW(es: jsExecState; str: Pwchar_t): jsValue; cdecl;
function jsEmptyObject(es: jsExecState): jsValue; cdecl;
function jsEmptyArray(es: jsExecState): jsValue; cdecl;
function jsObject(es: jsExecState; obj: PjsData): jsValue; cdecl;
function jsFunction(es: jsExecState; obj: PjsData): jsValue; cdecl;
function jsGetData(es: jsExecState; AObject: jsValue): jsData; cdecl;
function jsGet(es: jsExecState; AObject: jsValue; prop: Pchar): jsValue; cdecl;
procedure jsSet(es: jsExecState; AObject: jsValue; prop: Pchar; v: jsValue); cdecl;
function jsGetAt(es: jsExecState; AObject: jsValue; index: Integer): jsValue; cdecl;
procedure jsSetAt(es: jsExecState; AObject: jsValue; index: Integer; v: jsValue); cdecl;
function jsGetLength(es: jsExecState; AObject: jsValue): Integer; cdecl;
procedure jsSetLength(es: jsExecState; AObject: jsValue; length: Integer); cdecl;
function jsGlobalObject(es: jsExecState): jsValue; cdecl;
function jsGetWebView(es: jsExecState): wkeWebView; cdecl;
function jsEval(es: jsExecState; str: Putf8): jsValue; cdecl;
function jsEvalW(es: jsExecState; str: Pwchar_t): jsValue; cdecl;
function jsCall(es: jsExecState; func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
function jsCallGlobal(es: jsExecState; func: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
function jsGetGlobal(es: jsExecState; prop: Pchar): jsValue; cdecl;
procedure jsSetGlobal(es: jsExecState; prop: Pchar; v: jsValue); cdecl;
procedure jsGC; cdecl;


implementation


{ wkeWebView }

class procedure wkeWebView.Initialize;
begin
  wkeInitialize;
end;

class procedure wkeWebView.InitializeEx(settings: PwkeSettings);
begin
  wkeInitializeEx(settings);
end;

class procedure wkeWebView.Configure(settings: PwkeSettings);
begin
  wkeConfigure(settings);
end;

class procedure wkeWebView.Finalize;
begin
  wkeFinalize;
end;

class procedure wkeWebView.Update;
begin
  wkeUpdate;
end;

class function wkeWebView.GetVersion: Integer;
begin
  Result := wkeGetVersion;
end;

class function wkeWebView.GetVersionString: putf8;
begin
  Result := wkeGetVersionString;
end;

class procedure wkeWebView.SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
begin
  wkeSetFileSystem(pfn_open, pfn_close, pfn_size, pfn_read, pfn_seek);
end;

class function wkeWebView.CreateWebView: wkeWebView;
begin
  Result := wkeCreateWebView;
end;

//class function wkeWebView.GetWebView(name: Pchar): wkeWebView;
//begin
//  Result := wkeGetWebView(name);
//end;

procedure wkeWebView.DestroyWebView;
begin
  wkeDestroyWebView(Self);
end;

function wkeWebView.GetName: PAnsiChar;
begin
  Result := wkeGetName(Self);
end;

procedure wkeWebView.SetName(name: PAnsiChar);
begin
  wkeSetName(Self, name);
end;

function wkeWebView.IsTransparent: Boolean;
begin
  Result := wkeIsTransparent(Self);
end;

procedure wkeWebView.SetTransparent(transparent: Boolean);
begin
  wkeSetTransparent(Self, transparent);
end;

procedure wkeWebView.SetUserAgent(userAgent: Putf8);
begin
  wkeSetUserAgent(Self, userAgent);
end;

procedure wkeWebView.SetUserAgentW(userAgent: Pwchar_t);
begin
  wkeSetUserAgentW(Self, userAgent);
end;

procedure wkeWebView.LoadURL(url: Putf8);
begin
  wkeLoadURL(Self, url);
end;

procedure wkeWebView.LoadURLW(url: Pwchar_t);
begin
  wkeLoadURLW(Self, url);
end;

procedure wkeWebView.PostURL(url: Putf8; postData: Pchar; postLen: Integer);
begin
  wkePostURL(Self, url, postData, postLen);
end;

procedure wkeWebView.PostURLW(url: Pwchar_t; postData: Pchar; postLen: Integer);
begin
  wkePostURLW(Self, url, postData, postLen);
end;

procedure wkeWebView.LoadHTML(html: Putf8);
begin
  wkeLoadHTML(Self, html);
end;

procedure wkeWebView.LoadHTMLW(html: Pwchar_t);
begin
  wkeLoadHTMLW(Self, html);
end;

procedure wkeWebView.LoadFile(filename: Putf8);
begin
  wkeLoadFile(Self, filename);
end;

procedure wkeWebView.LoadFileW(filename: Pwchar_t);
begin
  wkeLoadFileW(Self, filename);
end;

procedure wkeWebView.Load(str: Putf8);
begin
  wkeLoad(Self, str);
end;

procedure wkeWebView.LoadW(str: Pwchar_t);
begin
  wkeLoadW(Self, str);
end;

//function wkeWebView.IsLoading: Boolean;
//begin
//  Result := wkeIsLoading(Self);
//end;

function wkeWebView.IsLoadingSucceeded: Boolean;
begin
  Result := wkeIsLoadingSucceeded(Self);
end;

function wkeWebView.IsLoadingFailed: Boolean;
begin
  Result := wkeIsLoadingFailed(Self);
end;

function wkeWebView.IsLoadingCompleted: Boolean;
begin
  Result := wkeIsLoadingCompleted(Self);
end;

function wkeWebView.IsDocumentReady: Boolean;
begin
  Result := wkeIsDocumentReady(Self);
end;

procedure wkeWebView.StopLoading;
begin
  wkeStopLoading(Self);
end;

procedure wkeWebView.Reload;
begin
  wkeReload(Self);
end;

function wkeWebView.GetTitle: putf8;
begin
  Result := wkeGetTitle(Self);
end;

function wkeWebView.GetTitleW: pwchar_t;
begin
  Result := wkeGetTitleW(Self);
end;

procedure wkeWebView.Resize(w: Integer; h: Integer);
begin
  wkeResize(Self, w, h);
end;

function wkeWebView.GetWidth: Integer;
begin
  Result := wkeGetWidth(Self);
end;

function wkeWebView.GetHeight: Integer;
begin
  Result := wkeGetHeight(Self);
end;

function wkeWebView.GetContentWidth: Integer;
begin
  Result := wkeGetContentWidth(Self);
end;

function wkeWebView.GetContentHeight: Integer;
begin
  Result := wkeGetContentHeight(Self);
end;

procedure wkeWebView.SetDirty(dirty: Boolean);
begin
  wkeSetDirty(Self, dirty);
end;

function wkeWebView.IsDirty: Boolean;
begin
  Result := wkeIsDirty(Self);
end;

procedure wkeWebView.AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
begin
  wkeAddDirtyArea(Self, x, y, w, h);
end;

procedure wkeWebView.LayoutIfNeeded;
begin
  wkeLayoutIfNeeded(Self);
end;

procedure wkeWebView.Paint(bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean);
begin
  wkePaint(Self, bits, bufWid, bufHei, xDst, yDst, w, h, xSrc, ySrc, bCopyAlpha);
end;

procedure wkeWebView.Paint2(bits: Pointer; pitch: Integer);
begin
  wkePaint2(Self, bits, pitch);
end;

procedure wkeWebView.RepaintIfNeeded;
begin
  wkeRepaintIfNeeded(Self);
end;

function wkeWebView.GetViewDC: HDC;
begin
  Result := wkeGetViewDC(Self);
end;

function wkeWebView.CanGoBack: Boolean;
begin
  Result := wkeCanGoBack(Self);
end;

function wkeWebView.GoBack: Boolean;
begin
  Result := wkeGoBack(Self);
end;

function wkeWebView.CanGoForward: Boolean;
begin
  Result := wkeCanGoForward(Self);
end;

function wkeWebView.GoForward: Boolean;
begin
  Result := wkeGoForward(Self);
end;

procedure wkeWebView.EditorSelectAll;
begin
  wkeEditorSelectAll(Self);
end;

procedure wkeWebView.EditorCopy;
begin
  wkeEditorCopy(Self);
end;

procedure wkeWebView.EditorCut;
begin
  wkeEditorCut(Self);
end;

procedure wkeWebView.EditorPaste;
begin
  wkeEditorPaste(Self);
end;

procedure wkeWebView.EditorDelete;
begin
  wkeEditorDelete(Self);
end;

function wkeWebView.GetCookieW: pwchar_t;
begin
  Result := wkeGetCookieW(Self);
end;

function wkeWebView.GetCookie: putf8;
begin
  Result := wkeGetCookie(Self);
end;

procedure wkeWebView.SetCookieEnabled(enable: Boolean);
begin
  wkeSetCookieEnabled(Self, enable);
end;

function wkeWebView.IsCookieEnabled: Boolean;
begin
  Result := wkeIsCookieEnabled(Self);
end;

procedure wkeWebView.SetMediaVolume(volume: Single);
begin
  wkeSetMediaVolume(Self, volume);
end;

function wkeWebView.GetMediaVolume: Single;
begin
  Result := wkeGetMediaVolume(Self);
end;

function wkeWebView.FireMouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireMouseEvent(Self, AMessage, x, y, flags);
end;

function wkeWebView.FireContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireContextMenuEvent(Self, x, y, flags);
end;

function wkeWebView.FireMouseWheelEvent(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireMouseWheelEvent(Self, x, y, delta, flags);
end;

function wkeWebView.FireKeyUpEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyUpEvent(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.FireKeyDownEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyDownEvent(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.FireKeyPressEvent(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyPressEvent(Self, charCode, flags, systemKey);
end;

procedure wkeWebView.SetFocus;
begin
  wkeSetFocus(Self);
end;

procedure wkeWebView.KillFocus;
begin
  wkeKillFocus(Self);
end;

function wkeWebView.GetCaretRect: wkeRect;
begin
  Result := wkeGetCaretRect(Self);
end;

function wkeWebView.RunJS(script: Putf8): jsValue;
begin
  Result := wkeRunJS(Self, script);
end;

function wkeWebView.RunJSW(script: Pwchar_t): jsValue;
begin
  Result := wkeRunJSW(Self, script);
end;

function wkeWebView.GlobalExec: jsExecState;
begin
  Result := wkeGlobalExec(Self);
end;

procedure wkeWebView.Sleep;
begin
  wkeSleep(Self);
end;

procedure wkeWebView.Wake;
begin
  wkeWake(Self);
end;

function wkeWebView.IsAwake: Boolean;
begin
  Result := wkeIsAwake(Self);
end;

procedure wkeWebView.SetZoomFactor(factor: Single);
begin
  wkeSetZoomFactor(Self, factor);
end;

function wkeWebView.GetZoomFactor: Single;
begin
  Result := wkeGetZoomFactor(Self);
end;

procedure wkeWebView.SetEditable(editable: Boolean);
begin
  wkeSetEditable(Self, editable);
end;

class function wkeWebView.GetString(AString: wkeString): putf8;
begin
  Result := wkeGetString(AString);
end;

class function wkeWebView.GetStringW(AString: wkeString): pwchar_t;
begin
  Result := wkeGetStringW(AString);
end;

class procedure wkeWebView.SetString(AString: wkeString; str: Putf8; len: size_t);
begin
  wkeSetString(AString, str, len);
end;

class procedure wkeWebView.SetStringW(AString: wkeString; str: Pwchar_t; len: size_t);
begin
  wkeSetStringW(AString, str, len);
end;

procedure wkeWebView.OnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
begin
  wkeOnTitleChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.OnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
begin
  wkeOnURLChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.OnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
begin
  wkeOnPaintUpdated(Self, callback, callbackParam);
end;

procedure wkeWebView.OnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
begin
  wkeOnAlertBox(Self, callback, callbackParam);
end;

procedure wkeWebView.OnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
begin
  wkeOnConfirmBox(Self, callback, callbackParam);
end;

procedure wkeWebView.OnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
begin
  wkeOnPromptBox(Self, callback, callbackParam);
end;

procedure wkeWebView.OnNavigation(callback: wkeNavigationCallback; param: Pointer);
begin
  wkeOnNavigation(Self, callback, param);
end;

procedure wkeWebView.OnCreateView(callback: wkeCreateViewCallback; param: Pointer);
begin
  wkeOnCreateView(Self, callback, param);
end;

procedure wkeWebView.OnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
begin
  wkeOnDocumentReady(Self, callback, param);
end;

procedure wkeWebView.OnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
begin
  wkeOnLoadingFinish(Self, callback, param);
end;

class function wkeWebView.CreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView;
begin
  Result := wkeCreateWebWindow(AType, parent, x, y, width, height);
end;

procedure wkeWebView.DestroyWebWindow;
begin
  wkeDestroyWebWindow(Self);
end;

function wkeWebView.GetWindowHandle: HWND;
begin
  Result := wkeGetWindowHandle(Self);
end;

procedure wkeWebView.OnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
begin
  wkeOnWindowClosing(Self, callback, param);
end;

procedure wkeWebView.OnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);
begin
  wkeOnWindowDestroy(Self, callback, param);
end;

procedure wkeWebView.ShowWindow(show: Boolean);
begin
  wkeShowWindow(Self, show);
end;

procedure wkeWebView.EnableWindow(enable: Boolean);
begin
  wkeEnableWindow(Self, enable);
end;

procedure wkeWebView.MoveWindow(x: Integer; y: Integer; width: Integer; height: Integer);
begin
  wkeMoveWindow(Self, x, y, width, height);
end;

procedure wkeWebView.MoveToCenter;
begin
  wkeMoveToCenter(Self);
end;

procedure wkeWebView.ResizeWindow(width: Integer; height: Integer);
begin
  wkeResizeWindow(Self, width, height);
end;

procedure wkeWebView.SetWindowTitle(title: Putf8);
begin
  wkeSetWindowTitle(Self, title);
end;

procedure wkeWebView.SetWindowTitleW(title: Pwchar_t);
begin
  wkeSetWindowTitleW(Self, title);
end;


//================================wkeWebView============================

procedure wkeInitialize; external wkedll name 'wkeInitialize';
procedure wkeInitializeEx; external wkedll name 'wkeInitializeEx';
procedure wkeConfigure; external wkedll name 'wkeConfigure';
procedure wkeFinalize; external wkedll name 'wkeFinalize';
procedure wkeUpdate; external wkedll name 'wkeUpdate';
function wkeGetVersion; external wkedll name 'wkeGetVersion';
function wkeGetVersionString; external wkedll name 'wkeGetVersionString';
procedure wkeSetFileSystem; external wkedll name 'wkeSetFileSystem';
function wkeCreateWebView; external wkedll name 'wkeCreateWebView';
//function wkeGetWebView; external wkedll name 'wkeGetWebView';
procedure wkeDestroyWebView; external wkedll name 'wkeDestroyWebView';
function wkeGetName; external wkedll name 'wkeGetName';
procedure wkeSetName; external wkedll name 'wkeSetName';
function wkeIsTransparent; external wkedll name 'wkeIsTransparent';
procedure wkeSetTransparent; external wkedll name 'wkeSetTransparent';
procedure wkeSetUserAgent; external wkedll name 'wkeSetUserAgent';
procedure wkeSetUserAgentW; external wkedll name 'wkeSetUserAgentW';
procedure wkeLoadURL; external wkedll name 'wkeLoadURL';
procedure wkeLoadURLW; external wkedll name 'wkeLoadURLW';
procedure wkePostURL; external wkedll name 'wkePostURL';
procedure wkePostURLW; external wkedll name 'wkePostURLW';
procedure wkeLoadHTML; external wkedll name 'wkeLoadHTML';
procedure wkeLoadHTMLW; external wkedll name 'wkeLoadHTMLW';
procedure wkeLoadFile; external wkedll name 'wkeLoadFile';
procedure wkeLoadFileW; external wkedll name 'wkeLoadFileW';
procedure wkeLoad; external wkedll name 'wkeLoad';
procedure wkeLoadW; external wkedll name 'wkeLoadW';
//function wkeIsLoading; external wkedll name 'wkeIsLoading';
function wkeIsLoadingSucceeded; external wkedll name 'wkeIsLoadingSucceeded';
function wkeIsLoadingFailed; external wkedll name 'wkeIsLoadingFailed';
function wkeIsLoadingCompleted; external wkedll name 'wkeIsLoadingCompleted';
function wkeIsDocumentReady; external wkedll name 'wkeIsDocumentReady';
procedure wkeStopLoading; external wkedll name 'wkeStopLoading';
procedure wkeReload; external wkedll name 'wkeReload';
function wkeGetTitle; external wkedll name 'wkeGetTitle';
function wkeGetTitleW; external wkedll name 'wkeGetTitleW';
procedure wkeResize; external wkedll name 'wkeResize';
function wkeGetWidth; external wkedll name 'wkeGetWidth';
function wkeGetHeight; external wkedll name 'wkeGetHeight';
function wkeGetContentWidth; external wkedll name 'wkeGetContentWidth';
function wkeGetContentHeight; external wkedll name 'wkeGetContentHeight';
procedure wkeSetDirty; external wkedll name 'wkeSetDirty';
function wkeIsDirty; external wkedll name 'wkeIsDirty';
procedure wkeAddDirtyArea; external wkedll name 'wkeAddDirtyArea';
procedure wkeLayoutIfNeeded; external wkedll name 'wkeLayoutIfNeeded';
procedure wkePaint; external wkedll name 'wkePaint';
procedure wkePaint2; external wkedll name 'wkePaint2';
procedure wkeRepaintIfNeeded; external wkedll name 'wkeRepaintIfNeeded';
function wkeGetViewDC; external wkedll name 'wkeGetViewDC';
function wkeCanGoBack; external wkedll name 'wkeCanGoBack';
function wkeGoBack; external wkedll name 'wkeGoBack';
function wkeCanGoForward; external wkedll name 'wkeCanGoForward';
function wkeGoForward; external wkedll name 'wkeGoForward';
procedure wkeEditorSelectAll; external wkedll name 'wkeEditorSelectAll';
procedure wkeEditorCopy; external wkedll name 'wkeEditorCopy';
procedure wkeEditorCut; external wkedll name 'wkeEditorCut';
procedure wkeEditorPaste; external wkedll name 'wkeEditorPaste';
procedure wkeEditorDelete; external wkedll name 'wkeEditorDelete';
function wkeGetCookieW; external wkedll name 'wkeGetCookieW';
function wkeGetCookie; external wkedll name 'wkeGetCookie';
procedure wkeSetCookieEnabled; external wkedll name 'wkeSetCookieEnabled';
function wkeIsCookieEnabled; external wkedll name 'wkeIsCookieEnabled';
procedure wkeSetMediaVolume; external wkedll name 'wkeSetMediaVolume';
function wkeGetMediaVolume; external wkedll name 'wkeGetMediaVolume';
function wkeFireMouseEvent; external wkedll name 'wkeFireMouseEvent';
function wkeFireContextMenuEvent; external wkedll name 'wkeFireContextMenuEvent';
function wkeFireMouseWheelEvent; external wkedll name 'wkeFireMouseWheelEvent';
function wkeFireKeyUpEvent; external wkedll name 'wkeFireKeyUpEvent';
function wkeFireKeyDownEvent; external wkedll name 'wkeFireKeyDownEvent';
function wkeFireKeyPressEvent; external wkedll name 'wkeFireKeyPressEvent';
procedure wkeSetFocus; external wkedll name 'wkeSetFocus';
procedure wkeKillFocus; external wkedll name 'wkeKillFocus';
function wkeGetCaretRect; external wkedll name 'wkeGetCaretRect';
function wkeRunJS; external wkedll name 'wkeRunJS';
function wkeRunJSW; external wkedll name 'wkeRunJSW';
function wkeGlobalExec; external wkedll name 'wkeGlobalExec';
procedure wkeSleep; external wkedll name 'wkeSleep';
procedure wkeWake; external wkedll name 'wkeWake';
function wkeIsAwake; external wkedll name 'wkeIsAwake';
procedure wkeSetZoomFactor; external wkedll name 'wkeSetZoomFactor';
function wkeGetZoomFactor; external wkedll name 'wkeGetZoomFactor';
procedure wkeSetEditable; external wkedll name 'wkeSetEditable';
function wkeGetString; external wkedll name 'wkeGetString';
function wkeGetStringW; external wkedll name 'wkeGetStringW';
procedure wkeSetString; external wkedll name 'wkeSetString';
procedure wkeSetStringW; external wkedll name 'wkeSetStringW';
procedure wkeOnTitleChanged; external wkedll name 'wkeOnTitleChanged';
procedure wkeOnURLChanged; external wkedll name 'wkeOnURLChanged';
procedure wkeOnPaintUpdated; external wkedll name 'wkeOnPaintUpdated';
procedure wkeOnAlertBox; external wkedll name 'wkeOnAlertBox';
procedure wkeOnConfirmBox; external wkedll name 'wkeOnConfirmBox';
procedure wkeOnPromptBox; external wkedll name 'wkeOnPromptBox';
procedure wkeOnNavigation; external wkedll name 'wkeOnNavigation';
procedure wkeOnCreateView; external wkedll name 'wkeOnCreateView';
procedure wkeOnDocumentReady; external wkedll name 'wkeOnDocumentReady';
procedure wkeOnLoadingFinish; external wkedll name 'wkeOnLoadingFinish';
function wkeCreateWebWindow; external wkedll name 'wkeCreateWebWindow';
procedure wkeDestroyWebWindow; external wkedll name 'wkeDestroyWebWindow';
function wkeGetWindowHandle; external wkedll name 'wkeGetWindowHandle';
procedure wkeOnWindowClosing; external wkedll name 'wkeOnWindowClosing';
procedure wkeOnWindowDestroy; external wkedll name 'wkeOnWindowDestroy';
procedure wkeShowWindow; external wkedll name 'wkeShowWindow';
procedure wkeEnableWindow; external wkedll name 'wkeEnableWindow';
procedure wkeMoveWindow; external wkedll name 'wkeMoveWindow';
procedure wkeMoveToCenter; external wkedll name 'wkeMoveToCenter';
procedure wkeResizeWindow; external wkedll name 'wkeResizeWindow';
procedure wkeSetWindowTitle; external wkedll name 'wkeSetWindowTitle';
procedure wkeSetWindowTitleW; external wkedll name 'wkeSetWindowTitleW';


//================================JScript============================

procedure jsBindFunction; external wkedll name 'jsBindFunction';
procedure jsBindGetter; external wkedll name 'jsBindGetter';
procedure jsBindSetter; external wkedll name 'jsBindSetter';
function jsArgCount; external wkedll name 'jsArgCount';
function jsArgType; external wkedll name 'jsArgType';
function jsArg; external wkedll name 'jsArg';
function jsTypeOf; external wkedll name 'jsTypeOf';
function jsIsNumber; external wkedll name 'jsIsNumber';
function jsIsString; external wkedll name 'jsIsString';
function jsIsBoolean; external wkedll name 'jsIsBoolean';
function jsIsObject; external wkedll name 'jsIsObject';
function jsIsFunction; external wkedll name 'jsIsFunction';
function jsIsUndefined; external wkedll name 'jsIsUndefined';
function jsIsNull; external wkedll name 'jsIsNull';
function jsIsArray; external wkedll name 'jsIsArray';
function jsIsTrue; external wkedll name 'jsIsTrue';
function jsIsFalse; external wkedll name 'jsIsFalse';
function jsToInt; external wkedll name 'jsToInt';
function jsToFloat; external wkedll name 'jsToFloat';
function jsToDouble; external wkedll name 'jsToDouble';
function jsToBoolean; external wkedll name 'jsToBoolean';
function jsToTempString; external wkedll name 'jsToTempString';
function jsToTempStringW; external wkedll name 'jsToTempStringW';
function jsInt; external wkedll name 'jsInt';
function jsFloat; external wkedll name 'jsFloat';
function jsDouble; external wkedll name 'jsDouble';
function jsBoolean; external wkedll name 'jsBoolean';
function jsUndefined; external wkedll name 'jsUndefined';
function jsNull; external wkedll name 'jsNull';
function jsTrue; external wkedll name 'jsTrue';
function jsFalse; external wkedll name 'jsFalse';
function jsString; external wkedll name 'jsString';
function jsStringW; external wkedll name 'jsStringW';
function jsEmptyObject; external wkedll name 'jsEmptyObject';
function jsEmptyArray; external wkedll name 'jsEmptyArray';
function jsObject; external wkedll name 'jsObject';
function jsFunction; external wkedll name 'jsFunction';
function jsGetData; external wkedll name 'jsGetData';
function jsGet; external wkedll name 'jsGet';
procedure jsSet; external wkedll name 'jsSet';
function jsGetAt; external wkedll name 'jsGetAt';
procedure jsSetAt; external wkedll name 'jsSetAt';
function jsGetLength; external wkedll name 'jsGetLength';
procedure jsSetLength; external wkedll name 'jsSetLength';
function jsGlobalObject; external wkedll name 'jsGlobalObject';
function jsGetWebView; external wkedll name 'jsGetWebView';
function jsEval; external wkedll name 'jsEval';
function jsEvalW; external wkedll name 'jsEvalW';
function jsCall; external wkedll name 'jsCall';
function jsCallGlobal; external wkedll name 'jsCallGlobal';
function jsGetGlobal; external wkedll name 'jsGetGlobal';
procedure jsSetGlobal; external wkedll name 'jsSetGlobal';
procedure jsGC; external wkedll name 'jsGC';



{$IFDEF MSWINDOWS}
{$IFNDEF FPC}
{$WARN SYMBOL_PLATFORM OFF}
// 屏掉浮点异常，暂时没办法的办法
var
  uSaved8087CW: Word;
initialization
  uSaved8087CW := Default8087CW;
  Set8087CW($133F);
finalization
  Set8087CW(uSaved8087CW);
{$ENDIF}
{$ENDIF}

end.
