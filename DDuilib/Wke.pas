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
{$Z4+}

interface

uses
  Windows,
  Types;

const
  wkedll = 'wke.dll';

  // wkeMouseFlags
  WKE_LBUTTON = $01;
  WKE_RBUTTON = $02;
  WKE_SHIFT   = $04;
  WKE_CONTROL = $08;
  WKE_MBUTTON = $10;


  // wkeKeyFlags
  WKE_EXTENDED = $0100;
  WKE_REPEAT   = $4000;


  // wkeMouseMsg
  WKE_MSG_MOUSEMOVE     = $0200;
  WKE_MSG_LBUTTONDOWN   = $0201;
  WKE_MSG_LBUTTONUP     = $0202;
  WKE_MSG_LBUTTONDBLCLK = $0203;
  WKE_MSG_RBUTTONDOWN   = $0204;
  WKE_MSG_RBUTTONUP     = $0205;
  WKE_MSG_RBUTTONDBLCLK = $0206;
  WKE_MSG_MBUTTONDOWN   = $0207;
  WKE_MSG_MBUTTONUP     = $0208;
  WKE_MSG_MBUTTONDBLCLK = $0209;
  WKE_MSG_MOUSEWHEEL    = $020A;


type
  utf8 = AnsiChar;
  Putf8 = PAnsiChar;
  wchar_t = WideChar;
  Pwchar_t = PWideChar;


  wkeJSValue = Int64;
  PwkeJSValue = ^wkeJSValue;
  wkeString = Pointer;

  wkeWebView = class;
  JScript = class;

  wkeJSState = JScript;

  wkeProxyType = (
    WKE_PROXY_NONE,
    WKE_PROXY_HTTP,
    WKE_PROXY_SOCKS4,
    WKE_PROXY_SOCKS4A,
    WKE_PROXY_SOCKS5,
    WKE_PROXY_SOCKS5HOSTNAME
  );
  TwkeProxyType = wkeProxyType;

  wkeSettingMask = (
    WKE_SETTING_PROXY = 1
  );
  TwkeSettingMask = wkeSettingMask;

  wkeNavigationType = (
    WKE_NAVIGATION_TYPE_LINKCLICK,
    WKE_NAVIGATION_TYPE_FORMSUBMITTE,
    WKE_NAVIGATION_TYPE_BACKFORWARD,
    WKE_NAVIGATION_TYPE_RELOAD,
    WKE_NAVIGATION_TYPE_FORMRESUBMITT,
    WKE_NAVIGATION_TYPE_OTHER
  );
  TwkeNavigationType = wkeNavigationType;

  wkeLoadingResult = (
    WKE_LOADING_SUCCEEDED,
    WKE_LOADING_FAILED,
    WKE_LOADING_CANCELED
  );
  TwkeLoadingResult = wkeLoadingResult;

  wkeWindowType = (
    WKE_WINDOW_TYPE_POPUP,
    WKE_WINDOW_TYPE_TRANSPARENT,
    WKE_WINDOW_TYPE_CONTROL
  );
  TwkeWindowType = wkeWindowType;

  wkeJSType = (
    JSTYPE_NUMBER,
    JSTYPE_STRING,
    JSTYPE_BOOLEAN,
    JSTYPE_OBJECT,
    JSTYPE_FUNCTION,
    JSTYPE_UNDEFINED
  );
  TwkeJSType = wkeJSType;

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
    hostname: array[0..99] of AnsiChar;
    port: Word;
    username: array[0..49] of AnsiChar;
    password: array[0..49] of AnsiChar;
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

  wkeMessageLevel = (
    WKE_MESSAGE_LEVEL_TIP,
    WKE_MESSAGE_LEVEL_LOG,
    WKE_MESSAGE_LEVEL_WARNING,
    WKE_MESSAGE_LEVEL_ERROR,
    WKE_MESSAGE_LEVEL_DEBUG
  );

  wkeMessageSource = (
    WKE_MESSAGE_SOURCE_HTML,
    WKE_MESSAGE_SOURCE_XML,
    WKE_MESSAGE_SOURCE_JS,
    WKE_MESSAGE_SOURCE_NETWORK,
    WKE_MESSAGE_SOURCE_CONSOLE_API,
    WKE_MESSAGE_SOURCE_OTHER
  );

  wkeMessageType = (
    WKE_MESSAGE_TYPE_LOG,
    WKE_MESSAGE_TYPE_DIR,
    WKE_MESSAGE_TYPE_DIR_XML,
    WKE_MESSAGE_TYPE_TRACE,
    WKE_MESSAGE_TYPE_START_GROUP,
    WKE_MESSAGE_TYPE_START_GROUP_COLLAPSED,
    WKE_MESSAGE_TYPE_END_GROUP,
    WKE_MESSAGE_TYPE_ASSERT
  );

  PwkeConsoleMessage = ^wkeConsoleMessage;
  wkeConsoleMessage = packed record
    source: wkeMessageSource;
    type_: wkeMessageType;
    level: wkeMessageLevel;
    message_: wkeString;
    url: wkeString;
    lineNumber: LongInt;
  end;

  PwkeNewViewInfo = ^wkeNewViewInfo;
  wkeNewViewInfo = record
    navigationType: wkeNavigationType;
    url: wkeString;
    target: wkeString;

    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
    menuBarVisible: Boolean;
    statusBarVisible: bool ;
    toolBarVisible: Boolean;
    locationBarVisible: Boolean;
    scrollbarsVisible: Boolean;
    resizable: Boolean;
    fullscreen: Boolean;
  end;
  TwkeNewViewInfo = wkeNewViewInfo;

  PwkeDocumentReadyInfo = ^wkeDocumentReadyInfo;
  wkeDocumentReadyInfo = record
    url: wkeString;
    frameJSState: wkeJSState;
    mainFrameJSState: wkeJSState;
  end;
  TwkeDocumentReadyInfo = wkeDocumentReadyInfo;


