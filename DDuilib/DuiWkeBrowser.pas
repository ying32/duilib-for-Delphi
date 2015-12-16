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
//***************************************************************************
unit DuiWkeBrowser;

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

  // MS VC编译的默认类成员约定为__thiscall，这里模拟调用下
  // 虚函数使用反的, 超过两参数的，除p1,p2都反过来申明
  // 注意：下面的申明只能vc的 __thiscall， 如使用gcc那就得另改啰
  IWebView = class
  private
    procedure __destroy(p1, p2: Pointer); virtual; abstract;
    function __name(p1, p2: Pointer): Putf8; virtual; abstract;
    procedure __setName(p1, p2: Pointer; name: Putf8); virtual; abstract;
    function __transparent(p1, p2: Pointer): Boolean; virtual; abstract;
    procedure __setTransparent(p1, p2: Pointer; transparent: Boolean); virtual; abstract;
    procedure __loadURLA(p1, p2: Pointer; url: Putf8); virtual; abstract;
    procedure __loadURLW(p1, p2: Pointer; url: Pwchar_t); virtual; abstract;
    procedure __loadHTMLA(p1, p2: Pointer; html: Putf8); virtual; abstract;
    procedure __loadHTMLW(p1, p2: Pointer; html: Pwchar_t); virtual; abstract;
    procedure __loadFileA(p1, p2: Pointer; filename: Putf8); virtual; abstract;
    procedure __loadFileW(p1, p2: Pointer; filename: Pwchar_t); virtual; abstract;
    function __isLoaded(p1, p2: Pointer): Boolean; virtual; abstract;
    function __isLoadFailed(p1, p2: Pointer): Boolean; virtual; abstract;
    function __isLoadComplete(p1, p2: Pointer): Boolean; virtual; abstract;
    function __isDocumentReady(p1, p2: Pointer): Boolean; virtual; abstract;
    procedure __stopLoading(p1, p2: Pointer); virtual; abstract;
    procedure __reload(p1, p2: Pointer); virtual; abstract;
    function __title(p1, p2: Pointer): Putf8; virtual; abstract;
    function __titleW(p1, p2: Pointer): Pwchar_t; virtual; abstract;
    // procedure __resize(p1, p2: Pointer; w: Integer; h: Integer); virtual; abstract;
    procedure __resize(p1, p2: Pointer; h: Integer; w: Integer); virtual; abstract;
    function __width(p1, p2: Pointer): Integer; virtual; abstract;
    function __height(p1, p2: Pointer): Integer; virtual; abstract;
    function __contentsWidth(p1, p2: Pointer): Integer; virtual; abstract;
    function __contentsHeight(p1, p2: Pointer): Integer; virtual; abstract;
    procedure __setDirty(p1, p2: Pointer; dirty: Boolean); virtual; abstract;
    function __isDirty(p1, p2: Pointer): Boolean; virtual; abstract;
    // procedure __addDirtyArea(p1, p2: Pointer; x: Integer; y: Integer; w: Integer; h: Integer); virtual; abstract;
    procedure __addDirtyArea(p1, p2: Pointer; h: Integer; w: Integer; y: Integer; x: Integer); virtual; abstract;
    procedure __layoutIfNeeded(p1, p2: Pointer); virtual; abstract;
    // procedure __paint(p1, p2: Pointer; bits: PPointer; pitch: Integer); virtual; abstract;
    procedure __paint(p1, p2: Pointer; pitch: Integer; bits: PPointer); virtual; abstract;
    function __canGoBack(p1, p2: Pointer): Boolean; virtual; abstract;
    function __goBack(p1, p2: Pointer): Boolean; virtual; abstract;
    function __canGoForward(p1, p2: Pointer): Boolean; virtual; abstract;
    function __goForward(p1, p2: Pointer): Boolean; virtual; abstract;
    procedure __selectAll(p1, p2: Pointer); virtual; abstract;
    procedure __copy(p1, p2: Pointer); virtual; abstract;
    procedure __cut(p1, p2: Pointer); virtual; abstract;
    procedure __paste(p1, p2: Pointer); virtual; abstract;
    procedure __delete_(p1, p2: Pointer); virtual; abstract;
    procedure __setCookieEnabled(p1, p2: Pointer; enable: Boolean); virtual; abstract;
    function __cookieEnabled(p1, p2: Pointer): Boolean; virtual; abstract;
    procedure __setMediaVolume(p1, p2: Pointer; volume: Single); virtual; abstract;
    function __mediaVolume(p1, p2: Pointer): Single; virtual; abstract;
    // function __mouseEvent(p1, p2: Pointer; AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean; virtual; abstract;
    function __mouseEvent(p1, p2: Pointer; flags: LongInt; y, x: Integer; AMessage: LongInt): Boolean; virtual; abstract;
    // function __contextMenuEvent(p1, p2: Pointer; x: Integer; y: Integer; flags: LongInt): Boolean; virtual; abstract;
    function __contextMenuEvent(p1, p2: Pointer; flags: LongInt; y, x: Integer): Boolean; virtual; abstract;
    // function __mouseWheel(p1, p2: Pointer; x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean; virtual; abstract;
    function __mouseWheel(p1, p2: Pointer; flags: LongInt; delta, y, x: Integer): Boolean; virtual; abstract;
    // function __keyUp(p1, p2: Pointer; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; virtual; abstract;
    function __keyUp(p1, p2: Pointer; systemKey: Boolean; flags: LongInt; virtualKeyCode: LongInt): Boolean; virtual; abstract;
    // function __keyDown(p1, p2: Pointer; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; virtual; abstract;
    function __keyDown(p1, p2: Pointer; systemKey: Boolean; flags: LongInt; virtualKeyCode: LongInt): Boolean; virtual; abstract;
    // function __keyPress(p1, p2: Pointer; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; virtual; abstract;
    function __keyPress(p1, p2: Pointer; systemKey: Boolean; flags: LongInt; virtualKeyCode: LongInt): Boolean; virtual; abstract;
    procedure __focus(p1, p2: Pointer); virtual; abstract;
    procedure __unfocus(p1, p2: Pointer); virtual; abstract;
    function __getCaret(p1, p2: Pointer): wkeRect; virtual; abstract;
    function __runJSA(p1, p2: Pointer; script: Putf8): jsValue; virtual; abstract;
    function __runJSW(p1, p2: Pointer; script: Pwchar_t): jsValue; virtual; abstract;
    function __globalExec(p1, p2: Pointer): jsExecState; virtual; abstract;
    procedure __sleep(p1, p2: Pointer); virtual; abstract;
    procedure __awaken(p1, p2: Pointer); virtual; abstract;
    function __isAwake(p1, p2: Pointer): Boolean; virtual; abstract;
    procedure __setZoomFactor(p1, p2: Pointer; factor: Single); virtual; abstract;
    function __zoomFactor(p1, p2: Pointer): Single; virtual; abstract;
    procedure __setEditable(p1, p2: Pointer; editable: Boolean); virtual; abstract;
    procedure __setClientHandler(p1, p2: Pointer; handler: PwkeClientHandler); virtual; abstract;
    function __getClientHandler(p1, p2: Pointer): wkeClientHandler; virtual; abstract;
  public
    procedure destroy_;
    function name: Putf8;
    procedure setName(const AName: Putf8);
    function transparent: Boolean;
    procedure setTransparent(ATransparent: Boolean);
    procedure loadURLA(const url: Putf8);
    procedure loadURLW(const url: Pwchar_t);
    procedure loadHTMLA(const html: Putf8);
    procedure loadHTMLW(const html: Pwchar_t);
    procedure loadFileA(const filename: Putf8);
    procedure loadFileW(const filename: Pwchar_t);
    function isLoaded: Boolean;
    function isLoadFailed: Boolean;
    function isLoadComplete: Boolean;
    function isDocumentReady: Boolean;
    procedure stopLoading;
    procedure reload;
    function title: Putf8;
    function titleW: Pwchar_t;
    procedure resize(w: Integer; h: Integer);
    function width: Integer;
    function height: Integer;
    function contentsWidth: Integer;
    function contentsHeight: Integer;
    procedure setDirty(dirty: Boolean);
    function isDirty: Boolean;
    procedure addDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
    procedure layoutIfNeeded;
    procedure paint(bits: PPointer; pitch: Integer);
    function canGoBack: Boolean;
    function goBack: Boolean;
    function canGoForward: Boolean;
    function goForward: Boolean;
    procedure selectAll;
    procedure copy;
    procedure cut;
    procedure paste;
    procedure delete_;
    procedure setCookieEnabled(enable: Boolean);
    function cookieEnabled: Boolean;
    procedure setMediaVolume(volume: Single);
    function mediaVolume: Single;
    function mouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
    function contextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
    function mouseWheel(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
    function keyUp(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function keyDown(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function keyPress(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    procedure focus;
    procedure unfocus;
    function getCaret: wkeRect;
    function runJSA(script: Putf8): jsValue;
    function runJSW(script: Pwchar_t): jsValue;
    function globalExec: jsExecState;
    procedure sleep;
    procedure awaken;
    function isAwake: Boolean;
    procedure setZoomFactor(factor: Single);
    function zoomFactor: Single;
    procedure setEditable(editable: Boolean);
    procedure setClientHandler(handler: PwkeClientHandler);
    function getClientHandler: wkeClientHandler;
  end;

  wkeWebView = IWebView;

  // 是不是应该使用PAnsiChar????
  FILE_OPEN = function(path: PAnsiChar): Pointer; cdecl;
  FILE_CLOSE = procedure(handle: Pointer); cdecl;
  FILE_SIZE = function(handle: Pointer): Cardinal; cdecl;
  FILE_READ = function(handle: Pointer; buffer: Pointer; size: Cardinal): Integer; cdecl;
  FILE_SEEK = function(handle: Pointer; offset: Integer; origin: Integer): Integer; cdecl;


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

  procedure wkeInit(Handle: IWebView); cdecl;
  procedure wkeShutdown(Handle: IWebView); cdecl;
  procedure wkeUpdate(Handle: IWebView); cdecl;
  function wkeVersion(Handle: IWebView): Integer; cdecl;
  function wkeVersionString(Handle: IWebView): utf8; cdecl;
  procedure wkeSetFileSystem(Handle: IWebView; pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK); cdecl;
  function wkeCreateWebView(Handle: IWebView): wkeWebView; cdecl;
  function wkeGetWebView(Handle: IWebView; name: Pchar): wkeWebView; cdecl;
  procedure wkeDestroyWebView(Handle: IWebView; webView: wkeWebView); cdecl;
  function wkeWebViewName(Handle: IWebView; webView: wkeWebView): char; cdecl;
  procedure wkeSetWebViewName(Handle: IWebView; webView: wkeWebView; const name: Pchar); cdecl;
  function wkeIsTransparent(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeSetTransparent(Handle: IWebView; webView: wkeWebView; transparent: Boolean); cdecl;
  procedure wkeLoadURL(Handle: IWebView; webView: wkeWebView; const url: Putf8); cdecl;
  procedure wkeLoadURLW(Handle: IWebView; webView: wkeWebView; const url: Pwchar_t); cdecl;
  procedure wkeLoadHTML(Handle: IWebView; webView: wkeWebView; const html: Putf8); cdecl;
  procedure wkeLoadHTMLW(Handle: IWebView; webView: wkeWebView; const html: Pwchar_t); cdecl;
  procedure wkeLoadFile(Handle: IWebView; webView: wkeWebView; const filename: Putf8); cdecl;
  procedure wkeLoadFileW(Handle: IWebView; webView: wkeWebView; const filename: Pwchar_t); cdecl;
  function wkeIsLoaded(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeIsLoadFailed(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeIsLoadComplete(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeIsDocumentReady(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeIsLoading(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeStopLoading(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeReload(Handle: IWebView; webView: wkeWebView); cdecl;
  function wkeTitle(Handle: IWebView; webView: wkeWebView): utf8; cdecl;
  function wkeTitleW(Handle: IWebView; webView: wkeWebView): wchar_t; cdecl;
  procedure wkeResize(Handle: IWebView; webView: wkeWebView; w: Integer; h: Integer); cdecl;
  function wkeWidth(Handle: IWebView; webView: wkeWebView): Integer; cdecl;
  function wkeHeight(Handle: IWebView; webView: wkeWebView): Integer; cdecl;
  function wkeContentsWidth(Handle: IWebView; webView: wkeWebView): Integer; cdecl;
  function wkeContentsHeight(Handle: IWebView; webView: wkeWebView): Integer; cdecl;
  procedure wkeSetDirty(Handle: IWebView; webView: wkeWebView; dirty: Boolean); cdecl;
  function wkeIsDirty(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeAddDirtyArea(Handle: IWebView; webView: wkeWebView; x: Integer; y: Integer; w: Integer; h: Integer); cdecl;
  procedure wkeLayoutIfNeeded(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkePaint(Handle: IWebView; webView: wkeWebView; bits: PPointer; pitch: Integer); cdecl;
  function wkeCanGoBack(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeGoBack(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeCanGoForward(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  function wkeGoForward(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeSelectAll(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeCopy(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeCut(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkePaste(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeDelete(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeSetCookieEnabled(Handle: IWebView; webView: wkeWebView; enable: Boolean); cdecl;
  function wkeCookieEnabled(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeSetMediaVolume(Handle: IWebView; webView: wkeWebView; volume: Single); cdecl;
  function wkeMediaVolume(Handle: IWebView; webView: wkeWebView): Single; cdecl;
  function wkeMouseEvent(Handle: IWebView; webView: wkeWebView; AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
  function wkeContextMenuEvent(Handle: IWebView; webView: wkeWebView; x: Integer; y: Integer; flags: LongInt): Boolean; cdecl;
  function wkeMouseWheel(Handle: IWebView; webView: wkeWebView; x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean; cdecl;
  function wkeKeyUp(Handle: IWebView; webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
  function wkeKeyDown(Handle: IWebView; webView: wkeWebView; virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
  function wkeKeyPress(Handle: IWebView; webView: wkeWebView; charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean; cdecl;
  procedure wkeFocus(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeUnfocus(Handle: IWebView; webView: wkeWebView); cdecl;
  function wkeGetCaret(Handle: IWebView; webView: wkeWebView): wkeRect; cdecl;
  function wkeRunJS(Handle: IWebView; webView: wkeWebView; const script: Putf8): jsValue; cdecl;
  function wkeRunJSW(Handle: IWebView; webView: wkeWebView; const script: Pwchar_t): jsValue; cdecl;
  function wkeGlobalExec(Handle: IWebView; webView: wkeWebView): jsExecState; cdecl;
  procedure wkeSleep(Handle: IWebView; webView: wkeWebView); cdecl;
  procedure wkeAwaken(Handle: IWebView; webView: wkeWebView); cdecl;
  function wkeIsAwake(Handle: IWebView; webView: wkeWebView): Boolean; cdecl;
  procedure wkeSetZoomFactor(Handle: IWebView; webView: wkeWebView; factor: Single); cdecl;
  function wkeZoomFactor(Handle: IWebView; webView: wkeWebView): Single; cdecl;
  procedure wkeSetEditable(Handle: IWebView; webView: wkeWebView; editable: Boolean); cdecl;
  procedure wkeSetClientHandler(Handle: IWebView; webView: wkeWebView; const handler: PwkeClientHandler); cdecl;
  function wkeGetClientHandler(Handle: IWebView; webView: wkeWebView): wkeClientHandler; cdecl;
  function wkeToString(Handle: IWebView; AString: wkeString): utf8; cdecl;
  function wkeToStringW(Handle: IWebView; AString: wkeString): wchar_t; cdecl;


  procedure jsBindFunction(Handle: IWebView; name: Pchar; fn: jsNativeFunction; argCount: LongInt); cdecl;
  procedure jsBindGetter(Handle: IWebView; name: Pchar; fn: jsNativeFunction); cdecl;
  procedure jsBindSetter(Handle: IWebView; name: Pchar; fn: jsNativeFunction); cdecl;
  function jsArgCount(Handle: IWebView; es: jsExecState): Integer; cdecl;
  function jsArgType(Handle: IWebView; es: jsExecState; argIdx: Integer): jsType; cdecl;
  function jsArg(Handle: IWebView; es: jsExecState; argIdx: Integer): jsValue; cdecl;
  function jsTypeOf(Handle: IWebView; v: jsValue): jsType; cdecl;
  function jsIsNumber(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsString(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsBoolean(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsObject(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsFunction(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsUndefined(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsNull(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsArray(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsTrue(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsIsFalse(Handle: IWebView; v: jsValue): Boolean; cdecl;
  function jsToInt(Handle: IWebView; es: jsExecState; v: jsValue): Integer; cdecl;
  function jsToFloat(Handle: IWebView; es: jsExecState; v: jsValue): Single; cdecl;
  function jsToDouble(Handle: IWebView; es: jsExecState; v: jsValue): Double; cdecl;
  function jsToBoolean(Handle: IWebView; es: jsExecState; v: jsValue): Boolean; cdecl;
  function jsToString(Handle: IWebView; es: jsExecState; v: jsValue): utf8; cdecl;
  function jsToStringW(Handle: IWebView; es: jsExecState; v: jsValue): wchar_t; cdecl;
  function jsInt(Handle: IWebView; n: Integer): jsValue; cdecl;
  function jsFloat(Handle: IWebView; f: Single): jsValue; cdecl;
  function jsDouble(Handle: IWebView; d: Double): jsValue; cdecl;
  function jsBoolean(Handle: IWebView; b: Boolean): jsValue; cdecl;
  function jsUndefined(Handle: IWebView): jsValue; cdecl;
  function jsNull(Handle: IWebView): jsValue; cdecl;
  function jsTrue(Handle: IWebView): jsValue; cdecl;
  function jsFalse(Handle: IWebView): jsValue; cdecl;
  function jsString(Handle: IWebView; es: jsExecState; str: Putf8): jsValue; cdecl;
  function jsStringW(Handle: IWebView; es: jsExecState; str: Pwchar_t): jsValue; cdecl;
  function jsObject(Handle: IWebView; es: jsExecState): jsValue; cdecl;
  function jsArray(Handle: IWebView; es: jsExecState): jsValue; cdecl;
  function jsFunction(Handle: IWebView; es: jsExecState; fn: jsNativeFunction; argCount: LongInt): jsValue; cdecl;
  function jsGlobalObject(Handle: IWebView; es: jsExecState): jsValue; cdecl;
  function jsEval(Handle: IWebView; es: jsExecState; str: Putf8): jsValue; cdecl;
  function jsEvalW(Handle: IWebView; es: jsExecState; str: Pwchar_t): jsValue; cdecl;
  function jsCall(Handle: IWebView; es: jsExecState; func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
  function jsCallGlobal(Handle: IWebView; es: jsExecState; func: jsValue; args: PjsValue; argCount: Integer): jsValue; cdecl;
  function jsGet(Handle: IWebView; es: jsExecState; AObject: jsValue; prop: Pchar): jsValue; cdecl;
  procedure jsSet(Handle: IWebView; es: jsExecState; AObject: jsValue; prop: Pchar; v: jsValue); cdecl;
  function jsGetGlobal(Handle: IWebView; es: jsExecState; prop: Pchar): jsValue; cdecl;
  procedure jsSetGlobal(Handle: IWebView; es: jsExecState; prop: Pchar; v: jsValue); cdecl;
  function jsGetAt(Handle: IWebView; es: jsExecState; AObject: jsValue; index: Integer): jsValue; cdecl;
  procedure jsSetAt(Handle: IWebView; es: jsExecState; AObject: jsValue; index: Integer; v: jsValue); cdecl;
  function jsGetLength(Handle: IWebView; es: jsExecState; AObject: jsValue): Integer; cdecl;
  procedure jsSetLength(Handle: IWebView; es: jsExecState; AObject: jsValue; length: Integer); cdecl;
  function jsGetWebView(Handle: IWebView; es: jsExecState): wkeWebView; cdecl;
  procedure jsGC(Handle: IWebView); cdecl;

implementation

{ IWebView }

procedure IWebView.addDirtyArea(x, y, w, h: Integer);
begin
  __addDirtyArea(Self, Self, h, w, y, x);
end;

procedure IWebView.awaken;
begin
  __awaken(Self, Self);
end;

function IWebView.canGoBack: Boolean;
begin
  Result := __canGoBack(Self, Self);
end;

function IWebView.canGoForward: Boolean;
begin
  Result := __canGoForward(Self, Self);
end;

function IWebView.contentsHeight: Integer;
begin
  Result := __contentsHeight(Self, Self);
end;

function IWebView.contentsWidth: Integer;
begin
  Result := __contentsWidth(Self, Self);
end;

function IWebView.contextMenuEvent(x, y, flags: Integer): Boolean;
begin
  Result := __contextMenuEvent(Self, Self, flags, y, x);
end;

function IWebView.cookieEnabled: Boolean;
begin
  Result := __cookieEnabled(Self, Self);
end;

procedure IWebView.copy;
begin
  __copy(Self, Self);
end;

procedure IWebView.cut;
begin
  __cut(Self, Self);
end;

procedure IWebView.delete_;
begin
  __delete_(Self, Self);
end;

procedure IWebView.destroy_;
begin
  __destroy(Self, Self);
end;

procedure IWebView.focus;
begin
  __focus(Self, Self);
end;

function IWebView.getCaret: wkeRect;
begin
  Result := __getCaret(Self, Self);
end;

function IWebView.getClientHandler: wkeClientHandler;
begin
  Result := __getClientHandler(Self, Self);
end;

function IWebView.globalExec: jsExecState;
begin
  Result := __globalExec(Self, Self);
end;

function IWebView.goBack: Boolean;
begin
  Result := __goBack(Self, Self);
end;

function IWebView.goForward: Boolean;
begin
  Result := __goForward(Self, Self);
end;

function IWebView.height: Integer;
begin
  Result := __height(Self, Self);
end;

function IWebView.isAwake: Boolean;
begin
  Result := __isAwake(Self, Self);
end;

function IWebView.isDirty: Boolean;
begin
  Result := __isDirty(Self, Self);
end;

function IWebView.isDocumentReady: Boolean;
begin
  Result := __isDocumentReady(Self, Self);
end;

function IWebView.isLoadComplete: Boolean;
begin
  Result := __isLoadComplete(Self, Self);
end;

function IWebView.isLoaded: Boolean;
begin
  Result := __isLoaded(Self, Self);
end;

function IWebView.isLoadFailed: Boolean;
begin
  Result := __isLoadFailed(Self, Self);
end;

function IWebView.keyDown(virtualKeyCode, flags: Integer;
  systemKey: Boolean): Boolean;
begin
  Result := __keyDown(Self, Self, systemKey, flags, virtualKeyCode);
end;

function IWebView.keyPress(virtualKeyCode, flags: Integer;
  systemKey: Boolean): Boolean;
begin
  Result := __keyPress(Self, Self, systemKey, flags, virtualKeyCode);
end;

function IWebView.keyUp(virtualKeyCode, flags: Integer;
  systemKey: Boolean): Boolean;
begin
  Result := __keyUp(Self, Self, systemKey, flags, virtualKeyCode);
end;

procedure IWebView.layoutIfNeeded;
begin
  __layoutIfNeeded(Self, Self);
end;

procedure IWebView.loadFileA(const filename: Putf8);
begin
  __loadFileA(Self, Self, filename);
end;

procedure IWebView.loadFileW(const filename: Pwchar_t);
begin
  __loadFileW(Self, Self, filename);
end;

procedure IWebView.loadHTMLA(const html: Putf8);
begin
  __loadHTMLA(Self, Self, html);
end;

procedure IWebView.loadHTMLW(const html: Pwchar_t);
begin
  __loadHTMLW(Self, Self, html);
end;

procedure IWebView.loadURLA(const url: Putf8);
begin
  __loadURLA(Self, Self, url);
end;

procedure IWebView.loadURLW(const url: Pwchar_t);
begin
  __loadURLW(Self, Self, url);
end;

function IWebView.mediaVolume: Single;
begin
  Result := __mediaVolume(Self, Self);
end;

function IWebView.mouseEvent(AMessage, x, y, flags: Integer): Boolean;
begin
  Result := __mouseEvent(Self, Self, flags, y, x, AMessage);
end;

function IWebView.mouseWheel(x, y, delta, flags: Integer): Boolean;
begin
  Result := __mouseWheel(Self, Self, flags, delta, y, x);
end;

function IWebView.name: Putf8;
begin
  Result := __name(Self, Self);
end;

procedure IWebView.paint(bits: PPointer; pitch: Integer);
begin
  __paint(Self, Self, pitch, bits);
end;

procedure IWebView.paste;
begin
  __paste(Self, Self);
end;

procedure IWebView.reload;
begin
  __reload(Self, Self);
end;

procedure IWebView.resize(w, h: Integer);
begin
  __resize(Self, Self, h, w);
end;

function IWebView.runJSA(script: Putf8): jsValue;
begin
  Result := __runJSA(Self, Self, script);
end;

function IWebView.runJSW(script: Pwchar_t): jsValue;
begin
  Result := __runJSW(Self, Self, script);
end;

procedure IWebView.selectAll;
begin
  __selectAll(Self, Self);
end;

procedure IWebView.setClientHandler(handler: PwkeClientHandler);
begin
  __setClientHandler(Self, Self, handler);
end;

procedure IWebView.setCookieEnabled(enable: Boolean);
begin
  __setCookieEnabled(Self, Self, enable);
end;

procedure IWebView.setDirty(dirty: Boolean);
begin
  __setDirty(Self, Self, dirty);
end;

procedure IWebView.setEditable(editable: Boolean);
begin
  __setEditable(Self, Self, editable);
end;

procedure IWebView.setMediaVolume(volume: Single);
begin
  __setMediaVolume(Self,  Self, volume);
end;

procedure IWebView.setName(const AName: Putf8);
begin
  __setName(Self, Self, AName);
end;

procedure IWebView.setTransparent(ATransparent: Boolean);
begin
  __setTransparent(Self, Self, ATransparent);
end;

procedure IWebView.setZoomFactor(factor: Single);
begin
  __setZoomFactor(Self, Self, factor);
end;

procedure IWebView.sleep;
begin
  __sleep(Self, Self);
end;

procedure IWebView.stopLoading;
begin
  __stopLoading(Self, Self);
end;

function IWebView.title: Putf8;
begin
  Result := __title(Self, Self);
end;

function IWebView.titleW: Pwchar_t;
begin
  Result := __titleW(Self, Self);
end;

function IWebView.transparent: Boolean;
begin
  Result := __transparent(Self, Self);
end;

procedure IWebView.unfocus;
begin
  __unfocus(Self, Self);
end;

function IWebView.width: Integer;
begin
  Result := __width(Self, Self);
end;

function IWebView.zoomFactor: Single;
begin
  Result := __zoomFactor(Self, Self);
end;




procedure wkeInit; external wkedll name 'wkeInit';
procedure wkeShutdown; external wkedll name 'wkeShutdown';
procedure wkeUpdate; external wkedll name 'wkeUpdate';
function wkeVersion; external wkedll name 'wkeVersion';
function wkeVersionString; external wkedll name 'wkeVersionString';
procedure wkeSetFileSystem; external wkedll name 'wkeSetFileSystem';
function wkeCreateWebView; external wkedll name 'wkeCreateWebView';
function wkeGetWebView; external wkedll name 'wkeGetWebView';
procedure wkeDestroyWebView; external wkedll name 'wkeDestroyWebView';
function wkeWebViewName; external wkedll name 'wkeWebViewName';
procedure wkeSetWebViewName; external wkedll name 'wkeSetWebViewName';
function wkeIsTransparent; external wkedll name 'wkeIsTransparent';
procedure wkeSetTransparent; external wkedll name 'wkeSetTransparent';
procedure wkeLoadURL; external wkedll name 'wkeLoadURL';
procedure wkeLoadURLW; external wkedll name 'wkeLoadURLW';
procedure wkeLoadHTML; external wkedll name 'wkeLoadHTML';
procedure wkeLoadHTMLW; external wkedll name 'wkeLoadHTMLW';
procedure wkeLoadFile; external wkedll name 'wkeLoadFile';
procedure wkeLoadFileW; external wkedll name 'wkeLoadFileW';
function wkeIsLoaded; external wkedll name 'wkeIsLoaded';
function wkeIsLoadFailed; external wkedll name 'wkeIsLoadFailed';
function wkeIsLoadComplete; external wkedll name 'wkeIsLoadComplete';
function wkeIsDocumentReady; external wkedll name 'wkeIsDocumentReady';
function wkeIsLoading; external wkedll name 'wkeIsLoading';
procedure wkeStopLoading; external wkedll name 'wkeStopLoading';
procedure wkeReload; external wkedll name 'wkeReload';
function wkeTitle; external wkedll name 'wkeTitle';
function wkeTitleW; external wkedll name 'wkeTitleW';
procedure wkeResize; external wkedll name 'wkeResize';
function wkeWidth; external wkedll name 'wkeWidth';
function wkeHeight; external wkedll name 'wkeHeight';
function wkeContentsWidth; external wkedll name 'wkeContentsWidth';
function wkeContentsHeight; external wkedll name 'wkeContentsHeight';
procedure wkeSetDirty; external wkedll name 'wkeSetDirty';
function wkeIsDirty; external wkedll name 'wkeIsDirty';
procedure wkeAddDirtyArea; external wkedll name 'wkeAddDirtyArea';
procedure wkeLayoutIfNeeded; external wkedll name 'wkeLayoutIfNeeded';
procedure wkePaint; external wkedll name 'wkePaint';
function wkeCanGoBack; external wkedll name 'wkeCanGoBack';
function wkeGoBack; external wkedll name 'wkeGoBack';
function wkeCanGoForward; external wkedll name 'wkeCanGoForward';
function wkeGoForward; external wkedll name 'wkeGoForward';
procedure wkeSelectAll; external wkedll name 'wkeSelectAll';
procedure wkeCopy; external wkedll name 'wkeCopy';
procedure wkeCut; external wkedll name 'wkeCut';
procedure wkePaste; external wkedll name 'wkePaste';
procedure wkeDelete; external wkedll name 'wkeDelete';
procedure wkeSetCookieEnabled; external wkedll name 'wkeSetCookieEnabled';
function wkeCookieEnabled; external wkedll name 'wkeCookieEnabled';
procedure wkeSetMediaVolume; external wkedll name 'wkeSetMediaVolume';
function wkeMediaVolume; external wkedll name 'wkeMediaVolume';
function wkeMouseEvent; external wkedll name 'wkeMouseEvent';
function wkeContextMenuEvent; external wkedll name 'wkeContextMenuEvent';
function wkeMouseWheel; external wkedll name 'wkeMouseWheel';
function wkeKeyUp; external wkedll name 'wkeKeyUp';
function wkeKeyDown; external wkedll name 'wkeKeyDown';
function wkeKeyPress; external wkedll name 'wkeKeyPress';
procedure wkeFocus; external wkedll name 'wkeFocus';
procedure wkeUnfocus; external wkedll name 'wkeUnfocus';
function wkeGetCaret; external wkedll name 'wkeGetCaret';
function wkeRunJS; external wkedll name 'wkeRunJS';
function wkeRunJSW; external wkedll name 'wkeRunJSW';
function wkeGlobalExec; external wkedll name 'wkeGlobalExec';
procedure wkeSleep; external wkedll name 'wkeSleep';
procedure wkeAwaken; external wkedll name 'wkeAwaken';
function wkeIsAwake; external wkedll name 'wkeIsAwake';
procedure wkeSetZoomFactor; external wkedll name 'wkeSetZoomFactor';
function wkeZoomFactor; external wkedll name 'wkeZoomFactor';
procedure wkeSetEditable; external wkedll name 'wkeSetEditable';
procedure wkeSetClientHandler; external wkedll name 'wkeSetClientHandler';
function wkeGetClientHandler; external wkedll name 'wkeGetClientHandler';
function wkeToString; external wkedll name 'wkeToString';
function wkeToStringW; external wkedll name 'wkeToStringW';


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
function jsToString; external wkedll name 'jsToString';
function jsToStringW; external wkedll name 'jsToStringW';
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
function jsObject; external wkedll name 'jsObject';
function jsArray; external wkedll name 'jsArray';
function jsFunction; external wkedll name 'jsFunction';
function jsGlobalObject; external wkedll name 'jsGlobalObject';
function jsEval; external wkedll name 'jsEval';
function jsEvalW; external wkedll name 'jsEvalW';
function jsCall; external wkedll name 'jsCall';
function jsCallGlobal; external wkedll name 'jsCallGlobal';
function jsGet; external wkedll name 'jsGet';
procedure jsSet; external wkedll name 'jsSet';
function jsGetGlobal; external wkedll name 'jsGetGlobal';
procedure jsSetGlobal; external wkedll name 'jsSetGlobal';
function jsGetAt; external wkedll name 'jsGetAt';
procedure jsSetAt; external wkedll name 'jsSetAt';
function jsGetLength; external wkedll name 'jsGetLength';
procedure jsSetLength; external wkedll name 'jsSetLength';
function jsGetWebView; external wkedll name 'jsGetWebView';
procedure jsGC; external wkedll name 'jsGC';

end.
