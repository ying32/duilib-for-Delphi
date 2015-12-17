//***************************************************************************
//
//       名称：wke.pas
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@vip.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       c++ wke内核: https://github.com/BlzFans/wke
//       wke的头文件，ying32翻译至pascal
//***************************************************************************
unit Wke;

interface

const
  wkedll = 'wke.dll';

type
  utf8 = AnsiChar;
  Putf8 = PAnsiChar;
  wchar_t = WideChar;
  Pwchar_t = PWideChar;

  jsExecState = Pointer;
  jsValue = int64;
  PjsValue = PInt64;
  wkeString = Pointer;

  {$Z4+}
  wkeMouseFlags = (
    WKE_LBUTTON = $01,
    WKE_RBUTTON = $02,
    WKE_SHIFT   = $04,
    WKE_CONTROL = $08,
    WKE_MBUTTON = $10
  );
  TwkeMouseFlags = wkeMouseFlags;

  {$Z4+}
  wkeMouseMsg = (
    WKE_MSG_MOUSEMOVE     = $0200,
    WKE_MSG_LBUTTONDOWN   = $0201,
    WKE_MSG_LBUTTONUP     = $0202,
    WKE_MSG_LBUTTONDBLCLK = $0203,
    WKE_MSG_RBUTTONDOWN   = $0204,
    WKE_MSG_RBUTTONUP     = $0205,
    WKE_MSG_RBUTTONDBLCLK = $0206,
    WKE_MSG_MBUTTONDOWN   = $0207,
    WKE_MSG_MBUTTONUP     = $0208,
    WKE_MSG_MBUTTONDBLCLK = $0209,
    WKE_MSG_MOUSEWHEEL    = $020A
  );
  TwkeMouseMsg = wkeMouseMsg;

  wkeRect = packed record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;
  PwkeRect = ^TwkeRect;
  TwkeRect = wkeRect;

  PwkeClientHandler = ^TwkeClientHandler;

  ON_TITLE_CHANGED = procedure(clientHandler: PwkeClientHandler; title: wkeString); cdecl;
  ON_URL_CHANGED = procedure(clientHandler: PwkeClientHandler; url: wkeString); cdecl;

  wkeClientHandler = packed record
    onTitleChanged: ON_TITLE_CHANGED;
    onURLChanged: ON_URL_CHANGED;
  end;
  _wkeClientHandler = wkeClientHandler;
  TwkeClientHandler = wkeClientHandler;

  // 是不是应该使用PAnsiChar????
  FILE_OPEN = function(path: PAnsiChar): Pointer; cdecl;
  FILE_CLOSE = procedure(handle: Pointer); cdecl;
  FILE_SIZE = function(handle: Pointer): Cardinal; cdecl;
  FILE_READ = function(handle: Pointer; buffer: Pointer; size: Cardinal): Integer; cdecl;
  FILE_SEEK = function(handle: Pointer; offset: Integer; origin: Integer): Integer; cdecl;


  wkeWebView = class
  public
    class procedure Init;
    class procedure Shutdown;
    class function CreateWebView: wkeWebView;
    procedure DestroyWebView;
    class function GetWebView(AName: PAnsiChar): wkeWebView;
    class procedure Update;
    class function Version: Integer;
    class function VersionString: utf8;
    class procedure SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
    function WebViewName: PAnsiChar;
    procedure SetWebViewName(name: PAnsiChar);
    function IsTransparent: Boolean;
    procedure SetTransparent(transparent: Boolean);
    procedure LoadURL(url: Putf8);
    procedure LoadURLW(url: Pwchar_t);
    procedure LoadHTML(html: Putf8);
    procedure LoadHTMLW(html: Pwchar_t);
    procedure LoadFile(filename: Putf8);
    procedure LoadFileW(filename: Pwchar_t);
    function IsLoaded: Boolean;
    function IsLoadFailed: Boolean;
    function IsLoadComplete: Boolean;
    function IsDocumentReady: Boolean;
    function IsLoading: Boolean;
    procedure StopLoading;
    procedure Reload;
    function Title: Putf8;
    function TitleW: Pwchar_t;
    procedure Resize(w: Integer; h: Integer);
    function Width: Integer;
    function Height: Integer;
    function ContentsWidth: Integer;
    function ContentsHeight: Integer;
    procedure SetDirty(dirty: Boolean);
    function IsDirty: Boolean;
    procedure AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
    procedure LayoutIfNeeded;
    procedure Paint(bits: PPointer; pitch: Integer);
    function CanGoBack: Boolean;
    function GoBack: Boolean;
    function CanGoForward: Boolean;
    function GoForward: Boolean;
    procedure SelectAll;
    procedure Copy;
    procedure Cut;
    procedure Paste;
    procedure Delete;
    procedure SetCookieEnabled(enable: Boolean);
    function CookieEnabled: Boolean;
    procedure SetMediaVolume(volume: Single);
    function MediaVolume: Single;
    function MouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
    function ContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
    function MouseWheel(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
    function KeyUp(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function KeyDown(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function KeyPress(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    procedure Focus;
    procedure Unfocus;
    function GetCaret: wkeRect;
    function RunJS(script: Putf8): jsValue;
    function RunJSW(script: Pwchar_t): jsValue;
    function GlobalExec: jsExecState;
    procedure Sleep;
    procedure Awaken;
    function IsAwake: Boolean;
    procedure SetZoomFactor(factor: Single);
    function ZoomFactor: Single;
    procedure SetEditable(editable: Boolean);
    procedure SetClientHandler(handler: PwkeClientHandler);
    function GetClientHandler: PwkeClientHandler;
    class function ToString(AString: wkeString): Putf8;
    class function ToStringW(AString: wkeString): Pwchar_t;
  end;
  TWkeWebView = wkeWebView;


  jsNativeFunction = function(es: jsExecState): jsValue; stdcall;

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


  JavaScript = class
  public
    class procedure BindFunction(name: Pchar; fn: jsNativeFunction; argCount: LongInt);
    class procedure BindGetter(name: Pchar; fn: jsNativeFunction);
    class procedure BindSetter(name: Pchar; fn: jsNativeFunction);
    class function ArgCount(es: jsExecState): Integer;
    class function ArgType(es: jsExecState; argIdx: Integer): jsType;
    class function Arg(es: jsExecState; argIdx: Integer): jsValue;
    class function TypeOf(v: jsValue): jsType;
    class function IsNumber(v: jsValue): Boolean;
    class function IsString(v: jsValue): Boolean;
    class function IsBoolean(v: jsValue): Boolean;
    class function IsObject(v: jsValue): Boolean;
    class function IsFunction(v: jsValue): Boolean;
    class function IsUndefined(v: jsValue): Boolean;
    class function IsNull(v: jsValue): Boolean;
    class function IsArray(v: jsValue): Boolean;
    class function IsTrue(v: jsValue): Boolean;
    class function IsFalse(v: jsValue): Boolean;
    class function ToInt(es: jsExecState; v: jsValue): Integer;
    class function ToFloat(es: jsExecState; v: jsValue): Single;
    class function ToDouble(es: jsExecState; v: jsValue): Double;
    class function ToBoolean(es: jsExecState; v: jsValue): Boolean;
    class function ToString(es: jsExecState; v: jsValue): utf8;
    class function ToStringW(es: jsExecState; v: jsValue): wchar_t;
    class function Int(n: Integer): jsValue;
    class function Float(f: Single): jsValue;
    class function Double(d: Double): jsValue;
    class function Boolean(b: Boolean): jsValue;
    class function Undefined: jsValue;
    class function Null: jsValue;
    class function True: jsValue;
    class function False: jsValue;
    class function StringA(es: jsExecState; str: Putf8): jsValue;
    class function StringW(es: jsExecState; str: Pwchar_t): jsValue;
    class function _Object(es: jsExecState): jsValue;
    class function _Array(es: jsExecState): jsValue;
    class function _Function(es: jsExecState; fn: jsNativeFunction; argCount: LongInt): jsValue;
    class function GlobalObject(es: jsExecState): jsValue;
    class function Eval(es: jsExecState; str: Putf8): jsValue;
    class function EvalW(es: jsExecState; str: Pwchar_t): jsValue;
    class function Call(es: jsExecState; func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue;
    class function CallGlobal(es: jsExecState; func: jsValue; args: PjsValue; argCount: Integer): jsValue;
    class function Get(es: jsExecState; AObject: jsValue; prop: Pchar): jsValue;
    class procedure _Set(es: jsExecState; AObject: jsValue; prop: Pchar; v: jsValue);
    class function GetGlobal(es: jsExecState; prop: Pchar): jsValue;
    class procedure SetGlobal(es: jsExecState; prop: Pchar; v: jsValue);
    class function GetAt(es: jsExecState; AObject: jsValue; index: Integer): jsValue;
    class procedure SetAt(es: jsExecState; AObject: jsValue; index: Integer; v: jsValue);
    class function GetLength(es: jsExecState; AObject: jsValue): Integer;
    class procedure SetLength(es: jsExecState; AObject: jsValue; length: Integer);
    class function GetWebView(es: jsExecState): wkeWebView;
    class procedure GC;
  end;


//================================wkeWebView============================

procedure wkeWebView_wkeInit; cdecl;
procedure wkeWebView_wkeShutdown; cdecl;
function wkeWebView_wkeCreateWebView: wkeWebView; cdecl;
procedure wkeWebView_wkeDestroyWebView(webView: wkeWebView); cdecl;
function wkeWebView_wkeGetWebView(name: PAnsiChar): wkeWebView; cdecl;
procedure wkeWebView_wkeUpdate; cdecl;
function wkeWebView_wkeVersion: Integer; cdecl;
function wkeWebView_wkeVersionString: utf8; cdecl;
procedure wkeWebView_wkeSetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK); cdecl;
function wkeWebView_wkeWebViewName(webView: wkeWebView): PAnsiChar; cdecl;
procedure wkeWebView_wkeSetWebViewName(webView: wkeWebView; name: PAnsiChar); cdecl;
function wkeWebView_wkeIsTransparent(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeSetTransparent(webView: wkeWebView; transparent: Boolean); cdecl;
procedure wkeWebView_wkeLoadURL(webView: wkeWebView; url: Putf8); cdecl;
procedure wkeWebView_wkeLoadURLW(webView: wkeWebView; url: Pwchar_t); cdecl;
procedure wkeWebView_wkeLoadHTML(webView: wkeWebView; html: Putf8); cdecl;
procedure wkeWebView_wkeLoadHTMLW(webView: wkeWebView; html: Pwchar_t); cdecl;
procedure wkeWebView_wkeLoadFile(webView: wkeWebView; filename: Putf8); cdecl;
procedure wkeWebView_wkeLoadFileW(webView: wkeWebView; filename: Pwchar_t); cdecl;
function wkeWebView_wkeIsLoaded(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeIsLoadFailed(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeIsLoadComplete(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeIsDocumentReady(webView: wkeWebView): Boolean; cdecl;
//function wkeWebView_wkeIsLoading(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeStopLoading(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeReload(webView: wkeWebView); cdecl;
function wkeWebView_wkeTitle(webView: wkeWebView): Putf8; cdecl;
function wkeWebView_wkeTitleW(webView: wkeWebView): Pwchar_t; cdecl;
procedure wkeWebView_wkeResize(webView: wkeWebView; w: Integer; h: Integer); cdecl;
function wkeWebView_wkeWidth(webView: wkeWebView): Integer; cdecl;
function wkeWebView_wkeHeight(webView: wkeWebView): Integer; cdecl;
function wkeWebView_wkeContentsWidth(webView: wkeWebView): Integer; cdecl;
function wkeWebView_wkeContentsHeight(webView: wkeWebView): Integer; cdecl;
procedure wkeWebView_wkeSetDirty(webView: wkeWebView; dirty: Boolean); cdecl;
function wkeWebView_wkeIsDirty(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeAddDirtyArea(webView: wkeWebView; x: Integer; y: Integer; w: Integer; h: Integer); cdecl;
procedure wkeWebView_wkeLayoutIfNeeded(webView: wkeWebView); cdecl;
procedure wkeWebView_wkePaint(webView: wkeWebView; bits: PPointer; pitch: Integer); cdecl;
function wkeWebView_wkeCanGoBack(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeGoBack(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeCanGoForward(webView: wkeWebView): Boolean; cdecl;
function wkeWebView_wkeGoForward(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeSelectAll(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeCopy(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeCut(webView: wkeWebView); cdecl;
procedure wkeWebView_wkePaste(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeDelete(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeSetCookieEnabled(webView: wkeWebView; enable: Boolean); cdecl;
function wkeWebView_wkeCookieEnabled(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeSetMediaVolume(webView: wkeWebView; volume: Single); cdecl;
function wkeWebView_wkeMediaVolume(webView: wkeWebView): Single; cdecl;
function wkeWebView_wkeMouseEvent(webView: wkeWebView; message: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
function wkeWebView_wkeContextMenuEvent(webView: wkeWebView; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
function wkeWebView_wkeMouseWheel(webView: wkeWebView; x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean; cdecl;
function wkeWebView_wkeKeyUp(webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
function wkeWebView_wkeKeyDown(webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
function wkeWebView_wkeKeyPress(webView: wkeWebView; charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
procedure wkeWebView_wkeFocus(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeUnfocus(webView: wkeWebView); cdecl;
function wkeWebView_wkeGetCaret(webView: wkeWebView): wkeRect; cdecl;
function wkeWebView_wkeRunJS(webView: wkeWebView; script: Putf8): jsValue; cdecl;
function wkeWebView_wkeRunJSW(webView: wkeWebView; script: Pwchar_t): jsValue; cdecl;
function wkeWebView_wkeGlobalExec(webView: wkeWebView): jsExecState; cdecl;
procedure wkeWebView_wkeSleep(webView: wkeWebView); cdecl;
procedure wkeWebView_wkeAwaken(webView: wkeWebView); cdecl;
function wkeWebView_wkeIsAwake(webView: wkeWebView): Boolean; cdecl;
procedure wkeWebView_wkeSetZoomFactor(webView: wkeWebView; factor: Single); cdecl;
function wkeWebView_wkeZoomFactor(webView: wkeWebView): Single; cdecl;
procedure wkeWebView_wkeSetEditable(webView: wkeWebView; editable: Boolean); cdecl;
procedure wkeWebView_wkeSetClientHandler(webView: wkeWebView; handler: PwkeClientHandler); cdecl;
function wkeWebView_wkeGetClientHandler(webView: wkeWebView): PwkeClientHandler; cdecl;
function wkeWebView_wkeToString(AString: wkeString): Putf8; cdecl;
function wkeWebView_wkeToStringW(AString: wkeString): Pwchar_t; cdecl;


//================================JavaScript============================

procedure JavaScript_jsBindFunction(name: Pchar; fn: jsNativeFunction; argCount: LongInt); cdecl;
procedure JavaScript_jsBindGetter(name: Pchar; fn: jsNativeFunction); cdecl;
procedure JavaScript_jsBindSetter(name: Pchar; fn: jsNativeFunction); cdecl;
function JavaScript_jsArgCount(es: jsExecState): Integer; cdecl;
function JavaScript_jsArgType(es: jsExecState; argIdx: Integer): jsType; cdecl;
function JavaScript_jsArg(es: jsExecState; argIdx: Integer): jsValue; cdecl;
function JavaScript_jsTypeOf(v: jsValue): jsType; cdecl;
function JavaScript_jsIsNumber(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsString(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsBoolean(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsObject(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsFunction(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsUndefined(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsNull(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsArray(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsTrue(v: jsValue): Boolean; cdecl;
function JavaScript_jsIsFalse(v: jsValue): Boolean; cdecl;
function JavaScript_jsToInt(es: jsExecState; v: jsValue): Integer; cdecl;
function JavaScript_jsToFloat(es: jsExecState; v: jsValue): Single; cdecl;
function JavaScript_jsToDouble(es: jsExecState; v: jsValue): Double; cdecl;
function JavaScript_jsToBoolean(es: jsExecState; v: jsValue): Boolean; cdecl;
function JavaScript_jsToString(es: jsExecState; v: jsValue): utf8; cdecl;
function JavaScript_jsToStringW(es: jsExecState; v: jsValue): wchar_t; cdecl;
function JavaScript_jsInt(n: Integer): jsValue; cdecl;
function JavaScript_jsFloat(f: Single): jsValue; cdecl;
function JavaScript_jsDouble(d: Double): jsValue; cdecl;
function JavaScript_jsBoolean(b: Boolean): jsValue; cdecl;
function JavaScript_jsUndefined: jsValue; cdecl;
function JavaScript_jsNull: jsValue; cdecl;
function JavaScript_jsTrue: jsValue; cdecl;
function JavaScript_jsFalse: jsValue; cdecl;
function JavaScript_jsString(es: jsExecState; str: Putf8): jsValue; cdecl;
function JavaScript_jsStringW(es: jsExecState; str: Pwchar_t): jsValue; cdecl;
function JavaScript_jsObject(es: jsExecState): jsValue; cdecl;
function JavaScript_jsArray(es: jsExecState): jsValue; cdecl;
function JavaScript_jsFunction(es: jsExecState; fn: jsNativeFunction; argCount: LongInt): jsValue; cdecl;
function JavaScript_jsGlobalObject(es: jsExecState): jsValue; cdecl;
function JavaScript_jsEval(es: jsExecState; str: Putf8): jsValue; cdecl;
function JavaScript_jsEvalW(es: jsExecState; str: Pwchar_t): jsValue; cdecl;
function JavaScript_jsCall(es: jsExecState; func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
function JavaScript_jsCallGlobal(es: jsExecState; func: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
function JavaScript_jsGet(es: jsExecState; AObject: jsValue; prop: Pchar): jsValue; cdecl;
procedure JavaScript_jsSet(es: jsExecState; AObject: jsValue; prop: Pchar; v: jsValue); cdecl;
function JavaScript_jsGetGlobal(es: jsExecState; prop: Pchar): jsValue; cdecl;
procedure JavaScript_jsSetGlobal(es: jsExecState; prop: Pchar; v: jsValue); cdecl;
function JavaScript_jsGetAt(es: jsExecState; AObject: jsValue; index: Integer): jsValue; cdecl;
procedure JavaScript_jsSetAt(es: jsExecState; AObject: jsValue; index: Integer; v: jsValue); cdecl;
function JavaScript_jsGetLength(es: jsExecState; AObject: jsValue): Integer; cdecl;
procedure JavaScript_jsSetLength(es: jsExecState; AObject: jsValue; length: Integer); cdecl;
function JavaScript_jsGetWebView(es: jsExecState): wkeWebView; cdecl;
procedure JavaScript_jsGC; cdecl;


implementation


{ wkeWebView }

class procedure wkeWebView.Init;
begin
  wkeWebView_wkeInit;
end;

class procedure wkeWebView.Shutdown;
begin
  wkeWebView_wkeShutdown;
end;

class function wkeWebView.CreateWebView: wkeWebView;
begin
  Result := wkeWebView_wkeCreateWebView;
end;

procedure wkeWebView.DestroyWebView;
begin
  wkeWebView_wkeDestroyWebView(Self);
end;

class function wkeWebView.GetWebView(AName: PAnsiChar): wkeWebView;
begin
  Result := wkeWebView_wkeGetWebView(AName);
end;

class procedure wkeWebView.Update;
begin
  wkeWebView_wkeUpdate;
end;

class function wkeWebView.Version: Integer;
begin
  Result := wkeWebView_wkeVersion;
end;

class function wkeWebView.VersionString: utf8;
begin
  Result := wkeWebView_wkeVersionString;
end;

class procedure wkeWebView.SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
begin
  wkeWebView_wkeSetFileSystem(pfn_open, pfn_close, pfn_size, pfn_read, pfn_seek);
end;

function wkeWebView.WebViewName: PAnsiChar;
begin
  Result := wkeWebView_wkeWebViewName(Self);
end;

procedure wkeWebView.SetWebViewName(name: PAnsiChar);
begin
  wkeWebView_wkeSetWebViewName(Self, name);
end;

function wkeWebView.IsTransparent: Boolean;
begin
  Result := wkeWebView_wkeIsTransparent(Self);
end;

procedure wkeWebView.SetTransparent(transparent: Boolean);
begin
  wkeWebView_wkeSetTransparent(Self, transparent);
end;

procedure wkeWebView.LoadURL(url: Putf8);
begin
  wkeWebView_wkeLoadURL(Self, url);
end;

procedure wkeWebView.LoadURLW(url: Pwchar_t);
begin
  wkeWebView_wkeLoadURLW(Self, url);
end;

procedure wkeWebView.LoadHTML(html: Putf8);
begin
  wkeWebView_wkeLoadHTML(Self, html);
end;

procedure wkeWebView.LoadHTMLW(html: Pwchar_t);
begin
  wkeWebView_wkeLoadHTMLW(Self, html);
end;

procedure wkeWebView.LoadFile(filename: Putf8);
begin
  wkeWebView_wkeLoadFile(Self, filename);
end;

procedure wkeWebView.LoadFileW(filename: Pwchar_t);
begin
  wkeWebView_wkeLoadFileW(Self, filename);
end;

function wkeWebView.IsLoaded: Boolean;
begin
  Result := wkeWebView_wkeIsLoaded(Self);
end;

function wkeWebView.IsLoadFailed: Boolean;
begin
  Result := wkeWebView_wkeIsLoadFailed(Self);
end;

function wkeWebView.IsLoadComplete: Boolean;
begin
  Result := wkeWebView_wkeIsLoadComplete(Self);
end;

function wkeWebView.IsDocumentReady: Boolean;
begin
  Result := wkeWebView_wkeIsDocumentReady(Self);
end;

function wkeWebView.IsLoading: Boolean;
begin
  Result := False; // 没有这个
//  Result := wkeWebView_wkeIsLoading(Self);
end;

procedure wkeWebView.StopLoading;
begin
  wkeWebView_wkeStopLoading(Self);
end;

procedure wkeWebView.Reload;
begin
  wkeWebView_wkeReload(Self);
end;

function wkeWebView.Title: Putf8;
begin
  Result := wkeWebView_wkeTitle(Self);
end;

function wkeWebView.TitleW: Pwchar_t;
begin
  Result := wkeWebView_wkeTitleW(Self);
end;

procedure wkeWebView.Resize(w: Integer; h: Integer);
begin
  wkeWebView_wkeResize(Self, w, h);
end;

function wkeWebView.Width: Integer;
begin
  Result := wkeWebView_wkeWidth(Self);
end;

function wkeWebView.Height: Integer;
begin
  Result := wkeWebView_wkeHeight(Self);
end;

function wkeWebView.ContentsWidth: Integer;
begin
  Result := wkeWebView_wkeContentsWidth(Self);
end;

function wkeWebView.ContentsHeight: Integer;
begin
  Result := wkeWebView_wkeContentsHeight(Self);
end;

procedure wkeWebView.SetDirty(dirty: Boolean);
begin
  wkeWebView_wkeSetDirty(Self, dirty);
end;

function wkeWebView.IsDirty: Boolean;
begin
  Result := wkeWebView_wkeIsDirty(Self);
end;

procedure wkeWebView.AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
begin
  wkeWebView_wkeAddDirtyArea(Self, x, y, w, h);
end;

procedure wkeWebView.LayoutIfNeeded;
begin
  wkeWebView_wkeLayoutIfNeeded(Self);
end;

procedure wkeWebView.Paint(bits: PPointer; pitch: Integer);
begin
  wkeWebView_wkePaint(Self, bits, pitch);
end;

function wkeWebView.CanGoBack: Boolean;
begin
  Result := wkeWebView_wkeCanGoBack(Self);
end;

function wkeWebView.GoBack: Boolean;
begin
  Result := wkeWebView_wkeGoBack(Self);
end;

function wkeWebView.CanGoForward: Boolean;
begin
  Result := wkeWebView_wkeCanGoForward(Self);
end;

function wkeWebView.GoForward: Boolean;
begin
  Result := wkeWebView_wkeGoForward(Self);
end;

procedure wkeWebView.SelectAll;
begin
  wkeWebView_wkeSelectAll(Self);
end;

procedure wkeWebView.Copy;
begin
  wkeWebView_wkeCopy(Self);
end;

procedure wkeWebView.Cut;
begin
  wkeWebView_wkeCut(Self);
end;

procedure wkeWebView.Paste;
begin
  wkeWebView_wkePaste(Self);
end;

procedure wkeWebView.Delete;
begin
  wkeWebView_wkeDelete(Self);
end;

procedure wkeWebView.SetCookieEnabled(enable: Boolean);
begin
  wkeWebView_wkeSetCookieEnabled(Self, enable);
end;

function wkeWebView.CookieEnabled: Boolean;
begin
  Result := wkeWebView_wkeCookieEnabled(Self);
end;

procedure wkeWebView.SetMediaVolume(volume: Single);
begin
  wkeWebView_wkeSetMediaVolume(Self, volume);
end;

function wkeWebView.MediaVolume: Single;
begin
  Result := wkeWebView_wkeMediaVolume(Self);
end;

function wkeWebView.MouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeWebView_wkeMouseEvent(Self, AMessage, x, y, flags);
end;

function wkeWebView.ContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeWebView_wkeContextMenuEvent(Self, x, y, flags);
end;

function wkeWebView.MouseWheel(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
begin
  Result := wkeWebView_wkeMouseWheel(Self, x, y, delta, flags);
end;

function wkeWebView.KeyUp(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeWebView_wkeKeyUp(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.KeyDown(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeWebView_wkeKeyDown(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.KeyPress(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeWebView_wkeKeyPress(Self, charCode, flags, systemKey);
end;

procedure wkeWebView.Focus;
begin
  wkeWebView_wkeFocus(Self);
end;

procedure wkeWebView.Unfocus;
begin
  wkeWebView_wkeUnfocus(Self);
end;

function wkeWebView.GetCaret: wkeRect;
begin
  Result := wkeWebView_wkeGetCaret(Self);
end;

function wkeWebView.RunJS(script: Putf8): jsValue;
begin
  Result := wkeWebView_wkeRunJS(Self, script);
end;

function wkeWebView.RunJSW(script: Pwchar_t): jsValue;
begin
  Result := wkeWebView_wkeRunJSW(Self, script);
end;

function wkeWebView.GlobalExec: jsExecState;
begin
  Result := wkeWebView_wkeGlobalExec(Self);
end;

procedure wkeWebView.Sleep;
begin
  wkeWebView_wkeSleep(Self);
end;

procedure wkeWebView.Awaken;
begin
  wkeWebView_wkeAwaken(Self);
end;

function wkeWebView.IsAwake: Boolean;
begin
  Result := wkeWebView_wkeIsAwake(Self);
end;

procedure wkeWebView.SetZoomFactor(factor: Single);
begin
  wkeWebView_wkeSetZoomFactor(Self, factor);
end;

function wkeWebView.ZoomFactor: Single;
begin
  Result := wkeWebView_wkeZoomFactor(Self);
end;

procedure wkeWebView.SetEditable(editable: Boolean);
begin
  wkeWebView_wkeSetEditable(Self, editable);
end;

procedure wkeWebView.SetClientHandler(handler: PwkeClientHandler);
begin
  wkeWebView_wkeSetClientHandler(Self, handler);
end;

function wkeWebView.GetClientHandler: PwkeClientHandler;
begin
  Result := wkeWebView_wkeGetClientHandler(Self);
end;

class function wkeWebView.ToString(AString: wkeString): Putf8;
begin
  Result := wkeWebView_wkeToString(AString);
end;

class function wkeWebView.ToStringW(AString: wkeString): Pwchar_t;
begin
  Result := wkeWebView_wkeToStringW(AString);
end;


{ JavaScript }


class procedure JavaScript.BindFunction(name: Pchar; fn: jsNativeFunction; argCount: LongInt);
begin
  JavaScript_jsBindFunction(name, fn, argCount);
end;

class procedure JavaScript.BindGetter(name: Pchar; fn: jsNativeFunction);
begin
  JavaScript_jsBindGetter(name, fn);
end;

class procedure JavaScript.BindSetter(name: Pchar; fn: jsNativeFunction);
begin
  JavaScript_jsBindSetter(name, fn);
end;

class function JavaScript.ArgCount(es: jsExecState): Integer;
begin
  Result := JavaScript_jsArgCount(es);
end;

class function JavaScript.ArgType(es: jsExecState; argIdx: Integer): jsType;
begin
  Result := JavaScript_jsArgType(es, argIdx);
end;

class function JavaScript.Arg(es: jsExecState; argIdx: Integer): jsValue;
begin
  Result := JavaScript_jsArg(es, argIdx);
end;

class function JavaScript.TypeOf(v: jsValue): jsType;
begin
  Result := JavaScript_jsTypeOf(v);
end;

class function JavaScript.IsNumber(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsNumber(v);
end;

class function JavaScript.IsString(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsString(v);
end;

class function JavaScript.IsBoolean(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsBoolean(v);
end;

class function JavaScript.IsObject(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsObject(v);
end;

class function JavaScript.IsFunction(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsFunction(v);
end;

class function JavaScript.IsUndefined(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsUndefined(v);
end;

class function JavaScript.IsNull(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsNull(v);
end;

class function JavaScript.IsArray(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsArray(v);
end;

class function JavaScript.IsTrue(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsTrue(v);
end;

class function JavaScript.IsFalse(v: jsValue): Boolean;
begin
  Result := JavaScript_jsIsFalse(v);
end;

class function JavaScript.ToInt(es: jsExecState; v: jsValue): Integer;
begin
  Result := JavaScript_jsToInt(es, v);
end;

class function JavaScript.ToFloat(es: jsExecState; v: jsValue): Single;
begin
  Result := JavaScript_jsToFloat(es, v);
end;

class function JavaScript.ToDouble(es: jsExecState; v: jsValue): Double;
begin
  Result := JavaScript_jsToDouble(es, v);
end;

class function JavaScript.ToBoolean(es: jsExecState; v: jsValue): Boolean;
begin
  Result := JavaScript_jsToBoolean(es, v);
end;

class function JavaScript.ToString(es: jsExecState; v: jsValue): utf8;
begin
  Result := JavaScript_jsToString(es, v);
end;

class function JavaScript.ToStringW(es: jsExecState; v: jsValue): wchar_t;
begin
  Result := JavaScript_jsToStringW(es, v);
end;

class function JavaScript.Int(n: Integer): jsValue;
begin
  Result := JavaScript_jsInt(n);
end;

class function JavaScript.Float(f: Single): jsValue;
begin
  Result := JavaScript_jsFloat(f);
end;

class function JavaScript.Double(d: Double): jsValue;
begin
  Result := JavaScript_jsDouble(d);
end;

class function JavaScript.Boolean(b: Boolean): jsValue;
begin
  Result := JavaScript_jsBoolean(b);
end;

class function JavaScript.Undefined: jsValue;
begin
  Result := JavaScript_jsUndefined;
end;

class function JavaScript.Null: jsValue;
begin
  Result := JavaScript_jsNull;
end;

class function JavaScript.True: jsValue;
begin
  Result := JavaScript_jsTrue;
end;

class function JavaScript.False: jsValue;
begin
  Result := JavaScript_jsFalse;
end;

class function JavaScript.StringA(es: jsExecState; str: Putf8): jsValue;
begin
  Result := JavaScript_jsString(es, str);
end;

class function JavaScript.StringW(es: jsExecState; str: Pwchar_t): jsValue;
begin
  Result := JavaScript_jsStringW(es, str);
end;

class function JavaScript._Object(es: jsExecState): jsValue;
begin
  Result := JavaScript_jsObject(es);
end;

class function JavaScript._Array(es: jsExecState): jsValue;
begin
  Result := JavaScript_jsArray(es);
end;

class function JavaScript._Function(es: jsExecState; fn: jsNativeFunction; argCount: LongInt): jsValue;
begin
  Result := JavaScript_jsFunction(es, fn, argCount);
end;

class function JavaScript.GlobalObject(es: jsExecState): jsValue;
begin
  Result := JavaScript_jsGlobalObject(es);
end;

class function JavaScript.Eval(es: jsExecState; str: Putf8): jsValue;
begin
  Result := JavaScript_jsEval(es, str);
end;

class function JavaScript.EvalW(es: jsExecState; str: Pwchar_t): jsValue;
begin
  Result := JavaScript_jsEvalW(es, str);
end;

class function JavaScript.Call(es: jsExecState; func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue;
begin
  Result := JavaScript_jsCall(es, func, thisObject, args, argCount);
end;

class function JavaScript.CallGlobal(es: jsExecState; func: jsValue; args: PjsValue; argCount: Integer): jsValue;
begin
  Result := JavaScript_jsCallGlobal(es, func, args, argCount);
end;

class function JavaScript.Get(es: jsExecState; AObject: jsValue; prop: Pchar): jsValue;
begin
  Result := JavaScript_jsGet(es, AObject, prop);
end;

class procedure JavaScript._Set(es: jsExecState; AObject: jsValue; prop: Pchar; v: jsValue);
begin
  JavaScript_jsSet(es, AObject, prop, v);
end;

class function JavaScript.GetGlobal(es: jsExecState; prop: Pchar): jsValue;
begin
  Result := JavaScript_jsGetGlobal(es, prop);
end;

class procedure JavaScript.SetGlobal(es: jsExecState; prop: Pchar; v: jsValue);
begin
  JavaScript_jsSetGlobal(es, prop, v);
end;

class function JavaScript.GetAt(es: jsExecState; AObject: jsValue; index: Integer): jsValue;
begin
  Result := JavaScript_jsGetAt(es, AObject, index);
end;

class procedure JavaScript.SetAt(es: jsExecState; AObject: jsValue; index: Integer; v: jsValue);
begin
  JavaScript_jsSetAt(es, AObject, index, v);
end;

class function JavaScript.GetLength(es: jsExecState; AObject: jsValue): Integer;
begin
  Result := JavaScript_jsGetLength(es, AObject);
end;

class procedure JavaScript.SetLength(es: jsExecState; AObject: jsValue; length: Integer);
begin
  JavaScript_jsSetLength(es, AObject, length);
end;

class function JavaScript.GetWebView(es: jsExecState): wkeWebView;
begin
  Result := JavaScript_jsGetWebView(es);
end;

class procedure JavaScript.GC;
begin
  JavaScript_jsGC;
end;


//================================wkeWebView============================

procedure wkeWebView_wkeInit; external wkedll name 'wkeInit';
procedure wkeWebView_wkeShutdown; external wkedll name 'wkeShutdown';
function wkeWebView_wkeCreateWebView; external wkedll name 'wkeCreateWebView';
procedure wkeWebView_wkeDestroyWebView; external wkedll name 'wkeDestroyWebView';
function wkeWebView_wkeGetWebView; external wkedll name 'wkeGetWebView';
procedure wkeWebView_wkeUpdate; external wkedll name 'wkeUpdate';
function wkeWebView_wkeVersion; external wkedll name 'wkeVersion';
function wkeWebView_wkeVersionString; external wkedll name 'wkeVersionString';
procedure wkeWebView_wkeSetFileSystem; external wkedll name 'wkeSetFileSystem';
function wkeWebView_wkeWebViewName; external wkedll name 'wkeWebViewName';
procedure wkeWebView_wkeSetWebViewName; external wkedll name 'wkeSetWebViewName';
function wkeWebView_wkeIsTransparent; external wkedll name 'wkeIsTransparent';
procedure wkeWebView_wkeSetTransparent; external wkedll name 'wkeSetTransparent';
procedure wkeWebView_wkeLoadURL; external wkedll name 'wkeLoadURL';
procedure wkeWebView_wkeLoadURLW; external wkedll name 'wkeLoadURLW';
procedure wkeWebView_wkeLoadHTML; external wkedll name 'wkeLoadHTML';
procedure wkeWebView_wkeLoadHTMLW; external wkedll name 'wkeLoadHTMLW';
procedure wkeWebView_wkeLoadFile; external wkedll name 'wkeLoadFile';
procedure wkeWebView_wkeLoadFileW; external wkedll name 'wkeLoadFileW';
function wkeWebView_wkeIsLoaded; external wkedll name 'wkeIsLoaded';
function wkeWebView_wkeIsLoadFailed; external wkedll name 'wkeIsLoadFailed';
function wkeWebView_wkeIsLoadComplete; external wkedll name 'wkeIsLoadComplete';
function wkeWebView_wkeIsDocumentReady; external wkedll name 'wkeIsDocumentReady';
//function wkeWebView_wkeIsLoading; external wkedll name 'wkeIsLoading';
procedure wkeWebView_wkeStopLoading; external wkedll name 'wkeStopLoading';
procedure wkeWebView_wkeReload; external wkedll name 'wkeReload';
function wkeWebView_wkeTitle; external wkedll name 'wkeTitle';
function wkeWebView_wkeTitleW; external wkedll name 'wkeTitleW';
procedure wkeWebView_wkeResize; external wkedll name 'wkeResize';
function wkeWebView_wkeWidth; external wkedll name 'wkeWidth';
function wkeWebView_wkeHeight; external wkedll name 'wkeHeight';
function wkeWebView_wkeContentsWidth; external wkedll name 'wkeContentsWidth';
function wkeWebView_wkeContentsHeight; external wkedll name 'wkeContentsHeight';
procedure wkeWebView_wkeSetDirty; external wkedll name 'wkeSetDirty';
function wkeWebView_wkeIsDirty; external wkedll name 'wkeIsDirty';
procedure wkeWebView_wkeAddDirtyArea; external wkedll name 'wkeAddDirtyArea';
procedure wkeWebView_wkeLayoutIfNeeded; external wkedll name 'wkeLayoutIfNeeded';
procedure wkeWebView_wkePaint; external wkedll name 'wkePaint';
function wkeWebView_wkeCanGoBack; external wkedll name 'wkeCanGoBack';
function wkeWebView_wkeGoBack; external wkedll name 'wkeGoBack';
function wkeWebView_wkeCanGoForward; external wkedll name 'wkeCanGoForward';
function wkeWebView_wkeGoForward; external wkedll name 'wkeGoForward';
procedure wkeWebView_wkeSelectAll; external wkedll name 'wkeSelectAll';
procedure wkeWebView_wkeCopy; external wkedll name 'wkeCopy';
procedure wkeWebView_wkeCut; external wkedll name 'wkeCut';
procedure wkeWebView_wkePaste; external wkedll name 'wkePaste';
procedure wkeWebView_wkeDelete; external wkedll name 'wkeDelete';
procedure wkeWebView_wkeSetCookieEnabled; external wkedll name 'wkeSetCookieEnabled';
function wkeWebView_wkeCookieEnabled; external wkedll name 'wkeCookieEnabled';
procedure wkeWebView_wkeSetMediaVolume; external wkedll name 'wkeSetMediaVolume';
function wkeWebView_wkeMediaVolume; external wkedll name 'wkeMediaVolume';
function wkeWebView_wkeMouseEvent; external wkedll name 'wkeMouseEvent';
function wkeWebView_wkeContextMenuEvent; external wkedll name 'wkeContextMenuEvent';
function wkeWebView_wkeMouseWheel; external wkedll name 'wkeMouseWheel';
function wkeWebView_wkeKeyUp; external wkedll name 'wkeKeyUp';
function wkeWebView_wkeKeyDown; external wkedll name 'wkeKeyDown';
function wkeWebView_wkeKeyPress; external wkedll name 'wkeKeyPress';
procedure wkeWebView_wkeFocus; external wkedll name 'wkeFocus';
procedure wkeWebView_wkeUnfocus; external wkedll name 'wkeUnfocus';
function wkeWebView_wkeGetCaret; external wkedll name 'wkeGetCaret';
function wkeWebView_wkeRunJS; external wkedll name 'wkeRunJS';
function wkeWebView_wkeRunJSW; external wkedll name 'wkeRunJSW';
function wkeWebView_wkeGlobalExec; external wkedll name 'wkeGlobalExec';
procedure wkeWebView_wkeSleep; external wkedll name 'wkeSleep';
procedure wkeWebView_wkeAwaken; external wkedll name 'wkeAwaken';
function wkeWebView_wkeIsAwake; external wkedll name 'wkeIsAwake';
procedure wkeWebView_wkeSetZoomFactor; external wkedll name 'wkeSetZoomFactor';
function wkeWebView_wkeZoomFactor; external wkedll name 'wkeZoomFactor';
procedure wkeWebView_wkeSetEditable; external wkedll name 'wkeSetEditable';
procedure wkeWebView_wkeSetClientHandler; external wkedll name 'wkeSetClientHandler';
function wkeWebView_wkeGetClientHandler; external wkedll name 'wkeGetClientHandler';
function wkeWebView_wkeToString; external wkedll name 'wkeToString';
function wkeWebView_wkeToStringW; external wkedll name 'wkeToStringW';


//================================JavaScript============================


procedure JavaScript_jsBindFunction; external wkedll name 'jsBindFunction';
procedure JavaScript_jsBindGetter; external wkedll name 'jsBindGetter';
procedure JavaScript_jsBindSetter; external wkedll name 'jsBindSetter';
function JavaScript_jsArgCount; external wkedll name 'jsArgCount';
function JavaScript_jsArgType; external wkedll name 'jsArgType';
function JavaScript_jsArg; external wkedll name 'jsArg';
function JavaScript_jsTypeOf; external wkedll name 'jsTypeOf';
function JavaScript_jsIsNumber; external wkedll name 'jsIsNumber';
function JavaScript_jsIsString; external wkedll name 'jsIsString';
function JavaScript_jsIsBoolean; external wkedll name 'jsIsBoolean';
function JavaScript_jsIsObject; external wkedll name 'jsIsObject';
function JavaScript_jsIsFunction; external wkedll name 'jsIsFunction';
function JavaScript_jsIsUndefined; external wkedll name 'jsIsUndefined';
function JavaScript_jsIsNull; external wkedll name 'jsIsNull';
function JavaScript_jsIsArray; external wkedll name 'jsIsArray';
function JavaScript_jsIsTrue; external wkedll name 'jsIsTrue';
function JavaScript_jsIsFalse; external wkedll name 'jsIsFalse';
function JavaScript_jsToInt; external wkedll name 'jsToInt';
function JavaScript_jsToFloat; external wkedll name 'jsToFloat';
function JavaScript_jsToDouble; external wkedll name 'jsToDouble';
function JavaScript_jsToBoolean; external wkedll name 'jsToBoolean';
function JavaScript_jsToString; external wkedll name 'jsToString';
function JavaScript_jsToStringW; external wkedll name 'jsToStringW';
function JavaScript_jsInt; external wkedll name 'jsInt';
function JavaScript_jsFloat; external wkedll name 'jsFloat';
function JavaScript_jsDouble; external wkedll name 'jsDouble';
function JavaScript_jsBoolean; external wkedll name 'jsBoolean';
function JavaScript_jsUndefined; external wkedll name 'jsUndefined';
function JavaScript_jsNull; external wkedll name 'jsNull';
function JavaScript_jsTrue; external wkedll name 'jsTrue';
function JavaScript_jsFalse; external wkedll name 'jsFalse';
function JavaScript_jsString; external wkedll name 'jsString';
function JavaScript_jsStringW; external wkedll name 'jsStringW';
function JavaScript_jsObject; external wkedll name 'jsObject';
function JavaScript_jsArray; external wkedll name 'jsArray';
function JavaScript_jsFunction; external wkedll name 'jsFunction';
function JavaScript_jsGlobalObject; external wkedll name 'jsGlobalObject';
function JavaScript_jsEval; external wkedll name 'jsEval';
function JavaScript_jsEvalW; external wkedll name 'jsEvalW';
function JavaScript_jsCall; external wkedll name 'jsCall';
function JavaScript_jsCallGlobal; external wkedll name 'jsCallGlobal';
function JavaScript_jsGet; external wkedll name 'jsGet';
procedure JavaScript_jsSet; external wkedll name 'jsSet';
function JavaScript_jsGetGlobal; external wkedll name 'jsGetGlobal';
procedure JavaScript_jsSetGlobal; external wkedll name 'jsSetGlobal';
function JavaScript_jsGetAt; external wkedll name 'jsGetAt';
procedure JavaScript_jsSetAt; external wkedll name 'jsSetAt';
function JavaScript_jsGetLength; external wkedll name 'jsGetLength';
procedure JavaScript_jsSetLength; external wkedll name 'jsSetLength';
function JavaScript_jsGetWebView; external wkedll name 'jsGetWebView';
procedure JavaScript_jsGC; external wkedll name 'jsGC';


end.