{$IF not Declared(SIZE_T)}
  SIZE_T = Cardinal;
{$IFEND}

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
  wkeCreateViewCallback = function(webView: wkeWebView; param: Pointer; info: PwkeNewViewInfo): wkeWebView; cdecl;
  wkeDocumentReadyCallback = procedure(webView: wkeWebView; param: Pointer; info: PwkeDocumentReadyInfo); cdecl;
  wkeLoadingFinishCallback = procedure(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason: wkeString); cdecl;
  wkeWindowClosingCallback = function(webWindow: wkeWebView; param: Pointer): Boolean; cdecl;
  wkeWindowDestroyCallback = procedure(webWindow: wkeWebView; param: Pointer); cdecl;

  // typedef void (*wkeConsoleMessageCallback)(wkeWebView webView, void* param, const wkeConsoleMessage* message);
  wkeConsoleMessageCallback = procedure(webView: wkeWebView; param: Pointer; var AMessage: wkeConsoleMessage); cdecl;


  PwkeJSData = ^TwkeJSData;

//typedef jsValue (*wkeJSGetPropertyCallback)(jsExecState es, jsValue object, const char* propertyName);
  wkeJSGetPropertyCallback = function(es: wkeJSState; AObject: wkeJSValue; propertyName: PAnsiChar): wkeJSValue; cdecl;
//typedef bool (*wkeJSSetPropertyCallback)(jsExecState es, jsValue object, const char* propertyName, jsValue value);
  wkeJSSetPropertyCallback = function(es: wkeJSState; AObject: wkeJSValue; propertyName: PAnsiChar; value: wkeJSValue): Boolean; cdecl;
//typedef jsValue (*wkeJSCallAsFunctionCallback)(jsExecState es, jsValue object, jsValue* args, int argCount);
  wkeJSCallAsFunctionCallback = function(es: wkeJSState; AObject: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue; cdecl;
//typedef void (*wkeJSFinalizeCallback)(struct tagjsData* data);
  wkeJSFinalizeCallback = procedure(data: PwkeJSData); cdecl;

  wkeJSData = packed record
    typeName: array[0..99] of AnsiChar; //char
    propertyGet: wkeJSGetPropertyCallback;
    propertySet: wkeJSSetPropertyCallback;
    finalize: wkeJSFinalizeCallback;
    callAsFunction: wkeJSCallAsFunctionCallback;
  end;
  TwkeJSData = wkeJSData;

  wkeWebView = class
  private
    class function GetVersion: Integer;
    class function GetVersionString: string;
    function GetName: string;
    procedure SetName(const AName: string);
    function IsTransparent: Boolean;
    procedure SetTransparent(ATransparent: Boolean);
    procedure SetUserAgent(const AUserAgent: string);
    function IsLoadingSucceeded: Boolean;
    function IsLoadingFailed: Boolean;
    function IsLoadingCompleted: Boolean;
    function IsDocumentReady: Boolean;
    function GetTitle: string;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetContentWidth: Integer;
    function GetContentHeight: Integer;
    procedure SetDirty(dirty: Boolean);
    function IsDirty: Boolean;
    function GetViewDC: HDC;
    function GetCookie: string;
    procedure SetCookieEnabled(enable: Boolean);
    function IsCookieEnabled: Boolean;
    procedure SetMediaVolume(volume: Single);
    function GetMediaVolume: Single;
    function GetCaretRect: wkeRect;
    procedure SetZoomFactor(factor: Single);
    function GetZoomFactor: Single;
    procedure SetEditable(editable: Boolean);
    function GetWindowHandle: HWND;
    procedure SetWindowTitle(const ATitle: string);
  public
    class procedure Initialize;
    class procedure InitializeEx(settings: PwkeSettings);
    class procedure Configure(settings: PwkeSettings);
    class procedure Finalize;
    class procedure Update;
    class procedure SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
    class function CreateWebView: wkeWebView;
    class function CreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView;
    class function RepaintAllNeeded: Boolean;
    class function RunMessageLoop(var quit: Boolean): Boolean;

    procedure DestroyWebWindow;
    procedure DestroyWebView;
    procedure LoadURL(const AURL: string);
    procedure PostURL(const AURL, APostData: string; PostLen: Integer);
    procedure LoadHTML(const AHTML: string);
    procedure LoadFile(const AFileName: string);
    procedure Load(const AStr: string);
    procedure StopLoading;
    procedure Reload;
    procedure Resize(w: Integer; h: Integer);
    procedure AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
    procedure LayoutIfNeeded;
    procedure Paint(bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean);
    procedure Paint2(bits: Pointer; pitch: Integer);
    procedure RepaintIfNeeded;
    function CanGoBack: Boolean;
    function GoBack: Boolean;
    function CanGoForward: Boolean;
    function GoForward: Boolean;
    procedure EditorSelectAll;
    procedure EditorCopy;
    procedure EditorCut;
    procedure EditorPaste;
    procedure EditorDelete;
    function FireMouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireMouseWheelEvent(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
    function FireKeyUpEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyDownEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyPressEvent(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    procedure SetFocus;
    procedure KillFocus;
    function RunJS(const AScript: string): wkeJSValue;
    function GlobalExec: wkeJSState;
    procedure Sleep;
    procedure Wake;

    function GetWebView(name: AnsiString): wkeWebView;
    function IsLoading(webView: wkeWebView): Boolean;

    procedure SetHostWindow(hostWindow: HWND);
    function GetHostWindow: HWND;
    procedure SetRepaintInterval(ms: Integer);
    function GetRepaintInterval: Integer;
    function RepaintIfNeededAfterInterval: Boolean;


    function IsAwake: Boolean;
    class function GetString(AString: wkeString): string;
    class procedure SetString(AString: wkeString; const AStr: string);
    procedure SetOnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
    procedure SetOnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
    procedure SetOnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
    procedure SetOnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
    procedure SetOnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
    procedure SetOnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
    procedure SetOnNavigation(callback: wkeNavigationCallback; param: Pointer);
    procedure SetOnCreateView(callback: wkeCreateViewCallback; param: Pointer);
    procedure SetOnConsoleMessage(callback: wkeConsoleMessageCallback; callbackParam: Pointer);
    procedure SetOnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
    procedure SetOnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
    procedure SetOnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
    procedure SetOnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);

    procedure ShowWindow(show: Boolean);
    procedure EnableWindow(enable: Boolean);
    procedure MoveWindow(x: Integer; y: Integer; width: Integer; height: Integer);
    procedure MoveToCenter;
    procedure ResizeWindow(width: Integer; height: Integer);
  public
    property Name: string read GetName write SetName;
    property Version: Integer read GetVersion;
    property VersionString: string read GetVersionString;
    property Transparent:Boolean read IsTransparent write SetTransparent;
    property UserAgent: string write SetUserAgent;
    property LoadingSucceeded: Boolean read IsLoadingSucceeded;
    property LoadingFailed: Boolean read IsLoadingFailed;
    property LoadingCompleted: Boolean read IsLoadingCompleted;
    property DocumentReady: Boolean read IsDocumentReady;
    property Title: string read GetTitle;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ContentHeight: Integer read GetContentHeight;
    property Dirty: Boolean read IsDirty write SetDirty;
    property ViewDC: HDC read GetViewDC;
    property Cookie: string read GetCookie;
    property CookieEnabled: Boolean read IsCookieEnabled write SetCookieEnabled;
    property MediaVolume: Single read GetMediaVolume write SetMediaVolume;
    property CaretRect: wkeRect read GetCaretRect;
    property ZoomFactor: Single read GetZoomFactor write SetZoomFactor;
    property Editable: Boolean write SetEditable;
    property WindowHandle: HWND read GetWindowHandle;
    property WindowTitle: string write SetWindowTitle;
  end;
  TWkeWebView = wkeWebView;


  // #define JS_CALL __fastcall
  //typedef jsValue (JS_CALL *jsNativeFunction) (jsExecState es);
  // 这里有两种写法，按照vc __fastcall的约定与delphi register约定的不一样
 {$IFDEF UseVcFastCall}
    jsNativeFunction = function(es: wkeJSState): wkeJSValue;
 {$ELSE}
     // 前两个参数用来占位用
    jsNativeFunction = function(p1, p2, es: wkeJSState): wkeJSValue;
 {$ENDIF}

  JScript = class
  public
    class procedure BindFunction(const AName: string; fn: jsNativeFunction; AArgCount: LongInt);{$IFDEF SupportInline}inline;{$ENDIF}
    class procedure BindGetter(const AName: string; fn: jsNativeFunction); {$IFDEF SupportInline}inline;{$ENDIF}
    class procedure BindSetter(const AName: string; fn: jsNativeFunction); {$IFDEF SupportInline}inline;{$ENDIF}
    function ArgCount: Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    function ArgType(argIdx: Integer): wkeJSType; {$IFDEF SupportInline}inline;{$ENDIF}
    function Arg(argIdx: Integer): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function TypeOf(v: wkeJSValue): wkeJSType; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsNumber(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsString(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsBoolean(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsObject(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsFunction(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsUndefined(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsNull(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsArray(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsTrue(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function IsFalse(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToInt(v: wkeJSValue): Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToFloat(v: wkeJSValue): Single; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToDouble(v: wkeJSValue): Double; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToBoolean(v: wkeJSValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToTempString(v: wkeJSValue): string; {$IFDEF SupportInline}inline;{$ENDIF}
    function Int(n: Integer): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Float(f: Single): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Double(d: Double): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Boolean(b: Boolean): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Undefined: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Null: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function True_: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function False_: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function String_(const AStr: string): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function EmptyObject: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function EmptyArray: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Object_(obj: PwkeJSData): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Function_(obj: PwkeJSData): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetData(AObject: wkeJSValue): PwkeJSData; {$IFDEF SupportInline}inline;{$ENDIF}
    function Get(AObject: wkeJSValue; const prop: string): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure Set_(AObject: wkeJSValue; const prop: string; v: wkeJSValue); {$IFDEF SupportInline}inline;{$ENDIF}
    function GetAt(AObject: wkeJSValue; index: Integer): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetAt(AObject: wkeJSValue; index: Integer; v: wkeJSValue); {$IFDEF SupportInline}inline;{$ENDIF}
    function GetLength(AObject: wkeJSValue): Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetLength(AObject: wkeJSValue; length: Integer); {$IFDEF SupportInline}inline;{$ENDIF}
    function GlobalObject: wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetWebView: wkeWebView; {$IFDEF SupportInline}inline;{$ENDIF}
    function Eval(const AStr: string): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Call(func: wkeJSValue; thisObject: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function CallGlobal(func: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetGlobal(const prop: string): wkeJSValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetGlobal(const prop: string; v: wkeJSValue); {$IFDEF SupportInline}inline;{$ENDIF}
    procedure AddRef(v: wkeJSValue); {$IFDEF SupportInline}inline;{$ENDIF}
    procedure ReleaseRef(v: wkeJSValue); {$IFDEF SupportInline}inline;{$ENDIF}
    procedure CollectGarbge; {$IFDEF SupportInline}inline;{$ENDIF}
  end;


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
function wkeGetWebView(name: PAnsiChar): wkeWebView; cdecl;
procedure wkeDestroyWebView(webView: wkeWebView); cdecl;
function wkeGetName(webView: wkeWebView): PAnsiChar; cdecl;
procedure wkeSetName(webView: wkeWebView; name: PAnsiChar); cdecl;
function wkeIsTransparent(webView: wkeWebView): Boolean; cdecl;
procedure wkeSetTransparent(webView: wkeWebView; transparent: Boolean); cdecl;
procedure wkeSetUserAgent(webView: wkeWebView; userAgent: Putf8); cdecl;
procedure wkeSetUserAgentW(webView: wkeWebView; userAgent: Pwchar_t); cdecl;
procedure wkeLoadURL(webView: wkeWebView; url: Putf8); cdecl;
procedure wkeLoadURLW(webView: wkeWebView; url: Pwchar_t); cdecl;
procedure wkePostURL(wkeView: wkeWebView; url: Putf8; postData: PAnsiChar; postLen: Integer); cdecl;
procedure wkePostURLW(wkeView: wkeWebView; url: Pwchar_t; postData: PAnsiChar; postLen: Integer); cdecl;
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

procedure wkeSetRepaintInterval(webView: wkeWebView; ms: Integer); cdecl;
function wkeGetRepaintInterval(webView: wkeWebView): Integer; cdecl;
function wkeRepaintIfNeededAfterInterval(webView: wkeWebView): Boolean; cdecl;
function wkeRepaintAllNeeded: Boolean; cdecl;
function wkeRunMessageLoop(var quit: Boolean): Boolean; cdecl;

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
function wkeRunJS(webView: wkeWebView; script: Putf8): wkeJSValue; cdecl;
function wkeRunJSW(webView: wkeWebView; script: Pwchar_t): wkeJSValue; cdecl;
function wkeGlobalExec(webView: wkeWebView): wkeJSState; cdecl;
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
procedure wkeOnConsoleMessage(webView: wkeWebView; callback: wkeConsoleMessageCallback; callbackParam: Pointer); cdecl;
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

procedure wkeSetHostWindow(webWindow: wkeWebView; hostWindow: HWND); cdecl;
function wkeGetHostWindow(webWindow: wkeWebView): HWND; cdecl;
//================================JScript============================

procedure wkeJSBindFunction(name: PAnsiChar; fn: jsNativeFunction; AArgCount: LongInt); cdecl;
procedure wkeJSBindGetter(name: PAnsiChar; fn: jsNativeFunction); cdecl;
procedure wkeJSBindSetter(name: PAnsiChar; fn: jsNativeFunction); cdecl;
function wkeJSParamCount(es: wkeJSState): Integer; cdecl;
function wkeJSParamType(es: wkeJSState; argIdx: Integer): wkeJSType; cdecl;
function wkeJSParam(es: wkeJSState; argIdx: Integer): wkeJSValue; cdecl;
function wkeJSTypeOf(es: wkeJSState; v: wkeJSValue): wkeJSType; cdecl;
function wkeJSIsNumber(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsString(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsBool(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsObject(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsFunction(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsUndefined(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsNull(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsArray(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsTrue(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSIsFalse(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSToInt(es: wkeJSState; v: wkeJSValue): Integer; cdecl;
function wkeJSToFloat(es: wkeJSState; v: wkeJSValue): Single; cdecl;
function wkeJSToDouble(es: wkeJSState; v: wkeJSValue): Double; cdecl;
function wkeJSToBool(es: wkeJSState; v: wkeJSValue): Boolean; cdecl;
function wkeJSToTempString(es: wkeJSState; v: wkeJSValue): putf8; cdecl;
function wkeJSToTempStringW(es: wkeJSState; v: wkeJSValue): pwchar_t; cdecl;
function wkeJSInt(es: wkeJSState; n: Integer): wkeJSValue; cdecl;
function wkeJSFloat(es: wkeJSState; f: Single): wkeJSValue; cdecl;
function wkeJSDouble(es: wkeJSState; d: Double): wkeJSValue; cdecl;
function wkeJSBool(es: wkeJSState; b: Boolean): wkeJSValue; cdecl;
function wkeJSUndefined(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSNull(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSTrue(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSFalse(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSString(es: wkeJSState; str: Putf8): wkeJSValue; cdecl;
function wkeJSStringW(es: wkeJSState; str: Pwchar_t): wkeJSValue; cdecl;
function wkeJSEmptyObject(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSEmptyArray(es: wkeJSState): wkeJSValue; cdecl;

function wkeJSObject(es: wkeJSState; obj: PwkeJSData): wkeJSValue; cdecl;
function wkeJSFunction(es: wkeJSState; obj: PwkeJSData): wkeJSValue; cdecl;
function wkeJSGetData(es: wkeJSState; AObject: wkeJSValue): PwkeJSData; cdecl;
function wkeJSGet(es: wkeJSState; AObject: wkeJSValue; prop: PAnsiChar): wkeJSValue; cdecl;
procedure wkeJSSet(es: wkeJSState; AObject: wkeJSValue; prop: PAnsiChar; v: wkeJSValue); cdecl;
function wkeJSGetAt(es: wkeJSState; AObject: wkeJSValue; index: Integer): wkeJSValue; cdecl;
procedure wkeJSSetAt(es: wkeJSState; AObject: wkeJSValue; index: Integer; v: wkeJSValue); cdecl;
function wkeJSGetLength(es: wkeJSState; AObject: wkeJSValue): Integer; cdecl;
procedure wkeJSSetLength(es: wkeJSState; AObject: wkeJSValue; length: Integer); cdecl;
function wkeJSGlobalObject(es: wkeJSState): wkeJSValue; cdecl;
function wkeJSGetWebView(es: wkeJSState): wkeWebView; cdecl;
function wkeJSEval(es: wkeJSState; str: Putf8): wkeJSValue; cdecl;
function wkeJSEvalW(es: wkeJSState; str: Pwchar_t): wkeJSValue; cdecl;
function wkeJSCall(es: wkeJSState; func: wkeJSValue; thisObject: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue; cdecl;
function wkeJSCallGlobal(es: wkeJSState; func: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue; cdecl;
function wkeJSGetGlobal(es: wkeJSState; prop: PAnsiChar): wkeJSValue; cdecl;
procedure wkeJSSetGlobal(es: wkeJSState; prop: PAnsiChar; v: wkeJSValue); cdecl;

procedure wkeJSAddRef(es: wkeJSState; v: wkeJSValue); cdecl;
procedure wkeJSReleaseRef(es: wkeJSState; v: wkeJSValue); cdecl;
procedure wkeJSCollectGarbge; cdecl;



{$IFDEF UseVcFastCall}
   procedure ProcessVcFastCall;
{$ENDIF UseVcFastCall}

implementation

{$IFDEF UseVcFastCall}
   // 必须放在函数开始的第一行位置，否则会破坏ecx寄存器
   procedure ProcessVcFastCall;
   asm
   {$IFDEF DEBUG}
     MOV [EBP-4], ECX
   {$ELSE}
     MOV EBX, ECX
   {$ENDIF DEBUG}
   end;
{$ENDIF UseVcFastCall}

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

class function wkeWebView.GetVersionString: string;
begin
  Result := string(AnsiString(wkeGetVersionString));
end;

class procedure wkeWebView.SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
begin
  wkeSetFileSystem(pfn_open, pfn_close, pfn_size, pfn_read, pfn_seek);
end;

class function wkeWebView.CreateWebView: wkeWebView;
begin
  Result := wkeCreateWebView;
end;

procedure wkeWebView.DestroyWebView;
begin
  wkeDestroyWebView(Self);
end;

function wkeWebView.GetName: string;
begin
  Result := string(AnsiString(wkeGetName(Self)));
end;

procedure wkeWebView.SetName(const AName: string);
begin
  wkeSetName(Self, PAnsiChar(AnsiString(AName)));
end;

function wkeWebView.IsTransparent: Boolean;
begin
  Result := wkeIsTransparent(Self);
end;

procedure wkeWebView.SetTransparent(ATransparent: Boolean);
begin
  wkeSetTransparent(Self, ATransparent);
end;

procedure wkeWebView.SetUserAgent(const AUserAgent: string);
begin
{$IFDEF UNICODE}
   wkeSetUserAgentW(Self, PChar(AUserAgent));
{$ELSE}
   wkeSetUserAgent(Self, PChar({$IFDEF FPC}AUserAgent{$ELSE}AnsiToUtf8(AUserAgent){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.LoadURL(const AURL: string);
begin
{$IFDEF UNICODE}
  wkeLoadURLW(Self, PChar(AURL));
{$ELSE}
  wkeLoadURL(Self, PChar({$IFDEF FPC}AURL{$ELSE}AnsiToUtf8(AURL){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.PostURL(const AURL, APostData: string; PostLen: Integer);
begin
{$IFDEF UNICODE}
   wkePostURLW(Self, PChar(AURL), PAnsiChar(AnsiString(APostData)), PostLen);
{$ELSE}
   wkePostURL(Self, PChar({$IFDEF FPC}AURL{$ELSE}AnsiToUtf8(AURL){$ENDIF}),
     PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(APostData){$ELSE}APostData{$ENDIF})), PostLen);
{$ENDIF}
end;

procedure wkeWebView.LoadHTML(const AHTML: string);
begin
{$IFDEF UNICODE}
  wkeLoadHTMLW(Self, PChar(AHTML));
{$ELSE}
  wkeLoadHTML(Self, PChar({$IFDEF FPC}AHTML{$ELSE}AnsiToUtf8(AHTML){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.LoadFile(const AFileName: string);
begin
{$IFDEF UNICODE}
  wkeLoadFileW(Self, PChar(AFileName));
{$ELSE}
  wkeLoadFile(Self, PChar({$IFDEF FPC}AFileName{$ELSE}AnsiToUtf8(AFileName){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.Load(const AStr: string);
begin
{$IFDEF UNICODE}
  wkeLoadW(Self, PChar(AStr))
{$ELSE}
  wkeLoad(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUTf8(AStr){$ENDIF}))
{$ENDIF}
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

procedure wkeWebView.SetHostWindow(hostWindow: HWND);
begin
  wkeSetHostWindow(Self, hostWindow);
end;

function wkeWebView.GetHostWindow: HWND;
begin
  Result := wkeGetHostWindow(Self);
end;

procedure wkeWebView.SetRepaintInterval(ms: Integer);
begin
  wkeSetRepaintInterval(Self, ms);
end;

function wkeWebView.GetRepaintInterval: Integer;
begin
  Result := wkeGetRepaintInterval(Self);
end;

function wkeWebView.RepaintIfNeededAfterInterval: Boolean;
begin
  Result := wkeRepaintIfNeededAfterInterval(Self);
end;


function wkeWebView.IsLoading(webView: wkeWebView): Boolean;
begin
  Result := True;
//  Result := wkeIsLoading(webView);
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

function wkeWebView.GetTitle: string;
begin
{$IFDEF UNICODE}
  Result := wkeGetTitleW(Self);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetTitle(Self){$ELSE}Utf8ToAnsi(wkeGetTitle(Self)){$ENDIF};
{$ENDIF}
end;

procedure wkeWebView.Resize(w: Integer; h: Integer);
begin
  wkeResize(Self, w, h);
end;

function wkeWebView.GetWebView(name: AnsiString): wkeWebView;
begin
  Result := wkeGetWebView(PAnsiChar(name));
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

class function wkeWebView.RepaintAllNeeded: Boolean;
begin
  Result := wkeRepaintAllNeeded;
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

function wkeWebView.GetCookie: string;
begin
{$IFDEF UNICODE}
  Result := wkeGetCookieW(Self);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetCookie(Self){$ELSE}Utf8ToAnsi(wkeGetCookie(Self)){$ENDIF};
{$ENDIF}
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

function wkeWebView.RunJS(const AScript: string): wkeJSValue;
begin
{$IFDEF UNICODE}
  Result := wkeRunJSW(Self, PChar(AScript));
{$ELSE}
  Result := wkeRunJS(Self, PChar({$IFDEF FPC}AScript{$ELSE}AnsiToUtf8(AScript){$ENDIF}));
{$ENDIF}
end;

class function wkeWebView.RunMessageLoop(var quit: Boolean): Boolean;
begin
  Result := wkeRunMessageLoop(quit);
end;

function wkeWebView.GlobalExec: wkeJSState;
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

class function wkeWebView.GetString(AString: wkeString): string;
begin
{$IFDEF UNICODE}
  Result := wkeGetStringW(AString);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetString(AString){$ELSE}Utf8ToAnsi(wkeGetString(AString)){$ENDIF};
{$ENDIF}
end;

class procedure wkeWebView.SetString(AString: wkeString; const AStr: string);
begin
{$IFDEF UNICODE}
  wkeSetStringW(AString, PChar(AStr), Length(AStr));
{$ELSE}
  wkeSetString(AString, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}), Length(AStr));
{$ENDIF}
end;

procedure wkeWebView.SetOnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
begin
  wkeOnTitleChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
begin
  wkeOnURLChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
begin
  wkeOnPaintUpdated(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
begin
  wkeOnAlertBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
begin
  wkeOnConfirmBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnConsoleMessage(callback: wkeConsoleMessageCallback;
  callbackParam: Pointer);
begin
//  wkeOnConsoleMessage(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
begin
  wkeOnPromptBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnNavigation(callback: wkeNavigationCallback; param: Pointer);
begin
  wkeOnNavigation(Self, callback, param);
end;

procedure wkeWebView.SetOnCreateView(callback: wkeCreateViewCallback; param: Pointer);
begin
  wkeOnCreateView(Self, callback, param);
end;

procedure wkeWebView.SetOnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
begin
  wkeOnDocumentReady(Self, callback, param);
end;

procedure wkeWebView.SetOnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
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

procedure wkeWebView.SetOnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
begin
  wkeOnWindowClosing(Self, callback, param);
end;

procedure wkeWebView.SetOnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);
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

procedure wkeWebView.SetWindowTitle(const ATitle: string);
begin
{$IFDEF UNICODE}
  wkeSetWindowTitleW(Self, PChar(ATitle));
{$ELSE}
  wkeSetWindowTitle(Self, PChar({$IFDEF FPC}ATitle{$ELSE}AnsiToUtf8(ATitle){$ENDIF}));
{$ENDIF}
end;

{ JScript }

class procedure JScript.BindFunction(const AName: string; fn: jsNativeFunction; AArgCount: LongInt);
begin
  wkeJSBindFunction(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn, AArgCount);
end;

class procedure JScript.BindGetter(const AName: string; fn: jsNativeFunction);
begin
  wkeJSBindGetter(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn);
end;

class procedure JScript.BindSetter(const AName: string; fn: jsNativeFunction);
begin
  wkeJSBindSetter(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn);
end;

function JScript.ArgCount: Integer;
begin
  Result := wkeJSParamCount(Self);
end;

function JScript.ArgType(argIdx: Integer): wkeJSType;
begin
  Result := wkeJSParamType(Self, argIdx);
end;

procedure JScript.AddRef(v: wkeJSValue);
begin
  wkeJSAddRef(self, v);
end;

function JScript.Arg(argIdx: Integer): wkeJSValue;
begin
  Result := wkeJSParam(Self, argIdx);
end;

function JScript.TypeOf(v: wkeJSValue): wkeJSType;
begin
  Result := wkeJSTypeOf(Self, v);
end;

function JScript.IsNumber(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsNumber(Self, v);
end;

function JScript.IsString(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsString(Self, v);
end;

function JScript.IsBoolean(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsBool(Self, v);
end;

function JScript.IsObject(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsObject(Self, v);
end;

function JScript.IsFunction(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsFunction(Self, v);
end;

function JScript.IsUndefined(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsUndefined(Self, v);
end;

function JScript.IsNull(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsNull(Self, v);
end;

function JScript.IsArray(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsArray(Self, v);
end;

function JScript.IsTrue(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsTrue(Self, v);
end;

function JScript.IsFalse(v: wkeJSValue): Boolean;
begin
  Result := wkeJSIsFalse(Self, v);
end;

function JScript.ToInt(v: wkeJSValue): Integer;
begin
  Result := wkeJSToInt(Self, v);
end;

function JScript.ToFloat(v: wkeJSValue): Single;
begin
  Result := wkeJSToFloat(Self, v);
end;

function JScript.ToDouble(v: wkeJSValue): Double;
begin
  Result := wkeJSToDouble(Self, v);
end;

function JScript.ToBoolean(v: wkeJSValue): Boolean;
begin
  Result := wkeJSToBool(Self, v);
end;

function JScript.ToTempString(v: wkeJSValue): string;
begin
{$IFDEF UNICODE}
  Result := wkeJSToTempStringW(Self, v);
{$ELSE}
  Result := {$IFDEF FPC}wkeJSToTempString(Self, v){$ELSE}Utf8ToAnsi(wkeJSToTempString(Self, v)){$ENDIF};
{$ENDIF}
end;

function JScript.Int(n: Integer): wkeJSValue;
begin
  Result := wkeJSInt(Self, n);
end;

function JScript.Float(f: Single): wkeJSValue;
begin
  Result := wkeJSFloat(Self, f);
end;

function JScript.Double(d: Double): wkeJSValue;
begin
  Result := wkeJSDouble(Self, d);
end;

function JScript.Boolean(b: Boolean): wkeJSValue;
begin
  Result := wkeJSBool(Self, b);
end;

function JScript.Undefined: wkeJSValue;
begin
  Result := wkeJSUndefined(self);
end;

function JScript.Null: wkeJSValue;
begin
  Result := wkeJSNull(Self);
end;

function JScript.True_: wkeJSValue;
begin
  Result := wkeJSTrue(Self);
end;

function JScript.False_: wkeJSValue;
begin
  Result := wkeJSFalse(Self);
end;

function JScript.String_(const AStr: string): wkeJSValue;
begin
{$IFDEF UNICODE}
  Result := wkeJSStringW(Self, PChar(AStr));
{$ELSE}
  Result := wkeJSString(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}));
{$ENDIF}
end;

function JScript.EmptyObject: wkeJSValue;
begin
  Result := wkeJSEmptyObject(Self);
end;

function JScript.EmptyArray: wkeJSValue;
begin
  Result := wkeJSEmptyArray(Self);
end;

function JScript.Object_(obj: PwkeJSData): wkeJSValue;
begin
  Result := wkeJSObject(Self, obj);
end;

procedure JScript.ReleaseRef(v: wkeJSValue);
begin
  wkeJSReleaseRef(Self, v);
end;

function JScript.Function_(obj: PwkeJSData): wkeJSValue;
begin
  Result := wkeJSFunction(Self, obj);
end;

function JScript.GetData(AObject: wkeJSValue): PwkeJSData;
begin
  Result := wkeJSGetData(Self, AObject);
end;

function JScript.Get(AObject: wkeJSValue; const prop: string): wkeJSValue;
begin
  Result := wkeJSGet(Self, AObject, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})));
end;

procedure JScript.Set_(AObject: wkeJSValue; const prop: string; v: wkeJSValue);
begin
  wkeJSSet(Self, AObject, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})), v);
end;

function JScript.GetAt(AObject: wkeJSValue; index: Integer): wkeJSValue;
begin
  Result := wkeJSGetAt(Self, AObject, index);
end;

procedure JScript.SetAt(AObject: wkeJSValue; index: Integer; v: wkeJSValue);
begin
  wkeJSSetAt(Self, AObject, index, v);
end;

function JScript.GetLength(AObject: wkeJSValue): Integer;
begin
  Result := wkeJSGetLength(Self, AObject);
end;

procedure JScript.SetLength(AObject: wkeJSValue; length: Integer);
begin
  wkeJSSetLength(Self, AObject, length);
end;

function JScript.GlobalObject: wkeJSValue;
begin
  Result := wkeJSGlobalObject(Self);
end;

function JScript.GetWebView: wkeWebView;
begin
  Result := wkeJSGetWebView(Self);
end;

function JScript.Eval(const AStr: string): wkeJSValue;
begin
{$IFDEF UNICODE}
  Result := wkeJSEvalW(Self, PChar(AStr));
{$ELSE}
  Result := wkeJSEval(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}));
{$ENDIF}
end;

function JScript.Call(func: wkeJSValue; thisObject: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue;
begin
  Result := wkeJSCall(Self, func, thisObject, args, argCount);
end;

function JScript.CallGlobal(func: wkeJSValue; args: PwkeJSValue; argCount: Integer): wkeJSValue;
begin
  Result := wkeJSCallGlobal(Self, func, args, argCount);
end;

procedure JScript.CollectGarbge;
begin
  wkeJSCollectGarbge;
end;

function JScript.GetGlobal(const prop: string): wkeJSValue;
begin
  Result := wkeJSGetGlobal(Self, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})));
end;

procedure JScript.SetGlobal(const prop: string; v: wkeJSValue);
begin
  wkeJSSetGlobal(Self, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})), v);
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
function wkeGetWebView; external wkedll name 'wkeGetWebView';
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

procedure wkeSetRepaintInterval; external wkedll name 'wkeSetRepaintInterval';
function wkeGetRepaintInterval; external wkedll name 'wkeGetRepaintInterval';
function wkeRepaintIfNeededAfterInterval; external wkedll name 'wkeRepaintIfNeededAfterInterval';
function wkeRepaintAllNeeded; external wkedll name 'wkeRepaintAllNeeded';
function wkeRunMessageLoop; external wkedll name 'wkeRunMessageLoop';

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
procedure wkeOnConsoleMessage; external wkedll name 'wkeOnConsoleMessage';
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

procedure wkeSetHostWindow; external wkedll name 'wkeSetHostWindow';
function wkeGetHostWindow; external wkedll name 'wkeGetHostWindow';

//================================JScript============================

procedure wkeJSBindFunction; external wkedll name 'wkeJSBindFunction';
procedure wkeJSBindGetter; external wkedll name 'wkeJSBindGetter';
procedure wkeJSBindSetter; external wkedll name 'wkeJSBindSetter';
function wkeJSParamCount; external wkedll name 'wkeJSParamCount';
function wkeJSParamType; external wkedll name 'wkeJSParamType';
function wkeJSParam; external wkedll name 'wkeJSParam';
function wkeJSTypeOf; external wkedll name 'wkeJSTypeOf';
function wkeJSIsNumber; external wkedll name 'wkeJSIsNumber';
function wkeJSIsString; external wkedll name 'wkeJSIsString';
function wkeJSIsBool; external wkedll name 'wkeJSIsBool';
function wkeJSIsObject; external wkedll name 'wkeJSIsObject';
function wkeJSIsFunction; external wkedll name 'wkeJSIsFunction';
function wkeJSIsUndefined; external wkedll name 'wkeJSIsUndefined';
function wkeJSIsNull; external wkedll name 'wkeJSIsNull';
function wkeJSIsArray; external wkedll name 'wkeJSIsArray';
function wkeJSIsTrue; external wkedll name 'wkeJSIsTrue';
function wkeJSIsFalse; external wkedll name 'wkeJSIsFalse';
function wkeJSToInt; external wkedll name 'wkeJSToInt';
function wkeJSToFloat; external wkedll name 'wkeJSToFloat';
function wkeJSToDouble; external wkedll name 'wkeJSToDouble';
function wkeJSToBool; external wkedll name 'wkeJSToBool';
function wkeJSToTempString; external wkedll name 'wkeJSToTempString';
function wkeJSToTempStringW; external wkedll name 'wkeJSToTempStringW';
function wkeJSInt; external wkedll name 'wkeJSInt';
function wkeJSFloat; external wkedll name 'wkeJSFloat';
function wkeJSDouble; external wkedll name 'wkeJSDouble';
function wkeJSBool; external wkedll name 'wkeJSBool';
function wkeJSUndefined; external wkedll name 'wkeJSUndefined';
function wkeJSNull; external wkedll name 'wkeJSNull';
function wkeJSTrue; external wkedll name 'wkeJSTrue';
function wkeJSFalse; external wkedll name 'wkeJSFalse';
function wkeJSString; external wkedll name 'wkeJSString';
function wkeJSStringW; external wkedll name 'wkeJSStringW';
function wkeJSEmptyObject; external wkedll name 'wkeJSEmptyObject';
function wkeJSEmptyArray; external wkedll name 'wkeJSEmptyArray';
function wkeJSObject; external wkedll name 'wkeJSObject';
function wkeJSFunction; external wkedll name 'wkeJSFunction';
function wkeJSGetData; external wkedll name 'wkeJSGetData';
function wkeJSGet; external wkedll name 'wkeJSGet';
procedure wkeJSSet; external wkedll name 'wkeJSSet';
function wkeJSGetAt; external wkedll name 'wkeJSGetAt';
procedure wkeJSSetAt; external wkedll name 'wkeJSSetAt';
function wkeJSGetLength; external wkedll name 'wkeJSGetLength';
procedure wkeJSSetLength; external wkedll name 'wkeJSSetLength';
function wkeJSGlobalObject; external wkedll name 'wkeJSGlobalObject';
function wkeJSGetWebView; external wkedll name 'wkeJSGetWebView';
function wkeJSEval; external wkedll name 'wkeJSEval';
function wkeJSEvalW; external wkedll name 'wkeJSEvalW';
function wkeJSCall; external wkedll name 'wkeJSCall';
function wkeJSCallGlobal; external wkedll name 'wkeJSCallGlobal';
function wkeJSGetGlobal; external wkedll name 'wkeJSGetGlobal';
procedure wkeJSSetGlobal; external wkedll name 'wkeJSSetGlobal';

procedure wkeJSAddRef; external wkedll name 'wkeJSAddRef';
procedure wkeJSReleaseRef; external wkedll name 'wkeJSReleaseRef';
procedure wkeJSCollectGarbge; external wkedll name 'wkeJSCollectGarbge';


{$IFDEF MSWINDOWS}
{$WARN SYMBOL_PLATFORM OFF}
// 屏掉浮点异常，暂时没办法的办法
var
  {$IFDEF FPC}uOldFPU, {$ENDIF}uOld8087CW: Word;
initialization
  uOld8087CW := Default8087CW;
  Set8087CW($133F);
{$IFDEF FPC}
   // http://lists.freepascal.org/pipermail/fpc-devel/2010-September/021808.html
   uOldFPU := GetSSECSR;
   SetSSECSR(uOldFPU or $0080);
{$ENDIF FPC}
finalization
  Set8087CW(uOld8087CW);
{$IFDEF FPC}
   SetSSECSR(uOldFPU);
{$ENDIF FPC}
{$ENDIF MSWINDOWS}

end.
