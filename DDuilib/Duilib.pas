//***************************************************************************
//
//       名称：Duilib.pas
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       本单元由CppConvert工具自动生成于2015-11-28 17:01:00
//       版权所有 (C) 2015 ying32 All Rights Reserved
//
//       1、以C开头的都是用来桥接C++类的，理论上是不给继承，除非是c++的类
//          其中的虚函数也是不能乱写的
//
//       注：此单元现在已经改为手动编辑了，不要使用生成的直接替换
//***************************************************************************
unit Duilib;

// 根据选择禁用有些提示，最好是确定单元后再这样做
{$HINTS OFF}
{$WARN SYMBOL_DEPRECATED OFF}
{$Z4+}

interface

{$I DDuilib.inc}

uses
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Types,
  Classes,
  DateUtils,
  SysUtils;

const
{$IFNDEF UseLowVer}
  {$IFDEF DEBUG}
    DuiLibdll = 'DuiLib_ud.dll';
  {$ELSE}
    DuiLibdll = 'DuiLib_u.dll';
  {$ENDIF}
{$ELSE}
  {$IFDEF DEBUG}
    DuiLibdll = 'DuiLib_d.dll';
  {$ELSE}
    DuiLibdll = 'DuiLib.dll';
  {$ENDIF}
{$ENDIF}



  UI_WNDSTYLE_CONTAINER   = 0;
  UI_WNDSTYLE_FRAME       = WS_VISIBLE or WS_OVERLAPPEDWINDOW;
  UI_WNDSTYLE_CHILD       = WS_VISIBLE or WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN;
  UI_WNDSTYLE_DIALOG      = WS_VISIBLE or WS_POPUPWINDOW or WS_CAPTION or WS_DLGFRAME or WS_CLIPSIBLINGS or WS_CLIPCHILDREN;

  UI_WNDSTYLE_EX_FRAME    = WS_EX_WINDOWEDGE;
  UI_WNDSTYLE_EX_DIALOG   = WS_EX_TOOLWINDOW or WS_EX_DLGMODALFRAME;

  UI_CLASSSTYLE_CONTAINER  = 0;
  UI_CLASSSTYLE_FRAME      = CS_VREDRAW or CS_HREDRAW;
  UI_CLASSSTYLE_CHILD      = CS_VREDRAW or CS_HREDRAW or CS_DBLCLKS or CS_SAVEBITS;
  UI_CLASSSTYLE_DIALOG     = CS_VREDRAW or CS_HREDRAW or CS_DBLCLKS or CS_SAVEBITS;

  UILIST_MAX_COLUMNS = 32;

  XMLFILE_ENCODING_UTF8    = 0;
  XMLFILE_ENCODING_UNICODE = 1;
  XMLFILE_ENCODING_ASNI    = 2;


  /// <summary>
  ///    MAX_LOCAL_STRING_LEN = 63 + 1 + 1 + #0 = 66byte
  /// </summary>
  MAX_LOCAL_STRING_LEN = 63;

type

  CControlUI = class;
  CScrollBarUI = class;
  CTreeViewUI = class;
  
  
  SHORT = SmallInt;
  PShort = ^SHORT;
{$IFDEF UseLowVer}
  TRectF = record
    Left, Top, Right, Bottom: Single;
  end;
  {$IFNDEF FPC}
    LPVOID = Pointer;
    UINT_PTR = Cardinal;
    LPBYTE = PByte;
    LPCVOID = Pointer;
    SIZE_T = Cardinal;
    UIntPtr = Cardinal;
    LONG = Longint;
  {$ELSE}
    BOOL = LongBool;
  {$ENDIF FPC}
{$ENDIF UseLowVer}

  FINDCONTROLPROC = function(AControl: CControlUI; P: LPVOID): CControlUI; cdecl;
  TFindControlProc = FINDCONTROLPROC;
  INotifyUI = Pointer;
  IMessageFilterUI = Pointer;

  CWebBrowserEventHandler = class(TObject) end;
  ITranslateAccelerator = Pointer;
  IDialogBuilderCallback = Pointer;
  IListOwnerUI = Pointer;
  IListCallbackUI = Pointer;
  STRINGorID = type PChar;
  IDropTarget = Pointer;
  PLRESULT = ^LRESULT;
  PULVCompareFunc = function(p1, p2, p3: UINT_PTR): Integer; cdecl;

  //CDuiString = array[0..65] of Char; //  132/68 byte
  // MAX_LOCAL_STRING_LEN = 63 + 1 + 1 + #0 = 66byte
  // 这里定义为一个记录， 因为他内部返回的并不是一个指针，so，字段大小不一样了，只能改record方式来做
  PCDuiString = ^CDuiString; // 这个有点牵强吧
  CDuiString = record
    m_pstr: LPTSTR{$IFNDEF UseLowVer} deprecated 'do not use'{$ENDIF};
    // 只是用来占位用，不要使用
    m_szBuffer: array[0..MAX_LOCAL_STRING_LEN] of Char deprecated{$IFNDEF UseLowVer} 'do not use'{$ENDIF};
{$IFNDEF UseLowVer}
  public
    class operator Equal(const Lhs, Rhs : CDuiString) : Boolean; overload;
    class operator Equal(const Lhs: CDuiString; Rhs : string) : Boolean; overload;
    class operator Equal(const Lhs: string; Rhs : CDuiString) : Boolean; overload;
    class operator NotEqual(const Lhs, Rhs : CDuiString): Boolean; overload;
    class operator NotEqual(const Lhs: CDuiString; Rhs : string): Boolean; overload;
    class operator NotEqual(const Lhs: string; Rhs : CDuiString): Boolean; overload;

    class operator Implicit(const AStr: string): CDuiString; overload;
    class operator Implicit(ADuiStr: CDuiString): string; overload;
    class operator Explicit(ADuiStr: CDuiString): string;

    function ToString: string;
    function Length: Integer;
    function IsEmpty: Boolean;
{$ENDIF}
  end;

  /// <summary>
  ///  来自磁盘文件, 来自磁盘zip压缩包, 来自资源, 来自资源的zip压缩包
  /// </summary>
  UILIB_RESOURCETYPE  = (UILIB_FILE = 1, UILIB_ZIP, UILIB_RESOURCE, UILIB_ZIPRESOURCE);
  TResourceType = UILIB_RESOURCETYPE;

  EVENTTYPE_UI = (
    UIEVENT__FIRST = 1,
    UIEVENT__KEYBEGIN,
    UIEVENT_KEYDOWN,
    UIEVENT_KEYUP,
    UIEVENT_CHAR,
    UIEVENT_SYSKEY,
    UIEVENT__KEYEND,
    UIEVENT__MOUSEBEGIN,
    UIEVENT_MOUSEMOVE,
    UIEVENT_MOUSELEAVE,
    UIEVENT_MOUSEENTER,
    UIEVENT_MOUSEHOVER,
    UIEVENT_BUTTONDOWN,
    UIEVENT_BUTTONUP,
    UIEVENT_RBUTTONDOWN,
    UIEVENT_DBLCLICK,
    UIEVENT_CONTEXTMENU,
    UIEVENT_SCROLLWHEEL,
    UIEVENT__MOUSEEND,
    UIEVENT_KILLFOCUS,
    UIEVENT_SETFOCUS,
    UIEVENT_WINDOWSIZE,
    UIEVENT_SETCURSOR,
    UIEVENT_TIMER,
    UIEVENT_NOTIFY,
    UIEVENT_COMMAND,
    UIEVENT__LAST
  );
  TEventTypeUI = EVENTTYPE_UI;

  tagTEventUI = packed record
    AType: TEventTypeUI;
    pSender: CControlUI;
    dwTimestamp: DWORD;
    ptMouse: TPoint;
    chKey: Char;
    wKeyState: WORD;
    wParam: WPARAM;
    lParam: LPARAM;
  end;
  PEventUI = ^TEventUI;
  TEventUI = tagTEventUI;

  tagTFontInfo = packed record
    hFont: HFONT;
    sFontName: CDuiString;
    iSize: Integer;
    bBold: Boolean;
    bUnderline: Boolean;
    bItalic: Boolean;
    tm: TEXTMETRIC;
  end;
  PFontInfo = ^TFontInfo;
  TFontInfo = tagTFontInfo;

  tagTImageInfo = packed record
    hBitmap: HBITMAP;
    pBits: LPBYTE;
    pSrcBits: LPBYTE;
    nX: Integer;
    nY: Integer;
    bAlpha: Boolean;
    bUseHSL: Boolean;
    sResType: CDuiString;
    dwMask: DWORD;
  end;
  PImageInfo = ^TImageInfo;
  TImageInfo = tagTImageInfo;

  tagTDrawInfo = packed record
    // tagTDrawInfo();
    // tagTDrawInfo(LPCTSTR lpsz);
    // void Clear();
    sDrawString: CDuiString;
    sImageName: CDuiString;
    bLoaded: Boolean;
    pImageInfo: PImageInfo;
    rcDestOffset: TRect;
    rcBmpPart: TRect;
    rcCorner: TRect;
    uFade: Byte;
    bHole: Boolean;
    bTiledX: Boolean;
    bTiledY: Boolean;
  end;
  PDrawInfo = ^TDrawInfo;
  TDrawInfo = tagTDrawInfo;

  tagTPercentInfo = packed record
    left: Double;
    top: Double;
    right: Double;
    bottom: Double;
  end;
  PPercentInfo = ^TPercentInfo;
  TPercentInfo = tagTPercentInfo;

  tagTListInfoUI = packed record
    nColumns: Integer;
    rcColumn: array[0..UILIST_MAX_COLUMNS-1] of TRect;
    nFont: Integer;
    uTextStyle: UINT;
    rcTextPadding: TRect;
    dwTextColor: DWORD;
    dwBkColor: DWORD;
    diBk: TDrawInfo;
    bAlternateBk: Boolean;
    dwSelectedTextColor: DWORD;
    dwSelectedBkColor: DWORD;
    diSelected: TDrawInfo;
    dwHotTextColor: DWORD;
    dwHotBkColor: DWORD;
    diHot: TDrawInfo;
    dwDisabledTextColor: DWORD;
    dwDisabledBkColor: DWORD;
    diDisabled: TDrawInfo;
    dwLineColor: DWORD;
    bShowHtml: Boolean;
    bMultiExpandable: Boolean;
  end;
  PListInfoUI = ^TListInfoUI;
  TListInfoUI = tagTListInfoUI;


  TNotifyUI = packed record
    sType: CDuiString;
    sVirtualWnd: CDuiString;
    pSender: CControlUI;
    dwTimestamp: DWORD;
    ptMouse: TPoint;
    wParam: WPARAM;
    lParam: LPARAM;
  end;

  CStdStringPtrMap = class
  private
    function GetSize: Integer;
    function GetAt(iIndex: Integer): string;
  public
    class function CppCreate: CStdStringPtrMap; deprecated{$IFNDEF UseLowver} 'use Create'{$ENDIF};
    procedure CppDestroy; deprecated{$IFNDEF UseLowVer} 'use Free'{$ENDIF};
    class function Create: CStdStringPtrMap;
    procedure Free;
    procedure Resize(nSize: Integer = 83);
    function Find(key: string; optimize: Boolean = True): Pointer;
    function Insert(key: string; pData: Pointer): Boolean;
    function {$IFNDEF UseLowVer}&Set{$ELSE}_Set{$ENDIF}(key: string; pData: Pointer): Pointer;
    function Remove(key: string): Boolean;
    procedure RemoveAll;
  public
    property Items[iIndex: Integer]: string read GetAt;
    property Size: Integer read GetSize;
  end;

  tagTResInfo = packed record
    m_dwDefaultDisabledColor: DWORD;
    m_dwDefaultFontColor: DWORD;
    m_dwDefaultLinkFontColor: DWORD;
    m_dwDefaultLinkHoverFontColor: DWORD;
    m_dwDefaultSelectedBkColor: DWORD;
    m_DefaultFontInfo: TFontInfo;
    m_CustomFonts: CStdStringPtrMap;
    m_ImageHash: CStdStringPtrMap;
    m_AttrHash: CStdStringPtrMap;
    m_MultiLanguageHash: CStdStringPtrMap;
  end;
  PResInfo = ^TResInfo;
  TResInfo = tagTResInfo;

  CStdValArray = class
  private
    function GetSize: Integer;
    function GetData: Pointer;
    function GetAt(iIndex: Integer): Pointer;
  public
    class function CppCreate(iElementSize: Integer; iPreallocSize: Integer = 0): CStdValArray; deprecated{$IFNDEF UseLowVer} 'use Create'{$ENDIF};
    procedure CppDestroy; deprecated{$IFNDEF UseLowVer} 'use Free'{$ENDIF};
    class function Create(iElementSize: Integer; iPreallocSize: Integer = 0): CStdValArray;
    procedure Free;
    procedure Empty;
    function IsEmpty: Boolean;
    function Add(pData: LPCVOID): Boolean;
    function Remove(iIndex: Integer): Boolean;
  public
    property Size: Integer read GetSize;
    property Data: Pointer read GetData;
    property Items[iIndex: Integer]: Pointer read GetAt;
  end;

  CStdPtrArray = class
  private
    function GetSize: Integer;
    function GetData: Pointer;
    function GetAt(iIndex: Integer): Pointer;
    procedure _SetAt(iIndex: Integer; const Value: Pointer);
  public
    class function CppCreate: CStdPtrArray;
    procedure CppDestroy;
    procedure Empty;
    procedure Resize(iSize: Integer);
    function IsEmpty: Boolean;
    function Find(iIndex: Pointer): Integer;
    function Add(pData: Pointer): Boolean;
    function InsertAt(iIndex: Integer; pData: Pointer): Boolean;
    function Remove(iIndex: Integer): Boolean;
    function SetAt(iIndex: Integer; pData: Pointer): Boolean;
  public
    property Data: Pointer read GetData;
    property Items[iIndex: Integer]: Pointer read GetAt write _SetAt;
    property Size: Integer read GetSize;
  end;

  // 特殊来对待
  // typedef bool (*FnType)(void*);
  FnType = function(P1: Pointer): Boolean; cdecl;
  PEventSource = ^CEventSource;
  CEventSource = record
{$IFNDEF UseLowVer}
  private
{$ENDIF}
    // CStdPtrArray size = 12, CStdPtrArray三个成员
    // 不要使用这三个变量,只是用来占位用
    m_ppVoid: PPointer;
    m_nCount: Integer;
    m_nAllocated: Integer;
{$IFNDEF UseLowVer}
  public
    /// <summary>
    ///   m_aDelegates: CStdPtrArray;
    ///   此时指向了变量的首地址，所就是返回了一个CStdPtrArray的指针
    /// </summary>
    function Delegates: CStdPtrArray; inline;
  public
    //  operator bool();
    function IsEmpty: Boolean; inline;
    //  void operator+= (const CDelegateBase& d); // add const for gcc
    //  void operator+= (FnType pFn);
    //  void operator-= (const CDelegateBase& d);
    //  void operator-= (FnType pFn);
    //  bool operator() (void* param);
    // function (param: Pointer): Boolean;
{$ENDIF}
  end;


  CNotifyPump = class
  public
    class function CppCreate: CNotifyPump;
    procedure CppDestroy;
    function AddVirtualWnd(strName: string; pObject: CNotifyPump): Boolean;
    function RemoveVirtualWnd(strName: string): Boolean;
    procedure NotifyPump(var msg: TNotifyUI);
    function LoopDispatch(var msg: TNotifyUI): Boolean;
  end;

  CMarkupNode = class
  public
    class function CppCreate: CMarkupNode;
    procedure CppDestroy;
    function IsValid: Boolean;
    function GetParent: CMarkupNode;
    function GetSibling: CMarkupNode;
    function GetChild: CMarkupNode; overload;
    function GetChild(pstrName: string): CMarkupNode; overload;
    function HasSiblings: Boolean;
    function HasChildren: Boolean;
    function GetName: string;
    function GetValue: string;
    function HasAttributes: Boolean;
    function HasAttribute(pstrName: string): Boolean;
    function GetAttributeCount: Integer;
    function GetAttributeName(iIndex: Integer): string;
    function GetAttributeValue(iIndex: Integer): string; overload;
    function GetAttributeValue(pstrName: string): string; overload;
    function GetAttributeValue(iIndex: Integer; pstrValue: string; cchMax: SIZE_T): Boolean; overload;
    function GetAttributeValue(pstrName: string; pstrValue: string; cchMax: SIZE_T): Boolean; overload;
  public
    property Parent: CMarkupNode read GetParent;
    property Sibling: CMarkupNode read GetSibling;
    property Name: string read GetName;
    property Value: string read GetValue;
    property AttributeCount: Integer read GetAttributeCount;
    property AttributeName[iIndex: Integer]: string read GetAttributeName;
  end;

  CMarkup = class
  public
    class function CppCreate(pstrXML: string = ''): CMarkup;
    procedure CppDestroy;
    function Load(pstrXML: string): Boolean;
    function LoadFromMem(pByte: PByte; dwSize: DWORD; encoding: Integer = XMLFILE_ENCODING_UTF8): Boolean;
    function LoadFromFile(pstrFilename: string; encoding: Integer = XMLFILE_ENCODING_UTF8): Boolean;
    procedure Release;
    function IsValid: Boolean;
    procedure SetPreserveWhitespace(bPreserve: Boolean = True);
    procedure GetLastErrorMessage(pstrMessage: string; cchMax: SIZE_T);
    procedure GetLastErrorLocation(pstrSource: string; cchMax: SIZE_T);
    function GetRoot: CMarkupNode;
  public
    property Valid: Boolean read IsValid;
    property Root: CMarkupNode read GetRoot;
  end;

  CPaintManagerUI = class
  public
    class function CppCreate: CPaintManagerUI;
    procedure CppDestroy;
    procedure Init(hWnd: HWND; pstrName: string = '');
    function IsUpdateNeeded: Boolean;
    procedure NeedUpdate;
    procedure Invalidate; overload;
    procedure Invalidate(const rcItem: TRect); overload;
    function GetPaintDC: HDC;
    function GetPaintWindow: HWND;
    function GetTooltipWindow: HWND;
    function GetMousePos: TPoint;
    function GetClientSize: TSize;
    function GetInitSize: TSize;
    procedure SetInitSize(cx: Integer; cy: Integer);
    function GetSizeBox: TRect;
    procedure SetSizeBox(const rcSizeBox: TRect);
    function GetCaptionRect: TRect;
    procedure SetCaptionRect(const rcCaption: TRect);
    function GetRoundCorner: TSize;
    procedure SetRoundCorner(cx: Integer; cy: Integer);
    function GetMinInfo: TSize;
    procedure SetMinInfo(cx: Integer; cy: Integer);
    function GetMaxInfo: TSize;
    procedure SetMaxInfo(cx: Integer; cy: Integer);
    function IsShowUpdateRect: Boolean;
    procedure SetShowUpdateRect(show: Boolean);
    class function GetInstance: HINST;
    class function GetInstancePath: string;
    class function GetCurrentPath: string;
    class function GetResourceDll: HINST;
    class function GetResourcePath: string;
    class function GetResourceZip: string;
    class function IsCachedResourceZip: Boolean;
    class function GetResourceZipHandle: THandle;
    class procedure SetInstance(hInst: HINST);
    class procedure SetCurrentPath(pStrPath: string);
    class procedure SetResourceDll(hInst: HINST);
    class procedure SetResourcePath(pStrPath: string);
    class procedure SetResourceZip(pVoid: Pointer; len: LongInt); overload;
    class procedure SetResourceZip(pstrZip: string; bCachedResourceZip: Boolean = False); overload;
    class function GetHSL(H: PShort; S: PShort; L: PShort): Boolean;
    class procedure ReloadSkin;
    class function LoadPlugin(pstrModuleName: string): Boolean;
    class function GetPlugins: CStdPtrArray;
    function IsForceUseSharedRes: Boolean;
    procedure SetForceUseSharedRes(bForce: Boolean);
    function IsPainting: Boolean;
    procedure SetPainting(bIsPainting: Boolean);
    function GetDefaultDisabledColor: DWORD;
    procedure SetDefaultDisabledColor(dwColor: DWORD; bShared: Boolean = False);
    function GetDefaultFontColor: DWORD;
    procedure SetDefaultFontColor(dwColor: DWORD; bShared: Boolean = False);
    function GetDefaultLinkFontColor: DWORD;
    procedure SetDefaultLinkFontColor(dwColor: DWORD; bShared: Boolean = False);
    function GetDefaultLinkHoverFontColor: DWORD;
    procedure SetDefaultLinkHoverFontColor(dwColor: DWORD; bShared: Boolean = False);
    function GetDefaultSelectedBkColor: DWORD;
    procedure SetDefaultSelectedBkColor(dwColor: DWORD; bShared: Boolean = False);
    function GetDefaultFontInfo: PFontInfo;
    procedure SetDefaultFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean = False);
    function GetCustomFontCount(bShared: Boolean = False): DWORD;
    function AddFont(id: Integer; pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean = False): HFONT;
    function GetFont(id: Integer): HFONT; overload;
    function GetFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean): HFONT; overload;
    function GetFontIndex(hFont: HFONT; bShared: Boolean = False): Integer; overload;
    function GetFontIndex(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean = False): Integer; overload;
    procedure RemoveFont(hFont: HFONT; bShared: Boolean = False); overload;
    procedure RemoveFont(id: Integer; bShared: Boolean = False); overload;
    procedure RemoveAllFonts(bShared: Boolean = False);
    function GetFontInfo(id: Integer): PFontInfo; overload;
    function GetFontInfo(hFont: HFONT): PFontInfo; overload;
    function GetImage(bitmap: string): PImageInfo;
    function GetImageEx(bitmap: string; AType: string = ''; mask: DWORD = 0; bUseHSL: Boolean = False): PImageInfo;
    function AddImage(bitmap: string; AType: string = ''; mask: DWORD = 0; bUseHSL: Boolean = False; bShared: Boolean = False): PImageInfo; overload;
    function AddImage(bitmap: string; hBitmap: HBITMAP; iWidth: Integer; iHeight: Integer; bAlpha: Boolean; bShared: Boolean = False): PImageInfo; overload;
    procedure RemoveImage(bitmap: string; bShared: Boolean = False);
    procedure RemoveAllImages(bShared: Boolean = False);
    class procedure ReloadSharedImages;
    procedure ReloadImages;
    procedure AddDefaultAttributeList(pStrControlName: string; pStrControlAttrList: string; bShared: Boolean = False);
    function GetDefaultAttributeList(pStrControlName: string): string;
    function RemoveDefaultAttributeList(pStrControlName: string; bShared: Boolean = False): Boolean;
    procedure RemoveAllDefaultAttributeList(bShared: Boolean = False);
    class procedure AddMultiLanguageString(id: Integer; pStrMultiLanguage: string);
    class function GetMultiLanguageString(id: Integer): string;
    class function RemoveMultiLanguageString(id: Integer): Boolean;
    class procedure RemoveAllMultiLanguageString;
    class procedure ProcessMultiLanguageTokens(var pStrMultiLanguage: string);
    function AttachDialog(pControl: CControlUI): Boolean;
    function InitControls(pControl: CControlUI; pParent: CControlUI = nil): Boolean;
    procedure ReapObjects(pControl: CControlUI);
    function AddOptionGroup(pStrGroupName: string; pControl: CControlUI): Boolean;
    function GetOptionGroup(pStrGroupName: string): CStdPtrArray;
    procedure RemoveOptionGroup(pStrGroupName: string; pControl: CControlUI);
    procedure RemoveAllOptionGroups;
    function GetFocus: CControlUI;
    procedure SetFocus(pControl: CControlUI; bFocusWnd: Boolean = True);
    procedure SetFocusNeeded(pControl: CControlUI);
    function SetNextTabControl(bForward: Boolean = True): Boolean;
    function SetTimer(pControl: CControlUI; nTimerID: UINT; uElapse: UINT): Boolean;
    function KillTimer(pControl: CControlUI; nTimerID: UINT): Boolean; overload;
    procedure KillTimer(pControl: CControlUI); overload;
    procedure RemoveAllTimers;
    procedure SetCapture;
    procedure ReleaseCapture;
    function IsCaptured: Boolean;
    function AddNotifier(pControl: INotifyUI): Boolean;
    function RemoveNotifier(pControl: INotifyUI): Boolean;
    procedure SendNotify(const Msg: TNotifyUI; bAsync: Boolean = False; bEnableRepeat: Boolean = True); overload;
    procedure SendNotify(pControl: CControlUI; pstrMessage: string; wParam: WPARAM = 0; lParam: LPARAM = 0; bAsync: Boolean = False; bEnableRepeat: Boolean = True); overload;
    function AddPreMessageFilter(pFilter: IMessageFilterUI): Boolean;
    function RemovePreMessageFilter(pFilter: IMessageFilterUI): Boolean;
    function AddMessageFilter(pFilter: IMessageFilterUI): Boolean;
    function RemoveMessageFilter(pFilter: IMessageFilterUI): Boolean;
    function GetPostPaintCount: Integer;
    function AddPostPaint(pControl: CControlUI): Boolean;
    function RemovePostPaint(pControl: CControlUI): Boolean;
    function SetPostPaintIndex(pControl: CControlUI; iIndex: Integer): Boolean;
    function GetNativeWindowCount: Integer;
    function AddNativeWindow(pControl: CControlUI; hChildWnd: HWND): Boolean;
    function RemoveNativeWindow(hChildWnd: HWND): Boolean;
    procedure AddDelayedCleanup(pControl: CControlUI);
    function AddTranslateAccelerator(pTranslateAccelerator: ITranslateAccelerator): Boolean;
    function RemoveTranslateAccelerator(pTranslateAccelerator: ITranslateAccelerator): Boolean;
    function TranslateAccelerator(pMsg: PMsg): Boolean;
    function GetRoot: CControlUI;
    function FindControl(pt: TPoint): CControlUI; overload;
    function FindControl(pstrName: string): CControlUI; overload;
    function FindSubControlByPoint(pParent: CControlUI; pt: TPoint): CControlUI;
    function FindSubControlByName(pParent: CControlUI; pstrName: string): CControlUI;
    function FindSubControlByClass(pParent: CControlUI; pstrClass: string; iIndex: Integer = 0): CControlUI;
    function FindSubControlsByClass(pParent: CControlUI; pstrClass: string): CStdPtrArray;
    class procedure MessageLoop;
    class function TranslateMessage(const pMsg: PMsg): Boolean;
    class procedure Term;
    function MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean;
    function PreMessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean;
    procedure UsedVirtualWnd(bUsed: Boolean);
    function GetName: string;
    function GetTooltipWindowWidth: Integer;
    procedure SetTooltipWindowWidth(iWidth: Integer);
    function GetHoverTime: Integer;
    procedure SetHoverTime(iTime: Integer);
    function GetOpacity: Byte;
    procedure SetOpacity(nOpacity: Byte);
    function IsLayered: Boolean;
    procedure SetLayered(bLayered: Boolean);
    function GetLayeredInset: TRect;
    procedure SetLayeredInset(const rcLayeredInset: TRect);
    function GetLayeredOpacity: Byte;
    procedure SetLayeredOpacity(nOpacity: Byte);
    function GetLayeredImage: string;
    procedure SetLayeredImage(pstrImage: string);
    class function GetPaintManager(pstrName: string): CPaintManagerUI;
    class function GetPaintManagers: CStdPtrArray;
    procedure AddWindowCustomAttribute(pstrName: string; pstrAttr: string);
    function GetWindowCustomAttribute(pstrName: string): string;
    function RemoveWindowCustomAttribute(pstrName: string): Boolean;
    procedure RemoveAllWindowCustomAttribute;
  public
    property Name: string read GetName;
  	property ForceUseSharedRes: Boolean read IsForceUseSharedRes write SetForceUseSharedRes;
    property Painting: Boolean read IsPainting write SetPainting;
    property LayeredImage: string read GetLayeredImage write SetLayeredImage;
    property LayeredOpacity: Byte read GetLayeredOpacity write SetLayeredOpacity;
    property LayeredInset: TRect read GetLayeredInset write SetLayeredInset;
    property Layered: Boolean read IsLayered write SetLayered;
    property Opacity: Byte read GetOpacity write SetOpacity;
    property HoverTime: Integer read GetHoverTime write SetHoverTime;
    property TooltipWindowWidth: Integer read GetTooltipWindowWidth write SetTooltipWindowWidth;
  end;

  CDialogBuilder = class
  public
    class function CppCreate: CDialogBuilder; //deprecated 'use Create';
    procedure CppDestroy; //deprecated 'use Free';
    function Create(xml: string; AType: string = ''; pCallback: IDialogBuilderCallback = nil; pManager: CPaintManagerUI = nil; pParent: CControlUI = nil): CControlUI; overload;
    function Create(pCallback: IDialogBuilderCallback = nil; pManager: CPaintManagerUI = nil; pParent: CControlUI = nil): CControlUI; overload;
    function GetMarkup: CMarkup;
    procedure GetLastErrorMessage(pstrMessage: string; cchMax: SIZE_T);
    procedure GetLastErrorLocation(pstrSource: string; cchMax: SIZE_T);
  public
    property Markup: CMarkup read GetMarkup;
  end;

  CControlUI = class
  {$IFNDEF UseLowVer}strict {$ENDIF}private
    // 占位用
    ____: Pointer;
  public
    // 根据c++初始化的规则，此时对应的地址会被填充到变量中
    OnInit: CEventSource;
    OnDestroy: CEventSource;
    OnSize: CEventSource;
    OnEvent: CEventSource;
    OnNotify: CEventSource;
    OnPaint: CEventSource;
    OnPostPaint: CEventSource;
  public
    class function CppCreate: CControlUI;
    procedure CppDestroy;
    function GetName: string;
    procedure SetName(pstrName: string);
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function GetNativeWindow: HWND;
    function Activate: Boolean;
    function GetManager: CPaintManagerUI;
    procedure SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean = True);
    function GetParent: CControlUI;
    function GetText: string;
    procedure SetText(pstrText: string);
    function GetBkColor: DWORD;
    procedure SetBkColor(dwBackColor: DWORD);
    function GetBkColor2: DWORD;
    procedure SetBkColor2(dwBackColor: DWORD);
    function GetBkColor3: DWORD;
    procedure SetBkColor3(dwBackColor: DWORD);
    function GetBkImage: string;
    procedure SetBkImage(pStrImage: string);
    function GetFocusBorderColor: DWORD;
    procedure SetFocusBorderColor(dwBorderColor: DWORD);
    function IsColorHSL: Boolean;
    procedure SetColorHSL(bColorHSL: Boolean);
    function GetBorderRound: TSize;
    procedure SetBorderRound(cxyRound: TSize);
    function DrawImage(hDC: HDC; var drawInfo: TDrawInfo): Boolean;
    function GetBorderColor: DWORD;
    procedure SetBorderColor(dwBorderColor: DWORD);
    function GetBorderSize: TRect;
    procedure SetBorderSize(rc: TRect); overload;
    procedure SetBorderSize(iSize: Integer); overload;
    function GetBorderStyle: Integer;
    procedure SetBorderStyle(nStyle: Integer);
    function GetPos: TRect;
    function GetRelativePos: TRect;
    function GetClientPos: TRect;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetX: Integer;
    function GetY: Integer;
    function GetPadding: TRect;
    procedure SetPadding(rcPadding: TRect);
    function GetFixedXY: TSize;
    procedure SetFixedXY(szXY: TSize);
    function GetFixedWidth: Integer;
    procedure SetFixedWidth(cx: Integer);
    function GetFixedHeight: Integer;
    procedure SetFixedHeight(cy: Integer);
    function GetMinWidth: Integer;
    procedure SetMinWidth(cx: Integer);
    function GetMaxWidth: Integer;
    procedure SetMaxWidth(cx: Integer);
    function GetMinHeight: Integer;
    procedure SetMinHeight(cy: Integer);
    function GetMaxHeight: Integer;
    procedure SetMaxHeight(cy: Integer);
    function GetFloatPercent: TPercentInfo;
    procedure SetFloatPercent(piFloatPercent: TPercentInfo);
    function GetToolTip: string;
    procedure SetToolTip(pstrText: string);
    procedure SetToolTipWidth(nWidth: Integer);
    function GetToolTipWidth: Integer;
    function GetShortcut: Char;
    procedure SetShortcut(ch: Char);
    function IsContextMenuUsed: Boolean;
    procedure SetContextMenuUsed(bMenuUsed: Boolean);
    function GetUserData: string;
    procedure SetUserData(pstrText: string);
    function GetTag: UINT_PTR;
    procedure SetTag(pTag: UINT_PTR);
    function IsVisible: Boolean;
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetInternVisible(bVisible: Boolean = True);
    function IsEnabled: Boolean;
    procedure SetEnabled(bEnable: Boolean = True);
    function IsMouseEnabled: Boolean;
    procedure SetMouseEnabled(bEnable: Boolean = True);
    function IsKeyboardEnabled: Boolean;
    procedure SetKeyboardEnabled(bEnable: Boolean = True);
    function IsFocused: Boolean;
    procedure SetFocus;
    function IsFloat: Boolean;
    procedure SetFloat(bFloat: Boolean = True);
    procedure AddCustomAttribute(pstrName: string; pstrAttr: string);
    function GetCustomAttribute(pstrName: string): string;
    function RemoveCustomAttribute(pstrName: string): Boolean;
    procedure RemoveAllCustomAttribute;
    function FindControl(Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI;
    procedure Invalidate;
    function IsUpdateNeeded: Boolean;
    procedure NeedUpdate;
    procedure NeedParentUpdate;
    function GetAdjustColor(dwColor: DWORD): DWORD;
    procedure Init;
    procedure DoInit;
    procedure Event(var AEvent: TEventUI);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    function ApplyAttributeList(pstrList: string): CControlUI;
    function EstimateSize(szAvailable: TSize): TSize;
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure Paint(hDC: HDC; var rcPaint: TRect);
    procedure PaintBkColor(hDC: HDC);
    procedure PaintBkImage(hDC: HDC);
    procedure PaintStatusImage(hDC: HDC);
    procedure PaintText(hDC: HDC);
    procedure PaintBorder(hDC: HDC);
    procedure DoPostPaint(hDC: HDC; var rcPaint: TRect);
    procedure SetVirtualWnd(pstrValue: string);
    function GetVirtualWnd: string;
    function ClassName: string;
  public
    procedure Hide;
    procedure Show;
  public
    property Attribute[AName: string]: string write SetAttribute;
    property ControlFlags: UINT read GetControlFlags;
    property X: Integer read GetX;
    property Y: Integer read GetY;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Text: string read GetText write SetText;
    property ToolTip: string read GetToolTip write SetToolTip;
    property ToolTipWidth: Integer read GetToolTipWidth write SetToolTipWidth;
    property Name: string read GetName write SetName;
    property Enabled: Boolean read IsEnabled write SetEnabled;
    property Parent: CControlUI read GetParent;
    property BkColor: DWORD read GetBkColor write SetBkColor;
    property BkColor2: DWORD read GetBkColor2 write SetBkColor2;
    property BkColor3: DWORD read GetBkColor3 write SetBkColor3;
    property BkImage: string read GetBkImage write SetBkImage;
    property FocusBorderColor: DWORD read GetFocusBorderColor write SetFocusBorderColor;
    property ColorHSL: Boolean read IsColorHSL write SetColorHSL;
    property BorderRound: TSize read GetBorderRound write SetBorderRound;
    property Shortcut: Char read GetShortcut write SetShortcut;
    property ContextMenuUsed: Boolean read IsContextMenuUsed write SetContextMenuUsed;
    property VirtualWnd: string read GetVirtualWnd write SetVirtualWnd;
    property Visible: Boolean read IsVisible write SetVisible;
    property Tag: UIntPtr read GetTag write SetTag;
    property FixedHeight: Integer read GetFixedHeight write SetFixedHeight;
  end;

  CDelphi_WindowImplBase = class
  public
    class function CppCreate: CDelphi_WindowImplBase;
    procedure CppDestroy;
    function GetHWND: HWND;
    function RegisterWindowClass: Boolean;
    function RegisterSuperclass: Boolean;
    function Create(hwndParent: HWND; pstrName: string; dwStyle: DWORD; dwExStyle: DWORD; const rc: TRect; hMenu: HMENU = 0): HWND; overload;
    function Create(hwndParent: HWND; pstrName: string; dwStyle: DWORD; dwExStyle: DWORD; x: Integer = Integer(CW_USEDEFAULT); y: Integer = Integer(CW_USEDEFAULT); cx: Integer = Integer(CW_USEDEFAULT); cy: Integer = Integer(CW_USEDEFAULT); hMenu: HMENU = 0): HWND; overload;
    function CreateDuiWindow(hwndParent: HWND; pstrWindowName: string; dwStyle: DWORD = 0; dwExStyle: DWORD = 0): HWND;
    function Subclass(hWnd: HWND): HWND;
    procedure Unsubclass;
    procedure ShowWindow(bShow: Boolean = True; bTakeFocus: Boolean = True);
    function ShowModal: UINT;
    procedure Close(nRet: UINT = IDOK);
    procedure CenterWindow;
    procedure SetIcon(nRes: UINT);
    function SendMessage(uMsg: UINT; wParam: WPARAM = 0; lParam: LPARAM = 0): LRESULT;
    function PostMessage(uMsg: UINT; wParam: WPARAM = 0; lParam: LPARAM = 0): LRESULT;
    procedure ResizeClient(cx: Integer = -1; cy: Integer = -1);
    function AddVirtualWnd(strName: string; pObject: CNotifyPump): Boolean;
    function RemoveVirtualWnd(strName: string): Boolean;
    procedure NotifyPump(var msg: TNotifyUI);
    function LoopDispatch(var msg: TNotifyUI): Boolean;
    function GetPaintManagerUI: CPaintManagerUI;
    procedure SetDelphiSelf(ASelf: Pointer);
    procedure SetClassName(AClassName: string);
    procedure SetSkinFile(SkinFile: string);
    procedure SetSkinFolder(SkinFolder: string);
    procedure SetZipFileName(ZipFileName: string);
    procedure SetResourceType(RType: TResourceType);
    procedure SetInitWindow(Callback: Pointer);
    procedure SetFinalMessage(Callback: Pointer);
    procedure SetHandleMessage(Callback: Pointer);
    procedure SetNotify(Callback: Pointer);
    procedure SetClick(Callback: Pointer);
    procedure SetMessageHandler(Callback: Pointer);
    procedure SetHandleCustomMessage(Callback: Pointer);
    procedure SetCreateControl(CallBack: Pointer);
    procedure SetGetItemText(ACallBack: Pointer);
    procedure SetGetClassStyle(uStyle: UINT);
    procedure RemoveThisInPaintManager;
    procedure SetResponseDefaultKeyEvent(ACallBack: LPVOID);
  end;

  CContainerUI = class(CControlUI)
  public
    class function CppCreate: CContainerUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetItemAt(iIndex: Integer): CControlUI;
    function GetItemIndex(pControl: CControlUI): Integer;
    function SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
    function GetCount: Integer;
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    function RemoveAt(iIndex: Integer): Boolean;
    procedure RemoveAll;
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetInternVisible(bVisible: Boolean = True);
    procedure SetMouseEnabled(bEnable: Boolean = True);
    function GetInset: TRect;
    procedure SetInset(rcInset: TRect);
    function GetChildPadding: Integer;
    procedure SetChildPadding(iPadding: Integer);
    function IsAutoDestroy: Boolean;
    procedure SetAutoDestroy(bAuto: Boolean);
    function IsDelayedDestroy: Boolean;
    procedure SetDelayedDestroy(bDelayed: Boolean);
    function IsMouseChildEnabled: Boolean;
    procedure SetMouseChildEnabled(bEnable: Boolean = True);
    function FindSelectable(iIndex: Integer; bForward: Boolean = True): Integer;
    function GetClientPos: TRect;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean = True);
    function FindControl(Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI;
    function SetSubControlText(pstrSubControlName: string; pstrText: string): Boolean;
    function SetSubControlFixedHeight(pstrSubControlName: string; cy: Integer): Boolean;
    function SetSubControlFixedWdith(pstrSubControlName: string; cx: Integer): Boolean;
    function SetSubControlUserData(pstrSubControlName: string; pstrText: string): Boolean;
    function GetSubControlText(pstrSubControlName: string): string;
    function GetSubControlFixedHeight(pstrSubControlName: string): Integer;
    function GetSubControlFixedWdith(pstrSubControlName: string): Integer;
    function GetSubControlUserData(pstrSubControlName: string): string;
    function FindSubControl(pstrSubControlName: string): CControlUI;
    function GetScrollPos: TSize;
    function GetScrollRange: TSize;
    procedure SetScrollPos(szPos: TSize);
    procedure LineUp;
    procedure LineDown;
    procedure PageUp;
    procedure PageDown;
    procedure HomeUp;
    procedure EndDown;
    procedure LineLeft;
    procedure LineRight;
    procedure PageLeft;
    procedure PageRight;
    procedure HomeLeft;
    procedure EndRight;
    procedure EnableScrollBar(bEnableVertical: Boolean = True; bEnableHorizontal: Boolean = False);
    function GetVerticalScrollBar: CScrollBarUI;
    function GetHorizontalScrollBar: CScrollBarUI;
  private
    function GetLastItem: CControlUI;
    procedure _SetItemIndex(pControl: CControlUI; const Value: Integer);
  public
    property Count: Integer read GetCount;
    property ChildPadding: Integer read GetChildPadding write SetChildPadding;
    property Items[iIndex: Integer]: CControlUI read GetItemAt;
    property ItemIndex[pControl: CControlUI]: Integer read GetItemIndex write _SetItemIndex;
    property LastItem: CControlUI read GetLastItem;
    property Inset: TRect read GetInset write SetInset;
    property AutoDestroy: Boolean read IsAutoDestroy write SetAutoDestroy;
    property DelayedDestroy: Boolean read IsDelayedDestroy write SetDelayedDestroy;
    property MouseChildEnabled: Boolean read IsMouseChildEnabled write SetMouseChildEnabled;
    property ScrollPos: TSize read GetScrollPos write SetScrollPos;
    property ScrollRange: TSize read GetScrollRange;
  end;

  CVerticalLayoutUI = class(CContainerUI)
  public
    class function CppCreate: CVerticalLayoutUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    procedure SetSepHeight(iHeight: Integer);
    function GetSepHeight: Integer;
    procedure SetSepImmMode(bImmediately: Boolean);
    function IsSepImmMode: Boolean;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure DoPostPaint(hDC: HDC; var rcPaint: TRect);
    function GetThumbRect(bUseNew: Boolean = False): TRect;
  public
    property SepImmMode: Boolean read IsSepImmMode write SetSepImmMode;
    property SepHeight: Integer read GetSepHeight write SetSepHeight;
  end;

  CHorizontalLayoutUI = class(CContainerUI)
  public
    class function CppCreate: CHorizontalLayoutUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    procedure SetSepWidth(iWidth: Integer);
    function GetSepWidth: Integer;
    procedure SetSepImmMode(bImmediately: Boolean);
    function IsSepImmMode: Boolean;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure DoPostPaint(hDC: HDC; var rcPaint: TRect);
    function GetThumbRect(bUseNew: Boolean = False): TRect;
  end;

  CListHeaderUI = class(CHorizontalLayoutUI)
  public
    class function CppCreate: CListHeaderUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function EstimateSize(szAvailable: TSize): TSize;
  end;

  CListUI = class(CVerticalLayoutUI)
  public
    class function CppCreate: CListUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetControlFlags: UINT;
    function GetInterface(pstrName: string): Pointer;
    function GetScrollSelect: Boolean;
    procedure SetScrollSelect(bScrollSelect: Boolean);
    function GetCurSel: Integer;
    function SelectItem(iIndex: Integer; bTakeFocus: Boolean = False; bTriggerEvent: Boolean = True): Boolean;
    function GetHeader: CListHeaderUI;
    function GetList: CContainerUI;
    function GetListInfo: PListInfoUI;
    function GetItemAt(iIndex: Integer): CControlUI;
    function GetItemIndex(pControl: CControlUI): Integer;
    function SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
    function GetCount: Integer;
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    function RemoveAt(iIndex: Integer): Boolean;
    procedure RemoveAll;
    procedure EnsureVisible(iIndex: Integer);
    procedure Scroll(dx: Integer; dy: Integer);
    function GetChildPadding: Integer;
    procedure SetChildPadding(iPadding: Integer);
    procedure SetItemFont(index: Integer);
    procedure SetItemTextStyle(uStyle: UINT);
    procedure SetItemTextPadding(rc: TRect);
    procedure SetItemTextColor(dwTextColor: DWORD);
    procedure SetItemBkColor(dwBkColor: DWORD);
    procedure SetItemBkImage(pStrImage: string);
    function IsAlternateBk: Boolean;
    procedure SetAlternateBk(bAlternateBk: Boolean);
    procedure SetSelectedItemTextColor(dwTextColor: DWORD);
    procedure SetSelectedItemBkColor(dwBkColor: DWORD);
    procedure SetSelectedItemImage(pStrImage: string);
    procedure SetHotItemTextColor(dwTextColor: DWORD);
    procedure SetHotItemBkColor(dwBkColor: DWORD);
    procedure SetHotItemImage(pStrImage: string);
    procedure SetDisabledItemTextColor(dwTextColor: DWORD);
    procedure SetDisabledItemBkColor(dwBkColor: DWORD);
    procedure SetDisabledItemImage(pStrImage: string);
    procedure SetItemLineColor(dwLineColor: DWORD);
    function IsItemShowHtml: Boolean;
    procedure SetItemShowHtml(bShowHtml: Boolean = True);
    function GetItemTextPadding: TRect;
    function GetItemTextColor: DWORD;
    function GetItemBkColor: DWORD;
    function GetItemBkImage: string;
    function GetSelectedItemTextColor: DWORD;
    function GetSelectedItemBkColor: DWORD;
    function GetSelectedItemImage: string;
    function GetHotItemTextColor: DWORD;
    function GetHotItemBkColor: DWORD;
    function GetHotItemImage: string;
    function GetDisabledItemTextColor: DWORD;
    function GetDisabledItemBkColor: DWORD;
    function GetDisabledItemImage: string;
    function GetItemLineColor: DWORD;
    procedure SetMultiExpanding(bMultiExpandable: Boolean);
    function GetExpandedItem: Integer;
    function ExpandItem(iIndex: Integer; bExpand: Boolean = True): Boolean;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    function GetTextCallback: IListCallbackUI;
    procedure SetTextCallback(pCallback: IListCallbackUI);
    function GetScrollPos: TSize;
    function GetScrollRange: TSize;
    procedure SetScrollPos(szPos: TSize);
    procedure LineUp;
    procedure LineDown;
    procedure PageUp;
    procedure PageDown;
    procedure HomeUp;
    procedure EndDown;
    procedure LineLeft;
    procedure LineRight;
    procedure PageLeft;
    procedure PageRight;
    procedure HomeLeft;
    procedure EndRight;
    procedure EnableScrollBar(bEnableVertical: Boolean = True; bEnableHorizontal: Boolean = False);
    function GetVerticalScrollBar: CScrollBarUI;
    function GetHorizontalScrollBar: CScrollBarUI;
    function SortItems(pfnCompare: PULVCompareFunc; dwData: UINT_PTR): BOOL;
  end;

  CDelphi_ListUI = class(CListUI)
  public
    class function CppCreate: CDelphi_ListUI;
    procedure CppDestroy;
    procedure SetDelphiSelf(ASelf: Pointer);
    procedure SetDoEvent(ADoEvent: Pointer);
  end;

  CLabelUI = class(CControlUI)
  public
    class function CppCreate: CLabelUI;
    procedure CppDestroy;
    function GetClass: string;
    procedure SetText(pstrText: string);
    function GetInterface(pstrName: string): Pointer;
    procedure SetTextStyle(uStyle: UINT);
    function GetTextStyle: UINT;
    procedure SetTextColor(dwTextColor: DWORD);
    function GetTextColor: DWORD;
    procedure SetDisabledTextColor(dwTextColor: DWORD);
    function GetDisabledTextColor: DWORD;
    procedure SetFont(index: Integer);
    function GetFont: Integer;
    function GetTextPadding: TRect;
    procedure SetTextPadding(rc: TRect);
    function IsShowHtml: Boolean;
    procedure SetShowHtml(bShowHtml: Boolean = True);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintText(hDC: HDC);
    procedure SetEnabledEffect(_EnabledEffect: Boolean);
    function GetEnabledEffect: Boolean;
    procedure SetEnabledLuminous(bEnableLuminous: Boolean);
    function GetEnabledLuminous: Boolean;
    procedure SetLuminousFuzzy(fFuzzy: Single);
    function GetLuminousFuzzy: Single;
    procedure SetGradientLength(_GradientLength: Integer);
    function GetGradientLength: Integer;
    procedure SetShadowOffset(_offset: Integer; _angle: Integer);
    function GetShadowOffset: TRectF;
    procedure SetTextColor1(_TextColor1: DWORD);
    function GetTextColor1: DWORD;
    procedure SetTextShadowColorA(_TextShadowColorA: DWORD);
    function GetTextShadowColorA: DWORD;
    procedure SetTextShadowColorB(_TextShadowColorB: DWORD);
    function GetTextShadowColorB: DWORD;
    procedure SetStrokeColor(_StrokeColor: DWORD);
    function GetStrokeColor: DWORD;
    procedure SetGradientAngle(_SetGradientAngle: Integer);
    function GetGradientAngle: Integer;
    procedure SetEnabledStroke(_EnabledStroke: Boolean);
    function GetEnabledStroke: Boolean;
    procedure SetEnabledShadow(_EnabledShadowe: Boolean);
    function GetEnabledShadow: Boolean;
  public
    property EnabledLuminous: Boolean read GetEnabledLuminous write SetEnabledLuminous;
    property LuminousFuzzy: Single read GetLuminousFuzzy write SetLuminousFuzzy;
    property TextStyle: UINT read GetTextStyle write SetTextStyle;
    property TextColor: DWORD read GetTextColor write SetTextColor;
   	property DisabledTextColor: DWORD read GetDisabledTextColor write SetDisabledTextColor;
    property Font: Integer read GetFont write SetFont;
	  property TextPadding: TRect read GetTextPadding write SetTextPadding;
    property ShowHtml: Boolean read IsShowHtml write SetShowHtml;
    property EnabledEffect: Boolean read GetEnabledEffect write SetEnabledEffect;
    property Text: string read GetText write SetText;
    property GradientLength: Integer read GetGradientLength write SetGradientLength;
   	property ShadowOffset: TRectF read GetShadowOffset;
    property TextColor1: DWORD read GetTextColor1 write SetTextColor1;
    property TextShadowColorA: DWORD read GetTextShadowColorA write SetTextShadowColorA;
    property TextShadowColorB: DWORD read GetTextShadowColorB write SetTextShadowColorB;
    property StrokeColor: DWORD read GetStrokeColor write SetStrokeColor;
    property GradientAngle: Integer read GetGradientAngle write SetGradientAngle;
    property EnabledStroke: Boolean read GetEnabledStroke write SetEnabledStroke;
    property EnabledShadow: Boolean read GetEnabledShadow write SetEnabledShadow;
  end;

  CButtonUI = class(CLabelUI)
  public
    class function CppCreate: CButtonUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function Activate: Boolean;
    procedure SetEnabled(bEnable: Boolean = True);
    procedure DoEvent(var AEvent: TEventUI);
    function GetNormalImage: string;
    procedure SetNormalImage(pStrImage: string);
    function GetHotImage: string;
    procedure SetHotImage(pStrImage: string);
    function GetPushedImage: string;
    procedure SetPushedImage(pStrImage: string);
    function GetFocusedImage: string;
    procedure SetFocusedImage(pStrImage: string);
    function GetDisabledImage: string;
    procedure SetDisabledImage(pStrImage: string);
    function GetForeImage: string;
    procedure SetForeImage(pStrImage: string);
    function GetHotForeImage: string;
    procedure SetHotForeImage(pStrImage: string);
    procedure SetHotBkColor(dwColor: DWORD);
    function GetHotBkColor: DWORD;
    procedure SetHotTextColor(dwColor: DWORD);
    function GetHotTextColor: DWORD;
    procedure SetPushedTextColor(dwColor: DWORD);
    function GetPushedTextColor: DWORD;
    procedure SetFocusedTextColor(dwColor: DWORD);
    function GetFocusedTextColor: DWORD;
    function EstimateSize(szAvailable: TSize): TSize;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintText(hDC: HDC);
    procedure PaintStatusImage(hDC: HDC);
    procedure SetFiveStatusImage(pStrImage: string);
    procedure SetFadeAlphaDelta(uDelta: Byte);
    function GetFadeAlphaDelta: Boolean;
  public
    property NormalImage: string read GetNormalImage write SetNormalImage;
    property HotImage: string read GetHotImage write SetHotImage;
    property PushedImage: string read GetPushedImage write SetPushedImage;
    property FocusedImage: string read GetFocusedImage write SetFocusedImage;
    property DisabledImage: string read GetDisabledImage write SetDisabledImage;
    property ForeImage: string read GetForeImage write SetForeImage;
    property HotForeImage: string read GetHotForeImage write SetHotForeImage;
    property HotBkColor: DWORD read GetHotBkColor write SetHotBkColor;
    property HotTextColor: DWORD read GetHotTextColor write SetHotTextColor;
    property PushedTextColor: DWORD read GetPushedTextColor write SetPushedTextColor;
    property FocusedTextColor: DWORD read GetFocusedTextColor write SetFocusedTextColor;
  end;

  COptionUI = class(CButtonUI)
  public
    class function CppCreate: COptionUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean = True);
    function Activate: Boolean;
    procedure SetEnabled(bEnable: Boolean = True);
    function GetSelectedImage: string;
    procedure SetSelectedImage(pStrImage: string);
    function GetSelectedHotImage: string;
    procedure SetSelectedHotImage(pStrImage: string);
    procedure SetSelectedTextColor(dwTextColor: DWORD);
    function GetSelectedTextColor: DWORD;
    procedure SetSelectedBkColor(dwBkColor: DWORD);
    function GetSelectBkColor: DWORD;
    function GetForeImage: string;
    procedure SetForeImage(pStrImage: string);
    function GetGroup: string;
    procedure SetGroup(pStrGroupName: string = '');
    function IsSelected: Boolean;
    procedure _Selected(bSelected: Boolean; bTriggerEvent: Boolean = True);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintStatusImage(hDC: HDC);
    procedure PaintText(hDC: HDC);
  private
    procedure SetSelected(const Value: Boolean);
  public
    property SelectedImage: string read GetSelectedImage write SetSelectedImage;
    property SelectedHotImage: string read GetSelectedHotImage write SetSelectedHotImage;
    property SelectedTextColor: DWORD read GetSelectedTextColor write SetSelectedTextColor;
    property SelectedBkColor: DWORD read GetSelectBkColor write SetSelectedBkColor;
    property ForeImage: string read GetForeImage write SetForeImage;
    property Group: string read GetGroup write SetGroup;
    property Selected: Boolean read IsSelected write SetSelected;
  end;

  CCheckBoxUI = class(COptionUI)
  public
    class function CppCreate: CCheckBoxUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure SetCheck(bCheck: Boolean; bTriggerEvent: Boolean = True);
    function GetCheck: Boolean;
  private
    procedure SetChecked(const Value: Boolean);
  public
    property Checked: Boolean read GetCheck write SetChecked;
  end;

  CListContainerElementUI = class(CContainerUI)
  public
    class function CppCreate: CListContainerElementUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetControlFlags: UINT;
    function GetInterface(pstrName: string): Pointer;
    function GetIndex: Integer;
    procedure SetIndex(iIndex: Integer);
    function GetOwner: IListOwnerUI;
    procedure SetOwner(pOwner: CControlUI);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetEnabled(bEnable: Boolean = True);
    function IsSelected: Boolean;
    function Select(bSelect: Boolean = True): Boolean;
    function IsExpanded: Boolean;
    function Expand(bExpand: Boolean = True): Boolean;
    procedure Invalidate;
    function Activate: Boolean;
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure DrawItemText(hDC: HDC; const rcItem: TRect);
    procedure DrawItemBk(hDC: HDC; const rcItem: TRect);
  private
    procedure SetExpand(const Value: Boolean);
    procedure SetSelect(const Value: Boolean);
  public
  	property Index: Integer read GetIndex write SetIndex;
   	property Selected: Boolean read IsSelected write SetSelect;
   	property Expanded: Boolean read IsExpanded write SetExpand;
  end;

  CComboUI = class(CContainerUI)
  public
    class function CppCreate: CComboUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoInit;
    function GetControlFlags: UINT;
    function GetText: string;
    procedure SetEnabled(bEnable: Boolean = True);
    function GetDropBoxAttributeList: string;
    procedure SetDropBoxAttributeList(pstrList: string);
    function GetDropBoxSize: TSize;
    procedure SetDropBoxSize(szDropBox: TSize);
    function GetCurSel: Integer;
    function GetSelectCloseFlag: Boolean;
    procedure SetSelectCloseFlag(flag: Boolean);
    function SelectItem(iIndex: Integer; bTakeFocus: Boolean = False; bTriggerEvent: Boolean = True): Boolean;
    function SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    function RemoveAt(iIndex: Integer): Boolean;
    procedure RemoveAll;
    function Activate: Boolean;
    function GetShowText: Boolean;
    procedure SetShowText(flag: Boolean);
    function GetTextPadding: TRect;
    procedure SetTextPadding(rc: TRect);
    function GetNormalImage: string;
    procedure SetNormalImage(pStrImage: string);
    function GetHotImage: string;
    procedure SetHotImage(pStrImage: string);
    function GetPushedImage: string;
    procedure SetPushedImage(pStrImage: string);
    function GetFocusedImage: string;
    procedure SetFocusedImage(pStrImage: string);
    function GetDisabledImage: string;
    procedure SetDisabledImage(pStrImage: string);
    function GetListInfo: PListInfoUI;
    procedure SetItemFont(index: Integer);
    procedure SetItemTextStyle(uStyle: UINT);
    function GetItemTextPadding: TRect;
    procedure SetItemTextPadding(rc: TRect);
    function GetItemTextColor: DWORD;
    procedure SetItemTextColor(dwTextColor: DWORD);
    function GetItemBkColor: DWORD;
    procedure SetItemBkColor(dwBkColor: DWORD);
    function GetItemBkImage: string;
    procedure SetItemBkImage(pStrImage: string);
    function IsAlternateBk: Boolean;
    procedure SetAlternateBk(bAlternateBk: Boolean);
    function GetSelectedItemTextColor: DWORD;
    procedure SetSelectedItemTextColor(dwTextColor: DWORD);
    function GetSelectedItemBkColor: DWORD;
    procedure SetSelectedItemBkColor(dwBkColor: DWORD);
    function GetSelectedItemImage: string;
    procedure SetSelectedItemImage(pStrImage: string);
    function GetHotItemTextColor: DWORD;
    procedure SetHotItemTextColor(dwTextColor: DWORD);
    function GetHotItemBkColor: DWORD;
    procedure SetHotItemBkColor(dwBkColor: DWORD);
    function GetHotItemImage: string;
    procedure SetHotItemImage(pStrImage: string);
    function GetDisabledItemTextColor: DWORD;
    procedure SetDisabledItemTextColor(dwTextColor: DWORD);
    function GetDisabledItemBkColor: DWORD;
    procedure SetDisabledItemBkColor(dwBkColor: DWORD);
    function GetDisabledItemImage: string;
    procedure SetDisabledItemImage(pStrImage: string);
    function GetItemLineColor: DWORD;
    procedure SetItemLineColor(dwLineColor: DWORD);
    function IsItemShowHtml: Boolean;
    procedure SetItemShowHtml(bShowHtml: Boolean = True);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure PaintText(hDC: HDC);
    procedure PaintStatusImage(hDC: HDC);
  public
    property DropBoxAttributeList: string read GetDropBoxAttributeList write SetDropBoxAttributeList;
	  property DropBoxSize: TSize read GetDropBoxSize write SetDropBoxSize;
    property CurSel: Integer read GetCurSel;
    property SelectCloseFlag: Boolean read GetSelectCloseFlag write SetSelectCloseFlag;
    property ShowText: Boolean read GetShowText write SetShowText;
    property TextPadding: TRect read GetTextPadding write SetTextPadding;
    property NormalImage: string read GetNormalImage write SetNormalImage;
    property HotImage: string  read GetHotImage write SetHotImage;
    property PushedImage: string read GetPushedImage write SetPushedImage;
	  property FocusedImage: string read GetFocusedImage write SetFocusedImage;
    property DisabledImage: string read GetDisabledImage write SetDisabledImage;
    property ItemTextPadding: TRect read GetItemTextPadding write SetItemTextPadding;
    property ItemTextColor: DWORD read GetItemTextColor write SetItemTextColor;
    property ItemBkColor: DWORD read GetItemBkColor write SetItemBkColor;
    property ItemBkImage: string read GetItemBkImage write SetItemBkImage;
    property AlternateBk: Boolean read IsAlternateBk write SetAlternateBk;
    property SelectedItemTextColor: DWORD read GetSelectedItemTextColor write SetSelectedItemTextColor;
    property SelectedItemBkColor: DWORD read GetSelectedItemBkColor write SetSelectedItemBkColor;
    property SelectedItemImage: string read GetSelectedItemImage write SetSelectedItemImage;
    property HotItemTextColor: DWORD read GetHotItemTextColor write SetHotItemTextColor;
    property HotItemBkColor: DWORD read GetHotItemBkColor write SetHotItemBkColor;
    property HotItemImage: string read GetHotItemImage write SetHotItemImage;
    property DisabledItemTextColor: DWORD read GetDisabledItemTextColor write SetDisabledItemTextColor;
    property DisabledItemBkColor: DWORD read GetDisabledItemBkColor write SetDisabledItemBkColor;
    property DisabledItemImage: string read GetDisabledItemImage write SetDisabledItemImage;
    property ItemLineColor: DWORD read GetItemLineColor write SetItemLineColor;
    property ItemShowHtml: Boolean read IsItemShowHtml write SetItemShowHtml;
  end;

  CDateTimeUI = class(CLabelUI)
  public
    class function CppCreate: CDateTimeUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function GetNativeWindow: HWND;
    function GetTime: TDateTime;
    procedure SetTime(pst: TDateTime);
    procedure SetReadOnly(bReadOnly: Boolean);
    function IsReadOnly: Boolean;
    procedure UpdateText;
    procedure DoEvent(var AEvent: TEventUI);
  public
    property ReadOnly: Boolean read IsReadOnly write SetReadOnly;
  	property Time: TDateTime read GetTime write SetTime;
  end;

  CEditUI = class(CLabelUI)
  public
    class function CppCreate: CEditUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function GetNativeWindow: HWND;
    procedure SetEnabled(bEnable: Boolean = True);
    procedure SetText(pstrText: string);
    procedure SetMaxChar(uMax: UINT);
    function GetMaxChar: UINT;
    procedure SetReadOnly(bReadOnly: Boolean);
    function IsReadOnly: Boolean;
    procedure SetPasswordMode(bPasswordMode: Boolean);
    function IsPasswordMode: Boolean;
    procedure SetPasswordChar(cPasswordChar: Char);
    function GetPasswordChar: Char;
    procedure SetNumberOnly(bNumberOnly: Boolean);
    function IsNumberOnly: Boolean;
    function GetWindowStyls: Integer;
    function GetNativeEditHWND: HWND;
    function GetNormalImage: string;
    procedure SetNormalImage(pStrImage: string);
    function GetHotImage: string;
    procedure SetHotImage(pStrImage: string);
    function GetFocusedImage: string;
    procedure SetFocusedImage(pStrImage: string);
    function GetDisabledImage: string;
    procedure SetDisabledImage(pStrImage: string);
    procedure SetNativeEditBkColor(dwBkColor: DWORD);
    function GetNativeEditBkColor: DWORD;
    procedure SetSel(nStartChar: LongInt; nEndChar: LongInt);
    procedure SetSelAll;
    procedure SetReplaceSel(lpszReplace: string);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetInternVisible(bVisible: Boolean = True);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintStatusImage(hDC: HDC);
    procedure PaintText(hDC: HDC);
  public
    property MaxChar: UINT read GetMaxChar write SetMaxChar;
    property ReadOnly: Boolean read IsReadOnly write SetReadOnly;
    property PasswordMode: Boolean read IsPasswordMode write SetPasswordMode;
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar;
    property NumberOnly: Boolean read IsNumberOnly write SetNumberOnly;
    property WindowStyls: Integer read GetWindowStyls;
    property NativeEditHWND: HWND read GetNativeEditHWND;
    property NormalImage: string read GetNormalImage write SetNormalImage;
    property HotImage: string read GetHotImage write SetHotImage;
    property FocusedImage: string read GetFocusedImage write SetFocusedImage;
    property DisabledImage: string read GetDisabledImage write SetDisabledImage;
    property NativeEditBkColor: DWORD read GetNativeEditBkColor write SetNativeEditBkColor;
  end;

  CProgressUI = class(CLabelUI)
  public
    class function CppCreate: CProgressUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function IsHorizontal: Boolean;
    procedure SetHorizontal(bHorizontal: Boolean = True);
    function IsStretchForeImage: Boolean;
    procedure SetStretchForeImage(bStretchForeImage: Boolean = True);
    function GetMinValue: Integer;
    procedure SetMinValue(nMin: Integer);
    function GetMaxValue: Integer;
    procedure SetMaxValue(nMax: Integer);
    function GetValue: Integer;
    procedure SetValue(nValue: Integer);
    function GetForeImage: string;
    procedure SetForeImage(pStrImage: string);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintStatusImage(hDC: HDC);
  public
    property Horizontal: Boolean read IsHorizontal write SetHorizontal;
    property StretchForeImage: Boolean read IsStretchForeImage write SetStretchForeImage;
    property Value: Integer read GetValue write SetValue;
    property MinValue: Integer read GetMinValue write SetMinValue;
    property MaxValue: Integer read GetMaxValue write SetMaxValue;
    property ForeImage: string read GetForeImage write SetForeImage;
  end;

  CScrollBarUI = class(CControlUI)
  public
    class function CppCreate: CScrollBarUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetOwner: CContainerUI;
    procedure SetOwner(pOwner: CContainerUI);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetEnabled(bEnable: Boolean = True);
    procedure SetFocus;
    function IsHorizontal: Boolean;
    procedure SetHorizontal(bHorizontal: Boolean = True);
    function GetScrollRange: Integer;
    procedure SetScrollRange(nRange: Integer);
    function GetScrollPos: Integer;
    procedure SetScrollPos(nPos: Integer; bTriggerEvent: Boolean = True);
    function GetLineSize: Integer;
    procedure SetLineSize(nSize: Integer);
    function GetShowButton1: Boolean;
    procedure SetShowButton1(bShow: Boolean);
    function GetButton1Color: DWORD;
    procedure SetButton1Color(dwColor: DWORD);
    function GetButton1NormalImage: string;
    procedure SetButton1NormalImage(pStrImage: string);
    function GetButton1HotImage: string;
    procedure SetButton1HotImage(pStrImage: string);
    function GetButton1PushedImage: string;
    procedure SetButton1PushedImage(pStrImage: string);
    function GetButton1DisabledImage: string;
    procedure SetButton1DisabledImage(pStrImage: string);
    function GetShowButton2: Boolean;
    procedure SetShowButton2(bShow: Boolean);
    function GetButton2Color: DWORD;
    procedure SetButton2Color(dwColor: DWORD);
    function GetButton2NormalImage: string;
    procedure SetButton2NormalImage(pStrImage: string);
    function GetButton2HotImage: string;
    procedure SetButton2HotImage(pStrImage: string);
    function GetButton2PushedImage: string;
    procedure SetButton2PushedImage(pStrImage: string);
    function GetButton2DisabledImage: string;
    procedure SetButton2DisabledImage(pStrImage: string);
    function GetThumbColor: DWORD;
    procedure SetThumbColor(dwColor: DWORD);
    function GetThumbNormalImage: string;
    procedure SetThumbNormalImage(pStrImage: string);
    function GetThumbHotImage: string;
    procedure SetThumbHotImage(pStrImage: string);
    function GetThumbPushedImage: string;
    procedure SetThumbPushedImage(pStrImage: string);
    function GetThumbDisabledImage: string;
    procedure SetThumbDisabledImage(pStrImage: string);
    function GetRailNormalImage: string;
    procedure SetRailNormalImage(pStrImage: string);
    function GetRailHotImage: string;
    procedure SetRailHotImage(pStrImage: string);
    function GetRailPushedImage: string;
    procedure SetRailPushedImage(pStrImage: string);
    function GetRailDisabledImage: string;
    procedure SetRailDisabledImage(pStrImage: string);
    function GetBkNormalImage: string;
    procedure SetBkNormalImage(pStrImage: string);
    function GetBkHotImage: string;
    procedure SetBkHotImage(pStrImage: string);
    function GetBkPushedImage: string;
    procedure SetBkPushedImage(pStrImage: string);
    function GetBkDisabledImage: string;
    procedure SetBkDisabledImage(pStrImage: string);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure PaintBk(hDC: HDC);
    procedure PaintButton1(hDC: HDC);
    procedure PaintButton2(hDC: HDC);
    procedure PaintThumb(hDC: HDC);
    procedure PaintRail(hDC: HDC);
  public
    property Owner: CContainerUI read GetOwner write SetOwner;
    property Horizontal: Boolean read IsHorizontal write SetHorizontal;
    property ScrollRange: Integer read GetScrollRange write SetScrollRange;
    property LineSize: Integer read GetLineSize write SetLineSize;
    property ShowButton1: Boolean read GetShowButton1 write SetShowButton1;
    property Button1Color: DWORD read GetButton1Color write SetButton1Color;
    property Button1NormalImage: string read GetButton1NormalImage write SetButton1NormalImage;
    property Button1HotImage: string read GetButton1HotImage write SetButton1HotImage;
    property Button1PushedImage: string read GetButton1PushedImage write SetButton1PushedImage;
    property Button1DisabledImage: string read GetButton1DisabledImage write SetButton1DisabledImage;
    property ShowButton2: Boolean read GetShowButton2 write SetShowButton2;
    property Button2Color: DWORD read GetButton2Color write SetButton2Color;
    property Button2NormalImage: string read GetButton2NormalImage write SetButton2NormalImage;
    property Button2HotImage: string read GetButton2HotImage write SetButton2HotImage;
    property Button2PushedImage: string read GetButton2PushedImage write SetButton2PushedImage;
    property Button2DisabledImage: string read GetButton2DisabledImage write SetButton2DisabledImage;
    property ThumbColor: DWORD read GetThumbColor write SetThumbColor;
    property ThumbNormalImage: string read GetThumbNormalImage write SetThumbNormalImage;
    property ThumbHotImage: string read GetThumbHotImage write SetThumbHotImage;
    property ThumbPushedImage: string read GetThumbPushedImage write SetThumbPushedImage;
    property ThumbDisabledImage: string read GetThumbDisabledImage write SetThumbDisabledImage;
    property RailNormalImage: string read GetRailNormalImage write SetRailNormalImage;
    property RailHotImage: string read GetRailHotImage write SetRailHotImage;
    property RailPushedImage: string read GetRailPushedImage write SetRailPushedImage;
    property RailDisabledImage: string read GetRailDisabledImage write SetRailDisabledImage;
    property BkNormalImage: string read GetBkNormalImage write SetBkNormalImage;
    property BkHotImage: string read GetBkHotImage write SetBkHotImage;
    property BkPushedImage: string read GetBkPushedImage write SetBkPushedImage;
    property BkDisabledImage: string read GetBkDisabledImage write SetBkDisabledImage;
  end;

  CSliderUI = class(CProgressUI)
  public
    class function CppCreate: CSliderUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetControlFlags: UINT;
    function GetInterface(pstrName: string): Pointer;
    procedure SetEnabled(bEnable: Boolean = True);
    function GetChangeStep: Integer;
    procedure SetChangeStep(step: Integer);
    procedure SetThumbSize(szXY: TSize);
    function GetThumbRect: TRect;
    function GetThumbImage: string;
    procedure SetThumbImage(pStrImage: string);
    function GetThumbHotImage: string;
    procedure SetThumbHotImage(pStrImage: string);
    function GetThumbPushedImage: string;
    procedure SetThumbPushedImage(pStrImage: string);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure PaintStatusImage(hDC: HDC);
  public
    property ChangeStep: Integer read GetChangeStep write SetChangeStep;
    property ThumbRect: TRect read GetThumbRect;
    property ThumbImage: string read GetThumbImage write SetThumbImage;
    property ThumbHotImage: string read GetThumbHotImage write SetThumbHotImage;
    property ThumbPushedImage: string read GetThumbPushedImage write SetThumbPushedImage;
  end;

  CTextUI = class(CLabelUI)
  public
    class function CppCreate: CTextUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetControlFlags: UINT;
    function GetInterface(pstrName: string): Pointer;
    function GetLinkContent(iIndex: Integer): string;
    procedure DoEvent(var AEvent: TEventUI);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure PaintText(hDC: HDC);
  end;

  CTreeNodeUI = class(CListContainerElementUI)
  public
    class function CppCreate(_ParentNode: CTreeNodeUI = nil): CTreeNodeUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoEvent(var AEvent: TEventUI);
    procedure Invalidate;
    function Select(bSelect: Boolean = True; bTriggerEvent: Boolean = True): Boolean;
    function Add(_pTreeNodeUI: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    procedure SetVisibleTag(_IsVisible: Boolean);
    function GetVisibleTag: Boolean;
    procedure SetItemText(pstrValue: string);
    function GetItemText: string;
    procedure SetCheckBoxSelected(_Selected: Boolean);
    function IsCheckBoxSelected: Boolean;
    function IsHasChild: Boolean;
    function AddChildNode(_pTreeNodeUI: CTreeNodeUI): Boolean;
    function RemoveAt(_pTreeNodeUI: CTreeNodeUI): Boolean;
    procedure SetParentNode(_pParentTreeNode: CTreeNodeUI);
    function GetParentNode: CTreeNodeUI;
    function GetCountChild: LongInt;
    procedure SetTreeView(_CTreeViewUI: CTreeViewUI);
    function GetTreeView: CTreeViewUI;
    function GetChildNode(_nIndex: Integer): CTreeNodeUI;
    procedure SetVisibleFolderBtn(_IsVisibled: Boolean);
    function GetVisibleFolderBtn: Boolean;
    procedure SetVisibleCheckBtn(_IsVisibled: Boolean);
    function GetVisibleCheckBtn: Boolean;
    procedure SetItemTextColor(_dwItemTextColor: DWORD);
    function GetItemTextColor: DWORD;
    procedure SetItemHotTextColor(_dwItemHotTextColor: DWORD);
    function GetItemHotTextColor: DWORD;
    procedure SetSelItemTextColor(_dwSelItemTextColor: DWORD);
    function GetSelItemTextColor: DWORD;
    procedure SetSelItemHotTextColor(_dwSelHotItemTextColor: DWORD);
    function GetSelItemHotTextColor: DWORD;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    function GetTreeNodes: CStdPtrArray;
    function GetTreeIndex: Integer;
    function GetNodeIndex: Integer;
  public
    property VisibleTag: Boolean read GetVisibleTag write SetVisibleTag;
    property ItemText: string read GetItemText write SetItemText;
    property CheckBoxSelected: Boolean read IsCheckBoxSelected write SetCheckBoxSelected;
    property HasChild: Boolean read IsHasChild;
    property ParentNode: CTreeNodeUI read GetParentNode write SetParentNode;
    property ChildCount: LongInt read GetCountChild;
    property TreeView: CTreeViewUI read GetTreeView write SetTreeView;
    property ChildNode[nindex: Integer]: CTreeNodeUI read GetChildNode;
    property VisibleFolderBtn: Boolean read GetVisibleFolderBtn write SetVisibleFolderBtn;
    property VisibleCheckBtn: Boolean read GetVisibleCheckBtn write SetVisibleCheckBtn;
    property ItemTextColor: DWORD read GetItemTextColor write SetItemTextColor;
    property ItemHotTextColor: DWORD read GetItemHotTextColor write SetItemHotTextColor;
    property SelItemTextColor: DWORD read GetSelItemTextColor write SetSelItemTextColor;
    property SelItemHotTextColor: DWORD read GetSelItemHotTextColor write SetSelItemHotTextColor;
    property TreeNodes: CStdPtrArray read GetTreeNodes;
    property TreeIndex: Integer read GetTreeIndex;
    property NodeIndex: Integer read GetNodeIndex;
  end;

  CTreeViewUI = class(CListUI)
  public
    class function CppCreate: CTreeViewUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function Add(pControl: CTreeNodeUI): Boolean;
    function AddAt(pControl: CTreeNodeUI; iIndex: Integer): LongInt; overload;
    function AddAt(pControl: CTreeNodeUI; _IndexNode: CTreeNodeUI): Boolean; overload;
    function Remove(pControl: CTreeNodeUI): Boolean;
    function RemoveAt(iIndex: Integer): Boolean;
    procedure RemoveAll;
    function OnCheckBoxChanged(param: PPointer): Boolean;
    function OnFolderChanged(param: PPointer): Boolean;
    function OnDBClickItem(param: PPointer): Boolean;
    function SetItemCheckBox(_Selected: Boolean; _TreeNode: CTreeNodeUI = nil): Boolean;
    procedure SetItemExpand(_Expanded: Boolean; _TreeNode: CTreeNodeUI = nil);
    procedure Notify(var msg: TNotifyUI);
    procedure SetVisibleFolderBtn(_IsVisibled: Boolean);
    function GetVisibleFolderBtn: Boolean;
    procedure SetVisibleCheckBtn(_IsVisibled: Boolean);
    function GetVisibleCheckBtn: Boolean;
    procedure SetItemMinWidth(_ItemMinWidth: UINT);
    function GetItemMinWidth: UINT;
    procedure SetItemTextColor(_dwItemTextColor: DWORD);
    procedure SetItemHotTextColor(_dwItemHotTextColor: DWORD);
    procedure SetSelItemTextColor(_dwSelItemTextColor: DWORD);
    procedure SetSelItemHotTextColor(_dwSelHotItemTextColor: DWORD);
    procedure SetAttribute(pstrName: string; pstrValue: string);
  public
    property VisibleFolderBtn: Boolean read GetVisibleFolderBtn write SetVisibleFolderBtn;
    property VisibleCheckBtn: Boolean read GetVisibleCheckBtn write SetVisibleCheckBtn;
    property ItemMinWidth: UINT read GetItemMinWidth write SetItemMinWidth;
  end;

  CTabLayoutUI = class(CContainerUI)
  public
    class function CppCreate: CTabLayoutUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    procedure RemoveAll;
    function GetCurSel: Integer;
    function SelectItem(iIndex: Integer; bTriggerEvent: Boolean = True): Boolean; overload;
    function SelectItem(pControl: CControlUI; bTriggerEvent: Boolean = True): Boolean; overload;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure SetAttribute(pstrName: string; pstrValue: string);
  private
    procedure SetSelectItem(const Value: Integer);
  public
    property SelectIndex: Integer read GetCurSel write SetSelectItem;
  end;

  CRenderClip = class
  public
    class function CppCreate: CRenderClip;
    procedure CppDestroy;
    class procedure GenerateClip(hDC: HDC; rc: TRect; var clip: CRenderClip);
    class procedure GenerateRoundClip(hDC: HDC; rc: TRect; rcItem: TRect; width: Integer; height: Integer; var clip: CRenderClip);
    class procedure UseOldClipBegin(hDC: HDC; var clip: CRenderClip);
    class procedure UseOldClipEnd(hDC: HDC; var clip: CRenderClip);
  end;

  CRenderEngine = class
  public
    class function CppCreate: CRenderEngine;
    procedure CppDestroy;
    class function AdjustColor(dwColor: DWORD; H: Short; S: Short; L: Short): DWORD;
    class function CreateARGB32Bitmap(hDC: HDC; cx: Integer; cy: Integer; pBits: COLORREF): HBITMAP;
    class procedure AdjustImage(bUseHSL: Boolean; imageInfo: PImageInfo; H: Short; S: Short; L: Short);
    class function LoadImage(bitmap: string; AType: string = ''; mask: DWORD = 0): PImageInfo;
    class procedure FreeImage(bitmap: PImageInfo; bDelete: Boolean = True);
    class procedure DrawImage(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcCorners: TRect; alphaChannel: Boolean; uFade: Byte = 255; hole: Boolean = False; xtiled: Boolean = False; ytiled: Boolean = False); overload;
    class function DrawImage(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean; overload;
    class procedure DrawColor(hDC: HDC; var rc: TRect; color: DWORD);
    class procedure DrawGradient(hDC: HDC; var rc: TRect; dwFirst: DWORD; dwSecond: DWORD; bVertical: Boolean; nSteps: Integer);
    class procedure DrawLine(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawRect(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawRoundRect(hDC: HDC; var rc: TRect; width: Integer; height: Integer; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; iFont: Integer; uStyle: UINT);
    class procedure DrawHtmlText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; pLinks: PRect; sLinks: string; var nLinkRects: Integer; uStyle: UINT);
    class function GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect): HBITMAP;
    class function GetTextSize(hDC: HDC; pManager: CPaintManagerUI; pstrText: string; iFont: Integer; uStyle: UINT): TSize;
  end;

  CListElementUI = class(CControlUI)
  public
    function GetClass: string;
    function GetControlFlags: UINT;
    function GetInterface(pstrName: string): Pointer;
    procedure SetEnabled(bEnable: Boolean = True);
    function GetIndex: Integer;
    procedure SetIndex(iIndex: Integer);
    function GetOwner: IListOwnerUI;
    procedure SetOwner(pOwner: CControlUI);
    procedure SetVisible(bVisible: Boolean = True);
    function IsSelected: Boolean;
    function Select(bSelect: Boolean = True): Boolean;
    function IsExpanded: Boolean;
    function Expand(bExpand: Boolean = True): Boolean;
    procedure Invalidate;
    function Activate: Boolean;
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure DrawItemBk(hDC: HDC; const rcItem: TRect);
  private
    procedure SetExpanded(const Value: Boolean);
    procedure SetSelect(const Value: Boolean);
  public
    property Index: Integer read GetIndex write SetIndex;
    property Selected: Boolean read IsSelected write SetSelect;
    property Expanded: Boolean read IsExpanded write SetExpanded;
  end;

  CListLabelElementUI = class(CListElementUI)
  public
    class function CppCreate: CListLabelElementUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoEvent(var AEvent: TEventUI);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure DrawItemText(hDC: HDC; const rcItem: TRect);
  end;

  CListTextElementUI = class(CListLabelElementUI)
  public
    class function CppCreate: CListTextElementUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function GetText(iIndex: Integer): string;
    procedure SetText(iIndex: Integer; pstrText: string);
    procedure SetOwner(pOwner: CControlUI);
    function GetLinkContent(iIndex: Integer): string;
    procedure DoEvent(var AEvent: TEventUI);
    function EstimateSize(szAvailable: TSize): TSize;
    procedure DrawItemText(hDC: HDC; const rcItem: TRect);
  public
    property Texts[iIndex: Integer]: string read GetText write SetText;
  end;

  CGifAnimUI = class(CControlUI)
  public
    class function CppCreate: CGifAnimUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoInit;
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure DoEvent(var AEvent: TEventUI);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure SetBkImage(pStrImage: string);
    function GetBkImage: string;
    procedure SetAutoPlay(bIsAuto: Boolean = True);
    function IsAutoPlay: Boolean;
    procedure SetAutoSize(bIsAuto: Boolean = True);
    function IsAutoSize: Boolean;
    procedure PlayGif;
    procedure PauseGif;
    procedure StopGif;
  public
    property BkImage: string read GetBkImage write SetBkImage;
    property AutoPlay: Boolean read IsAutoPlay write SetAutoPlay;
    property AutoSize: Boolean read IsAutoSize write SetAutoSize;
  end;


  CChildLayoutUI = class(CContainerUI)
  public
    class function CppCreate: CChildLayoutUI;
    procedure CppDestroy;
    procedure Init;
    procedure SetAttribute(pstrName: string; pstrValue: string);
    procedure SetChildLayoutXML(pXML: string);
    function GetChildLayoutXML: string;
    function GetInterface(pstrName: string): Pointer;
    function GetClass: string;
  public
    property ChildLayoutXML: string read GetChildLayoutXML write SetChildLayoutXML;
  end;

  CTileLayoutUI = class(CContainerUI)
  public
    class function CppCreate: CTileLayoutUI;
    procedure CppDestroy;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    function GetItemSize: TSize;
    procedure SetItemSize(szItem: TSize);
    function GetColumns: Integer;
    procedure SetColumns(nCols: Integer);
    procedure SetAttribute(pstrName: string; pstrValue: string);
  public
    property ItemSize: TSize read GetItemSize write SetItemSize;
    property Columns: Integer read GetColumns write SetColumns;
  end;


  CNativeControlUI = class(CContainerUI)
  public
    class function CppCreate(hWnd: HWND = 0): CNativeControlUI;
    procedure CppDestroy;
    procedure SetInternVisible(bVisible: Boolean = True);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean);
    function GetClass: string;
    function GetText: string;
    procedure SetText(pstrText: string);
    procedure SetNativeHandle(hWd: HWND);
  public
    property Text: string read GetText write SetText;
  end;


//================================CStdStringPtrMap============================

function Delphi_StdStringPtrMap_CppCreate: CStdStringPtrMap; cdecl;
procedure Delphi_StdStringPtrMap_CppDestroy(Handle: CStdStringPtrMap); cdecl;
procedure Delphi_StdStringPtrMap_Resize(Handle: CStdStringPtrMap; nSize: Integer); cdecl;
function Delphi_StdStringPtrMap_Find(Handle: CStdStringPtrMap; key: LPCTSTR; optimize: Boolean): Pointer; cdecl;
function Delphi_StdStringPtrMap_Insert(Handle: CStdStringPtrMap; key: LPCTSTR; pData: Pointer): Boolean; cdecl;
function Delphi_StdStringPtrMap_Set(Handle: CStdStringPtrMap; key: LPCTSTR; pData: Pointer): Pointer; cdecl;
function Delphi_StdStringPtrMap_Remove(Handle: CStdStringPtrMap; key: LPCTSTR): Boolean; cdecl;
procedure Delphi_StdStringPtrMap_RemoveAll(Handle: CStdStringPtrMap); cdecl;
function Delphi_StdStringPtrMap_GetSize(Handle: CStdStringPtrMap): Integer; cdecl;
function Delphi_StdStringPtrMap_GetAt(Handle: CStdStringPtrMap; iIndex: Integer): LPCTSTR; cdecl;

//================================CStdValArray============================

function Delphi_StdValArray_CppCreate(iElementSize: Integer; iPreallocSize: Integer): CStdValArray; cdecl;
procedure Delphi_StdValArray_CppDestroy(Handle: CStdValArray); cdecl;
procedure Delphi_StdValArray_Empty(Handle: CStdValArray); cdecl;
function Delphi_StdValArray_IsEmpty(Handle: CStdValArray): Boolean; cdecl;
function Delphi_StdValArray_Add(Handle: CStdValArray; pData: LPCVOID): Boolean; cdecl;
function Delphi_StdValArray_Remove(Handle: CStdValArray; iIndex: Integer): Boolean; cdecl;
function Delphi_StdValArray_GetSize(Handle: CStdValArray): Integer; cdecl;
function Delphi_StdValArray_GetData(Handle: CStdValArray): Pointer; cdecl;
function Delphi_StdValArray_GetAt(Handle: CStdValArray; iIndex: Integer): Pointer; cdecl;

//================================CStdPtrArray============================

function Delphi_StdPtrArray_CppCreate: CStdPtrArray; cdecl;
procedure Delphi_StdPtrArray_CppDestroy(Handle: CStdPtrArray); cdecl;
procedure Delphi_StdPtrArray_Empty(Handle: CStdPtrArray); cdecl;
procedure Delphi_StdPtrArray_Resize(Handle: CStdPtrArray; iSize: Integer); cdecl;
function Delphi_StdPtrArray_IsEmpty(Handle: CStdPtrArray): Boolean; cdecl;
function Delphi_StdPtrArray_Find(Handle: CStdPtrArray; iIndex: Pointer): Integer; cdecl;
function Delphi_StdPtrArray_Add(Handle: CStdPtrArray; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_SetAt(Handle: CStdPtrArray; iIndex: Integer; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_InsertAt(Handle: CStdPtrArray; iIndex: Integer; pData: Pointer): Boolean; cdecl;
function Delphi_StdPtrArray_Remove(Handle: CStdPtrArray; iIndex: Integer): Boolean; cdecl;
function Delphi_StdPtrArray_GetSize(Handle: CStdPtrArray): Integer; cdecl;
function Delphi_StdPtrArray_GetData(Handle: CStdPtrArray): Pointer; cdecl;
function Delphi_StdPtrArray_GetAt(Handle: CStdPtrArray; iIndex: Integer): Pointer; cdecl;

//================================CNotifyPump============================

function Delphi_NotifyPump_CppCreate: CNotifyPump; cdecl;
procedure Delphi_NotifyPump_CppDestroy(Handle: CNotifyPump); cdecl;
function Delphi_NotifyPump_AddVirtualWnd(Handle: CNotifyPump; strName: CDuiString; pObject: CNotifyPump): Boolean; cdecl;
function Delphi_NotifyPump_RemoveVirtualWnd(Handle: CNotifyPump; strName: CDuiString): Boolean; cdecl;
procedure Delphi_NotifyPump_NotifyPump(Handle: CNotifyPump; var msg: TNotifyUI); cdecl;
function Delphi_NotifyPump_LoopDispatch(Handle: CNotifyPump; var msg: TNotifyUI): Boolean; cdecl;

//================================CDialogBuilder============================

function Delphi_DialogBuilder_CppCreate: CDialogBuilder; cdecl;
procedure Delphi_DialogBuilder_CppDestroy(Handle: CDialogBuilder); cdecl;
function Delphi_DialogBuilder_Create_01(Handle: CDialogBuilder; xml: STRINGorID; AType: LPCTSTR; pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI; cdecl;
function Delphi_DialogBuilder_Create_02(Handle: CDialogBuilder; pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI; cdecl;
function Delphi_DialogBuilder_GetMarkup(Handle: CDialogBuilder): CMarkup; cdecl;
procedure Delphi_DialogBuilder_GetLastErrorMessage(Handle: CDialogBuilder; pstrMessage: LPTSTR; cchMax: SIZE_T); cdecl;
procedure Delphi_DialogBuilder_GetLastErrorLocation(Handle: CDialogBuilder; pstrSource: LPTSTR; cchMax: SIZE_T); cdecl;

//================================CMarkup============================

function Delphi_Markup_CppCreate(pstrXML: LPCTSTR): CMarkup; cdecl;
procedure Delphi_Markup_CppDestroy(Handle: CMarkup); cdecl;
function Delphi_Markup_Load(Handle: CMarkup; pstrXML: LPCTSTR): Boolean; cdecl;
function Delphi_Markup_LoadFromMem(Handle: CMarkup; pByte: PByte; dwSize: DWORD; encoding: Integer): Boolean; cdecl;
function Delphi_Markup_LoadFromFile(Handle: CMarkup; pstrFilename: LPCTSTR; encoding: Integer): Boolean; cdecl;
procedure Delphi_Markup_Release(Handle: CMarkup); cdecl;
function Delphi_Markup_IsValid(Handle: CMarkup): Boolean; cdecl;
procedure Delphi_Markup_SetPreserveWhitespace(Handle: CMarkup; bPreserve: Boolean); cdecl;
procedure Delphi_Markup_GetLastErrorMessage(Handle: CMarkup; pstrMessage: LPTSTR; cchMax: SIZE_T); cdecl;
procedure Delphi_Markup_GetLastErrorLocation(Handle: CMarkup; pstrSource: LPTSTR; cchMax: SIZE_T); cdecl;
function Delphi_Markup_GetRoot(Handle: CMarkup): CMarkupNode; cdecl;

//================================CMarkupNode============================

function Delphi_MarkupNode_CppCreate: CMarkupNode; cdecl;
procedure Delphi_MarkupNode_CppDestroy(Handle: CMarkupNode); cdecl;
function Delphi_MarkupNode_IsValid(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_GetParent(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetSibling(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetChild_01(Handle: CMarkupNode): CMarkupNode; cdecl;
function Delphi_MarkupNode_GetChild_02(Handle: CMarkupNode; pstrName: LPCTSTR): CMarkupNode; cdecl;
function Delphi_MarkupNode_HasSiblings(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_HasChildren(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_GetName(Handle: CMarkupNode): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetValue(Handle: CMarkupNode): LPCTSTR; cdecl;
function Delphi_MarkupNode_HasAttributes(Handle: CMarkupNode): Boolean; cdecl;
function Delphi_MarkupNode_HasAttribute(Handle: CMarkupNode; pstrName: LPCTSTR): Boolean; cdecl;
function Delphi_MarkupNode_GetAttributeCount(Handle: CMarkupNode): Integer; cdecl;
function Delphi_MarkupNode_GetAttributeName(Handle: CMarkupNode; iIndex: Integer): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_01(Handle: CMarkupNode; iIndex: Integer): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_02(Handle: CMarkupNode; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_MarkupNode_GetAttributeValue_03(Handle: CMarkupNode; iIndex: Integer; pstrValue: LPTSTR; cchMax: SIZE_T): Boolean; cdecl;
function Delphi_MarkupNode_GetAttributeValue_04(Handle: CMarkupNode; pstrName: LPCTSTR; pstrValue: LPTSTR; cchMax: SIZE_T): Boolean; cdecl;

//================================CControlUI============================

function Delphi_ControlUI_CppCreate: CControlUI; cdecl;
procedure Delphi_ControlUI_CppDestroy(Handle: CControlUI); cdecl;
function Delphi_ControlUI_GetName(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetName(Handle: CControlUI; pstrName: LPCTSTR); cdecl;
function Delphi_ControlUI_GetClass(Handle: CControlUI): LPCTSTR; cdecl;
function Delphi_ControlUI_GetInterface(Handle: CControlUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ControlUI_GetControlFlags(Handle: CControlUI): UINT; cdecl;
function Delphi_ControlUI_GetNativeWindow(Handle: CControlUI): HWND; cdecl;
function Delphi_ControlUI_Activate(Handle: CControlUI): Boolean; cdecl;
function Delphi_ControlUI_GetManager(Handle: CControlUI): CPaintManagerUI; cdecl;
procedure Delphi_ControlUI_SetManager(Handle: CControlUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_ControlUI_GetParent(Handle: CControlUI): CControlUI; cdecl;
function Delphi_ControlUI_GetText(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetText(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
function Delphi_ControlUI_GetBkColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkColor2(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor2(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkColor3(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBkColor3(Handle: CControlUI; dwBackColor: DWORD); cdecl;
function Delphi_ControlUI_GetBkImage(Handle: CControlUI): LPCTSTR; cdecl;
procedure Delphi_ControlUI_SetBkImage(Handle: CControlUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ControlUI_GetFocusBorderColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetFocusBorderColor(Handle: CControlUI; dwBorderColor: DWORD); cdecl;
function Delphi_ControlUI_IsColorHSL(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetColorHSL(Handle: CControlUI; bColorHSL: Boolean); cdecl;
procedure Delphi_ControlUI_GetBorderRound(Handle: CControlUI; var Result: TSize); cdecl;
procedure Delphi_ControlUI_SetBorderRound(Handle: CControlUI; cxyRound: TSize); cdecl;
function Delphi_ControlUI_DrawImage(Handle: CControlUI; hDC: HDC; var drawInfo: TDrawInfo): Boolean; cdecl;
function Delphi_ControlUI_GetBorderColor(Handle: CControlUI): DWORD; cdecl;
procedure Delphi_ControlUI_SetBorderColor(Handle: CControlUI; dwBorderColor: DWORD); cdecl;
procedure Delphi_ControlUI_GetBorderSize(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetBorderSize_01(Handle: CControlUI; rc: TRect); cdecl;
procedure Delphi_ControlUI_SetBorderSize_02(Handle: CControlUI; iSize: Integer); cdecl;
function Delphi_ControlUI_GetBorderStyle(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetBorderStyle(Handle: CControlUI; nStyle: Integer); cdecl;
function Delphi_ControlUI_GetPos(Handle: CControlUI): PRect; cdecl;
procedure Delphi_ControlUI_GetRelativePos(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_GetClientPos(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetPos(Handle: CControlUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ControlUI_Move(Handle: CControlUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
function Delphi_ControlUI_GetWidth(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetHeight(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetX(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetY(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_GetPadding(Handle: CControlUI; var Result: TRect); cdecl;
procedure Delphi_ControlUI_SetPadding(Handle: CControlUI; rcPadding: TRect); cdecl;
procedure Delphi_ControlUI_GetFixedXY(Handle: CControlUI; var Result: TSize); cdecl;
procedure Delphi_ControlUI_SetFixedXY(Handle: CControlUI; szXY: TSize); cdecl;
function Delphi_ControlUI_GetFixedWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetFixedWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetFixedHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetFixedHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetMinWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMinWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetMaxWidth(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMaxWidth(Handle: CControlUI; cx: Integer); cdecl;
function Delphi_ControlUI_GetMinHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMinHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetMaxHeight(Handle: CControlUI): Integer; cdecl;
procedure Delphi_ControlUI_SetMaxHeight(Handle: CControlUI; cy: Integer); cdecl;
function Delphi_ControlUI_GetFloatPercent(Handle: CControlUI): TPercentInfo; cdecl;
procedure Delphi_ControlUI_SetFloatPercent(Handle: CControlUI; piFloatPercent: TPercentInfo); cdecl;
function Delphi_ControlUI_GetToolTip(Handle: CControlUI): CDuiString; cdecl;
procedure Delphi_ControlUI_SetToolTip(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_ControlUI_SetToolTipWidth(Handle: CControlUI; nWidth: Integer); cdecl;
function Delphi_ControlUI_GetToolTipWidth(Handle: CControlUI): Integer; cdecl;
function Delphi_ControlUI_GetShortcut(Handle: CControlUI): Char; cdecl;
procedure Delphi_ControlUI_SetShortcut(Handle: CControlUI; ch: Char); cdecl;
function Delphi_ControlUI_IsContextMenuUsed(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetContextMenuUsed(Handle: CControlUI; bMenuUsed: Boolean); cdecl;
function Delphi_ControlUI_GetUserData(Handle: CControlUI): PCDuiString; cdecl;
procedure Delphi_ControlUI_SetUserData(Handle: CControlUI; pstrText: LPCTSTR); cdecl;
function Delphi_ControlUI_GetTag(Handle: CControlUI): UINT_PTR; cdecl;
procedure Delphi_ControlUI_SetTag(Handle: CControlUI; pTag: UINT_PTR); cdecl;
function Delphi_ControlUI_IsVisible(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetVisible(Handle: CControlUI; bVisible: Boolean); cdecl;
procedure Delphi_ControlUI_SetInternVisible(Handle: CControlUI; bVisible: Boolean); cdecl;
function Delphi_ControlUI_IsEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsMouseEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetMouseEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsKeyboardEnabled(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetKeyboardEnabled(Handle: CControlUI; bEnable: Boolean); cdecl;
function Delphi_ControlUI_IsFocused(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetFocus(Handle: CControlUI); cdecl;
function Delphi_ControlUI_IsFloat(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_SetFloat(Handle: CControlUI; bFloat: Boolean); cdecl;
procedure Delphi_ControlUI_AddCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR; pstrAttr: LPCTSTR); cdecl;
function Delphi_ControlUI_GetCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_ControlUI_RemoveCustomAttribute(Handle: CControlUI; pstrName: LPCTSTR): Boolean; cdecl;
procedure Delphi_ControlUI_RemoveAllCustomAttribute(Handle: CControlUI); cdecl;
function Delphi_ControlUI_FindControl(Handle: CControlUI; Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI; cdecl;
procedure Delphi_ControlUI_Invalidate(Handle: CControlUI); cdecl;
function Delphi_ControlUI_IsUpdateNeeded(Handle: CControlUI): Boolean; cdecl;
procedure Delphi_ControlUI_NeedUpdate(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_NeedParentUpdate(Handle: CControlUI); cdecl;
function Delphi_ControlUI_GetAdjustColor(Handle: CControlUI; dwColor: DWORD): DWORD; cdecl;
procedure Delphi_ControlUI_Init(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_DoInit(Handle: CControlUI); cdecl;
procedure Delphi_ControlUI_Event(Handle: CControlUI; var event: TEventUI); cdecl;
procedure Delphi_ControlUI_DoEvent(Handle: CControlUI; var event: TEventUI); cdecl;
procedure Delphi_ControlUI_SetAttribute(Handle: CControlUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_ControlUI_ApplyAttributeList(Handle: CControlUI; pstrList: LPCTSTR): CControlUI; cdecl;
procedure Delphi_ControlUI_EstimateSize(Handle: CControlUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ControlUI_DoPaint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ControlUI_Paint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ControlUI_PaintBkColor(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintBkImage(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintStatusImage(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintText(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_PaintBorder(Handle: CControlUI; hDC: HDC); cdecl;
procedure Delphi_ControlUI_DoPostPaint(Handle: CControlUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ControlUI_SetVirtualWnd(Handle: CControlUI; pstrValue: LPCTSTR); cdecl;
function Delphi_ControlUI_GetVirtualWnd(Handle: CControlUI): CDuiString; cdecl;


//================================CDelphi_WindowImplBase============================

function Delphi_Delphi_WindowImplBase_CppCreate: CDelphi_WindowImplBase; cdecl;
procedure Delphi_Delphi_WindowImplBase_CppDestroy(Handle: CDelphi_WindowImplBase); cdecl;
function Delphi_Delphi_WindowImplBase_GetHWND(Handle: CDelphi_WindowImplBase): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_RegisterWindowClass(Handle: CDelphi_WindowImplBase): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_RegisterSuperclass(Handle: CDelphi_WindowImplBase): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_Create_01(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD; rc: TRect; hMenu: HMENU): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_Create_02(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD; x: Integer; y: Integer; cx: Integer; cy: Integer; hMenu: HMENU): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_CreateDuiWindow(Handle: CDelphi_WindowImplBase; hwndParent: HWND; pstrWindowName: LPCTSTR; dwStyle: DWORD; dwExStyle: DWORD): HWND; cdecl;
function Delphi_Delphi_WindowImplBase_Subclass(Handle: CDelphi_WindowImplBase; hWnd: HWND): HWND; cdecl;
procedure Delphi_Delphi_WindowImplBase_Unsubclass(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_ShowWindow(Handle: CDelphi_WindowImplBase; bShow: Boolean; bTakeFocus: Boolean); cdecl;
function Delphi_Delphi_WindowImplBase_ShowModal(Handle: CDelphi_WindowImplBase): UINT; cdecl;
procedure Delphi_Delphi_WindowImplBase_Close(Handle: CDelphi_WindowImplBase; nRet: UINT); cdecl;
procedure Delphi_Delphi_WindowImplBase_CenterWindow(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetIcon(Handle: CDelphi_WindowImplBase; nRes: UINT); cdecl;
function Delphi_Delphi_WindowImplBase_SendMessage(Handle: CDelphi_WindowImplBase; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
function Delphi_Delphi_WindowImplBase_PostMessage(Handle: CDelphi_WindowImplBase; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
procedure Delphi_Delphi_WindowImplBase_ResizeClient(Handle: CDelphi_WindowImplBase; cx: Integer; cy: Integer); cdecl;
function Delphi_Delphi_WindowImplBase_AddVirtualWnd(Handle: CDelphi_WindowImplBase; strName: CDuiString; pObject: CNotifyPump): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_RemoveVirtualWnd(Handle: CDelphi_WindowImplBase; strName: CDuiString): Boolean; cdecl;
procedure Delphi_Delphi_WindowImplBase_NotifyPump(Handle: CDelphi_WindowImplBase; var msg: TNotifyUI); cdecl;
function Delphi_Delphi_WindowImplBase_LoopDispatch(Handle: CDelphi_WindowImplBase; var msg: TNotifyUI): Boolean; cdecl;
function Delphi_Delphi_WindowImplBase_GetPaintManagerUI(Handle: CDelphi_WindowImplBase): CPaintManagerUI; cdecl;
procedure Delphi_Delphi_WindowImplBase_SetDelphiSelf(Handle: CDelphi_WindowImplBase; ASelf: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetClassName(Handle: CDelphi_WindowImplBase; ClassName: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetSkinFile(Handle: CDelphi_WindowImplBase; SkinFile: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetSkinFolder(Handle: CDelphi_WindowImplBase; SkinFolder: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetZipFileName(Handle: CDelphi_WindowImplBase; ZipFileName: LPCTSTR); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetResourceType(Handle: CDelphi_WindowImplBase; RType: UILIB_RESOURCETYPE); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetInitWindow(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetFinalMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetHandleMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetNotify(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetClick(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetMessageHandler(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetHandleCustomMessage(Handle: CDelphi_WindowImplBase; Callback: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetCreateControl(Handle: CDelphi_WindowImplBase; CallBack: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetGetItemText(Handle: CDelphi_WindowImplBase; CallBack: Pointer); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetGetClassStyle(Handle: CDelphi_WindowImplBase; uStyle: UINT); cdecl;
procedure Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager(Handle: CDelphi_WindowImplBase); cdecl;
procedure Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent(Handle: CDelphi_WindowImplBase; ACallBack: LPVOID); cdecl;

//================================CPaintManagerUI============================

function Delphi_PaintManagerUI_CppCreate: CPaintManagerUI; cdecl;
procedure Delphi_PaintManagerUI_CppDestroy(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Init(Handle: CPaintManagerUI; hWnd: HWND; pstrName: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_IsUpdateNeeded(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_NeedUpdate(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Invalidate_01(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_Invalidate_02(Handle: CPaintManagerUI; const rcItem: TRect); cdecl;
function Delphi_PaintManagerUI_GetPaintDC(Handle: CPaintManagerUI): HDC; cdecl;
function Delphi_PaintManagerUI_GetPaintWindow(Handle: CPaintManagerUI): HWND; cdecl;
function Delphi_PaintManagerUI_GetTooltipWindow(Handle: CPaintManagerUI): HWND; cdecl;
function Delphi_PaintManagerUI_GetMousePos(Handle: CPaintManagerUI): TPoint; cdecl;
procedure Delphi_PaintManagerUI_GetClientSize(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_GetInitSize(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetInitSize(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
function Delphi_PaintManagerUI_GetSizeBox(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetSizeBox(Handle: CPaintManagerUI; const rcSizeBox: TRect); cdecl;
function Delphi_PaintManagerUI_GetCaptionRect(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetCaptionRect(Handle: CPaintManagerUI; const rcCaption: TRect); cdecl;
procedure Delphi_PaintManagerUI_GetRoundCorner(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetRoundCorner(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
procedure Delphi_PaintManagerUI_GetMinInfo(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetMinInfo(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
procedure Delphi_PaintManagerUI_GetMaxInfo(Handle: CPaintManagerUI; var Result: TSize); cdecl;
procedure Delphi_PaintManagerUI_SetMaxInfo(Handle: CPaintManagerUI; cx: Integer; cy: Integer); cdecl;
function Delphi_PaintManagerUI_IsShowUpdateRect(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetShowUpdateRect(Handle: CPaintManagerUI; show: Boolean); cdecl;
function Delphi_PaintManagerUI_GetInstance: HINST; cdecl;
function Delphi_PaintManagerUI_GetInstancePath: CDuiString; cdecl;
function Delphi_PaintManagerUI_GetCurrentPath: CDuiString; cdecl;
function Delphi_PaintManagerUI_GetResourceDll: HINST; cdecl;
function Delphi_PaintManagerUI_GetResourcePath: PCDuiString; cdecl;
function Delphi_PaintManagerUI_GetResourceZip: PCDuiString; cdecl;
function Delphi_PaintManagerUI_IsCachedResourceZip: Boolean; cdecl;
function Delphi_PaintManagerUI_GetResourceZipHandle: THandle; cdecl;
procedure Delphi_PaintManagerUI_SetInstance(hInst: HINST); cdecl;
procedure Delphi_PaintManagerUI_SetCurrentPath(pStrPath: LPCTSTR); cdecl;
procedure Delphi_PaintManagerUI_SetResourceDll(hInst: HINST); cdecl;
procedure Delphi_PaintManagerUI_SetResourcePath(pStrPath: LPCTSTR); cdecl;
procedure Delphi_PaintManagerUI_SetResourceZip_01(pVoid: Pointer; len: LongInt); cdecl;
procedure Delphi_PaintManagerUI_SetResourceZip_02(pstrZip: LPCTSTR; bCachedResourceZip: Boolean); cdecl;
function Delphi_PaintManagerUI_GetHSL(H: PShort; S: PShort; L: PShort): Boolean; cdecl;
procedure Delphi_PaintManagerUI_ReloadSkin; cdecl;
function Delphi_PaintManagerUI_LoadPlugin(pstrModuleName: LPCTSTR): Boolean; cdecl;
function Delphi_PaintManagerUI_GetPlugins: CStdPtrArray; cdecl;
function Delphi_PaintManagerUI_IsForceUseSharedRes(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetForceUseSharedRes(Handle: CPaintManagerUI; bForce: Boolean); cdecl;
function Delphi_PaintManagerUI_IsPainting(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetPainting(Handle: CPaintManagerUI; bIsPainting: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultDisabledColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultDisabledColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultLinkFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultLinkFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultSelectedBkColor(Handle: CPaintManagerUI): DWORD; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultSelectedBkColor(Handle: CPaintManagerUI; dwColor: DWORD; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultFontInfo(Handle: CPaintManagerUI): PFontInfo; cdecl;
procedure Delphi_PaintManagerUI_SetDefaultFont(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetCustomFontCount(Handle: CPaintManagerUI; bShared: Boolean): DWORD; cdecl;
function Delphi_PaintManagerUI_AddFont(Handle: CPaintManagerUI; id: Integer; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFont_01(Handle: CPaintManagerUI; id: Integer): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFont_02(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean): HFONT; cdecl;
function Delphi_PaintManagerUI_GetFontIndex_01(Handle: CPaintManagerUI; hFont: HFONT; bShared: Boolean): Integer; cdecl;
function Delphi_PaintManagerUI_GetFontIndex_02(Handle: CPaintManagerUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): Integer; cdecl;
procedure Delphi_PaintManagerUI_RemoveFont_01(Handle: CPaintManagerUI; hFont: HFONT; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveFont_02(Handle: CPaintManagerUI; id: Integer; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllFonts(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetFontInfo_01(Handle: CPaintManagerUI; id: Integer): PFontInfo; cdecl;
function Delphi_PaintManagerUI_GetFontInfo_02(Handle: CPaintManagerUI; hFont: HFONT): PFontInfo; cdecl;
function Delphi_PaintManagerUI_GetImage(Handle: CPaintManagerUI; bitmap: LPCTSTR): PImageInfo; cdecl;
function Delphi_PaintManagerUI_GetImageEx(Handle: CPaintManagerUI; bitmap: LPCTSTR; AType: LPCTSTR; mask: DWORD; bUseHSL: Boolean): PImageInfo; cdecl;
function Delphi_PaintManagerUI_AddImage_01(Handle: CPaintManagerUI; bitmap: LPCTSTR; AType: LPCTSTR; mask: DWORD; bUseHSL: Boolean; bShared: Boolean): PImageInfo; cdecl;
function Delphi_PaintManagerUI_AddImage_02(Handle: CPaintManagerUI; bitmap: LPCTSTR; hBitmap: HBITMAP; iWidth: Integer; iHeight: Integer; bAlpha: Boolean; bShared: Boolean): PImageInfo; cdecl;
procedure Delphi_PaintManagerUI_RemoveImage(Handle: CPaintManagerUI; bitmap: LPCTSTR; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllImages(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_ReloadSharedImages; cdecl;
procedure Delphi_PaintManagerUI_ReloadImages(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_AddDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR; pStrControlAttrList: LPCTSTR; bShared: Boolean); cdecl;
function Delphi_PaintManagerUI_GetDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveDefaultAttributeList(Handle: CPaintManagerUI; pStrControlName: LPCTSTR; bShared: Boolean): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllDefaultAttributeList(Handle: CPaintManagerUI; bShared: Boolean); cdecl;
procedure Delphi_PaintManagerUI_AddMultiLanguageString(id: Integer; pStrMultiLanguage: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetMultiLanguageString(id: Integer): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveMultiLanguageString(id: Integer): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllMultiLanguageString; cdecl;
procedure Delphi_PaintManagerUI_ProcessMultiLanguageTokens(var pStrMultiLanguage: CDuiString); cdecl;
function Delphi_PaintManagerUI_AttachDialog(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_InitControls(Handle: CPaintManagerUI; pControl: CControlUI; pParent: CControlUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_ReapObjects(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_AddOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_GetOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR): CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_RemoveOptionGroup(Handle: CPaintManagerUI; pStrGroupName: LPCTSTR; pControl: CControlUI); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllOptionGroups(Handle: CPaintManagerUI); cdecl;
function Delphi_PaintManagerUI_GetFocus(Handle: CPaintManagerUI): CControlUI; cdecl;
procedure Delphi_PaintManagerUI_SetFocus(Handle: CPaintManagerUI; pControl: CControlUI; bFocusWnd: Boolean); cdecl;
procedure Delphi_PaintManagerUI_SetFocusNeeded(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_SetNextTabControl(Handle: CPaintManagerUI; bForward: Boolean): Boolean; cdecl;
function Delphi_PaintManagerUI_SetTimer(Handle: CPaintManagerUI; pControl: CControlUI; nTimerID: UINT; uElapse: UINT): Boolean; cdecl;
function Delphi_PaintManagerUI_KillTimer_01(Handle: CPaintManagerUI; pControl: CControlUI; nTimerID: UINT): Boolean; cdecl;
procedure Delphi_PaintManagerUI_KillTimer_02(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
procedure Delphi_PaintManagerUI_RemoveAllTimers(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_SetCapture(Handle: CPaintManagerUI); cdecl;
procedure Delphi_PaintManagerUI_ReleaseCapture(Handle: CPaintManagerUI); cdecl;
function Delphi_PaintManagerUI_IsCaptured(Handle: CPaintManagerUI): Boolean; cdecl;
function Delphi_PaintManagerUI_AddNotifier(Handle: CPaintManagerUI; pControl: INotifyUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveNotifier(Handle: CPaintManagerUI; pControl: INotifyUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SendNotify_01(Handle: CPaintManagerUI; const Msg: TNotifyUI; bAsync: Boolean; bEnableRepeat: Boolean); cdecl;
procedure Delphi_PaintManagerUI_SendNotify_02(Handle: CPaintManagerUI; pControl: CControlUI; pstrMessage: LPCTSTR; wParam: WPARAM; lParam: LPARAM; bAsync: Boolean; bEnableRepeat: Boolean); cdecl;
function Delphi_PaintManagerUI_AddPreMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemovePreMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_AddMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveMessageFilter(Handle: CPaintManagerUI; pFilter: IMessageFilterUI): Boolean; cdecl;
function Delphi_PaintManagerUI_GetPostPaintCount(Handle: CPaintManagerUI): Integer; cdecl;
function Delphi_PaintManagerUI_AddPostPaint(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_RemovePostPaint(Handle: CPaintManagerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_PaintManagerUI_SetPostPaintIndex(Handle: CPaintManagerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_PaintManagerUI_GetNativeWindowCount(Handle: CPaintManagerUI): Integer; cdecl;
function Delphi_PaintManagerUI_AddNativeWindow(Handle: CPaintManagerUI; pControl: CControlUI; hChildWnd: HWND): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveNativeWindow(Handle: CPaintManagerUI; hChildWnd: HWND): Boolean; cdecl;
procedure Delphi_PaintManagerUI_AddDelayedCleanup(Handle: CPaintManagerUI; pControl: CControlUI); cdecl;
function Delphi_PaintManagerUI_AddTranslateAccelerator(Handle: CPaintManagerUI; pTranslateAccelerator: ITranslateAccelerator): Boolean; cdecl;
function Delphi_PaintManagerUI_RemoveTranslateAccelerator(Handle: CPaintManagerUI; pTranslateAccelerator: ITranslateAccelerator): Boolean; cdecl;
function Delphi_PaintManagerUI_TranslateAccelerator(Handle: CPaintManagerUI; pMsg: PMsg): Boolean; cdecl;
function Delphi_PaintManagerUI_GetRoot(Handle: CPaintManagerUI): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindControl_01(Handle: CPaintManagerUI; pt: TPoint): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindControl_02(Handle: CPaintManagerUI; pstrName: LPCTSTR): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByPoint(Handle: CPaintManagerUI; pParent: CControlUI; pt: TPoint): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByName(Handle: CPaintManagerUI; pParent: CControlUI; pstrName: LPCTSTR): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlByClass(Handle: CPaintManagerUI; pParent: CControlUI; pstrClass: LPCTSTR; iIndex: Integer): CControlUI; cdecl;
function Delphi_PaintManagerUI_FindSubControlsByClass(Handle: CPaintManagerUI; pParent: CControlUI; pstrClass: LPCTSTR): CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_MessageLoop; cdecl;
function Delphi_PaintManagerUI_TranslateMessage(pMsg: PMsg): Boolean; cdecl;
procedure Delphi_PaintManagerUI_Term; cdecl;
function Delphi_PaintManagerUI_MessageHandler(Handle: CPaintManagerUI; uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean; cdecl;
function Delphi_PaintManagerUI_PreMessageHandler(Handle: CPaintManagerUI; uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean; cdecl;
procedure Delphi_PaintManagerUI_UsedVirtualWnd(Handle: CPaintManagerUI; bUsed: Boolean); cdecl;

function Delphi_PaintManagerUI_GetName(Handle: CPaintManagerUI): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_GetTooltipWindowWidth(Handle: CPaintManagerUI): Integer; cdecl;
procedure Delphi_PaintManagerUI_SetTooltipWindowWidth(Handle: CPaintManagerUI; iWidth: Integer); cdecl;
function Delphi_PaintManagerUI_GetHoverTime(Handle: CPaintManagerUI): Integer; cdecl;
procedure Delphi_PaintManagerUI_SetHoverTime(Handle: CPaintManagerUI; iTime: Integer); cdecl;
function Delphi_PaintManagerUI_GetOpacity(Handle: CPaintManagerUI): Byte; cdecl;
procedure Delphi_PaintManagerUI_SetOpacity(Handle: CPaintManagerUI; nOpacity: Byte); cdecl;
function Delphi_PaintManagerUI_IsLayered(Handle: CPaintManagerUI): Boolean; cdecl;
procedure Delphi_PaintManagerUI_SetLayered(Handle: CPaintManagerUI; bLayered: Boolean); cdecl;
function Delphi_PaintManagerUI_GetLayeredInset(Handle: CPaintManagerUI): PRect; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredInset(Handle: CPaintManagerUI; const rcLayeredInset: TRect); cdecl;
function Delphi_PaintManagerUI_GetLayeredOpacity(Handle: CPaintManagerUI): Byte; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredOpacity(Handle: CPaintManagerUI; nOpacity: Byte); cdecl;
function Delphi_PaintManagerUI_GetLayeredImage(Handle: CPaintManagerUI): LPCTSTR; cdecl;
procedure Delphi_PaintManagerUI_SetLayeredImage(Handle: CPaintManagerUI; pstrImage: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetPaintManager(pstrName: LPCTSTR): CPaintManagerUI; cdecl;
function Delphi_PaintManagerUI_GetPaintManagers: CStdPtrArray; cdecl;
procedure Delphi_PaintManagerUI_AddWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR; pstrAttr: LPCTSTR); cdecl;
function Delphi_PaintManagerUI_GetWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR): LPCTSTR; cdecl;
function Delphi_PaintManagerUI_RemoveWindowCustomAttribute(Handle: CPaintManagerUI; pstrName: LPCTSTR): Boolean; cdecl;
procedure Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute(Handle: CPaintManagerUI); cdecl;
//================================CContainerUI============================

function Delphi_ContainerUI_CppCreate: CContainerUI; cdecl;
procedure Delphi_ContainerUI_CppDestroy(Handle: CContainerUI); cdecl;
function Delphi_ContainerUI_GetClass(Handle: CContainerUI): LPCTSTR; cdecl;
function Delphi_ContainerUI_GetInterface(Handle: CContainerUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ContainerUI_GetItemAt(Handle: CContainerUI; iIndex: Integer): CControlUI; cdecl;
function Delphi_ContainerUI_GetItemIndex(Handle: CContainerUI; pControl: CControlUI): Integer; cdecl;
function Delphi_ContainerUI_SetItemIndex(Handle: CContainerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ContainerUI_GetCount(Handle: CContainerUI): Integer; cdecl;
function Delphi_ContainerUI_Add(Handle: CContainerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ContainerUI_AddAt(Handle: CContainerUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ContainerUI_Remove(Handle: CContainerUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ContainerUI_RemoveAt(Handle: CContainerUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ContainerUI_RemoveAll(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_DoEvent(Handle: CContainerUI; var event: TEventUI); cdecl;
procedure Delphi_ContainerUI_SetVisible(Handle: CContainerUI; bVisible: Boolean); cdecl;
procedure Delphi_ContainerUI_SetInternVisible(Handle: CContainerUI; bVisible: Boolean); cdecl;
procedure Delphi_ContainerUI_SetMouseEnabled(Handle: CContainerUI; bEnable: Boolean); cdecl;
procedure Delphi_ContainerUI_GetInset(Handle: CContainerUI; var Result: TRect); cdecl;
procedure Delphi_ContainerUI_SetInset(Handle: CContainerUI; rcInset: TRect); cdecl;
function Delphi_ContainerUI_GetChildPadding(Handle: CContainerUI): Integer; cdecl;
procedure Delphi_ContainerUI_SetChildPadding(Handle: CContainerUI; iPadding: Integer); cdecl;
function Delphi_ContainerUI_IsAutoDestroy(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetAutoDestroy(Handle: CContainerUI; bAuto: Boolean); cdecl;
function Delphi_ContainerUI_IsDelayedDestroy(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetDelayedDestroy(Handle: CContainerUI; bDelayed: Boolean); cdecl;
function Delphi_ContainerUI_IsMouseChildEnabled(Handle: CContainerUI): Boolean; cdecl;
procedure Delphi_ContainerUI_SetMouseChildEnabled(Handle: CContainerUI; bEnable: Boolean); cdecl;
function Delphi_ContainerUI_FindSelectable(Handle: CContainerUI; iIndex: Integer; bForward: Boolean): Integer; cdecl;
procedure Delphi_ContainerUI_GetClientPos(Handle: CContainerUI; var Result: TRect); cdecl;
procedure Delphi_ContainerUI_SetPos(Handle: CContainerUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ContainerUI_Move(Handle: CContainerUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ContainerUI_DoPaint(Handle: CContainerUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ContainerUI_SetAttribute(Handle: CContainerUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ContainerUI_SetManager(Handle: CContainerUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_ContainerUI_FindControl(Handle: CContainerUI; Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI; cdecl;
function Delphi_ContainerUI_SetSubControlText(Handle: CContainerUI; pstrSubControlName: LPCTSTR; pstrText: LPCTSTR): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlFixedHeight(Handle: CContainerUI; pstrSubControlName: LPCTSTR; cy: Integer): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlFixedWdith(Handle: CContainerUI; pstrSubControlName: LPCTSTR; cx: Integer): Boolean; cdecl;
function Delphi_ContainerUI_SetSubControlUserData(Handle: CContainerUI; pstrSubControlName: LPCTSTR; pstrText: LPCTSTR): Boolean; cdecl;
function Delphi_ContainerUI_GetSubControlText(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CDuiString; cdecl;
function Delphi_ContainerUI_GetSubControlFixedHeight(Handle: CContainerUI; pstrSubControlName: LPCTSTR): Integer; cdecl;
function Delphi_ContainerUI_GetSubControlFixedWdith(Handle: CContainerUI; pstrSubControlName: LPCTSTR): Integer; cdecl;
function Delphi_ContainerUI_GetSubControlUserData(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CDuiString; cdecl;
function Delphi_ContainerUI_FindSubControl(Handle: CContainerUI; pstrSubControlName: LPCTSTR): CControlUI; cdecl;
procedure Delphi_ContainerUI_GetScrollPos(Handle: CContainerUI; var Result: TSize); cdecl;
procedure Delphi_ContainerUI_GetScrollRange(Handle: CContainerUI; var Result: TSize); cdecl;
procedure Delphi_ContainerUI_SetScrollPos(Handle: CContainerUI; szPos: TSize); cdecl;
procedure Delphi_ContainerUI_LineUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_HomeUp(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EndDown(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_LineRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_PageRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_HomeLeft(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EndRight(Handle: CContainerUI); cdecl;
procedure Delphi_ContainerUI_EnableScrollBar(Handle: CContainerUI; bEnableVertical: Boolean; bEnableHorizontal: Boolean); cdecl;
function Delphi_ContainerUI_GetVerticalScrollBar(Handle: CContainerUI): CScrollBarUI; cdecl;
function Delphi_ContainerUI_GetHorizontalScrollBar(Handle: CContainerUI): CScrollBarUI; cdecl;

//================================CVerticalLayoutUI============================

function Delphi_VerticalLayoutUI_CppCreate: CVerticalLayoutUI; cdecl;
procedure Delphi_VerticalLayoutUI_CppDestroy(Handle: CVerticalLayoutUI); cdecl;
function Delphi_VerticalLayoutUI_GetClass(Handle: CVerticalLayoutUI): LPCTSTR; cdecl;
function Delphi_VerticalLayoutUI_GetInterface(Handle: CVerticalLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_VerticalLayoutUI_GetControlFlags(Handle: CVerticalLayoutUI): UINT; cdecl;
procedure Delphi_VerticalLayoutUI_SetSepHeight(Handle: CVerticalLayoutUI; iHeight: Integer); cdecl;
function Delphi_VerticalLayoutUI_GetSepHeight(Handle: CVerticalLayoutUI): Integer; cdecl;
procedure Delphi_VerticalLayoutUI_SetSepImmMode(Handle: CVerticalLayoutUI; bImmediately: Boolean); cdecl;
function Delphi_VerticalLayoutUI_IsSepImmMode(Handle: CVerticalLayoutUI): Boolean; cdecl;
procedure Delphi_VerticalLayoutUI_SetAttribute(Handle: CVerticalLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_VerticalLayoutUI_DoEvent(Handle: CVerticalLayoutUI; var event: TEventUI); cdecl;
procedure Delphi_VerticalLayoutUI_SetPos(Handle: CVerticalLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_VerticalLayoutUI_DoPostPaint(Handle: CVerticalLayoutUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_VerticalLayoutUI_GetThumbRect(Handle: CVerticalLayoutUI; bUseNew: Boolean; var Result: TRect); cdecl;

//================================CListUI============================

function Delphi_ListUI_CppCreate: CListUI; cdecl;
procedure Delphi_ListUI_CppDestroy(Handle: CListUI); cdecl;
function Delphi_ListUI_GetClass(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetControlFlags(Handle: CListUI): UINT; cdecl;
function Delphi_ListUI_GetInterface(Handle: CListUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListUI_GetScrollSelect(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetScrollSelect(Handle: CListUI; bScrollSelect: Boolean); cdecl;
function Delphi_ListUI_GetCurSel(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_SelectItem(Handle: CListUI; iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_ListUI_GetHeader(Handle: CListUI): CListHeaderUI; cdecl;
function Delphi_ListUI_GetList(Handle: CListUI): CContainerUI; cdecl;
function Delphi_ListUI_GetListInfo(Handle: CListUI): PListInfoUI; cdecl;
function Delphi_ListUI_GetItemAt(Handle: CListUI; iIndex: Integer): CControlUI; cdecl;
function Delphi_ListUI_GetItemIndex(Handle: CListUI; pControl: CControlUI): Integer; cdecl;
function Delphi_ListUI_SetItemIndex(Handle: CListUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ListUI_GetCount(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_Add(Handle: CListUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ListUI_AddAt(Handle: CListUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ListUI_Remove(Handle: CListUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ListUI_RemoveAt(Handle: CListUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ListUI_RemoveAll(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EnsureVisible(Handle: CListUI; iIndex: Integer); cdecl;
procedure Delphi_ListUI_Scroll(Handle: CListUI; dx: Integer; dy: Integer); cdecl;
function Delphi_ListUI_GetChildPadding(Handle: CListUI): Integer; cdecl;
procedure Delphi_ListUI_SetChildPadding(Handle: CListUI; iPadding: Integer); cdecl;
procedure Delphi_ListUI_SetItemFont(Handle: CListUI; index: Integer); cdecl;
procedure Delphi_ListUI_SetItemTextStyle(Handle: CListUI; uStyle: UINT); cdecl;
procedure Delphi_ListUI_SetItemTextPadding(Handle: CListUI; rc: TRect); cdecl;
procedure Delphi_ListUI_SetItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetItemBkImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ListUI_IsAlternateBk(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetAlternateBk(Handle: CListUI; bAlternateBk: Boolean); cdecl;
procedure Delphi_ListUI_SetSelectedItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetSelectedItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetSelectedItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetHotItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetHotItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetHotItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetDisabledItemTextColor(Handle: CListUI; dwTextColor: DWORD); cdecl;
procedure Delphi_ListUI_SetDisabledItemBkColor(Handle: CListUI; dwBkColor: DWORD); cdecl;
procedure Delphi_ListUI_SetDisabledItemImage(Handle: CListUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ListUI_SetItemLineColor(Handle: CListUI; dwLineColor: DWORD); cdecl;
function Delphi_ListUI_IsItemShowHtml(Handle: CListUI): Boolean; cdecl;
procedure Delphi_ListUI_SetItemShowHtml(Handle: CListUI; bShowHtml: Boolean); cdecl;
procedure Delphi_ListUI_GetItemTextPadding(Handle: CListUI; var Result: TRect); cdecl;
function Delphi_ListUI_GetItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetItemBkImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetSelectedItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetSelectedItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetSelectedItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetHotItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetHotItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetHotItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetDisabledItemTextColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetDisabledItemBkColor(Handle: CListUI): DWORD; cdecl;
function Delphi_ListUI_GetDisabledItemImage(Handle: CListUI): LPCTSTR; cdecl;
function Delphi_ListUI_GetItemLineColor(Handle: CListUI): DWORD; cdecl;
procedure Delphi_ListUI_SetMultiExpanding(Handle: CListUI; bMultiExpandable: Boolean); cdecl;
function Delphi_ListUI_GetExpandedItem(Handle: CListUI): Integer; cdecl;
function Delphi_ListUI_ExpandItem(Handle: CListUI; iIndex: Integer; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListUI_SetPos(Handle: CListUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ListUI_Move(Handle: CListUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ListUI_DoEvent(Handle: CListUI; var event: TEventUI); cdecl;
procedure Delphi_ListUI_SetAttribute(Handle: CListUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_ListUI_GetTextCallback(Handle: CListUI): IListCallbackUI; cdecl;
procedure Delphi_ListUI_SetTextCallback(Handle: CListUI; pCallback: IListCallbackUI); cdecl;
procedure Delphi_ListUI_GetScrollPos(Handle: CListUI; var Result: TSize); cdecl;
procedure Delphi_ListUI_GetScrollRange(Handle: CListUI; var Result: TSize); cdecl;
procedure Delphi_ListUI_SetScrollPos(Handle: CListUI; szPos: TSize); cdecl;
procedure Delphi_ListUI_LineUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_HomeUp(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EndDown(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_LineRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_PageRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_HomeLeft(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EndRight(Handle: CListUI); cdecl;
procedure Delphi_ListUI_EnableScrollBar(Handle: CListUI; bEnableVertical: Boolean; bEnableHorizontal: Boolean); cdecl;
function Delphi_ListUI_GetVerticalScrollBar(Handle: CListUI): CScrollBarUI; cdecl;
function Delphi_ListUI_GetHorizontalScrollBar(Handle: CListUI): CScrollBarUI; cdecl;
function Delphi_ListUI_SortItems(Handle: CListUI; pfnCompare: PULVCompareFunc; dwData: UINT_PTR): BOOL; cdecl;

//================================CDelphi_ListUI============================

function Delphi_Delphi_ListUI_CppCreate: CDelphi_ListUI; cdecl;
procedure Delphi_Delphi_ListUI_CppDestroy(Handle: CDelphi_ListUI); cdecl;
procedure Delphi_Delphi_ListUI_SetDelphiSelf(Handle: CDelphi_ListUI; ASelf: Pointer); cdecl;
procedure Delphi_Delphi_ListUI_SetDoEvent(Handle: CDelphi_ListUI; ADoEvent: Pointer); cdecl;

//================================CLabelUI============================

function Delphi_LabelUI_CppCreate: CLabelUI; cdecl;
procedure Delphi_LabelUI_CppDestroy(Handle: CLabelUI); cdecl;
function Delphi_LabelUI_GetClass(Handle: CLabelUI): LPCTSTR; cdecl;
procedure Delphi_LabelUI_SetText(Handle: CLabelUI; pstrText: LPCTSTR); cdecl;
function Delphi_LabelUI_GetInterface(Handle: CLabelUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_LabelUI_SetTextStyle(Handle: CLabelUI; uStyle: UINT); cdecl;
function Delphi_LabelUI_GetTextStyle(Handle: CLabelUI): UINT; cdecl;
procedure Delphi_LabelUI_SetTextColor(Handle: CLabelUI; dwTextColor: DWORD); cdecl;
function Delphi_LabelUI_GetTextColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetDisabledTextColor(Handle: CLabelUI; dwTextColor: DWORD); cdecl;
function Delphi_LabelUI_GetDisabledTextColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetFont(Handle: CLabelUI; index: Integer); cdecl;
function Delphi_LabelUI_GetFont(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_GetTextPadding(Handle: CLabelUI; var Result: TRect); cdecl;
procedure Delphi_LabelUI_SetTextPadding(Handle: CLabelUI; rc: TRect); cdecl;
function Delphi_LabelUI_IsShowHtml(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetShowHtml(Handle: CLabelUI; bShowHtml: Boolean); cdecl;
procedure Delphi_LabelUI_EstimateSize(Handle: CLabelUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_LabelUI_DoEvent(Handle: CLabelUI; var event: TEventUI); cdecl;
procedure Delphi_LabelUI_SetAttribute(Handle: CLabelUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_LabelUI_PaintText(Handle: CLabelUI; hDC: HDC); cdecl;
procedure Delphi_LabelUI_SetEnabledEffect(Handle: CLabelUI; _EnabledEffect: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledEffect(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetEnabledLuminous(Handle: CLabelUI; bEnableLuminous: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledLuminous(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetLuminousFuzzy(Handle: CLabelUI; fFuzzy: Single); cdecl;
function Delphi_LabelUI_GetLuminousFuzzy(Handle: CLabelUI): Single; cdecl;
procedure Delphi_LabelUI_SetGradientLength(Handle: CLabelUI; _GradientLength: Integer); cdecl;
function Delphi_LabelUI_GetGradientLength(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_SetShadowOffset(Handle: CLabelUI; _offset: Integer; _angle: Integer); cdecl;
procedure Delphi_LabelUI_GetShadowOffset(Handle: CLabelUI; var Result: TRectF); cdecl;
procedure Delphi_LabelUI_SetTextColor1(Handle: CLabelUI; _TextColor1: DWORD); cdecl;
function Delphi_LabelUI_GetTextColor1(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetTextShadowColorA(Handle: CLabelUI; _TextShadowColorA: DWORD); cdecl;
function Delphi_LabelUI_GetTextShadowColorA(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetTextShadowColorB(Handle: CLabelUI; _TextShadowColorB: DWORD); cdecl;
function Delphi_LabelUI_GetTextShadowColorB(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetStrokeColor(Handle: CLabelUI; _StrokeColor: DWORD); cdecl;
function Delphi_LabelUI_GetStrokeColor(Handle: CLabelUI): DWORD; cdecl;
procedure Delphi_LabelUI_SetGradientAngle(Handle: CLabelUI; _SetGradientAngle: Integer); cdecl;
function Delphi_LabelUI_GetGradientAngle(Handle: CLabelUI): Integer; cdecl;
procedure Delphi_LabelUI_SetEnabledStroke(Handle: CLabelUI; _EnabledStroke: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledStroke(Handle: CLabelUI): Boolean; cdecl;
procedure Delphi_LabelUI_SetEnabledShadow(Handle: CLabelUI; _EnabledShadowe: Boolean); cdecl;
function Delphi_LabelUI_GetEnabledShadow(Handle: CLabelUI): Boolean; cdecl;

//================================CButtonUI============================

function Delphi_ButtonUI_CppCreate: CButtonUI; cdecl;
procedure Delphi_ButtonUI_CppDestroy(Handle: CButtonUI); cdecl;
function Delphi_ButtonUI_GetClass(Handle: CButtonUI): LPCTSTR; cdecl;
function Delphi_ButtonUI_GetInterface(Handle: CButtonUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ButtonUI_GetControlFlags(Handle: CButtonUI): UINT; cdecl;
function Delphi_ButtonUI_Activate(Handle: CButtonUI): Boolean; cdecl;
procedure Delphi_ButtonUI_SetEnabled(Handle: CButtonUI; bEnable: Boolean); cdecl;
procedure Delphi_ButtonUI_DoEvent(Handle: CButtonUI; var event: TEventUI); cdecl;
function Delphi_ButtonUI_GetNormalImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetNormalImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetHotImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetHotImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetPushedImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetPushedImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetFocusedImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetFocusedImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetDisabledImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetDisabledImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetForeImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetForeImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ButtonUI_GetHotForeImage(Handle: CButtonUI): LPCTSTR; cdecl;
procedure Delphi_ButtonUI_SetHotForeImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_SetHotBkColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetHotBkColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetHotTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetHotTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetPushedTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetPushedTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_SetFocusedTextColor(Handle: CButtonUI; dwColor: DWORD); cdecl;
function Delphi_ButtonUI_GetFocusedTextColor(Handle: CButtonUI): DWORD; cdecl;
procedure Delphi_ButtonUI_EstimateSize(Handle: CButtonUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ButtonUI_SetAttribute(Handle: CButtonUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_PaintText(Handle: CButtonUI; hDC: HDC); cdecl;
procedure Delphi_ButtonUI_PaintStatusImage(Handle: CButtonUI; hDC: HDC); cdecl;

procedure Delphi_ButtonUI_SetFiveStatusImage(Handle: CButtonUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ButtonUI_SetFadeAlphaDelta(Handle: CButtonUI; uDelta: Byte); cdecl;
function Delphi_ButtonUI_GetFadeAlphaDelta(Handle: CButtonUI): Boolean; cdecl;




//================================COptionUI============================

function Delphi_OptionUI_CppCreate: COptionUI; cdecl;
procedure Delphi_OptionUI_CppDestroy(Handle: COptionUI); cdecl;
function Delphi_OptionUI_GetClass(Handle: COptionUI): LPCTSTR; cdecl;
function Delphi_OptionUI_GetInterface(Handle: COptionUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_OptionUI_SetManager(Handle: COptionUI; pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean); cdecl;
function Delphi_OptionUI_Activate(Handle: COptionUI): Boolean; cdecl;
procedure Delphi_OptionUI_SetEnabled(Handle: COptionUI; bEnable: Boolean); cdecl;
function Delphi_OptionUI_GetSelectedImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetSelectedImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
function Delphi_OptionUI_GetSelectedHotImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetSelectedHotImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_OptionUI_SetSelectedTextColor(Handle: COptionUI; dwTextColor: DWORD); cdecl;
function Delphi_OptionUI_GetSelectedTextColor(Handle: COptionUI): DWORD; cdecl;
procedure Delphi_OptionUI_SetSelectedBkColor(Handle: COptionUI; dwBkColor: DWORD); cdecl;
function Delphi_OptionUI_GetSelectBkColor(Handle: COptionUI): DWORD; cdecl;
function Delphi_OptionUI_GetForeImage(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetForeImage(Handle: COptionUI; pStrImage: LPCTSTR); cdecl;
function Delphi_OptionUI_GetGroup(Handle: COptionUI): LPCTSTR; cdecl;
procedure Delphi_OptionUI_SetGroup(Handle: COptionUI; pStrGroupName: LPCTSTR); cdecl;
function Delphi_OptionUI_IsSelected(Handle: COptionUI): Boolean; cdecl;
procedure Delphi_OptionUI_Selected(Handle: COptionUI; bSelected: Boolean; bTriggerEvent: Boolean); cdecl;
procedure Delphi_OptionUI_EstimateSize(Handle: COptionUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_OptionUI_SetAttribute(Handle: COptionUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_OptionUI_PaintStatusImage(Handle: COptionUI; hDC: HDC); cdecl;
procedure Delphi_OptionUI_PaintText(Handle: COptionUI; hDC: HDC); cdecl;

//================================CCheckBoxUI============================

function Delphi_CheckBoxUI_CppCreate: CCheckBoxUI; cdecl;
procedure Delphi_CheckBoxUI_CppDestroy(Handle: CCheckBoxUI); cdecl;
function Delphi_CheckBoxUI_GetClass(Handle: CCheckBoxUI): LPCTSTR; cdecl;
function Delphi_CheckBoxUI_GetInterface(Handle: CCheckBoxUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_CheckBoxUI_SetCheck(Handle: CCheckBoxUI; bCheck: Boolean; bTriggerEvent: Boolean); cdecl;
function Delphi_CheckBoxUI_GetCheck(Handle: CCheckBoxUI): Boolean; cdecl;

//================================CListContainerElementUI============================

function Delphi_ListContainerElementUI_CppCreate: CListContainerElementUI; cdecl;
procedure Delphi_ListContainerElementUI_CppDestroy(Handle: CListContainerElementUI); cdecl;
function Delphi_ListContainerElementUI_GetClass(Handle: CListContainerElementUI): LPCTSTR; cdecl;
function Delphi_ListContainerElementUI_GetControlFlags(Handle: CListContainerElementUI): UINT; cdecl;
function Delphi_ListContainerElementUI_GetInterface(Handle: CListContainerElementUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListContainerElementUI_GetIndex(Handle: CListContainerElementUI): Integer; cdecl;
procedure Delphi_ListContainerElementUI_SetIndex(Handle: CListContainerElementUI; iIndex: Integer); cdecl;
function Delphi_ListContainerElementUI_GetOwner(Handle: CListContainerElementUI): IListOwnerUI; cdecl;
procedure Delphi_ListContainerElementUI_SetOwner(Handle: CListContainerElementUI; pOwner: CControlUI); cdecl;
procedure Delphi_ListContainerElementUI_SetVisible(Handle: CListContainerElementUI; bVisible: Boolean); cdecl;
procedure Delphi_ListContainerElementUI_SetEnabled(Handle: CListContainerElementUI; bEnable: Boolean); cdecl;
function Delphi_ListContainerElementUI_IsSelected(Handle: CListContainerElementUI): Boolean; cdecl;
function Delphi_ListContainerElementUI_Select(Handle: CListContainerElementUI; bSelect: Boolean): Boolean; cdecl;
function Delphi_ListContainerElementUI_IsExpanded(Handle: CListContainerElementUI): Boolean; cdecl;
function Delphi_ListContainerElementUI_Expand(Handle: CListContainerElementUI; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListContainerElementUI_Invalidate(Handle: CListContainerElementUI); cdecl;
function Delphi_ListContainerElementUI_Activate(Handle: CListContainerElementUI): Boolean; cdecl;
procedure Delphi_ListContainerElementUI_DoEvent(Handle: CListContainerElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListContainerElementUI_SetAttribute(Handle: CListContainerElementUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ListContainerElementUI_DoPaint(Handle: CListContainerElementUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ListContainerElementUI_DrawItemText(Handle: CListContainerElementUI; hDC: HDC; const rcItem: TRect); cdecl;
procedure Delphi_ListContainerElementUI_DrawItemBk(Handle: CListContainerElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CComboUI============================

function Delphi_ComboUI_CppCreate: CComboUI; cdecl;
procedure Delphi_ComboUI_CppDestroy(Handle: CComboUI); cdecl;
function Delphi_ComboUI_GetClass(Handle: CComboUI): LPCTSTR; cdecl;
function Delphi_ComboUI_GetInterface(Handle: CComboUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ComboUI_DoInit(Handle: CComboUI); cdecl;
function Delphi_ComboUI_GetControlFlags(Handle: CComboUI): UINT; cdecl;
function Delphi_ComboUI_GetText(Handle: CComboUI): CDuiString; cdecl;
procedure Delphi_ComboUI_SetEnabled(Handle: CComboUI; bEnable: Boolean); cdecl;
function Delphi_ComboUI_GetDropBoxAttributeList(Handle: CComboUI): CDuiString; cdecl;
procedure Delphi_ComboUI_SetDropBoxAttributeList(Handle: CComboUI; pstrList: LPCTSTR); cdecl;
procedure Delphi_ComboUI_GetDropBoxSize(Handle: CComboUI; var Result: TSize); cdecl;
procedure Delphi_ComboUI_SetDropBoxSize(Handle: CComboUI; szDropBox: TSize); cdecl;
function Delphi_ComboUI_GetCurSel(Handle: CComboUI): Integer; cdecl;
function Delphi_ComboUI_GetSelectCloseFlag(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetSelectCloseFlag(Handle: CComboUI; flag: Boolean); cdecl;
function Delphi_ComboUI_SelectItem(Handle: CComboUI; iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_ComboUI_SetItemIndex(Handle: CComboUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ComboUI_Add(Handle: CComboUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ComboUI_AddAt(Handle: CComboUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_ComboUI_Remove(Handle: CComboUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_ComboUI_RemoveAt(Handle: CComboUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_ComboUI_RemoveAll(Handle: CComboUI); cdecl;
function Delphi_ComboUI_Activate(Handle: CComboUI): Boolean; cdecl;
function Delphi_ComboUI_GetShowText(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetShowText(Handle: CComboUI; flag: Boolean); cdecl;
procedure Delphi_ComboUI_GetTextPadding(Handle: CComboUI; var Result: TRect); cdecl;
procedure Delphi_ComboUI_SetTextPadding(Handle: CComboUI; rc: TRect); cdecl;
function Delphi_ComboUI_GetNormalImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetNormalImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetHotImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetHotImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetPushedImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetPushedImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetFocusedImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetFocusedImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetDisabledImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetDisabledImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetListInfo(Handle: CComboUI): PListInfoUI; cdecl;
procedure Delphi_ComboUI_SetItemFont(Handle: CComboUI; index: Integer); cdecl;
procedure Delphi_ComboUI_SetItemTextStyle(Handle: CComboUI; uStyle: UINT); cdecl;
procedure Delphi_ComboUI_GetItemTextPadding(Handle: CComboUI; var Result: TRect); cdecl;
procedure Delphi_ComboUI_SetItemTextPadding(Handle: CComboUI; rc: TRect); cdecl;
function Delphi_ComboUI_GetItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetItemBkImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetItemBkImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_IsAlternateBk(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetAlternateBk(Handle: CComboUI; bAlternateBk: Boolean); cdecl;
function Delphi_ComboUI_GetSelectedItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetSelectedItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetSelectedItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetSelectedItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetSelectedItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetSelectedItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetHotItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetHotItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetHotItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetHotItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetHotItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetHotItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetDisabledItemTextColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetDisabledItemTextColor(Handle: CComboUI; dwTextColor: DWORD); cdecl;
function Delphi_ComboUI_GetDisabledItemBkColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetDisabledItemBkColor(Handle: CComboUI; dwBkColor: DWORD); cdecl;
function Delphi_ComboUI_GetDisabledItemImage(Handle: CComboUI): LPCTSTR; cdecl;
procedure Delphi_ComboUI_SetDisabledItemImage(Handle: CComboUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ComboUI_GetItemLineColor(Handle: CComboUI): DWORD; cdecl;
procedure Delphi_ComboUI_SetItemLineColor(Handle: CComboUI; dwLineColor: DWORD); cdecl;
function Delphi_ComboUI_IsItemShowHtml(Handle: CComboUI): Boolean; cdecl;
procedure Delphi_ComboUI_SetItemShowHtml(Handle: CComboUI; bShowHtml: Boolean); cdecl;
procedure Delphi_ComboUI_EstimateSize(Handle: CComboUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ComboUI_SetPos(Handle: CComboUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ComboUI_Move(Handle: CComboUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ComboUI_DoEvent(Handle: CComboUI; var event: TEventUI); cdecl;
procedure Delphi_ComboUI_SetAttribute(Handle: CComboUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ComboUI_DoPaint(Handle: CComboUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ComboUI_PaintText(Handle: CComboUI; hDC: HDC); cdecl;
procedure Delphi_ComboUI_PaintStatusImage(Handle: CComboUI; hDC: HDC); cdecl;

//================================CDateTimeUI============================

function Delphi_DateTimeUI_CppCreate: CDateTimeUI; cdecl;
procedure Delphi_DateTimeUI_CppDestroy(Handle: CDateTimeUI); cdecl;
function Delphi_DateTimeUI_GetClass(Handle: CDateTimeUI): LPCTSTR; cdecl;
function Delphi_DateTimeUI_GetInterface(Handle: CDateTimeUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_DateTimeUI_GetControlFlags(Handle: CDateTimeUI): UINT; cdecl;
function Delphi_DateTimeUI_GetNativeWindow(Handle: CDateTimeUI): HWND; cdecl;
function Delphi_DateTimeUI_GetTime(Handle: CDateTimeUI): PSYSTEMTIME; cdecl;
procedure Delphi_DateTimeUI_SetTime(Handle: CDateTimeUI; pst: PSYSTEMTIME); cdecl;
procedure Delphi_DateTimeUI_SetReadOnly(Handle: CDateTimeUI; bReadOnly: Boolean); cdecl;
function Delphi_DateTimeUI_IsReadOnly(Handle: CDateTimeUI): Boolean; cdecl;
procedure Delphi_DateTimeUI_UpdateText(Handle: CDateTimeUI); cdecl;
procedure Delphi_DateTimeUI_DoEvent(Handle: CDateTimeUI; var event: TEventUI); cdecl;

//================================CEditUI============================

function Delphi_EditUI_CppCreate: CEditUI; cdecl;
procedure Delphi_EditUI_CppDestroy(Handle: CEditUI); cdecl;
function Delphi_EditUI_GetClass(Handle: CEditUI): LPCTSTR; cdecl;
function Delphi_EditUI_GetInterface(Handle: CEditUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_EditUI_GetControlFlags(Handle: CEditUI): UINT; cdecl;
function Delphi_EditUI_GetNativeWindow(Handle: CEditUI): HWND; cdecl;
procedure Delphi_EditUI_SetEnabled(Handle: CEditUI; bEnable: Boolean); cdecl;
procedure Delphi_EditUI_SetText(Handle: CEditUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetMaxChar(Handle: CEditUI; uMax: UINT); cdecl;
function Delphi_EditUI_GetMaxChar(Handle: CEditUI): UINT; cdecl;
procedure Delphi_EditUI_SetReadOnly(Handle: CEditUI; bReadOnly: Boolean); cdecl;
function Delphi_EditUI_IsReadOnly(Handle: CEditUI): Boolean; cdecl;
procedure Delphi_EditUI_SetPasswordMode(Handle: CEditUI; bPasswordMode: Boolean); cdecl;
function Delphi_EditUI_IsPasswordMode(Handle: CEditUI): Boolean; cdecl;
procedure Delphi_EditUI_SetPasswordChar(Handle: CEditUI; cPasswordChar: Char); cdecl;
function Delphi_EditUI_GetPasswordChar(Handle: CEditUI): Char; cdecl;
procedure Delphi_EditUI_SetNumberOnly(Handle: CEditUI; bNumberOnly: Boolean); cdecl;
function Delphi_EditUI_IsNumberOnly(Handle: CEditUI): Boolean; cdecl;
function Delphi_EditUI_GetWindowStyls(Handle: CEditUI): Integer; cdecl;
function Delphi_EditUI_GetNativeEditHWND(Handle: CEditUI): HWND; cdecl;
function Delphi_EditUI_GetNormalImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetNormalImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetHotImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetHotImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetFocusedImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetFocusedImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
function Delphi_EditUI_GetDisabledImage(Handle: CEditUI): LPCTSTR; cdecl;
procedure Delphi_EditUI_SetDisabledImage(Handle: CEditUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetNativeEditBkColor(Handle: CEditUI; dwBkColor: DWORD); cdecl;
function Delphi_EditUI_GetNativeEditBkColor(Handle: CEditUI): DWORD; cdecl;
procedure Delphi_EditUI_SetSel(Handle: CEditUI; nStartChar: LongInt; nEndChar: LongInt); cdecl;
procedure Delphi_EditUI_SetSelAll(Handle: CEditUI); cdecl;
procedure Delphi_EditUI_SetReplaceSel(Handle: CEditUI; lpszReplace: LPCTSTR); cdecl;
procedure Delphi_EditUI_SetPos(Handle: CEditUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_EditUI_Move(Handle: CEditUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_EditUI_SetVisible(Handle: CEditUI; bVisible: Boolean); cdecl;
procedure Delphi_EditUI_SetInternVisible(Handle: CEditUI; bVisible: Boolean); cdecl;
procedure Delphi_EditUI_EstimateSize(Handle: CEditUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_EditUI_DoEvent(Handle: CEditUI; var event: TEventUI); cdecl;
procedure Delphi_EditUI_SetAttribute(Handle: CEditUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_EditUI_PaintStatusImage(Handle: CEditUI; hDC: HDC); cdecl;
procedure Delphi_EditUI_PaintText(Handle: CEditUI; hDC: HDC); cdecl;

//================================CProgressUI============================

function Delphi_ProgressUI_CppCreate: CProgressUI; cdecl;
procedure Delphi_ProgressUI_CppDestroy(Handle: CProgressUI); cdecl;
function Delphi_ProgressUI_GetClass(Handle: CProgressUI): LPCTSTR; cdecl;
function Delphi_ProgressUI_GetInterface(Handle: CProgressUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ProgressUI_IsHorizontal(Handle: CProgressUI): Boolean; cdecl;
procedure Delphi_ProgressUI_SetHorizontal(Handle: CProgressUI; bHorizontal: Boolean); cdecl;
function Delphi_ProgressUI_IsStretchForeImage(Handle: CProgressUI): Boolean; cdecl;
procedure Delphi_ProgressUI_SetStretchForeImage(Handle: CProgressUI; bStretchForeImage: Boolean); cdecl;
function Delphi_ProgressUI_GetMinValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetMinValue(Handle: CProgressUI; nMin: Integer); cdecl;
function Delphi_ProgressUI_GetMaxValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetMaxValue(Handle: CProgressUI; nMax: Integer); cdecl;
function Delphi_ProgressUI_GetValue(Handle: CProgressUI): Integer; cdecl;
procedure Delphi_ProgressUI_SetValue(Handle: CProgressUI; nValue: Integer); cdecl;
function Delphi_ProgressUI_GetForeImage(Handle: CProgressUI): LPCTSTR; cdecl;
procedure Delphi_ProgressUI_SetForeImage(Handle: CProgressUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ProgressUI_SetAttribute(Handle: CProgressUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ProgressUI_PaintStatusImage(Handle: CProgressUI; hDC: HDC); cdecl;

//================================CScrollBarUI============================

function Delphi_ScrollBarUI_CppCreate: CScrollBarUI; cdecl;
procedure Delphi_ScrollBarUI_CppDestroy(Handle: CScrollBarUI); cdecl;
function Delphi_ScrollBarUI_GetClass(Handle: CScrollBarUI): LPCTSTR; cdecl;
function Delphi_ScrollBarUI_GetInterface(Handle: CScrollBarUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ScrollBarUI_GetOwner(Handle: CScrollBarUI): CContainerUI; cdecl;
procedure Delphi_ScrollBarUI_SetOwner(Handle: CScrollBarUI; pOwner: CContainerUI); cdecl;
procedure Delphi_ScrollBarUI_SetVisible(Handle: CScrollBarUI; bVisible: Boolean); cdecl;
procedure Delphi_ScrollBarUI_SetEnabled(Handle: CScrollBarUI; bEnable: Boolean); cdecl;
procedure Delphi_ScrollBarUI_SetFocus(Handle: CScrollBarUI); cdecl;
function Delphi_ScrollBarUI_IsHorizontal(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetHorizontal(Handle: CScrollBarUI; bHorizontal: Boolean); cdecl;
function Delphi_ScrollBarUI_GetScrollRange(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetScrollRange(Handle: CScrollBarUI; nRange: Integer); cdecl;
function Delphi_ScrollBarUI_GetScrollPos(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetScrollPos(Handle: CScrollBarUI; nPos: Integer; bTriggerEvent: Boolean); cdecl;
function Delphi_ScrollBarUI_GetLineSize(Handle: CScrollBarUI): Integer; cdecl;
procedure Delphi_ScrollBarUI_SetLineSize(Handle: CScrollBarUI; nSize: Integer); cdecl;
function Delphi_ScrollBarUI_GetShowButton1(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetShowButton1(Handle: CScrollBarUI; bShow: Boolean); cdecl;
function Delphi_ScrollBarUI_GetButton1Color(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetButton1Color(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetButton1NormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1NormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1HotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1HotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1PushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1PushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton1DisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton1DisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetShowButton2(Handle: CScrollBarUI): Boolean; cdecl;
procedure Delphi_ScrollBarUI_SetShowButton2(Handle: CScrollBarUI; bShow: Boolean); cdecl;
function Delphi_ScrollBarUI_GetButton2Color(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetButton2Color(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetButton2NormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2NormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2HotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2HotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2PushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2PushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetButton2DisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetButton2DisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbColor(Handle: CScrollBarUI): DWORD; cdecl;
procedure Delphi_ScrollBarUI_SetThumbColor(Handle: CScrollBarUI; dwColor: DWORD); cdecl;
function Delphi_ScrollBarUI_GetThumbNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetThumbDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetThumbDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetRailDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetRailDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkNormalImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkNormalImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkHotImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkHotImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkPushedImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkPushedImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
function Delphi_ScrollBarUI_GetBkDisabledImage(Handle: CScrollBarUI): LPCTSTR; cdecl;
procedure Delphi_ScrollBarUI_SetBkDisabledImage(Handle: CScrollBarUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_ScrollBarUI_SetPos(Handle: CScrollBarUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_ScrollBarUI_DoEvent(Handle: CScrollBarUI; var event: TEventUI); cdecl;
procedure Delphi_ScrollBarUI_SetAttribute(Handle: CScrollBarUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ScrollBarUI_DoPaint(Handle: CScrollBarUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ScrollBarUI_PaintBk(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintButton1(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintButton2(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintThumb(Handle: CScrollBarUI; hDC: HDC); cdecl;
procedure Delphi_ScrollBarUI_PaintRail(Handle: CScrollBarUI; hDC: HDC); cdecl;

//================================CSliderUI============================

function Delphi_SliderUI_CppCreate: CSliderUI; cdecl;
procedure Delphi_SliderUI_CppDestroy(Handle: CSliderUI); cdecl;
function Delphi_SliderUI_GetClass(Handle: CSliderUI): LPCTSTR; cdecl;
function Delphi_SliderUI_GetControlFlags(Handle: CSliderUI): UINT; cdecl;
function Delphi_SliderUI_GetInterface(Handle: CSliderUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_SliderUI_SetEnabled(Handle: CSliderUI; bEnable: Boolean); cdecl;
function Delphi_SliderUI_GetChangeStep(Handle: CSliderUI): Integer; cdecl;
procedure Delphi_SliderUI_SetChangeStep(Handle: CSliderUI; step: Integer); cdecl;
procedure Delphi_SliderUI_SetThumbSize(Handle: CSliderUI; szXY: TSize); cdecl;
procedure Delphi_SliderUI_GetThumbRect(Handle: CSliderUI; var Result: TRect); cdecl;
function Delphi_SliderUI_GetThumbImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
function Delphi_SliderUI_GetThumbHotImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbHotImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
function Delphi_SliderUI_GetThumbPushedImage(Handle: CSliderUI): LPCTSTR; cdecl;
procedure Delphi_SliderUI_SetThumbPushedImage(Handle: CSliderUI; pStrImage: LPCTSTR); cdecl;
procedure Delphi_SliderUI_DoEvent(Handle: CSliderUI; var event: TEventUI); cdecl;
procedure Delphi_SliderUI_SetAttribute(Handle: CSliderUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_SliderUI_PaintStatusImage(Handle: CSliderUI; hDC: HDC); cdecl;

//================================CTextUI============================

function Delphi_TextUI_CppCreate: CTextUI; cdecl;
procedure Delphi_TextUI_CppDestroy(Handle: CTextUI); cdecl;
function Delphi_TextUI_GetClass(Handle: CTextUI): LPCTSTR; cdecl;
function Delphi_TextUI_GetControlFlags(Handle: CTextUI): UINT; cdecl;
function Delphi_TextUI_GetInterface(Handle: CTextUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TextUI_GetLinkContent(Handle: CTextUI; iIndex: Integer): CDuiString; cdecl;
procedure Delphi_TextUI_DoEvent(Handle: CTextUI; var event: TEventUI); cdecl;
procedure Delphi_TextUI_EstimateSize(Handle: CTextUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_TextUI_PaintText(Handle: CTextUI; hDC: HDC); cdecl;

//================================CTreeNodeUI============================

function Delphi_TreeNodeUI_CppCreate(_ParentNode: CTreeNodeUI): CTreeNodeUI; cdecl;
procedure Delphi_TreeNodeUI_CppDestroy(Handle: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_GetClass(Handle: CTreeNodeUI): LPCTSTR; cdecl;
function Delphi_TreeNodeUI_GetInterface(Handle: CTreeNodeUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_TreeNodeUI_DoEvent(Handle: CTreeNodeUI; var event: TEventUI); cdecl;
procedure Delphi_TreeNodeUI_Invalidate(Handle: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_Select(Handle: CTreeNodeUI; bSelect: Boolean; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_TreeNodeUI_Add(Handle: CTreeNodeUI; _pTreeNodeUI: CControlUI): Boolean; cdecl;
function Delphi_TreeNodeUI_AddAt(Handle: CTreeNodeUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_TreeNodeUI_Remove(Handle: CTreeNodeUI; pControl: CControlUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleTag(Handle: CTreeNodeUI; _IsVisible: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleTag(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetItemText(Handle: CTreeNodeUI; pstrValue: LPCTSTR); cdecl;
function Delphi_TreeNodeUI_GetItemText(Handle: CTreeNodeUI): CDuiString; cdecl;
procedure Delphi_TreeNodeUI_CheckBoxSelected(Handle: CTreeNodeUI; _Selected: Boolean); cdecl;
function Delphi_TreeNodeUI_IsCheckBoxSelected(Handle: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_IsHasChild(Handle: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_AddChildNode(Handle: CTreeNodeUI; _pTreeNodeUI: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeNodeUI_RemoveAt(Handle: CTreeNodeUI; _pTreeNodeUI: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetParentNode(Handle: CTreeNodeUI; _pParentTreeNode: CTreeNodeUI); cdecl;
function Delphi_TreeNodeUI_GetParentNode(Handle: CTreeNodeUI): CTreeNodeUI; cdecl;
function Delphi_TreeNodeUI_GetCountChild(Handle: CTreeNodeUI): LongInt; cdecl;
procedure Delphi_TreeNodeUI_SetTreeView(Handle: CTreeNodeUI; _CTreeViewUI: CTreeViewUI); cdecl;
function Delphi_TreeNodeUI_GetTreeView(Handle: CTreeNodeUI): CTreeViewUI; cdecl;
function Delphi_TreeNodeUI_GetChildNode(Handle: CTreeNodeUI; _nIndex: Integer): CTreeNodeUI; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleFolderBtn(Handle: CTreeNodeUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleFolderBtn(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetVisibleCheckBtn(Handle: CTreeNodeUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeNodeUI_GetVisibleCheckBtn(Handle: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeNodeUI_SetItemTextColor(Handle: CTreeNodeUI; _dwItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetItemTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetItemHotTextColor(Handle: CTreeNodeUI; _dwItemHotTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetItemHotTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetSelItemTextColor(Handle: CTreeNodeUI; _dwSelItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetSelItemTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetSelItemHotTextColor(Handle: CTreeNodeUI; _dwSelHotItemTextColor: DWORD); cdecl;
function Delphi_TreeNodeUI_GetSelItemHotTextColor(Handle: CTreeNodeUI): DWORD; cdecl;
procedure Delphi_TreeNodeUI_SetAttribute(Handle: CTreeNodeUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
function Delphi_TreeNodeUI_GetTreeNodes(Handle: CTreeNodeUI): CStdPtrArray; cdecl;
function Delphi_TreeNodeUI_GetTreeIndex(Handle: CTreeNodeUI): Integer; cdecl;
function Delphi_TreeNodeUI_GetNodeIndex(Handle: CTreeNodeUI): Integer; cdecl;

//================================CTreeViewUI============================

function Delphi_TreeViewUI_CppCreate: CTreeViewUI; cdecl;
procedure Delphi_TreeViewUI_CppDestroy(Handle: CTreeViewUI); cdecl;
function Delphi_TreeViewUI_GetClass(Handle: CTreeViewUI): LPCTSTR; cdecl;
function Delphi_TreeViewUI_GetInterface(Handle: CTreeViewUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TreeViewUI_Add(Handle: CTreeViewUI; pControl: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_AddAt_01(Handle: CTreeViewUI; pControl: CTreeNodeUI; iIndex: Integer): LongInt; cdecl;
function Delphi_TreeViewUI_AddAt_02(Handle: CTreeViewUI; pControl: CTreeNodeUI; _IndexNode: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_Remove(Handle: CTreeViewUI; pControl: CTreeNodeUI): Boolean; cdecl;
function Delphi_TreeViewUI_RemoveAt(Handle: CTreeViewUI; iIndex: Integer): Boolean; cdecl;
procedure Delphi_TreeViewUI_RemoveAll(Handle: CTreeViewUI); cdecl;
function Delphi_TreeViewUI_OnCheckBoxChanged(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_OnFolderChanged(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_OnDBClickItem(Handle: CTreeViewUI; param: PPointer): Boolean; cdecl;
function Delphi_TreeViewUI_SetItemCheckBox(Handle: CTreeViewUI; _Selected: Boolean; _TreeNode: CTreeNodeUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetItemExpand(Handle: CTreeViewUI; _Expanded: Boolean; _TreeNode: CTreeNodeUI); cdecl;
procedure Delphi_TreeViewUI_Notify(Handle: CTreeViewUI; var msg: TNotifyUI); cdecl;
procedure Delphi_TreeViewUI_SetVisibleFolderBtn(Handle: CTreeViewUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeViewUI_GetVisibleFolderBtn(Handle: CTreeViewUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetVisibleCheckBtn(Handle: CTreeViewUI; _IsVisibled: Boolean); cdecl;
function Delphi_TreeViewUI_GetVisibleCheckBtn(Handle: CTreeViewUI): Boolean; cdecl;
procedure Delphi_TreeViewUI_SetItemMinWidth(Handle: CTreeViewUI; _ItemMinWidth: UINT); cdecl;
function Delphi_TreeViewUI_GetItemMinWidth(Handle: CTreeViewUI): UINT; cdecl;
procedure Delphi_TreeViewUI_SetItemTextColor(Handle: CTreeViewUI; _dwItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetItemHotTextColor(Handle: CTreeViewUI; _dwItemHotTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetSelItemTextColor(Handle: CTreeViewUI; _dwSelItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetSelItemHotTextColor(Handle: CTreeViewUI; _dwSelHotItemTextColor: DWORD); cdecl;
procedure Delphi_TreeViewUI_SetAttribute(Handle: CTreeViewUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CTabLayoutUI============================

function Delphi_TabLayoutUI_CppCreate: CTabLayoutUI; cdecl;
procedure Delphi_TabLayoutUI_CppDestroy(Handle: CTabLayoutUI); cdecl;
function Delphi_TabLayoutUI_GetClass(Handle: CTabLayoutUI): LPCTSTR; cdecl;
function Delphi_TabLayoutUI_GetInterface(Handle: CTabLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_TabLayoutUI_Add(Handle: CTabLayoutUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_TabLayoutUI_AddAt(Handle: CTabLayoutUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_TabLayoutUI_Remove(Handle: CTabLayoutUI; pControl: CControlUI): Boolean; cdecl;
procedure Delphi_TabLayoutUI_RemoveAll(Handle: CTabLayoutUI); cdecl;
function Delphi_TabLayoutUI_GetCurSel(Handle: CTabLayoutUI): Integer; cdecl;
function Delphi_TabLayoutUI_SelectItem_01(Handle: CTabLayoutUI; iIndex: Integer; bTriggerEvent: Boolean): Boolean; cdecl;
function Delphi_TabLayoutUI_SelectItem_02(Handle: CTabLayoutUI; pControl: CControlUI; bTriggerEvent: Boolean): Boolean; cdecl;
procedure Delphi_TabLayoutUI_SetPos(Handle: CTabLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_TabLayoutUI_SetAttribute(Handle: CTabLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CHorizontalLayoutUI============================

function Delphi_HorizontalLayoutUI_CppCreate: CHorizontalLayoutUI; cdecl;
procedure Delphi_HorizontalLayoutUI_CppDestroy(Handle: CHorizontalLayoutUI); cdecl;
function Delphi_HorizontalLayoutUI_GetClass(Handle: CHorizontalLayoutUI): LPCTSTR; cdecl;
function Delphi_HorizontalLayoutUI_GetInterface(Handle: CHorizontalLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_HorizontalLayoutUI_GetControlFlags(Handle: CHorizontalLayoutUI): UINT; cdecl;
procedure Delphi_HorizontalLayoutUI_SetSepWidth(Handle: CHorizontalLayoutUI; iWidth: Integer); cdecl;
function Delphi_HorizontalLayoutUI_GetSepWidth(Handle: CHorizontalLayoutUI): Integer; cdecl;
procedure Delphi_HorizontalLayoutUI_SetSepImmMode(Handle: CHorizontalLayoutUI; bImmediately: Boolean); cdecl;
function Delphi_HorizontalLayoutUI_IsSepImmMode(Handle: CHorizontalLayoutUI): Boolean; cdecl;
procedure Delphi_HorizontalLayoutUI_SetAttribute(Handle: CHorizontalLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_HorizontalLayoutUI_DoEvent(Handle: CHorizontalLayoutUI; var event: TEventUI); cdecl;
procedure Delphi_HorizontalLayoutUI_SetPos(Handle: CHorizontalLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_HorizontalLayoutUI_DoPostPaint(Handle: CHorizontalLayoutUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_HorizontalLayoutUI_GetThumbRect(Handle: CHorizontalLayoutUI; bUseNew: Boolean; var Result: TRect); cdecl;

//================================CListHeaderUI============================

function Delphi_ListHeaderUI_CppCreate: CListHeaderUI; cdecl;
procedure Delphi_ListHeaderUI_CppDestroy(Handle: CListHeaderUI); cdecl;
function Delphi_ListHeaderUI_GetClass(Handle: CListHeaderUI): LPCTSTR; cdecl;
function Delphi_ListHeaderUI_GetInterface(Handle: CListHeaderUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListHeaderUI_EstimateSize(Handle: CListHeaderUI; szAvailable: TSize; var Result: TSize); cdecl;


 //================================CRenderClip============================

function Delphi_RenderClip_CppCreate: CRenderClip; cdecl;
procedure Delphi_RenderClip_CppDestroy(Handle: CRenderClip); cdecl;
procedure Delphi_RenderClip_GenerateClip(hDC: HDC; rc: TRect; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_GenerateRoundClip(hDC: HDC; rc: TRect; rcItem: TRect; width: Integer; height: Integer; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_UseOldClipBegin(hDC: HDC; var clip: CRenderClip); cdecl;
procedure Delphi_RenderClip_UseOldClipEnd(hDC: HDC; var clip: CRenderClip); cdecl;

//================================CRenderEngine============================

function Delphi_RenderEngine_CppCreate: CRenderEngine; cdecl;
procedure Delphi_RenderEngine_CppDestroy(Handle: CRenderEngine); cdecl;
function Delphi_RenderEngine_AdjustColor(dwColor: DWORD; H: Short; S: Short; L: Short): DWORD; cdecl;
function Delphi_RenderEngine_CreateARGB32Bitmap(hDC: HDC; cx: Integer; cy: Integer; pBits: COLORREF): HBITMAP; cdecl;
procedure Delphi_RenderEngine_AdjustImage(bUseHSL: Boolean; imageInfo: PImageInfo; H: Short; S: Short; L: Short); cdecl;
function Delphi_RenderEngine_LoadImage(bitmap: STRINGorID; AType: LPCTSTR; mask: DWORD): PImageInfo; cdecl;
procedure Delphi_RenderEngine_FreeImage(bitmap: PImageInfo; bDelete: Boolean); cdecl;
procedure Delphi_RenderEngine_DrawImage_01(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcCorners: TRect; alphaChannel: Boolean; uFade: Byte; hole: Boolean; xtiled: Boolean; ytiled: Boolean); cdecl;
function Delphi_RenderEngine_DrawImage_02(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean; cdecl;
procedure Delphi_RenderEngine_DrawColor(hDC: HDC; var rc: TRect; color: DWORD); cdecl;
procedure Delphi_RenderEngine_DrawGradient(hDC: HDC; var rc: TRect; dwFirst: DWORD; dwSecond: DWORD; bVertical: Boolean; nSteps: Integer); cdecl;
procedure Delphi_RenderEngine_DrawLine(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawRect(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawRoundRect(hDC: HDC; var rc: TRect; width: Integer; height: Integer; nSize: Integer; dwPenColor: DWORD; nStyle: Integer); cdecl;
procedure Delphi_RenderEngine_DrawText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: LPCTSTR; dwTextColor: DWORD; iFont: Integer; uStyle: UINT); cdecl;
procedure Delphi_RenderEngine_DrawHtmlText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: LPCTSTR; dwTextColor: DWORD; pLinks: PRect; sLinks: CDuiString; var nLinkRects: Integer; uStyle: UINT); cdecl;
function Delphi_RenderEngine_GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect): HBITMAP; cdecl;
procedure Delphi_RenderEngine_GetTextSize(hDC: HDC; pManager: CPaintManagerUI; pstrText: LPCTSTR; iFont: Integer; uStyle: UINT; var Result: TSize); cdecl;



//================================CListElementUI============================

//function Delphi_ListElementUI_CppCreate: CListElementUI; cdecl;
//procedure Delphi_ListElementUI_CppDestroy(Handle: CListElementUI); cdecl;
function Delphi_ListElementUI_GetClass(Handle: CListElementUI): LPCTSTR; cdecl;
function Delphi_ListElementUI_GetControlFlags(Handle: CListElementUI): UINT; cdecl;
function Delphi_ListElementUI_GetInterface(Handle: CListElementUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListElementUI_SetEnabled(Handle: CListElementUI; bEnable: Boolean); cdecl;
function Delphi_ListElementUI_GetIndex(Handle: CListElementUI): Integer; cdecl;
procedure Delphi_ListElementUI_SetIndex(Handle: CListElementUI; iIndex: Integer); cdecl;
function Delphi_ListElementUI_GetOwner(Handle: CListElementUI): IListOwnerUI; cdecl;
procedure Delphi_ListElementUI_SetOwner(Handle: CListElementUI; pOwner: CControlUI); cdecl;
procedure Delphi_ListElementUI_SetVisible(Handle: CListElementUI; bVisible: Boolean); cdecl;
function Delphi_ListElementUI_IsSelected(Handle: CListElementUI): Boolean; cdecl;
function Delphi_ListElementUI_Select(Handle: CListElementUI; bSelect: Boolean): Boolean; cdecl;
function Delphi_ListElementUI_IsExpanded(Handle: CListElementUI): Boolean; cdecl;
function Delphi_ListElementUI_Expand(Handle: CListElementUI; bExpand: Boolean): Boolean; cdecl;
procedure Delphi_ListElementUI_Invalidate(Handle: CListElementUI); cdecl;
function Delphi_ListElementUI_Activate(Handle: CListElementUI): Boolean; cdecl;
procedure Delphi_ListElementUI_DoEvent(Handle: CListElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListElementUI_SetAttribute(Handle: CListElementUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ListElementUI_DrawItemBk(Handle: CListElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CListLabelElementUI============================

function Delphi_ListLabelElementUI_CppCreate: CListLabelElementUI; cdecl;
procedure Delphi_ListLabelElementUI_CppDestroy(Handle: CListLabelElementUI); cdecl;
function Delphi_ListLabelElementUI_GetClass(Handle: CListLabelElementUI): LPCTSTR; cdecl;
function Delphi_ListLabelElementUI_GetInterface(Handle: CListLabelElementUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_ListLabelElementUI_DoEvent(Handle: CListLabelElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListLabelElementUI_EstimateSize(Handle: CListLabelElementUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ListLabelElementUI_DoPaint(Handle: CListLabelElementUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_ListLabelElementUI_DrawItemText(Handle: CListLabelElementUI; hDC: HDC; const rcItem: TRect); cdecl;

//================================CListTextElementUI============================

function Delphi_ListTextElementUI_CppCreate: CListTextElementUI; cdecl;
procedure Delphi_ListTextElementUI_CppDestroy(Handle: CListTextElementUI); cdecl;
function Delphi_ListTextElementUI_GetClass(Handle: CListTextElementUI): LPCTSTR; cdecl;
function Delphi_ListTextElementUI_GetInterface(Handle: CListTextElementUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ListTextElementUI_GetControlFlags(Handle: CListTextElementUI): UINT; cdecl;
function Delphi_ListTextElementUI_GetText(Handle: CListTextElementUI; iIndex: Integer): LPCTSTR; cdecl;
procedure Delphi_ListTextElementUI_SetText(Handle: CListTextElementUI; iIndex: Integer; pstrText: LPCTSTR); cdecl;
procedure Delphi_ListTextElementUI_SetOwner(Handle: CListTextElementUI; pOwner: CControlUI); cdecl;
function Delphi_ListTextElementUI_GetLinkContent(Handle: CListTextElementUI; iIndex: Integer): CDuiString; cdecl;
procedure Delphi_ListTextElementUI_DoEvent(Handle: CListTextElementUI; var event: TEventUI); cdecl;
procedure Delphi_ListTextElementUI_EstimateSize(Handle: CListTextElementUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_ListTextElementUI_DrawItemText(Handle: CListTextElementUI; hDC: HDC; const rcItem: TRect); cdecl;


//================================CGifAnimUI============================

function Delphi_GifAnimUI_CppCreate: CGifAnimUI; cdecl;
procedure Delphi_GifAnimUI_CppDestroy(Handle: CGifAnimUI); cdecl;
function Delphi_GifAnimUI_GetClass(Handle: CGifAnimUI): LPCTSTR; cdecl;
function Delphi_GifAnimUI_GetInterface(Handle: CGifAnimUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_GifAnimUI_DoInit(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_DoPaint(Handle: CGifAnimUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_GifAnimUI_DoEvent(Handle: CGifAnimUI; var event: TEventUI); cdecl;
procedure Delphi_GifAnimUI_SetVisible(Handle: CGifAnimUI; bVisible: Boolean); cdecl;
procedure Delphi_GifAnimUI_SetAttribute(Handle: CGifAnimUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_GifAnimUI_SetBkImage(Handle: CGifAnimUI; pStrImage: LPCTSTR); cdecl;
function Delphi_GifAnimUI_GetBkImage(Handle: CGifAnimUI): LPCTSTR; cdecl;
procedure Delphi_GifAnimUI_SetAutoPlay(Handle: CGifAnimUI; bIsAuto: Boolean); cdecl;
function Delphi_GifAnimUI_IsAutoPlay(Handle: CGifAnimUI): Boolean; cdecl;
procedure Delphi_GifAnimUI_SetAutoSize(Handle: CGifAnimUI; bIsAuto: Boolean); cdecl;
function Delphi_GifAnimUI_IsAutoSize(Handle: CGifAnimUI): Boolean; cdecl;
procedure Delphi_GifAnimUI_PlayGif(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_PauseGif(Handle: CGifAnimUI); cdecl;
procedure Delphi_GifAnimUI_StopGif(Handle: CGifAnimUI); cdecl;


//================================CChildLayoutUI============================

function Delphi_ChildLayoutUI_CppCreate: CChildLayoutUI; cdecl;
procedure Delphi_ChildLayoutUI_CppDestroy(Handle: CChildLayoutUI); cdecl;
procedure Delphi_ChildLayoutUI_Init(Handle: CChildLayoutUI); cdecl;
procedure Delphi_ChildLayoutUI_SetAttribute(Handle: CChildLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;
procedure Delphi_ChildLayoutUI_SetChildLayoutXML(Handle: CChildLayoutUI; pXML: CDuiString); cdecl;
function Delphi_ChildLayoutUI_GetChildLayoutXML(Handle: CChildLayoutUI): CDuiString; cdecl;
function Delphi_ChildLayoutUI_GetInterface(Handle: CChildLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_ChildLayoutUI_GetClass(Handle: CChildLayoutUI): LPCTSTR; cdecl;

//================================CTileLayoutUI============================

function Delphi_TileLayoutUI_CppCreate: CTileLayoutUI; cdecl;
procedure Delphi_TileLayoutUI_CppDestroy(Handle: CTileLayoutUI); cdecl;
function Delphi_TileLayoutUI_GetClass(Handle: CTileLayoutUI): LPCTSTR; cdecl;
function Delphi_TileLayoutUI_GetInterface(Handle: CTileLayoutUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_TileLayoutUI_SetPos(Handle: CTileLayoutUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_TileLayoutUI_GetItemSize(Handle: CTileLayoutUI; var Result: TSize); cdecl;
procedure Delphi_TileLayoutUI_SetItemSize(Handle: CTileLayoutUI; szItem: TSize); cdecl;
function Delphi_TileLayoutUI_GetColumns(Handle: CTileLayoutUI): Integer; cdecl;
procedure Delphi_TileLayoutUI_SetColumns(Handle: CTileLayoutUI; nCols: Integer); cdecl;
procedure Delphi_TileLayoutUI_SetAttribute(Handle: CTileLayoutUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CNativeControlUI============================

function Delphi_NativeControlUI_CppCreate(hWnd: HWND): CNativeControlUI; cdecl;
procedure Delphi_NativeControlUI_CppDestroy(Handle: CNativeControlUI); cdecl;
procedure Delphi_NativeControlUI_SetInternVisible(Handle: CNativeControlUI; bVisible: Boolean); cdecl;
procedure Delphi_NativeControlUI_SetVisible(Handle: CNativeControlUI; bVisible: Boolean); cdecl;
procedure Delphi_NativeControlUI_SetPos(Handle: CNativeControlUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
function Delphi_NativeControlUI_GetClass(Handle: CNativeControlUI): LPCTSTR; cdecl;
function Delphi_NativeControlUI_GetText(Handle: CNativeControlUI): CDuiString; cdecl;
procedure Delphi_NativeControlUI_SetText(Handle: CNativeControlUI; pstrText: LPCTSTR); cdecl;
procedure Delphi_NativeControlUI_SetNativeHandle(Handle: CNativeControlUI; hWd: HWND); cdecl;


{$IFDEF UseLowVer}
  function StringToDuiString(const AStr: string): CDuiString; {$IFDEF SupportInline}inline;{$ENDIF}
  function DuiStringToString(ADuiStr: CDuiString): string; {$IFDEF SupportInline}inline;{$ENDIF}
{$ENDIF UseLowVer}
implementation


{ CDuiString }

{$IFNDEF UseLowVer}
class operator CDuiString.Equal(const Lhs, Rhs: CDuiString): Boolean;
begin
  Result := Lhs.ToString = Rhs.ToString;
end;

class operator CDuiString.Equal(const Lhs: CDuiString; Rhs: string): Boolean;
begin
  Result := Lhs.ToString = Rhs;
end;

class operator CDuiString.Equal(const Lhs: string; Rhs: CDuiString): Boolean;
begin
  Result := Lhs = Rhs.ToString;
end;

class operator CDuiString.Explicit(ADuiStr: CDuiString): string;
begin
  Result := ADuiStr.ToString;
end;

// 他这个貌似只是临时性的，所以没啥关系吧
class operator CDuiString.Implicit(const AStr: string): CDuiString;
var
  LLen: Integer;
begin
  Result.m_pstr := PChar(AStr);
  // 这里其实大多时候可选
  LLen := System.Length(AStr);
  if LLen > MAX_LOCAL_STRING_LEN then
    LLen := MAX_LOCAL_STRING_LEN;
  Move(Result.m_pstr^, Result.m_szBuffer[0], LLen * 2);
  Result.m_szBuffer[LLen] := #0;
end;

class operator CDuiString.Implicit(ADuiStr: CDuiString): string;
begin
  Result := ADuiStr.ToString;
end;

function CDuiString.IsEmpty: Boolean;
begin
  Result := ToString.IsEmpty;
end;

function CDuiString.Length: Integer;
begin
  Result := ToString.Length;
end;

class operator CDuiString.NotEqual(const Lhs, Rhs: CDuiString): Boolean;
begin
  Result := Lhs.ToString <> Rhs.ToString;
end;

class operator CDuiString.NotEqual(const Lhs: CDuiString; Rhs: string): Boolean;
begin
  Result := Lhs.ToString <> Rhs;
end;

class operator CDuiString.NotEqual(const Lhs: string; Rhs: CDuiString): Boolean;
begin
  Result := Lhs <> Rhs.ToString;
end;

function CDuiString.ToString: string;
begin
  Result := m_pstr; //PChar(@m_szBuffer[0]);
end;
{$ELSE UseLowVer}
function StringToDuiString(const AStr: string): CDuiString;
var
  LLen: Integer;
begin
  Result.m_pstr := PChar(AStr);
  // 这里其实大多时候可选
  LLen := System.Length(AStr);
  if LLen > MAX_LOCAL_STRING_LEN then
    LLen := MAX_LOCAL_STRING_LEN;
  Move(Result.m_pstr^, Result.m_szBuffer[0], LLen);
  Result.m_szBuffer[LLen] := #0;
end;

function DuiStringToString(ADuiStr: CDuiString): string;
begin
  Result := ADuiStr.m_pstr;
end;

{$ENDIF UseLowVer}

{ CStdStringPtrMap }

class function CStdStringPtrMap.CppCreate: CStdStringPtrMap;
begin
  Result := Delphi_StdStringPtrMap_CppCreate;
end;

procedure CStdStringPtrMap.CppDestroy;
begin
  Delphi_StdStringPtrMap_CppDestroy(Self);
end;

class function CStdStringPtrMap.Create: CStdStringPtrMap;
begin
  Result := Delphi_StdStringPtrMap_CppCreate;
end;

procedure CStdStringPtrMap.Free;
begin
  Delphi_StdStringPtrMap_CppDestroy(Self);
end;

procedure CStdStringPtrMap.Resize(nSize: Integer);
begin
  Delphi_StdStringPtrMap_Resize(Self, nSize);
end;

function CStdStringPtrMap.Find(key: string; optimize: Boolean): Pointer;
begin
  Result := Delphi_StdStringPtrMap_Find(Self, PChar(key), optimize);
end;

function CStdStringPtrMap.Insert(key: string; pData: Pointer): Boolean;
begin
  Result := Delphi_StdStringPtrMap_Insert(Self, PChar(key), pData);
end;

function CStdStringPtrMap.{$IFNDEF UseLowVer}&Set{$ELSE}_Set{$ENDIF}(key: string; pData: Pointer): Pointer;
begin
  Result := Delphi_StdStringPtrMap_Set(Self, PChar(key), pData);
end;

function CStdStringPtrMap.Remove(key: string): Boolean;
begin
  Result := Delphi_StdStringPtrMap_Remove(Self, PChar(key));
end;

procedure CStdStringPtrMap.RemoveAll;
begin
  Delphi_StdStringPtrMap_RemoveAll(Self);
end;

function CStdStringPtrMap.GetSize: Integer;
begin
  Result := Delphi_StdStringPtrMap_GetSize(Self);
end;

function CStdStringPtrMap.GetAt(iIndex: Integer): string;
begin
  Result := Delphi_StdStringPtrMap_GetAt(Self, iIndex);
end;

{ CStdValArray }

class function CStdValArray.CppCreate(iElementSize: Integer; iPreallocSize: Integer = 0): CStdValArray;
begin
  Result := Delphi_StdValArray_CppCreate(iElementSize, iPreallocSize);
end;

procedure CStdValArray.CppDestroy;
begin
  Delphi_StdValArray_CppDestroy(Self);
end;

class function CStdValArray.Create(iElementSize,
  iPreallocSize: Integer): CStdValArray;
begin
  Result := Delphi_StdValArray_CppCreate(iElementSize, iPreallocSize);
end;

procedure CStdValArray.Free;
begin
  Delphi_StdValArray_CppDestroy(Self);
end;

procedure CStdValArray.Empty;
begin
  Delphi_StdValArray_Empty(Self);
end;

function CStdValArray.IsEmpty: Boolean;
begin
  Result := Delphi_StdValArray_IsEmpty(Self);
end;

function CStdValArray.Add(pData: LPCVOID): Boolean;
begin
  Result := Delphi_StdValArray_Add(Self, pData);
end;

function CStdValArray.Remove(iIndex: Integer): Boolean;
begin
  Result := Delphi_StdValArray_Remove(Self, iIndex);
end;

function CStdValArray.GetSize: Integer;
begin
  Result := Delphi_StdValArray_GetSize(Self);
end;

function CStdValArray.GetData: Pointer;
begin
  Result := Delphi_StdValArray_GetData(Self);
end;

function CStdValArray.GetAt(iIndex: Integer): Pointer;
begin
  Result := Delphi_StdValArray_GetAt(Self, iIndex);
end;

{ CStdPtrArray }

class function CStdPtrArray.CppCreate: CStdPtrArray;
begin
  Result := Delphi_StdPtrArray_CppCreate;
end;

procedure CStdPtrArray.CppDestroy;
begin
  Delphi_StdPtrArray_CppDestroy(Self);
end;

procedure CStdPtrArray.Empty;
begin
  Delphi_StdPtrArray_Empty(Self);
end;

procedure CStdPtrArray.Resize(iSize: Integer);
begin
  Delphi_StdPtrArray_Resize(Self, iSize);
end;

function CStdPtrArray.IsEmpty: Boolean;
begin
  Result := Delphi_StdPtrArray_IsEmpty(Self);
end;

function CStdPtrArray.Find(iIndex: Pointer): Integer;
begin
  Result := Delphi_StdPtrArray_Find(Self, iIndex);
end;

function CStdPtrArray.Add(pData: Pointer): Boolean;
begin
  Result := Delphi_StdPtrArray_Add(Self, pData);
end;

function CStdPtrArray.SetAt(iIndex: Integer; pData: Pointer): Boolean;
begin
  Result := Delphi_StdPtrArray_SetAt(Self, iIndex, pData);
end;

procedure CStdPtrArray._SetAt(iIndex: Integer; const Value: Pointer);
begin
  SetAt(iIndex, Value);
end;

function CStdPtrArray.InsertAt(iIndex: Integer; pData: Pointer): Boolean;
begin
  Result := Delphi_StdPtrArray_InsertAt(Self, iIndex, pData);
end;

function CStdPtrArray.Remove(iIndex: Integer): Boolean;
begin
  Result := Delphi_StdPtrArray_Remove(Self, iIndex);
end;

function CStdPtrArray.GetSize: Integer;
begin
  Result := Delphi_StdPtrArray_GetSize(Self);
end;

function CStdPtrArray.GetData: Pointer;
begin
  Result := Delphi_StdPtrArray_GetData(Self);
end;

function CStdPtrArray.GetAt(iIndex: Integer): Pointer;
begin
  Result := Delphi_StdPtrArray_GetAt(Self, iIndex);
end;

{ CEventSource }

{$IFNDEF UseLowVer}
function CEventSource.Delegates: CStdPtrArray;
begin
  Result := CStdPtrArray(@Self);
end;

function CEventSource.IsEmpty: Boolean;
begin
  Result := Delegates.GetSize > 0;
end;
{$ENDIF UseLowVer}

{ CNotifyPump }

class function CNotifyPump.CppCreate: CNotifyPump;
begin
  Result := Delphi_NotifyPump_CppCreate;
end;

procedure CNotifyPump.CppDestroy;
begin
  Delphi_NotifyPump_CppDestroy(Self);
end;

function CNotifyPump.AddVirtualWnd(strName: string; pObject: CNotifyPump): Boolean;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_NotifyPump_AddVirtualWnd(Self, strName, pObject);
{$ELSE}
  Result := Delphi_NotifyPump_AddVirtualWnd(Self, StringToDuiString(strName), pObject);
{$ENDIF}
end;

function CNotifyPump.RemoveVirtualWnd(strName: string): Boolean;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_NotifyPump_RemoveVirtualWnd(Self, strName);
{$ELSE}
  Result := Delphi_NotifyPump_RemoveVirtualWnd(Self, StringToDuiString(strName));
{$ENDIF}
end;

procedure CNotifyPump.NotifyPump(var msg: TNotifyUI);
begin
  Delphi_NotifyPump_NotifyPump(Self, msg);
end;

function CNotifyPump.LoopDispatch(var msg: TNotifyUI): Boolean;
begin
  Result := Delphi_NotifyPump_LoopDispatch(Self, msg);
end;

{ CDialogBuilder }

class function CDialogBuilder.CppCreate: CDialogBuilder;
begin
  Result := Delphi_DialogBuilder_CppCreate;
end;

procedure CDialogBuilder.CppDestroy;
begin
  Delphi_DialogBuilder_CppDestroy(Self);
end;

function CDialogBuilder.Create(xml: string; AType: string; pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI;
begin
  Result := Delphi_DialogBuilder_Create_01(Self, STRINGorID(xml), PChar(AType), pCallback, pManager, pParent);
end;

function CDialogBuilder.Create(pCallback: IDialogBuilderCallback; pManager: CPaintManagerUI; pParent: CControlUI): CControlUI;
begin
  Result := Delphi_DialogBuilder_Create_02(Self, pCallback, pManager, pParent);
end;

function CDialogBuilder.GetMarkup: CMarkup;
begin
  Result := Delphi_DialogBuilder_GetMarkup(Self);
end;

procedure CDialogBuilder.GetLastErrorMessage(pstrMessage: string; cchMax: SIZE_T);
begin
  Delphi_DialogBuilder_GetLastErrorMessage(Self, LPTSTR(pstrMessage), cchMax);
end;

procedure CDialogBuilder.GetLastErrorLocation(pstrSource: string; cchMax: SIZE_T);
begin
  Delphi_DialogBuilder_GetLastErrorLocation(Self, LPTSTR(pstrSource), cchMax);
end;

{ CMarkup }

class function CMarkup.CppCreate(pstrXML: string): CMarkup;
begin
  Result := Delphi_Markup_CppCreate(PChar(pstrXML));
end;

procedure CMarkup.CppDestroy;
begin
  Delphi_Markup_CppDestroy(Self);
end;

function CMarkup.Load(pstrXML: string): Boolean;
begin
  Result := Delphi_Markup_Load(Self, PChar(pstrXML));
end;

function CMarkup.LoadFromMem(pByte: PByte; dwSize: DWORD; encoding: Integer): Boolean;
begin
  Result := Delphi_Markup_LoadFromMem(Self, pByte, dwSize, encoding);
end;

function CMarkup.LoadFromFile(pstrFilename: string; encoding: Integer): Boolean;
begin
  Result := Delphi_Markup_LoadFromFile(Self, PChar(pstrFilename), encoding);
end;

procedure CMarkup.Release;
begin
  Delphi_Markup_Release(Self);
end;

function CMarkup.IsValid: Boolean;
begin
  Result := Delphi_Markup_IsValid(Self);
end;

procedure CMarkup.SetPreserveWhitespace(bPreserve: Boolean);
begin
  Delphi_Markup_SetPreserveWhitespace(Self, bPreserve);
end;

procedure CMarkup.GetLastErrorMessage(pstrMessage: string; cchMax: SIZE_T);
begin
  Delphi_Markup_GetLastErrorMessage(Self, LPTSTR(pstrMessage), cchMax);
end;

procedure CMarkup.GetLastErrorLocation(pstrSource: string; cchMax: SIZE_T);
begin
  Delphi_Markup_GetLastErrorLocation(Self, LPTSTR(pstrSource), cchMax);
end;

function CMarkup.GetRoot: CMarkupNode;
begin
  Result := Delphi_Markup_GetRoot(Self);
end;

{ CMarkupNode }

class function CMarkupNode.CppCreate: CMarkupNode;
begin
  Result := Delphi_MarkupNode_CppCreate;
end;

procedure CMarkupNode.CppDestroy;
begin
  Delphi_MarkupNode_CppDestroy(Self);
end;

function CMarkupNode.IsValid: Boolean;
begin
  Result := Delphi_MarkupNode_IsValid(Self);
end;

function CMarkupNode.GetParent: CMarkupNode;
begin
  Result := Delphi_MarkupNode_GetParent(Self);
end;

function CMarkupNode.GetSibling: CMarkupNode;
begin
  Result := Delphi_MarkupNode_GetSibling(Self);
end;

function CMarkupNode.GetChild: CMarkupNode;
begin
  Result := Delphi_MarkupNode_GetChild_01(Self);
end;

function CMarkupNode.GetChild(pstrName: string): CMarkupNode;
begin
  Result := Delphi_MarkupNode_GetChild_02(Self, PChar(pstrName));
end;

function CMarkupNode.HasSiblings: Boolean;
begin
  Result := Delphi_MarkupNode_HasSiblings(Self);
end;

function CMarkupNode.HasChildren: Boolean;
begin
  Result := Delphi_MarkupNode_HasChildren(Self);
end;

function CMarkupNode.GetName: string;
begin
  Result := Delphi_MarkupNode_GetName(Self);
end;

function CMarkupNode.GetValue: string;
begin
  Result := Delphi_MarkupNode_GetValue(Self);
end;

function CMarkupNode.HasAttributes: Boolean;
begin
  Result := Delphi_MarkupNode_HasAttributes(Self);
end;

function CMarkupNode.HasAttribute(pstrName: string): Boolean;
begin
  Result := Delphi_MarkupNode_HasAttribute(Self, PChar(pstrName));
end;

function CMarkupNode.GetAttributeCount: Integer;
begin
  Result := Delphi_MarkupNode_GetAttributeCount(Self);
end;

function CMarkupNode.GetAttributeName(iIndex: Integer): string;
begin
  Result := Delphi_MarkupNode_GetAttributeName(Self, iIndex);
end;

function CMarkupNode.GetAttributeValue(iIndex: Integer): string;
begin
  Result := Delphi_MarkupNode_GetAttributeValue_01(Self, iIndex);
end;

function CMarkupNode.GetAttributeValue(pstrName: string): string;
begin
  Result := Delphi_MarkupNode_GetAttributeValue_02(Self, PChar(pstrName));
end;

function CMarkupNode.GetAttributeValue(iIndex: Integer; pstrValue: string; cchMax: SIZE_T): Boolean;
begin
  Result := Delphi_MarkupNode_GetAttributeValue_03(Self, iIndex, LPTSTR(pstrValue), cchMax);
end;

function CMarkupNode.GetAttributeValue(pstrName: string; pstrValue: string; cchMax: SIZE_T): Boolean;
begin
  Result := Delphi_MarkupNode_GetAttributeValue_04(Self, PChar(pstrName), LPTSTR(pstrValue), cchMax);
end;

{ CControlUI }

function CControlUI.ClassName: string;
begin
  Result := GetClass;
end;

class function CControlUI.CppCreate: CControlUI;
begin
  Result := Delphi_ControlUI_CppCreate;
end;

procedure CControlUI.CppDestroy;
begin
  Delphi_ControlUI_CppDestroy(Self);
end;

function CControlUI.GetName: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetName(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ControlUI_GetName(Self));
{$ENDIF}
end;

procedure CControlUI.SetName(pstrName: string);
begin
  Delphi_ControlUI_SetName(Self, PChar(pstrName));
end;

function CControlUI.GetClass: string;
begin
  Result := Delphi_ControlUI_GetClass(Self);
end;

function CControlUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ControlUI_GetInterface(Self, PChar(pstrName));
end;

function CControlUI.GetControlFlags: UINT;
begin
  Result := Delphi_ControlUI_GetControlFlags(Self);
end;

function CControlUI.GetNativeWindow: HWND;
begin
  Result := Delphi_ControlUI_GetNativeWindow(Self);
end;

function CControlUI.Activate: Boolean;
begin
  Result := Delphi_ControlUI_Activate(Self);
end;

function CControlUI.GetManager: CPaintManagerUI;
begin
  Result := Delphi_ControlUI_GetManager(Self);
end;

procedure CControlUI.SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean);
begin
  Delphi_ControlUI_SetManager(Self, pManager, pParent, bInit);
end;

function CControlUI.GetParent: CControlUI;
begin
  Result := Delphi_ControlUI_GetParent(Self);
end;

function CControlUI.GetText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetText(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ControlUI_GetText(Self));
{$ENDIF}
end;

procedure CControlUI.SetText(pstrText: string);
begin
  Delphi_ControlUI_SetText(Self, PChar(pstrText));
end;

function CControlUI.GetBkColor: DWORD;
begin
  Result := Delphi_ControlUI_GetBkColor(Self);
end;

procedure CControlUI.SetBkColor(dwBackColor: DWORD);
begin
  Delphi_ControlUI_SetBkColor(Self, dwBackColor);
end;

function CControlUI.GetBkColor2: DWORD;
begin
  Result := Delphi_ControlUI_GetBkColor2(Self);
end;

procedure CControlUI.SetBkColor2(dwBackColor: DWORD);
begin
  Delphi_ControlUI_SetBkColor2(Self, dwBackColor);
end;

function CControlUI.GetBkColor3: DWORD;
begin
  Result := Delphi_ControlUI_GetBkColor3(Self);
end;

procedure CControlUI.SetBkColor3(dwBackColor: DWORD);
begin
  Delphi_ControlUI_SetBkColor3(Self, dwBackColor);
end;

function CControlUI.GetBkImage: string;
begin
  Result := Delphi_ControlUI_GetBkImage(Self);
end;

procedure CControlUI.SetBkImage(pStrImage: string);
begin
  Delphi_ControlUI_SetBkImage(Self, PChar(pStrImage));
end;

function CControlUI.GetFocusBorderColor: DWORD;
begin
  Result := Delphi_ControlUI_GetFocusBorderColor(Self);
end;

procedure CControlUI.SetFocusBorderColor(dwBorderColor: DWORD);
begin
  Delphi_ControlUI_SetFocusBorderColor(Self, dwBorderColor);
end;

function CControlUI.IsColorHSL: Boolean;
begin
  Result := Delphi_ControlUI_IsColorHSL(Self);
end;

procedure CControlUI.SetColorHSL(bColorHSL: Boolean);
begin
  Delphi_ControlUI_SetColorHSL(Self, bColorHSL);
end;

function CControlUI.GetBorderRound: TSize;
begin
  Delphi_ControlUI_GetBorderRound(Self, Result);
end;

procedure CControlUI.SetBorderRound(cxyRound: TSize);
begin
  Delphi_ControlUI_SetBorderRound(Self, cxyRound);
end;

function CControlUI.DrawImage(hDC: HDC; var drawInfo: TDrawInfo): Boolean;
begin
  Result := Delphi_ControlUI_DrawImage(Self, hDC, drawInfo);
end;

function CControlUI.GetBorderColor: DWORD;
begin
  Result := Delphi_ControlUI_GetBorderColor(Self);
end;

procedure CControlUI.SetBorderColor(dwBorderColor: DWORD);
begin
  Delphi_ControlUI_SetBorderColor(Self, dwBorderColor);
end;

function CControlUI.GetBorderSize: TRect;
begin
  Delphi_ControlUI_GetBorderSize(Self, Result);
end;

procedure CControlUI.SetBorderSize(rc: TRect);
begin
  Delphi_ControlUI_SetBorderSize_01(Self, rc);
end;

procedure CControlUI.SetBorderSize(iSize: Integer);
begin
  Delphi_ControlUI_SetBorderSize_02(Self, iSize);
end;

function CControlUI.GetBorderStyle: Integer;
begin
  Result := Delphi_ControlUI_GetBorderStyle(Self);
end;

procedure CControlUI.SetBorderStyle(nStyle: Integer);
begin
  Delphi_ControlUI_SetBorderStyle(Self, nStyle);
end;

function CControlUI.GetPos: TRect;
begin
  Result := Delphi_ControlUI_GetPos(Self)^;
end;

function CControlUI.GetRelativePos: TRect;
begin
  Delphi_ControlUI_GetRelativePos(Self, Result);
end;

function CControlUI.GetClientPos: TRect;
begin
  Delphi_ControlUI_GetClientPos(Self, Result);
end;

procedure CControlUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_ControlUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CControlUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_ControlUI_Move(Self, szOffset, bNeedInvalidate);
end;

function CControlUI.GetWidth: Integer;
begin
  Result := Delphi_ControlUI_GetWidth(Self);
end;

function CControlUI.GetHeight: Integer;
begin
  Result := Delphi_ControlUI_GetHeight(Self);
end;

function CControlUI.GetX: Integer;
begin
  Result := Delphi_ControlUI_GetX(Self);
end;

function CControlUI.GetY: Integer;
begin
  Result := Delphi_ControlUI_GetY(Self);
end;

procedure CControlUI.Hide;
begin
  Visible := False;
end;

function CControlUI.GetPadding: TRect;
begin
  Delphi_ControlUI_GetPadding(Self, Result);
end;

procedure CControlUI.SetPadding(rcPadding: TRect);
begin
  Delphi_ControlUI_SetPadding(Self, rcPadding);
end;

function CControlUI.GetFixedXY: TSize;
begin
  Delphi_ControlUI_GetFixedXY(Self, Result);
end;

procedure CControlUI.SetFixedXY(szXY: TSize);
begin
  Delphi_ControlUI_SetFixedXY(Self, szXY);
end;

function CControlUI.GetFixedWidth: Integer;
begin
  Result := Delphi_ControlUI_GetFixedWidth(Self);
end;

procedure CControlUI.SetFixedWidth(cx: Integer);
begin
  Delphi_ControlUI_SetFixedWidth(Self, cx);
end;

function CControlUI.GetFixedHeight: Integer;
begin
  Result := Delphi_ControlUI_GetFixedHeight(Self);
end;

procedure CControlUI.SetFixedHeight(cy: Integer);
begin
  Delphi_ControlUI_SetFixedHeight(Self, cy);
end;

function CControlUI.GetMinWidth: Integer;
begin
  Result := Delphi_ControlUI_GetMinWidth(Self);
end;

procedure CControlUI.SetMinWidth(cx: Integer);
begin
  Delphi_ControlUI_SetMinWidth(Self, cx);
end;

function CControlUI.GetMaxWidth: Integer;
begin
  Result := Delphi_ControlUI_GetMaxWidth(Self);
end;

procedure CControlUI.SetMaxWidth(cx: Integer);
begin
  Delphi_ControlUI_SetMaxWidth(Self, cx);
end;

function CControlUI.GetMinHeight: Integer;
begin
  Result := Delphi_ControlUI_GetMinHeight(Self);
end;

procedure CControlUI.SetMinHeight(cy: Integer);
begin
  Delphi_ControlUI_SetMinHeight(Self, cy);
end;

function CControlUI.GetMaxHeight: Integer;
begin
  Result := Delphi_ControlUI_GetMaxHeight(Self);
end;

procedure CControlUI.SetMaxHeight(cy: Integer);
begin
  Delphi_ControlUI_SetMaxHeight(Self, cy);
end;

function CControlUI.GetFloatPercent: TPercentInfo;
begin
  Result := Delphi_ControlUI_GetFloatPercent(Self);
end;

procedure CControlUI.SetFloatPercent(piFloatPercent: TPercentInfo);
begin
  Delphi_ControlUI_SetFloatPercent(Self, piFloatPercent);
end;

function CControlUI.GetToolTip: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetToolTip(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ControlUI_GetToolTip(Self));
{$ENDIF}
end;

procedure CControlUI.SetToolTip(pstrText: string);
begin
  Delphi_ControlUI_SetToolTip(Self, PChar(pstrText));
end;

procedure CControlUI.SetToolTipWidth(nWidth: Integer);
begin
  Delphi_ControlUI_SetToolTipWidth(Self, nWidth);
end;

function CControlUI.GetToolTipWidth: Integer;
begin
  Result := Delphi_ControlUI_GetToolTipWidth(Self);
end;

function CControlUI.GetShortcut: Char;
begin
  Result := Delphi_ControlUI_GetShortcut(Self);
end;

procedure CControlUI.SetShortcut(ch: Char);
begin
  Delphi_ControlUI_SetShortcut(Self, ch);
end;

function CControlUI.IsContextMenuUsed: Boolean;
begin
  Result := Delphi_ControlUI_IsContextMenuUsed(Self);
end;

procedure CControlUI.SetContextMenuUsed(bMenuUsed: Boolean);
begin
  Delphi_ControlUI_SetContextMenuUsed(Self, bMenuUsed);
end;

function CControlUI.GetUserData: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetUserData(Self)^;
{$ELSE}
  Result := DuiStringToString(Delphi_ControlUI_GetUserData(Self)^);
{$ENDIF}
end;

procedure CControlUI.SetUserData(pstrText: string);
begin
  Delphi_ControlUI_SetUserData(Self, PChar(pstrText));
end;

function CControlUI.GetTag: UINT_PTR;
begin
  Result := Delphi_ControlUI_GetTag(Self);
end;

procedure CControlUI.SetTag(pTag: UINT_PTR);
begin
  Delphi_ControlUI_SetTag(Self, pTag);
end;

function CControlUI.IsVisible: Boolean;
begin
  Result := Delphi_ControlUI_IsVisible(Self);
end;

procedure CControlUI.SetVisible(bVisible: Boolean);
begin
  Delphi_ControlUI_SetVisible(Self, bVisible);
end;

procedure CControlUI.Show;
begin
  Visible := True;
end;

procedure CControlUI.SetInternVisible(bVisible: Boolean);
begin
  Delphi_ControlUI_SetInternVisible(Self, bVisible);
end;

function CControlUI.IsEnabled: Boolean;
begin
  Result := Delphi_ControlUI_IsEnabled(Self);
end;

procedure CControlUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ControlUI_SetEnabled(Self, bEnable);
end;

function CControlUI.IsMouseEnabled: Boolean;
begin
  Result := Delphi_ControlUI_IsMouseEnabled(Self);
end;

procedure CControlUI.SetMouseEnabled(bEnable: Boolean);
begin
  Delphi_ControlUI_SetMouseEnabled(Self, bEnable);
end;

function CControlUI.IsKeyboardEnabled: Boolean;
begin
  Result := Delphi_ControlUI_IsKeyboardEnabled(Self);
end;

procedure CControlUI.SetKeyboardEnabled(bEnable: Boolean);
begin
  Delphi_ControlUI_SetKeyboardEnabled(Self, bEnable);
end;

function CControlUI.IsFocused: Boolean;
begin
  Result := Delphi_ControlUI_IsFocused(Self);
end;

procedure CControlUI.SetFocus;
begin
  Delphi_ControlUI_SetFocus(Self);
end;

function CControlUI.IsFloat: Boolean;
begin
  Result := Delphi_ControlUI_IsFloat(Self);
end;

procedure CControlUI.SetFloat(bFloat: Boolean);
begin
  Delphi_ControlUI_SetFloat(Self, bFloat);
end;

procedure CControlUI.AddCustomAttribute(pstrName: string; pstrAttr: string);
begin
  Delphi_ControlUI_AddCustomAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrAttr));
end;

function CControlUI.GetCustomAttribute(pstrName: string): string;
begin
  Result := Delphi_ControlUI_GetCustomAttribute(Self, LPCTSTR(pstrName));
end;

function CControlUI.RemoveCustomAttribute(pstrName: string): Boolean;
begin
  Result := Delphi_ControlUI_RemoveCustomAttribute(Self, LPCTSTR(pstrName));
end;

procedure CControlUI.RemoveAllCustomAttribute;
begin
  Delphi_ControlUI_RemoveAllCustomAttribute(Self);
end;

function CControlUI.FindControl(Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI;
begin
  Result := Delphi_ControlUI_FindControl(Self, Proc, pData, uFlags);
end;

procedure CControlUI.Invalidate;
begin
  Delphi_ControlUI_Invalidate(Self);
end;

function CControlUI.IsUpdateNeeded: Boolean;
begin
  Result := Delphi_ControlUI_IsUpdateNeeded(Self);
end;

procedure CControlUI.NeedUpdate;
begin
  Delphi_ControlUI_NeedUpdate(Self);
end;

procedure CControlUI.NeedParentUpdate;
begin
  Delphi_ControlUI_NeedParentUpdate(Self);
end;

function CControlUI.GetAdjustColor(dwColor: DWORD): DWORD;
begin
  Result := Delphi_ControlUI_GetAdjustColor(Self, dwColor);
end;

procedure CControlUI.Init;
begin
  Delphi_ControlUI_Init(Self);
end;

procedure CControlUI.DoInit;
begin
  Delphi_ControlUI_DoInit(Self);
end;

procedure CControlUI.Event(var AEvent: TEventUI);
begin
  Delphi_ControlUI_Event(Self, AEvent);
end;

procedure CControlUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ControlUI_DoEvent(Self, AEvent);
end;

procedure CControlUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ControlUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

function CControlUI.ApplyAttributeList(pstrList: string): CControlUI;
begin
  Result := Delphi_ControlUI_ApplyAttributeList(Self, PChar(pstrList));
end;

function CControlUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ControlUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CControlUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ControlUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CControlUI.Paint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ControlUI_Paint(Self, hDC, rcPaint);
end;

procedure CControlUI.PaintBkColor(hDC: HDC);
begin
  Delphi_ControlUI_PaintBkColor(Self, hDC);
end;

procedure CControlUI.PaintBkImage(hDC: HDC);
begin
  Delphi_ControlUI_PaintBkImage(Self, hDC);
end;

procedure CControlUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_ControlUI_PaintStatusImage(Self, hDC);
end;

procedure CControlUI.PaintText(hDC: HDC);
begin
  Delphi_ControlUI_PaintText(Self, hDC);
end;

procedure CControlUI.PaintBorder(hDC: HDC);
begin
  Delphi_ControlUI_PaintBorder(Self, hDC);
end;

procedure CControlUI.DoPostPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ControlUI_DoPostPaint(Self, hDC, rcPaint);
end;

procedure CControlUI.SetVirtualWnd(pstrValue: string);
begin
  Delphi_ControlUI_SetVirtualWnd(Self, PChar(pstrValue));
end;

function CControlUI.GetVirtualWnd: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetVirtualWnd(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ControlUI_GetVirtualWnd(Self));
{$ENDIF}
end;

{ CDelphi_WindowImplBase }

class function CDelphi_WindowImplBase.CppCreate: CDelphi_WindowImplBase;
begin
  Result := Delphi_Delphi_WindowImplBase_CppCreate;
end;

procedure CDelphi_WindowImplBase.CppDestroy;
begin
  Delphi_Delphi_WindowImplBase_CppDestroy(Self);
end;

function CDelphi_WindowImplBase.GetHWND: HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_GetHWND(Self);
end;

function CDelphi_WindowImplBase.RegisterWindowClass: Boolean;
begin
  Result := Delphi_Delphi_WindowImplBase_RegisterWindowClass(Self);
end;

function CDelphi_WindowImplBase.RegisterSuperclass: Boolean;
begin
  Result := Delphi_Delphi_WindowImplBase_RegisterSuperclass(Self);
end;

function CDelphi_WindowImplBase.Create(hwndParent: HWND; pstrName: string; dwStyle: DWORD; dwExStyle: DWORD; const rc: TRect; hMenu: HMENU): HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_Create_01(Self, hwndParent, PChar(pstrName), dwStyle, dwExStyle, rc, hMenu);
end;

function CDelphi_WindowImplBase.Create(hwndParent: HWND; pstrName: string; dwStyle: DWORD; dwExStyle: DWORD; x: Integer; y: Integer; cx: Integer; cy: Integer; hMenu: HMENU): HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_Create_02(Self, hwndParent, PChar(pstrName), dwStyle, dwExStyle, x, y, cx, cy, hMenu);
end;

function CDelphi_WindowImplBase.CreateDuiWindow(hwndParent: HWND; pstrWindowName: string; dwStyle: DWORD; dwExStyle: DWORD): HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_CreateDuiWindow(Self, hwndParent, PChar(pstrWindowName), dwStyle, dwExStyle);
end;

function CDelphi_WindowImplBase.Subclass(hWnd: HWND): HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_Subclass(Self, hWnd);
end;

procedure CDelphi_WindowImplBase.Unsubclass;
begin
  Delphi_Delphi_WindowImplBase_Unsubclass(Self);
end;

procedure CDelphi_WindowImplBase.ShowWindow(bShow: Boolean; bTakeFocus: Boolean);
begin
  Delphi_Delphi_WindowImplBase_ShowWindow(Self, bShow, bTakeFocus);
end;

function CDelphi_WindowImplBase.ShowModal: UINT;
begin
  Result := Delphi_Delphi_WindowImplBase_ShowModal(Self);
end;

procedure CDelphi_WindowImplBase.Close(nRet: UINT);
begin
  Delphi_Delphi_WindowImplBase_Close(Self, nRet);
end;

procedure CDelphi_WindowImplBase.CenterWindow;
begin
  Delphi_Delphi_WindowImplBase_CenterWindow(Self);
end;

procedure CDelphi_WindowImplBase.SetIcon(nRes: UINT);
begin
  Delphi_Delphi_WindowImplBase_SetIcon(Self, nRes);
end;

function CDelphi_WindowImplBase.SendMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := Delphi_Delphi_WindowImplBase_SendMessage(Self, uMsg, wParam, lParam);
end;

function CDelphi_WindowImplBase.PostMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := Delphi_Delphi_WindowImplBase_PostMessage(Self, uMsg, wParam, lParam);
end;

procedure CDelphi_WindowImplBase.ResizeClient(cx: Integer; cy: Integer);
begin
  Delphi_Delphi_WindowImplBase_ResizeClient(Self, cx, cy);
end;

function CDelphi_WindowImplBase.AddVirtualWnd(strName: string; pObject: CNotifyPump): Boolean;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_Delphi_WindowImplBase_AddVirtualWnd(Self, strName, pObject);
{$ELSE}
  Result := Delphi_Delphi_WindowImplBase_AddVirtualWnd(Self, StringToDuiString(strName), pObject);
{$ENDIF}
end;

procedure CDelphi_WindowImplBase.RemoveThisInPaintManager;
begin
  Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager(Self);
end;

procedure CDelphi_WindowImplBase.SetResponseDefaultKeyEvent(ACallBack: LPVOID);
begin
  Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent(Self, ACallBack);
end;

function CDelphi_WindowImplBase.RemoveVirtualWnd(strName: string): Boolean;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_Delphi_WindowImplBase_RemoveVirtualWnd(Self, strName);
{$ELSE}
  Result := Delphi_Delphi_WindowImplBase_RemoveVirtualWnd(Self, StringToDuiString(strName));
{$ENDIF}
end;

procedure CDelphi_WindowImplBase.NotifyPump(var msg: TNotifyUI);
begin
  Delphi_Delphi_WindowImplBase_NotifyPump(Self, msg);
end;

function CDelphi_WindowImplBase.LoopDispatch(var msg: TNotifyUI): Boolean;
begin
  Result := Delphi_Delphi_WindowImplBase_LoopDispatch(Self, msg);
end;

function CDelphi_WindowImplBase.GetPaintManagerUI: CPaintManagerUI;
begin
  Result := Delphi_Delphi_WindowImplBase_GetPaintManagerUI(Self);
end;

procedure CDelphi_WindowImplBase.SetDelphiSelf(ASelf: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetDelphiSelf(Self, ASelf);
end;

procedure CDelphi_WindowImplBase.SetClassName(AClassName: string);
begin
  Delphi_Delphi_WindowImplBase_SetClassName(Self, PChar(AClassName));
end;

procedure CDelphi_WindowImplBase.SetSkinFile(SkinFile: string);
begin
  Delphi_Delphi_WindowImplBase_SetSkinFile(Self, PChar(SkinFile));
end;

procedure CDelphi_WindowImplBase.SetSkinFolder(SkinFolder: string);
begin
  Delphi_Delphi_WindowImplBase_SetSkinFolder(Self, PChar(SkinFolder));
end;

procedure CDelphi_WindowImplBase.SetZipFileName(ZipFileName: string);
begin
  Delphi_Delphi_WindowImplBase_SetZipFileName(Self, PChar(ZipFileName));
end;

procedure CDelphi_WindowImplBase.SetResourceType(RType: TResourceType);
begin
  Delphi_Delphi_WindowImplBase_SetResourceType(Self, RType);
end;

procedure CDelphi_WindowImplBase.SetInitWindow(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetInitWindow(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetFinalMessage(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetFinalMessage(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetGetClassStyle(uStyle: UINT);
begin
  Delphi_Delphi_WindowImplBase_SetGetClassStyle(Self, uStyle);
end;

procedure CDelphi_WindowImplBase.SetGetItemText(ACallBack: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetGetItemText(Self, ACallBack);
end;

procedure CDelphi_WindowImplBase.SetHandleMessage(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetHandleMessage(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetNotify(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetNotify(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetClick(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetClick(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetMessageHandler(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetMessageHandler(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetHandleCustomMessage(Callback: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetHandleCustomMessage(Self, Callback);
end;

procedure CDelphi_WindowImplBase.SetCreateControl(CallBack: Pointer);
begin
  Delphi_Delphi_WindowImplBase_SetCreateControl(Self, CallBack);
end;


{ CPaintManagerUI }

class function CPaintManagerUI.CppCreate: CPaintManagerUI;
begin
  Result := Delphi_PaintManagerUI_CppCreate;
end;

procedure CPaintManagerUI.CppDestroy;
begin
  Delphi_PaintManagerUI_CppDestroy(Self);
end;

procedure CPaintManagerUI.Init(hWnd: HWND; pstrName: string);
begin
  Delphi_PaintManagerUI_Init(Self, hWnd, LPCTSTR(pstrName));
end;

function CPaintManagerUI.IsUpdateNeeded: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsUpdateNeeded(Self);
end;

procedure CPaintManagerUI.NeedUpdate;
begin
  Delphi_PaintManagerUI_NeedUpdate(Self);
end;

procedure CPaintManagerUI.Invalidate;
begin
  Delphi_PaintManagerUI_Invalidate_01(Self);
end;

procedure CPaintManagerUI.Invalidate(const rcItem: TRect);
begin
  Delphi_PaintManagerUI_Invalidate_02(Self, rcItem);
end;

function CPaintManagerUI.GetPaintDC: HDC;
begin
  Result := Delphi_PaintManagerUI_GetPaintDC(Self);
end;

function CPaintManagerUI.GetPaintWindow: HWND;
begin
  Result := Delphi_PaintManagerUI_GetPaintWindow(Self);
end;

function CPaintManagerUI.GetTooltipWindow: HWND;
begin
  Result := Delphi_PaintManagerUI_GetTooltipWindow(Self);
end;

function CPaintManagerUI.GetMousePos: TPoint;
begin
  Result := Delphi_PaintManagerUI_GetMousePos(Self);
end;

function CPaintManagerUI.GetClientSize: TSize;
begin
  Delphi_PaintManagerUI_GetClientSize(Self, Result);
end;

function CPaintManagerUI.GetInitSize: TSize;
begin
  Delphi_PaintManagerUI_GetInitSize(Self, Result);
end;

procedure CPaintManagerUI.SetInitSize(cx: Integer; cy: Integer);
begin
  Delphi_PaintManagerUI_SetInitSize(Self, cx, cy);
end;

function CPaintManagerUI.GetSizeBox: TRect;
begin
  Result := Delphi_PaintManagerUI_GetSizeBox(Self)^;
end;

procedure CPaintManagerUI.SetSizeBox(const rcSizeBox: TRect);
begin
  Delphi_PaintManagerUI_SetSizeBox(Self, rcSizeBox);
end;

function CPaintManagerUI.GetCaptionRect: TRect;
begin
  Result := Delphi_PaintManagerUI_GetCaptionRect(Self)^;
end;

procedure CPaintManagerUI.SetCaptionRect(const rcCaption: TRect);
begin
  Delphi_PaintManagerUI_SetCaptionRect(Self, rcCaption);
end;

function CPaintManagerUI.GetRoundCorner: TSize;
begin
  Delphi_PaintManagerUI_GetRoundCorner(Self, Result);
end;

procedure CPaintManagerUI.SetRoundCorner(cx: Integer; cy: Integer);
begin
  Delphi_PaintManagerUI_SetRoundCorner(Self, cx, cy);
end;

function CPaintManagerUI.GetMinInfo: TSize;
begin
  Delphi_PaintManagerUI_GetMinInfo(Self, Result);
end;

procedure CPaintManagerUI.SetMinInfo(cx: Integer; cy: Integer);
begin
  Delphi_PaintManagerUI_SetMinInfo(Self, cx, cy);
end;

function CPaintManagerUI.GetMaxInfo: TSize;
begin
  Delphi_PaintManagerUI_GetMaxInfo(Self, Result);
end;

procedure CPaintManagerUI.SetMaxInfo(cx: Integer; cy: Integer);
begin
  Delphi_PaintManagerUI_SetMaxInfo(Self, cx, cy);
end;

function CPaintManagerUI.IsShowUpdateRect: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsShowUpdateRect(Self);
end;

procedure CPaintManagerUI.SetShowUpdateRect(show: Boolean);
begin
  Delphi_PaintManagerUI_SetShowUpdateRect(Self, show);
end;

class function CPaintManagerUI.GetInstance: HINST;
begin
  Result := Delphi_PaintManagerUI_GetInstance;
end;

class function CPaintManagerUI.GetInstancePath: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_PaintManagerUI_GetInstancePath;
{$ELSE}
  Result := DuiStringToString(Delphi_PaintManagerUI_GetInstancePath);
{$ENDIF}
end;

class function CPaintManagerUI.GetCurrentPath: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_PaintManagerUI_GetCurrentPath;
{$ELSE}
  Result := DuiStringToString(Delphi_PaintManagerUI_GetCurrentPath);
{$ENDIF}
end;

class function CPaintManagerUI.GetResourceDll: HINST;
begin
  Result := Delphi_PaintManagerUI_GetResourceDll;
end;

class function CPaintManagerUI.GetResourcePath: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_PaintManagerUI_GetResourcePath^;
{$ELSE}
  Result := DuiStringToString(Delphi_PaintManagerUI_GetResourcePath^);
{$ENDIF}
end;

class function CPaintManagerUI.GetResourceZip: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_PaintManagerUI_GetResourceZip^;
{$ELSE}
  Result := DuiStringToString(Delphi_PaintManagerUI_GetResourceZip^);
{$ENDIF}
end;

class function CPaintManagerUI.IsCachedResourceZip: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsCachedResourceZip;
end;

class function CPaintManagerUI.GetResourceZipHandle: THandle;
begin
  Result := Delphi_PaintManagerUI_GetResourceZipHandle;
end;

class procedure CPaintManagerUI.SetInstance(hInst: HINST);
begin
  Delphi_PaintManagerUI_SetInstance(hInst);
end;

class procedure CPaintManagerUI.SetCurrentPath(pStrPath: string);
begin
  Delphi_PaintManagerUI_SetCurrentPath(PChar(pStrPath));
end;

class procedure CPaintManagerUI.SetResourceDll(hInst: HINST);
begin
  Delphi_PaintManagerUI_SetResourceDll(hInst);
end;

class procedure CPaintManagerUI.SetResourcePath(pStrPath: string);
begin
  Delphi_PaintManagerUI_SetResourcePath(PChar(pStrPath));
end;

class procedure CPaintManagerUI.SetResourceZip(pVoid: Pointer; len: LongInt);
begin
  Delphi_PaintManagerUI_SetResourceZip_01(pVoid, len);
end;

class procedure CPaintManagerUI.SetResourceZip(pstrZip: string; bCachedResourceZip: Boolean);
begin
  Delphi_PaintManagerUI_SetResourceZip_02(PChar(pstrZip), bCachedResourceZip);
end;

class function CPaintManagerUI.GetHSL(H: PShort; S: PShort; L: PShort): Boolean;
begin
  Result := Delphi_PaintManagerUI_GetHSL(H, S, L);
end;

class procedure CPaintManagerUI.ReloadSkin;
begin
  Delphi_PaintManagerUI_ReloadSkin;
end;

class function CPaintManagerUI.LoadPlugin(pstrModuleName: string): Boolean;
begin
  Result := Delphi_PaintManagerUI_LoadPlugin(PChar(pstrModuleName));
end;

class function CPaintManagerUI.GetPlugins: CStdPtrArray;
begin
  Result := Delphi_PaintManagerUI_GetPlugins;
end;

function CPaintManagerUI.IsForceUseSharedRes: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsForceUseSharedRes(Self);
end;

procedure CPaintManagerUI.SetForceUseSharedRes(bForce: Boolean);
begin
  Delphi_PaintManagerUI_SetForceUseSharedRes(Self, bForce);
end;

function CPaintManagerUI.IsPainting: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsPainting(Self);
end;

procedure CPaintManagerUI.SetPainting(bIsPainting: Boolean);
begin
  Delphi_PaintManagerUI_SetPainting(Self, bIsPainting);
end;

function CPaintManagerUI.GetDefaultDisabledColor: DWORD;
begin
  Result := Delphi_PaintManagerUI_GetDefaultDisabledColor(Self);
end;

procedure CPaintManagerUI.SetDefaultDisabledColor(dwColor: DWORD; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultDisabledColor(Self, dwColor, bShared);
end;

function CPaintManagerUI.GetDefaultFontColor: DWORD;
begin
  Result := Delphi_PaintManagerUI_GetDefaultFontColor(Self);
end;

procedure CPaintManagerUI.SetDefaultFontColor(dwColor: DWORD; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultFontColor(Self, dwColor, bShared);
end;

function CPaintManagerUI.GetDefaultLinkFontColor: DWORD;
begin
  Result := Delphi_PaintManagerUI_GetDefaultLinkFontColor(Self);
end;

procedure CPaintManagerUI.SetDefaultLinkFontColor(dwColor: DWORD; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultLinkFontColor(Self, dwColor, bShared);
end;

function CPaintManagerUI.GetDefaultLinkHoverFontColor: DWORD;
begin
  Result := Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor(Self);
end;

procedure CPaintManagerUI.SetDefaultLinkHoverFontColor(dwColor: DWORD; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor(Self, dwColor, bShared);
end;

function CPaintManagerUI.GetDefaultSelectedBkColor: DWORD;
begin
  Result := Delphi_PaintManagerUI_GetDefaultSelectedBkColor(Self);
end;

procedure CPaintManagerUI.SetDefaultSelectedBkColor(dwColor: DWORD; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultSelectedBkColor(Self, dwColor, bShared);
end;

function CPaintManagerUI.GetDefaultFontInfo: PFontInfo;
begin
  Result := Delphi_PaintManagerUI_GetDefaultFontInfo(Self);
end;

procedure CPaintManagerUI.SetDefaultFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean);
begin
  Delphi_PaintManagerUI_SetDefaultFont(Self, PChar(pStrFontName), nSize, bBold, bUnderline, bItalic, bShared);
end;

function CPaintManagerUI.GetCustomFontCount(bShared: Boolean): DWORD;
begin
  Result := Delphi_PaintManagerUI_GetCustomFontCount(Self, bShared);
end;

function CPaintManagerUI.AddFont(id: Integer; pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): HFONT;
begin
  Result := Delphi_PaintManagerUI_AddFont(Self, id, PChar(pStrFontName), nSize, bBold, bUnderline, bItalic, bShared);
end;

function CPaintManagerUI.GetFont(id: Integer): HFONT;
begin
  Result := Delphi_PaintManagerUI_GetFont_01(Self, id);
end;

function CPaintManagerUI.GetFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean): HFONT;
begin
  Result := Delphi_PaintManagerUI_GetFont_02(Self, PChar(pStrFontName), nSize, bBold, bUnderline, bItalic);
end;

function CPaintManagerUI.GetFontIndex(hFont: HFONT; bShared: Boolean): Integer;
begin
  Result := Delphi_PaintManagerUI_GetFontIndex_01(Self, hFont, bShared);
end;

function CPaintManagerUI.GetFontIndex(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean; bShared: Boolean): Integer;
begin
  Result := Delphi_PaintManagerUI_GetFontIndex_02(Self, PChar(pStrFontName), nSize, bBold, bUnderline, bItalic, bShared);
end;

procedure CPaintManagerUI.RemoveFont(hFont: HFONT; bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveFont_01(Self, hFont, bShared);
end;

procedure CPaintManagerUI.RemoveFont(id: Integer; bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveFont_02(Self, id, bShared);
end;

procedure CPaintManagerUI.RemoveAllFonts(bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveAllFonts(Self, bShared);
end;

function CPaintManagerUI.GetFontInfo(id: Integer): PFontInfo;
begin
  Result := Delphi_PaintManagerUI_GetFontInfo_01(Self, id);
end;

function CPaintManagerUI.GetFontInfo(hFont: HFONT): PFontInfo;
begin
  Result := Delphi_PaintManagerUI_GetFontInfo_02(Self, hFont);
end;

function CPaintManagerUI.GetImage(bitmap: string): PImageInfo;
begin
  Result := Delphi_PaintManagerUI_GetImage(Self, PChar(bitmap));
end;

function CPaintManagerUI.GetImageEx(bitmap: string; AType: string; mask: DWORD; bUseHSL: Boolean): PImageInfo;
begin
  Result := Delphi_PaintManagerUI_GetImageEx(Self, PChar(bitmap), PChar(AType), mask, bUseHSL);
end;

function CPaintManagerUI.AddImage(bitmap: string; AType: string; mask: DWORD; bUseHSL: Boolean; bShared: Boolean): PImageInfo;
begin
  Result := Delphi_PaintManagerUI_AddImage_01(Self, PChar(bitmap), PChar(AType), mask, bUseHSL, bShared);
end;

function CPaintManagerUI.AddImage(bitmap: string; hBitmap: HBITMAP; iWidth: Integer; iHeight: Integer; bAlpha: Boolean; bShared: Boolean): PImageInfo;
begin
  Result := Delphi_PaintManagerUI_AddImage_02(Self, PChar(bitmap), hBitmap, iWidth, iHeight, bAlpha, bShared);
end;

procedure CPaintManagerUI.RemoveImage(bitmap: string; bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveImage(Self, PChar(bitmap), bShared);
end;

procedure CPaintManagerUI.RemoveAllImages(bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveAllImages(Self, bShared);
end;

class procedure CPaintManagerUI.ReloadSharedImages;
begin
  Delphi_PaintManagerUI_ReloadSharedImages;
end;

procedure CPaintManagerUI.ReloadImages;
begin
  Delphi_PaintManagerUI_ReloadImages(Self);
end;

procedure CPaintManagerUI.AddDefaultAttributeList(pStrControlName: string; pStrControlAttrList: string; bShared: Boolean);
begin
  Delphi_PaintManagerUI_AddDefaultAttributeList(Self, PChar(pStrControlName), PChar(pStrControlAttrList), bShared);
end;

function CPaintManagerUI.GetDefaultAttributeList(pStrControlName: string): string;
begin
  Result := Delphi_PaintManagerUI_GetDefaultAttributeList(Self, PChar(pStrControlName));
end;

function CPaintManagerUI.RemoveDefaultAttributeList(pStrControlName: string; bShared: Boolean): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveDefaultAttributeList(Self, PChar(pStrControlName), bShared);
end;

procedure CPaintManagerUI.RemoveAllDefaultAttributeList(bShared: Boolean);
begin
  Delphi_PaintManagerUI_RemoveAllDefaultAttributeList(Self, bShared);
end;

class procedure CPaintManagerUI.AddMultiLanguageString(id: Integer; pStrMultiLanguage: string);
begin
  Delphi_PaintManagerUI_AddMultiLanguageString(id, PChar(pStrMultiLanguage));
end;

class function CPaintManagerUI.GetMultiLanguageString(id: Integer): string;
begin
  Result := Delphi_PaintManagerUI_GetMultiLanguageString(id);
end;

class function CPaintManagerUI.RemoveMultiLanguageString(id: Integer): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveMultiLanguageString(id);
end;

class procedure CPaintManagerUI.RemoveAllMultiLanguageString;
begin
  Delphi_PaintManagerUI_RemoveAllMultiLanguageString;
end;

class procedure CPaintManagerUI.ProcessMultiLanguageTokens(var pStrMultiLanguage: string);
var
  DuiStr: CDuiString;
begin
  Delphi_PaintManagerUI_ProcessMultiLanguageTokens(DuiStr);
  pStrMultiLanguage := {$IFNDEF UseLowVer}DuiStr{$ELSE}DuiStringToString(DuiStr){$ENDIF};
end;

function CPaintManagerUI.AttachDialog(pControl: CControlUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AttachDialog(Self, pControl);
end;

function CPaintManagerUI.InitControls(pControl: CControlUI; pParent: CControlUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_InitControls(Self, pControl, pParent);
end;

procedure CPaintManagerUI.ReapObjects(pControl: CControlUI);
begin
  Delphi_PaintManagerUI_ReapObjects(Self, pControl);
end;

function CPaintManagerUI.AddOptionGroup(pStrGroupName: string; pControl: CControlUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddOptionGroup(Self, PChar(pStrGroupName), pControl);
end;

function CPaintManagerUI.GetOptionGroup(pStrGroupName: string): CStdPtrArray;
begin
  Result := Delphi_PaintManagerUI_GetOptionGroup(Self, PChar(pStrGroupName));
end;

procedure CPaintManagerUI.RemoveOptionGroup(pStrGroupName: string; pControl: CControlUI);
begin
  Delphi_PaintManagerUI_RemoveOptionGroup(Self, PChar(pStrGroupName), pControl);
end;

procedure CPaintManagerUI.RemoveAllOptionGroups;
begin
  Delphi_PaintManagerUI_RemoveAllOptionGroups(Self);
end;

function CPaintManagerUI.GetFocus: CControlUI;
begin
  Result := Delphi_PaintManagerUI_GetFocus(Self);
end;

procedure CPaintManagerUI.SetFocus(pControl: CControlUI; bFocusWnd: Boolean);
begin
  Delphi_PaintManagerUI_SetFocus(Self, pControl, bFocusWnd);
end;

procedure CPaintManagerUI.SetFocusNeeded(pControl: CControlUI);
begin
  Delphi_PaintManagerUI_SetFocusNeeded(Self, pControl);
end;

function CPaintManagerUI.SetNextTabControl(bForward: Boolean): Boolean;
begin
  Result := Delphi_PaintManagerUI_SetNextTabControl(Self, bForward);
end;

function CPaintManagerUI.SetTimer(pControl: CControlUI; nTimerID: UINT; uElapse: UINT): Boolean;
begin
  Result := Delphi_PaintManagerUI_SetTimer(Self, pControl, nTimerID, uElapse);
end;

function CPaintManagerUI.KillTimer(pControl: CControlUI; nTimerID: UINT): Boolean;
begin
  Result := Delphi_PaintManagerUI_KillTimer_01(Self, pControl, nTimerID);
end;

procedure CPaintManagerUI.KillTimer(pControl: CControlUI);
begin
  Delphi_PaintManagerUI_KillTimer_02(Self, pControl);
end;

procedure CPaintManagerUI.RemoveAllTimers;
begin
  Delphi_PaintManagerUI_RemoveAllTimers(Self);
end;

procedure CPaintManagerUI.SetCapture;
begin
  Delphi_PaintManagerUI_SetCapture(Self);
end;

procedure CPaintManagerUI.ReleaseCapture;
begin
  Delphi_PaintManagerUI_ReleaseCapture(Self);
end;

function CPaintManagerUI.IsCaptured: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsCaptured(Self);
end;

function CPaintManagerUI.AddNotifier(pControl: INotifyUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddNotifier(Self, pControl);
end;

function CPaintManagerUI.RemoveNotifier(pControl: INotifyUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveNotifier(Self, pControl);
end;

procedure CPaintManagerUI.SendNotify(const Msg: TNotifyUI; bAsync: Boolean; bEnableRepeat: Boolean);
begin
  Delphi_PaintManagerUI_SendNotify_01(Self, Msg, bAsync, bEnableRepeat);
end;

procedure CPaintManagerUI.SendNotify(pControl: CControlUI; pstrMessage: string; wParam: WPARAM; lParam: LPARAM; bAsync: Boolean; bEnableRepeat: Boolean);
begin
  Delphi_PaintManagerUI_SendNotify_02(Self, pControl, LPCTSTR(pstrMessage), wParam, lParam, bAsync, bEnableRepeat);
end;

function CPaintManagerUI.AddPreMessageFilter(pFilter: IMessageFilterUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddPreMessageFilter(Self, pFilter);
end;

function CPaintManagerUI.RemovePreMessageFilter(pFilter: IMessageFilterUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemovePreMessageFilter(Self, pFilter);
end;

function CPaintManagerUI.AddMessageFilter(pFilter: IMessageFilterUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddMessageFilter(Self, pFilter);
end;

function CPaintManagerUI.RemoveMessageFilter(pFilter: IMessageFilterUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveMessageFilter(Self, pFilter);
end;

function CPaintManagerUI.GetPostPaintCount: Integer;
begin
  Result := Delphi_PaintManagerUI_GetPostPaintCount(Self);
end;

function CPaintManagerUI.AddPostPaint(pControl: CControlUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddPostPaint(Self, pControl);
end;

function CPaintManagerUI.RemovePostPaint(pControl: CControlUI): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemovePostPaint(Self, pControl);
end;

function CPaintManagerUI.SetPostPaintIndex(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_PaintManagerUI_SetPostPaintIndex(Self, pControl, iIndex);
end;

function CPaintManagerUI.GetNativeWindowCount: Integer;
begin
  Result := Delphi_PaintManagerUI_GetNativeWindowCount(Self);
end;

function CPaintManagerUI.AddNativeWindow(pControl: CControlUI; hChildWnd: HWND): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddNativeWindow(Self, pControl, hChildWnd);
end;

function CPaintManagerUI.RemoveNativeWindow(hChildWnd: HWND): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveNativeWindow(Self, hChildWnd);
end;

procedure CPaintManagerUI.AddDelayedCleanup(pControl: CControlUI);
begin
  Delphi_PaintManagerUI_AddDelayedCleanup(Self, pControl);
end;

function CPaintManagerUI.AddTranslateAccelerator(pTranslateAccelerator: ITranslateAccelerator): Boolean;
begin
  Result := Delphi_PaintManagerUI_AddTranslateAccelerator(Self, pTranslateAccelerator);
end;

function CPaintManagerUI.RemoveTranslateAccelerator(pTranslateAccelerator: ITranslateAccelerator): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveTranslateAccelerator(Self, pTranslateAccelerator);
end;

function CPaintManagerUI.TranslateAccelerator(pMsg: PMsg): Boolean;
begin
  Result := Delphi_PaintManagerUI_TranslateAccelerator(Self, pMsg);
end;

function CPaintManagerUI.GetRoot: CControlUI;
begin
  Result := Delphi_PaintManagerUI_GetRoot(Self);
end;

function CPaintManagerUI.FindControl(pt: TPoint): CControlUI;
begin
  Result := Delphi_PaintManagerUI_FindControl_01(Self, pt);
end;

function CPaintManagerUI.FindControl(pstrName: string): CControlUI;
begin
  Result := Delphi_PaintManagerUI_FindControl_02(Self, PChar(pstrName));
end;

function CPaintManagerUI.FindSubControlByPoint(pParent: CControlUI; pt: TPoint): CControlUI;
begin
  Result := Delphi_PaintManagerUI_FindSubControlByPoint(Self, pParent, pt);
end;

function CPaintManagerUI.FindSubControlByName(pParent: CControlUI; pstrName: string): CControlUI;
begin
  Result := Delphi_PaintManagerUI_FindSubControlByName(Self, pParent, PChar(pstrName));
end;

function CPaintManagerUI.FindSubControlByClass(pParent: CControlUI; pstrClass: string; iIndex: Integer): CControlUI;
begin
  Result := Delphi_PaintManagerUI_FindSubControlByClass(Self, pParent, PChar(pstrClass), iIndex);
end;

function CPaintManagerUI.FindSubControlsByClass(pParent: CControlUI; pstrClass: string): CStdPtrArray;
begin
  Result := Delphi_PaintManagerUI_FindSubControlsByClass(Self, pParent, PChar(pstrClass));
end;

class procedure CPaintManagerUI.MessageLoop;
begin
  Delphi_PaintManagerUI_MessageLoop;
end;

class function CPaintManagerUI.TranslateMessage(const pMsg: PMsg): Boolean;
begin
  Result := Delphi_PaintManagerUI_TranslateMessage(pMsg);
end;

class procedure CPaintManagerUI.Term;
begin
  Delphi_PaintManagerUI_Term;
end;

function CPaintManagerUI.MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean;
begin
  Result := Delphi_PaintManagerUI_MessageHandler(Self, uMsg, wParam, lParam, lRes);
end;

function CPaintManagerUI.PreMessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var lRes: LRESULT): Boolean;
begin
  Result := Delphi_PaintManagerUI_PreMessageHandler(Self, uMsg, wParam, lParam, lRes);
end;

procedure CPaintManagerUI.UsedVirtualWnd(bUsed: Boolean);
begin
  Delphi_PaintManagerUI_UsedVirtualWnd(Self, bUsed);
end;

function CPaintManagerUI.GetName: string;
begin
  Result := Delphi_PaintManagerUI_GetName(Self);
end;

function CPaintManagerUI.GetTooltipWindowWidth: Integer;
begin
  Result := Delphi_PaintManagerUI_GetTooltipWindowWidth(Self);
end;

procedure CPaintManagerUI.SetTooltipWindowWidth(iWidth: Integer);
begin
  Delphi_PaintManagerUI_SetTooltipWindowWidth(Self, iWidth);
end;

function CPaintManagerUI.GetHoverTime: Integer;
begin
  Result := Delphi_PaintManagerUI_GetHoverTime(Self);
end;

procedure CPaintManagerUI.SetHoverTime(iTime: Integer);
begin
  Delphi_PaintManagerUI_SetHoverTime(Self, iTime);
end;

function CPaintManagerUI.GetOpacity: Byte;
begin
  Result := Delphi_PaintManagerUI_GetOpacity(Self);
end;

procedure CPaintManagerUI.SetOpacity(nOpacity: Byte);
begin
  Delphi_PaintManagerUI_SetOpacity(Self, nOpacity);
end;

function CPaintManagerUI.IsLayered: Boolean;
begin
  Result := Delphi_PaintManagerUI_IsLayered(Self);
end;

procedure CPaintManagerUI.SetLayered(bLayered: Boolean);
begin
  Delphi_PaintManagerUI_SetLayered(Self, bLayered);
end;

function CPaintManagerUI.GetLayeredInset: TRect;
begin
  Result := Delphi_PaintManagerUI_GetLayeredInset(Self)^;
end;

procedure CPaintManagerUI.SetLayeredInset(const rcLayeredInset: TRect);
begin
  Delphi_PaintManagerUI_SetLayeredInset(Self, rcLayeredInset);
end;

function CPaintManagerUI.GetLayeredOpacity: Byte;
begin
  Result := Delphi_PaintManagerUI_GetLayeredOpacity(Self);
end;

procedure CPaintManagerUI.SetLayeredOpacity(nOpacity: Byte);
begin
  Delphi_PaintManagerUI_SetLayeredOpacity(Self, nOpacity);
end;

function CPaintManagerUI.GetLayeredImage: string;
begin
  Result := Delphi_PaintManagerUI_GetLayeredImage(Self);
end;

procedure CPaintManagerUI.SetLayeredImage(pstrImage: string);
begin
  Delphi_PaintManagerUI_SetLayeredImage(Self, LPCTSTR(pstrImage));
end;

class function CPaintManagerUI.GetPaintManager(pstrName: string): CPaintManagerUI;
begin
  Result := Delphi_PaintManagerUI_GetPaintManager(LPCTSTR(pstrName));
end;

class function CPaintManagerUI.GetPaintManagers: CStdPtrArray;
begin
  Result := Delphi_PaintManagerUI_GetPaintManagers;
end;

procedure CPaintManagerUI.AddWindowCustomAttribute(pstrName: string; pstrAttr: string);
begin
  Delphi_PaintManagerUI_AddWindowCustomAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrAttr));
end;

function CPaintManagerUI.GetWindowCustomAttribute(pstrName: string): string;
begin
  Result := Delphi_PaintManagerUI_GetWindowCustomAttribute(Self, LPCTSTR(pstrName));
end;

function CPaintManagerUI.RemoveWindowCustomAttribute(pstrName: string): Boolean;
begin
  Result := Delphi_PaintManagerUI_RemoveWindowCustomAttribute(Self, LPCTSTR(pstrName));
end;

procedure CPaintManagerUI.RemoveAllWindowCustomAttribute;
begin
  Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute(Self);
end;

{ CContainerUI }

class function CContainerUI.CppCreate: CContainerUI;
begin
  Result := Delphi_ContainerUI_CppCreate;
end;

procedure CContainerUI.CppDestroy;
begin
  Delphi_ContainerUI_CppDestroy(Self);
end;

function CContainerUI.GetClass: string;
begin
  Result := Delphi_ContainerUI_GetClass(Self);
end;

function CContainerUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ContainerUI_GetInterface(Self, PChar(pstrName));
end;

function CContainerUI.GetItemAt(iIndex: Integer): CControlUI;
begin
  Result := Delphi_ContainerUI_GetItemAt(Self, iIndex);
end;

function CContainerUI.GetItemIndex(pControl: CControlUI): Integer;
begin
  Result := Delphi_ContainerUI_GetItemIndex(Self, pControl);
end;

function CContainerUI.GetLastItem: CControlUI;
begin
  Result := Items[Count - 1];
end;

function CContainerUI.SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ContainerUI_SetItemIndex(Self, pControl, iIndex);
end;

function CContainerUI.GetCount: Integer;
begin
  Result := Delphi_ContainerUI_GetCount(Self);
end;

function CContainerUI.Add(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ContainerUI_Add(Self, pControl);
end;

function CContainerUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ContainerUI_AddAt(Self, pControl, iIndex);
end;

function CContainerUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ContainerUI_Remove(Self, pControl);
end;

function CContainerUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := Delphi_ContainerUI_RemoveAt(Self, iIndex);
end;

procedure CContainerUI.RemoveAll;
begin
  Delphi_ContainerUI_RemoveAll(Self);
end;

procedure CContainerUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ContainerUI_DoEvent(Self, AEvent);
end;

procedure CContainerUI.SetVisible(bVisible: Boolean);
begin
  Delphi_ContainerUI_SetVisible(Self, bVisible);
end;

procedure CContainerUI._SetItemIndex(pControl: CControlUI;
  const Value: Integer);
begin
  SetItemIndex(pControl, Value);
end;

procedure CContainerUI.SetInternVisible(bVisible: Boolean);
begin
  Delphi_ContainerUI_SetInternVisible(Self, bVisible);
end;

procedure CContainerUI.SetMouseEnabled(bEnable: Boolean);
begin
  Delphi_ContainerUI_SetMouseEnabled(Self, bEnable);
end;

function CContainerUI.GetInset: TRect;
begin
  Delphi_ContainerUI_GetInset(Self, Result);
end;

procedure CContainerUI.SetInset(rcInset: TRect);
begin
  Delphi_ContainerUI_SetInset(Self, rcInset);
end;

function CContainerUI.GetChildPadding: Integer;
begin
  Result := Delphi_ContainerUI_GetChildPadding(Self);
end;

procedure CContainerUI.SetChildPadding(iPadding: Integer);
begin
  Delphi_ContainerUI_SetChildPadding(Self, iPadding);
end;

function CContainerUI.IsAutoDestroy: Boolean;
begin
  Result := Delphi_ContainerUI_IsAutoDestroy(Self);
end;

procedure CContainerUI.SetAutoDestroy(bAuto: Boolean);
begin
  Delphi_ContainerUI_SetAutoDestroy(Self, bAuto);
end;

function CContainerUI.IsDelayedDestroy: Boolean;
begin
  Result := Delphi_ContainerUI_IsDelayedDestroy(Self);
end;

procedure CContainerUI.SetDelayedDestroy(bDelayed: Boolean);
begin
  Delphi_ContainerUI_SetDelayedDestroy(Self, bDelayed);
end;

function CContainerUI.IsMouseChildEnabled: Boolean;
begin
  Result := Delphi_ContainerUI_IsMouseChildEnabled(Self);
end;

procedure CContainerUI.SetMouseChildEnabled(bEnable: Boolean);
begin
  Delphi_ContainerUI_SetMouseChildEnabled(Self, bEnable);
end;

function CContainerUI.FindSelectable(iIndex: Integer; bForward: Boolean): Integer;
begin
  Result := Delphi_ContainerUI_FindSelectable(Self, iIndex, bForward);
end;

function CContainerUI.GetClientPos: TRect;
begin
  Delphi_ContainerUI_GetClientPos(Self, Result);
end;

procedure CContainerUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_ContainerUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CContainerUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_ContainerUI_Move(Self, szOffset, bNeedInvalidate);
end;

procedure CContainerUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ContainerUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CContainerUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ContainerUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CContainerUI.SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean);
begin
  Delphi_ContainerUI_SetManager(Self, pManager, pParent, bInit);
end;

function CContainerUI.FindControl(Proc: TFindControlProc; pData: Pointer; uFlags: UINT): CControlUI;
begin
  Result := Delphi_ContainerUI_FindControl(Self, Proc, pData, uFlags);
end;

function CContainerUI.SetSubControlText(pstrSubControlName: string; pstrText: string): Boolean;
begin
  Result := Delphi_ContainerUI_SetSubControlText(Self, PChar(pstrSubControlName), PChar(pstrText));
end;

function CContainerUI.SetSubControlFixedHeight(pstrSubControlName: string; cy: Integer): Boolean;
begin
  Result := Delphi_ContainerUI_SetSubControlFixedHeight(Self, PChar(pstrSubControlName), cy);
end;

function CContainerUI.SetSubControlFixedWdith(pstrSubControlName: string; cx: Integer): Boolean;
begin
  Result := Delphi_ContainerUI_SetSubControlFixedWdith(Self, PChar(pstrSubControlName), cx);
end;

function CContainerUI.SetSubControlUserData(pstrSubControlName: string; pstrText: string): Boolean;
begin
  Result := Delphi_ContainerUI_SetSubControlUserData(Self, PChar(pstrSubControlName), PChar(pstrText));
end;

function CContainerUI.GetSubControlText(pstrSubControlName: string): string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ContainerUI_GetSubControlText(Self, PChar(pstrSubControlName));
{$ELSE}
  Result := DuiStringToString(Delphi_ContainerUI_GetSubControlText(Self, PChar(pstrSubControlName)));
{$ENDIF}
end;

function CContainerUI.GetSubControlFixedHeight(pstrSubControlName: string): Integer;
begin
  Result := Delphi_ContainerUI_GetSubControlFixedHeight(Self, PChar(pstrSubControlName));
end;

function CContainerUI.GetSubControlFixedWdith(pstrSubControlName: string): Integer;
begin
  Result := Delphi_ContainerUI_GetSubControlFixedWdith(Self, PChar(pstrSubControlName));
end;

function CContainerUI.GetSubControlUserData(pstrSubControlName: string): string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ContainerUI_GetSubControlUserData(Self, PChar(pstrSubControlName));
{$ELSE}
  Result := DuiStringToString(Delphi_ContainerUI_GetSubControlUserData(Self, PChar(pstrSubControlName)));
{$ENDIF}
end;

function CContainerUI.FindSubControl(pstrSubControlName: string): CControlUI;
begin
  Result := Delphi_ContainerUI_FindSubControl(Self, PChar(pstrSubControlName));
end;

function CContainerUI.GetScrollPos: TSize;
begin
  Delphi_ContainerUI_GetScrollPos(Self, Result);
end;

function CContainerUI.GetScrollRange: TSize;
begin
  Delphi_ContainerUI_GetScrollRange(Self, Result);
end;

procedure CContainerUI.SetScrollPos(szPos: TSize);
begin
  Delphi_ContainerUI_SetScrollPos(Self, szPos);
end;

procedure CContainerUI.LineUp;
begin
  Delphi_ContainerUI_LineUp(Self);
end;

procedure CContainerUI.LineDown;
begin
  Delphi_ContainerUI_LineDown(Self);
end;

procedure CContainerUI.PageUp;
begin
  Delphi_ContainerUI_PageUp(Self);
end;

procedure CContainerUI.PageDown;
begin
  Delphi_ContainerUI_PageDown(Self);
end;

procedure CContainerUI.HomeUp;
begin
  Delphi_ContainerUI_HomeUp(Self);
end;

procedure CContainerUI.EndDown;
begin
  Delphi_ContainerUI_EndDown(Self);
end;

procedure CContainerUI.LineLeft;
begin
  Delphi_ContainerUI_LineLeft(Self);
end;

procedure CContainerUI.LineRight;
begin
  Delphi_ContainerUI_LineRight(Self);
end;

procedure CContainerUI.PageLeft;
begin
  Delphi_ContainerUI_PageLeft(Self);
end;

procedure CContainerUI.PageRight;
begin
  Delphi_ContainerUI_PageRight(Self);
end;

procedure CContainerUI.HomeLeft;
begin
  Delphi_ContainerUI_HomeLeft(Self);
end;

procedure CContainerUI.EndRight;
begin
  Delphi_ContainerUI_EndRight(Self);
end;

procedure CContainerUI.EnableScrollBar(bEnableVertical: Boolean; bEnableHorizontal: Boolean);
begin
  Delphi_ContainerUI_EnableScrollBar(Self, bEnableVertical, bEnableHorizontal);
end;

function CContainerUI.GetVerticalScrollBar: CScrollBarUI;
begin
  Result := Delphi_ContainerUI_GetVerticalScrollBar(Self);
end;

function CContainerUI.GetHorizontalScrollBar: CScrollBarUI;
begin
  Result := Delphi_ContainerUI_GetHorizontalScrollBar(Self);
end;

{ CVerticalLayoutUI }

class function CVerticalLayoutUI.CppCreate: CVerticalLayoutUI;
begin
  Result := Delphi_VerticalLayoutUI_CppCreate;
end;

procedure CVerticalLayoutUI.CppDestroy;
begin
  Delphi_VerticalLayoutUI_CppDestroy(Self);
end;

function CVerticalLayoutUI.GetClass: string;
begin
  Result := Delphi_VerticalLayoutUI_GetClass(Self);
end;

function CVerticalLayoutUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_VerticalLayoutUI_GetInterface(Self, PChar(pstrName));
end;

function CVerticalLayoutUI.GetControlFlags: UINT;
begin
  Result := Delphi_VerticalLayoutUI_GetControlFlags(Self);
end;

procedure CVerticalLayoutUI.SetSepHeight(iHeight: Integer);
begin
  Delphi_VerticalLayoutUI_SetSepHeight(Self, iHeight);
end;

function CVerticalLayoutUI.GetSepHeight: Integer;
begin
  Result := Delphi_VerticalLayoutUI_GetSepHeight(Self);
end;

procedure CVerticalLayoutUI.SetSepImmMode(bImmediately: Boolean);
begin
  Delphi_VerticalLayoutUI_SetSepImmMode(Self, bImmediately);
end;

function CVerticalLayoutUI.IsSepImmMode: Boolean;
begin
  Result := Delphi_VerticalLayoutUI_IsSepImmMode(Self);
end;

procedure CVerticalLayoutUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_VerticalLayoutUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CVerticalLayoutUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_VerticalLayoutUI_DoEvent(Self, AEvent);
end;

procedure CVerticalLayoutUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_VerticalLayoutUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CVerticalLayoutUI.DoPostPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_VerticalLayoutUI_DoPostPaint(Self, hDC, rcPaint);
end;

function CVerticalLayoutUI.GetThumbRect(bUseNew: Boolean): TRect;
begin
  Delphi_VerticalLayoutUI_GetThumbRect(Self, bUseNew, Result);
end;

{ CListUI }

class function CListUI.CppCreate: CListUI;
begin
  Result := Delphi_ListUI_CppCreate;
end;

procedure CListUI.CppDestroy;
begin
  Delphi_ListUI_CppDestroy(Self);
end;

function CListUI.GetClass: string;
begin
  Result := Delphi_ListUI_GetClass(Self);
end;

function CListUI.GetControlFlags: UINT;
begin
  Result := Delphi_ListUI_GetControlFlags(Self);
end;

function CListUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListUI_GetInterface(Self, PChar(pstrName));
end;

function CListUI.GetScrollSelect: Boolean;
begin
  Result := Delphi_ListUI_GetScrollSelect(Self);
end;

procedure CListUI.SetScrollSelect(bScrollSelect: Boolean);
begin
  Delphi_ListUI_SetScrollSelect(Self, bScrollSelect);
end;

function CListUI.GetCurSel: Integer;
begin
  Result := Delphi_ListUI_GetCurSel(Self);
end;

function CListUI.SelectItem(iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean;
begin
  Result := Delphi_ListUI_SelectItem(Self, iIndex, bTakeFocus, bTriggerEvent);
end;

function CListUI.GetHeader: CListHeaderUI;
begin
  Result := Delphi_ListUI_GetHeader(Self);
end;

function CListUI.GetList: CContainerUI;
begin
  Result := Delphi_ListUI_GetList(Self);
end;

function CListUI.GetListInfo: PListInfoUI;
begin
  Result := Delphi_ListUI_GetListInfo(Self);
end;

function CListUI.GetItemAt(iIndex: Integer): CControlUI;
begin
  Result := Delphi_ListUI_GetItemAt(Self, iIndex);
end;

function CListUI.GetItemIndex(pControl: CControlUI): Integer;
begin
  Result := Delphi_ListUI_GetItemIndex(Self, pControl);
end;

function CListUI.SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ListUI_SetItemIndex(Self, pControl, iIndex);
end;

function CListUI.GetCount: Integer;
begin
  Result := Delphi_ListUI_GetCount(Self);
end;

function CListUI.Add(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ListUI_Add(Self, pControl);
end;

function CListUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ListUI_AddAt(Self, pControl, iIndex);
end;

function CListUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ListUI_Remove(Self, pControl);
end;

function CListUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := Delphi_ListUI_RemoveAt(Self, iIndex);
end;

procedure CListUI.RemoveAll;
begin
  Delphi_ListUI_RemoveAll(Self);
end;

procedure CListUI.EnsureVisible(iIndex: Integer);
begin
  Delphi_ListUI_EnsureVisible(Self, iIndex);
end;

procedure CListUI.Scroll(dx: Integer; dy: Integer);
begin
  Delphi_ListUI_Scroll(Self, dx, dy);
end;

function CListUI.GetChildPadding: Integer;
begin
  Result := Delphi_ListUI_GetChildPadding(Self);
end;

procedure CListUI.SetChildPadding(iPadding: Integer);
begin
  Delphi_ListUI_SetChildPadding(Self, iPadding);
end;

procedure CListUI.SetItemFont(index: Integer);
begin
  Delphi_ListUI_SetItemFont(Self, index);
end;

procedure CListUI.SetItemTextStyle(uStyle: UINT);
begin
  Delphi_ListUI_SetItemTextStyle(Self, uStyle);
end;

procedure CListUI.SetItemTextPadding(rc: TRect);
begin
  Delphi_ListUI_SetItemTextPadding(Self, rc);
end;

procedure CListUI.SetItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ListUI_SetItemTextColor(Self, dwTextColor);
end;

procedure CListUI.SetItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ListUI_SetItemBkColor(Self, dwBkColor);
end;

procedure CListUI.SetItemBkImage(pStrImage: string);
begin
  Delphi_ListUI_SetItemBkImage(Self, PChar(pStrImage));
end;

function CListUI.IsAlternateBk: Boolean;
begin
  Result := Delphi_ListUI_IsAlternateBk(Self);
end;

procedure CListUI.SetAlternateBk(bAlternateBk: Boolean);
begin
  Delphi_ListUI_SetAlternateBk(Self, bAlternateBk);
end;

procedure CListUI.SetSelectedItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ListUI_SetSelectedItemTextColor(Self, dwTextColor);
end;

procedure CListUI.SetSelectedItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ListUI_SetSelectedItemBkColor(Self, dwBkColor);
end;

procedure CListUI.SetSelectedItemImage(pStrImage: string);
begin
  Delphi_ListUI_SetSelectedItemImage(Self, PChar(pStrImage));
end;

procedure CListUI.SetHotItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ListUI_SetHotItemTextColor(Self, dwTextColor);
end;

procedure CListUI.SetHotItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ListUI_SetHotItemBkColor(Self, dwBkColor);
end;

procedure CListUI.SetHotItemImage(pStrImage: string);
begin
  Delphi_ListUI_SetHotItemImage(Self, PChar(pStrImage));
end;

procedure CListUI.SetDisabledItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ListUI_SetDisabledItemTextColor(Self, dwTextColor);
end;

procedure CListUI.SetDisabledItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ListUI_SetDisabledItemBkColor(Self, dwBkColor);
end;

procedure CListUI.SetDisabledItemImage(pStrImage: string);
begin
  Delphi_ListUI_SetDisabledItemImage(Self, PChar(pStrImage));
end;

procedure CListUI.SetItemLineColor(dwLineColor: DWORD);
begin
  Delphi_ListUI_SetItemLineColor(Self, dwLineColor);
end;

function CListUI.IsItemShowHtml: Boolean;
begin
  Result := Delphi_ListUI_IsItemShowHtml(Self);
end;

procedure CListUI.SetItemShowHtml(bShowHtml: Boolean);
begin
  Delphi_ListUI_SetItemShowHtml(Self, bShowHtml);
end;

function CListUI.GetItemTextPadding: TRect;
begin
  Delphi_ListUI_GetItemTextPadding(Self, Result);
end;

function CListUI.GetItemTextColor: DWORD;
begin
  Result := Delphi_ListUI_GetItemTextColor(Self);
end;

function CListUI.GetItemBkColor: DWORD;
begin
  Result := Delphi_ListUI_GetItemBkColor(Self);
end;

function CListUI.GetItemBkImage: string;
begin
  Result := Delphi_ListUI_GetItemBkImage(Self);
end;

function CListUI.GetSelectedItemTextColor: DWORD;
begin
  Result := Delphi_ListUI_GetSelectedItemTextColor(Self);
end;

function CListUI.GetSelectedItemBkColor: DWORD;
begin
  Result := Delphi_ListUI_GetSelectedItemBkColor(Self);
end;

function CListUI.GetSelectedItemImage: string;
begin
  Result := Delphi_ListUI_GetSelectedItemImage(Self);
end;

function CListUI.GetHotItemTextColor: DWORD;
begin
  Result := Delphi_ListUI_GetHotItemTextColor(Self);
end;

function CListUI.GetHotItemBkColor: DWORD;
begin
  Result := Delphi_ListUI_GetHotItemBkColor(Self);
end;

function CListUI.GetHotItemImage: string;
begin
  Result := Delphi_ListUI_GetHotItemImage(Self);
end;

function CListUI.GetDisabledItemTextColor: DWORD;
begin
  Result := Delphi_ListUI_GetDisabledItemTextColor(Self);
end;

function CListUI.GetDisabledItemBkColor: DWORD;
begin
  Result := Delphi_ListUI_GetDisabledItemBkColor(Self);
end;

function CListUI.GetDisabledItemImage: string;
begin
  Result := Delphi_ListUI_GetDisabledItemImage(Self);
end;

function CListUI.GetItemLineColor: DWORD;
begin
  Result := Delphi_ListUI_GetItemLineColor(Self);
end;

procedure CListUI.SetMultiExpanding(bMultiExpandable: Boolean);
begin
  Delphi_ListUI_SetMultiExpanding(Self, bMultiExpandable);
end;

function CListUI.GetExpandedItem: Integer;
begin
  Result := Delphi_ListUI_GetExpandedItem(Self);
end;

function CListUI.ExpandItem(iIndex: Integer; bExpand: Boolean): Boolean;
begin
  Result := Delphi_ListUI_ExpandItem(Self, iIndex, bExpand);
end;

procedure CListUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_ListUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CListUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_ListUI_Move(Self, szOffset, bNeedInvalidate);
end;

procedure CListUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ListUI_DoEvent(Self, AEvent);
end;

procedure CListUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ListUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

function CListUI.GetTextCallback: IListCallbackUI;
begin
  Result := Delphi_ListUI_GetTextCallback(Self);
end;

procedure CListUI.SetTextCallback(pCallback: IListCallbackUI);
begin
  Delphi_ListUI_SetTextCallback(Self, pCallback);
end;

function CListUI.GetScrollPos: TSize;
begin
  Delphi_ListUI_GetScrollPos(Self, Result);
end;

function CListUI.GetScrollRange: TSize;
begin
  Delphi_ListUI_GetScrollRange(Self, Result);
end;

procedure CListUI.SetScrollPos(szPos: TSize);
begin
  Delphi_ListUI_SetScrollPos(Self, szPos);
end;

procedure CListUI.LineUp;
begin
  Delphi_ListUI_LineUp(Self);
end;

procedure CListUI.LineDown;
begin
  Delphi_ListUI_LineDown(Self);
end;

procedure CListUI.PageUp;
begin
  Delphi_ListUI_PageUp(Self);
end;

procedure CListUI.PageDown;
begin
  Delphi_ListUI_PageDown(Self);
end;

procedure CListUI.HomeUp;
begin
  Delphi_ListUI_HomeUp(Self);
end;

procedure CListUI.EndDown;
begin
  Delphi_ListUI_EndDown(Self);
end;

procedure CListUI.LineLeft;
begin
  Delphi_ListUI_LineLeft(Self);
end;

procedure CListUI.LineRight;
begin
  Delphi_ListUI_LineRight(Self);
end;

procedure CListUI.PageLeft;
begin
  Delphi_ListUI_PageLeft(Self);
end;

procedure CListUI.PageRight;
begin
  Delphi_ListUI_PageRight(Self);
end;

procedure CListUI.HomeLeft;
begin
  Delphi_ListUI_HomeLeft(Self);
end;

procedure CListUI.EndRight;
begin
  Delphi_ListUI_EndRight(Self);
end;

procedure CListUI.EnableScrollBar(bEnableVertical: Boolean; bEnableHorizontal: Boolean);
begin
  Delphi_ListUI_EnableScrollBar(Self, bEnableVertical, bEnableHorizontal);
end;

function CListUI.GetVerticalScrollBar: CScrollBarUI;
begin
  Result := Delphi_ListUI_GetVerticalScrollBar(Self);
end;

function CListUI.GetHorizontalScrollBar: CScrollBarUI;
begin
  Result := Delphi_ListUI_GetHorizontalScrollBar(Self);
end;

function CListUI.SortItems(pfnCompare: PULVCompareFunc; dwData: UINT_PTR): BOOL;
begin
  Result := Delphi_ListUI_SortItems(Self, pfnCompare, dwData);
end;

{ CDelphi_ListUI }

class function CDelphi_ListUI.CppCreate: CDelphi_ListUI;
begin
  Result := Delphi_Delphi_ListUI_CppCreate;
end;

procedure CDelphi_ListUI.CppDestroy;
begin
  Delphi_Delphi_ListUI_CppDestroy(Self);
end;

procedure CDelphi_ListUI.SetDelphiSelf(ASelf: Pointer);
begin
  Delphi_Delphi_ListUI_SetDelphiSelf(Self, ASelf);
end;

procedure CDelphi_ListUI.SetDoEvent(ADoEvent: Pointer);
begin
  Delphi_Delphi_ListUI_SetDoEvent(Self, ADoEvent);
end;

{ CLabelUI }

class function CLabelUI.CppCreate: CLabelUI;
begin
  Result := Delphi_LabelUI_CppCreate;
end;

procedure CLabelUI.CppDestroy;
begin
  Delphi_LabelUI_CppDestroy(Self);
end;

function CLabelUI.GetClass: string;
begin
  Result := Delphi_LabelUI_GetClass(Self);
end;

procedure CLabelUI.SetText(pstrText: string);
begin
  Delphi_LabelUI_SetText(Self, PChar(pstrText));
end;

function CLabelUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_LabelUI_GetInterface(Self, PChar(pstrName));
end;

procedure CLabelUI.SetTextStyle(uStyle: UINT);
begin
  Delphi_LabelUI_SetTextStyle(Self, uStyle);
end;

function CLabelUI.GetTextStyle: UINT;
begin
  Result := Delphi_LabelUI_GetTextStyle(Self);
end;

procedure CLabelUI.SetTextColor(dwTextColor: DWORD);
begin
  Delphi_LabelUI_SetTextColor(Self, dwTextColor);
end;

function CLabelUI.GetTextColor: DWORD;
begin
  Result := Delphi_LabelUI_GetTextColor(Self);
end;

procedure CLabelUI.SetDisabledTextColor(dwTextColor: DWORD);
begin
  Delphi_LabelUI_SetDisabledTextColor(Self, dwTextColor);
end;

function CLabelUI.GetDisabledTextColor: DWORD;
begin
  Result := Delphi_LabelUI_GetDisabledTextColor(Self);
end;

procedure CLabelUI.SetFont(index: Integer);
begin
  Delphi_LabelUI_SetFont(Self, index);
end;

function CLabelUI.GetFont: Integer;
begin
  Result := Delphi_LabelUI_GetFont(Self);
end;

function CLabelUI.GetTextPadding: TRect;
begin
  Delphi_LabelUI_GetTextPadding(Self, Result);
end;

procedure CLabelUI.SetTextPadding(rc: TRect);
begin
  Delphi_LabelUI_SetTextPadding(Self, rc);
end;

function CLabelUI.IsShowHtml: Boolean;
begin
  Result := Delphi_LabelUI_IsShowHtml(Self);
end;

procedure CLabelUI.SetShowHtml(bShowHtml: Boolean);
begin
  Delphi_LabelUI_SetShowHtml(Self, bShowHtml);
end;

function CLabelUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_LabelUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CLabelUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_LabelUI_DoEvent(Self, AEvent);
end;

procedure CLabelUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_LabelUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CLabelUI.PaintText(hDC: HDC);
begin
  Delphi_LabelUI_PaintText(Self, hDC);
end;

procedure CLabelUI.SetEnabledEffect(_EnabledEffect: Boolean);
begin
  Delphi_LabelUI_SetEnabledEffect(Self, _EnabledEffect);
end;

function CLabelUI.GetEnabledEffect: Boolean;
begin
  Result := Delphi_LabelUI_GetEnabledEffect(Self);
end;

procedure CLabelUI.SetEnabledLuminous(bEnableLuminous: Boolean);
begin
  Delphi_LabelUI_SetEnabledLuminous(Self, bEnableLuminous);
end;

function CLabelUI.GetEnabledLuminous: Boolean;
begin
  Result := Delphi_LabelUI_GetEnabledLuminous(Self);
end;

procedure CLabelUI.SetLuminousFuzzy(fFuzzy: Single);
begin
  Delphi_LabelUI_SetLuminousFuzzy(Self, fFuzzy);
end;

function CLabelUI.GetLuminousFuzzy: Single;
begin
  Result := Delphi_LabelUI_GetLuminousFuzzy(Self);
end;

procedure CLabelUI.SetGradientLength(_GradientLength: Integer);
begin
  Delphi_LabelUI_SetGradientLength(Self, _GradientLength);
end;

function CLabelUI.GetGradientLength: Integer;
begin
  Result := Delphi_LabelUI_GetGradientLength(Self);
end;

procedure CLabelUI.SetShadowOffset(_offset: Integer; _angle: Integer);
begin
  Delphi_LabelUI_SetShadowOffset(Self, _offset, _angle);
end;

function CLabelUI.GetShadowOffset: TRectF;
begin
  Delphi_LabelUI_GetShadowOffset(Self, Result);
end;

procedure CLabelUI.SetTextColor1(_TextColor1: DWORD);
begin
  Delphi_LabelUI_SetTextColor1(Self, _TextColor1);
end;

function CLabelUI.GetTextColor1: DWORD;
begin
  Result := Delphi_LabelUI_GetTextColor1(Self);
end;

procedure CLabelUI.SetTextShadowColorA(_TextShadowColorA: DWORD);
begin
  Delphi_LabelUI_SetTextShadowColorA(Self, _TextShadowColorA);
end;

function CLabelUI.GetTextShadowColorA: DWORD;
begin
  Result := Delphi_LabelUI_GetTextShadowColorA(Self);
end;

procedure CLabelUI.SetTextShadowColorB(_TextShadowColorB: DWORD);
begin
  Delphi_LabelUI_SetTextShadowColorB(Self, _TextShadowColorB);
end;

function CLabelUI.GetTextShadowColorB: DWORD;
begin
  Result := Delphi_LabelUI_GetTextShadowColorB(Self);
end;

procedure CLabelUI.SetStrokeColor(_StrokeColor: DWORD);
begin
  Delphi_LabelUI_SetStrokeColor(Self, _StrokeColor);
end;

function CLabelUI.GetStrokeColor: DWORD;
begin
  Result := Delphi_LabelUI_GetStrokeColor(Self);
end;

procedure CLabelUI.SetGradientAngle(_SetGradientAngle: Integer);
begin
  Delphi_LabelUI_SetGradientAngle(Self, _SetGradientAngle);
end;

function CLabelUI.GetGradientAngle: Integer;
begin
  Result := Delphi_LabelUI_GetGradientAngle(Self);
end;

procedure CLabelUI.SetEnabledStroke(_EnabledStroke: Boolean);
begin
  Delphi_LabelUI_SetEnabledStroke(Self, _EnabledStroke);
end;

function CLabelUI.GetEnabledStroke: Boolean;
begin
  Result := Delphi_LabelUI_GetEnabledStroke(Self);
end;

procedure CLabelUI.SetEnabledShadow(_EnabledShadowe: Boolean);
begin
  Delphi_LabelUI_SetEnabledShadow(Self, _EnabledShadowe);
end;

function CLabelUI.GetEnabledShadow: Boolean;
begin
  Result := Delphi_LabelUI_GetEnabledShadow(Self);
end;

{ CButtonUI }

class function CButtonUI.CppCreate: CButtonUI;
begin
  Result := Delphi_ButtonUI_CppCreate;
end;

procedure CButtonUI.CppDestroy;
begin
  Delphi_ButtonUI_CppDestroy(Self);
end;

function CButtonUI.GetClass: string;
begin
  Result := Delphi_ButtonUI_GetClass(Self);
end;

function CButtonUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ButtonUI_GetInterface(Self, PChar(pstrName));
end;

function CButtonUI.GetControlFlags: UINT;
begin
  Result := Delphi_ButtonUI_GetControlFlags(Self);
end;

function CButtonUI.Activate: Boolean;
begin
  Result := Delphi_ButtonUI_Activate(Self);
end;

procedure CButtonUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ButtonUI_SetEnabled(Self, bEnable);
end;

procedure CButtonUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ButtonUI_DoEvent(Self, AEvent);
end;

function CButtonUI.GetNormalImage: string;
begin
  Result := Delphi_ButtonUI_GetNormalImage(Self);
end;

procedure CButtonUI.SetNormalImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetNormalImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetHotImage: string;
begin
  Result := Delphi_ButtonUI_GetHotImage(Self);
end;

procedure CButtonUI.SetHotImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetHotImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetPushedImage: string;
begin
  Result := Delphi_ButtonUI_GetPushedImage(Self);
end;

procedure CButtonUI.SetPushedImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetPushedImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetFocusedImage: string;
begin
  Result := Delphi_ButtonUI_GetFocusedImage(Self);
end;

procedure CButtonUI.SetFocusedImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetFocusedImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetDisabledImage: string;
begin
  Result := Delphi_ButtonUI_GetDisabledImage(Self);
end;

procedure CButtonUI.SetDisabledImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetDisabledImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetForeImage: string;
begin
  Result := Delphi_ButtonUI_GetForeImage(Self);
end;

procedure CButtonUI.SetForeImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetForeImage(Self, PChar(pStrImage));
end;

function CButtonUI.GetHotForeImage: string;
begin
  Result := Delphi_ButtonUI_GetHotForeImage(Self);
end;

procedure CButtonUI.SetHotForeImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetHotForeImage(Self, PChar(pStrImage));
end;

procedure CButtonUI.SetHotBkColor(dwColor: DWORD);
begin
  Delphi_ButtonUI_SetHotBkColor(Self, dwColor);
end;

function CButtonUI.GetHotBkColor: DWORD;
begin
  Result := Delphi_ButtonUI_GetHotBkColor(Self);
end;

procedure CButtonUI.SetHotTextColor(dwColor: DWORD);
begin
  Delphi_ButtonUI_SetHotTextColor(Self, dwColor);
end;

function CButtonUI.GetHotTextColor: DWORD;
begin
  Result := Delphi_ButtonUI_GetHotTextColor(Self);
end;

procedure CButtonUI.SetPushedTextColor(dwColor: DWORD);
begin
  Delphi_ButtonUI_SetPushedTextColor(Self, dwColor);
end;

function CButtonUI.GetPushedTextColor: DWORD;
begin
  Result := Delphi_ButtonUI_GetPushedTextColor(Self);
end;

procedure CButtonUI.SetFocusedTextColor(dwColor: DWORD);
begin
  Delphi_ButtonUI_SetFocusedTextColor(Self, dwColor);
end;

function CButtonUI.GetFocusedTextColor: DWORD;
begin
  Result := Delphi_ButtonUI_GetFocusedTextColor(Self);
end;

function CButtonUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ButtonUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CButtonUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ButtonUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CButtonUI.PaintText(hDC: HDC);
begin
  Delphi_ButtonUI_PaintText(Self, hDC);
end;

procedure CButtonUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_ButtonUI_PaintStatusImage(Self, hDC);
end;

procedure CButtonUI.SetFiveStatusImage(pStrImage: string);
begin
  Delphi_ButtonUI_SetFiveStatusImage(Self, LPCTSTR(pStrImage));
end;

procedure CButtonUI.SetFadeAlphaDelta(uDelta: Byte);
begin
  Delphi_ButtonUI_SetFadeAlphaDelta(Self, uDelta);
end;

function CButtonUI.GetFadeAlphaDelta: Boolean;
begin
  Result := Delphi_ButtonUI_GetFadeAlphaDelta(Self);
end;

{ COptionUI }

class function COptionUI.CppCreate: COptionUI;
begin
  Result := Delphi_OptionUI_CppCreate;
end;

procedure COptionUI.CppDestroy;
begin
  Delphi_OptionUI_CppDestroy(Self);
end;

function COptionUI.GetClass: string;
begin
  Result := Delphi_OptionUI_GetClass(Self);
end;

function COptionUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_OptionUI_GetInterface(Self, PChar(pstrName));
end;

procedure COptionUI.SetManager(pManager: CPaintManagerUI; pParent: CControlUI; bInit: Boolean);
begin
  Delphi_OptionUI_SetManager(Self, pManager, pParent, bInit);
end;

function COptionUI.Activate: Boolean;
begin
  Result := Delphi_OptionUI_Activate(Self);
end;

procedure COptionUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_OptionUI_SetEnabled(Self, bEnable);
end;

function COptionUI.GetSelectedImage: string;
begin
  Result := Delphi_OptionUI_GetSelectedImage(Self);
end;

procedure COptionUI.SetSelectedImage(pStrImage: string);
begin
  Delphi_OptionUI_SetSelectedImage(Self, PChar(pStrImage));
end;

function COptionUI.GetSelectedHotImage: string;
begin
  Result := Delphi_OptionUI_GetSelectedHotImage(Self);
end;

procedure COptionUI.SetSelectedHotImage(pStrImage: string);
begin
  Delphi_OptionUI_SetSelectedHotImage(Self, PChar(pStrImage));
end;

procedure COptionUI.SetSelectedTextColor(dwTextColor: DWORD);
begin
  Delphi_OptionUI_SetSelectedTextColor(Self, dwTextColor);
end;

function COptionUI.GetSelectedTextColor: DWORD;
begin
  Result := Delphi_OptionUI_GetSelectedTextColor(Self);
end;

procedure COptionUI.SetSelected(const Value: Boolean);
begin
  _Selected(Value);
end;

procedure COptionUI.SetSelectedBkColor(dwBkColor: DWORD);
begin
  Delphi_OptionUI_SetSelectedBkColor(Self, dwBkColor);
end;

function COptionUI.GetSelectBkColor: DWORD;
begin
  Result := Delphi_OptionUI_GetSelectBkColor(Self);
end;

function COptionUI.GetForeImage: string;
begin
  Result := Delphi_OptionUI_GetForeImage(Self);
end;

procedure COptionUI.SetForeImage(pStrImage: string);
begin
  Delphi_OptionUI_SetForeImage(Self, PChar(pStrImage));
end;

function COptionUI.GetGroup: string;
begin
  Result := Delphi_OptionUI_GetGroup(Self);
end;

procedure COptionUI.SetGroup(pStrGroupName: string);
begin
  Delphi_OptionUI_SetGroup(Self, PChar(pStrGroupName));
end;

function COptionUI.IsSelected: Boolean;
begin
  Result := Delphi_OptionUI_IsSelected(Self);
end;

procedure COptionUI._Selected(bSelected: Boolean; bTriggerEvent: Boolean);
begin
  Delphi_OptionUI_Selected(Self, bSelected, bTriggerEvent);
end;

function COptionUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_OptionUI_EstimateSize(Self, szAvailable, Result);
end;

procedure COptionUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_OptionUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure COptionUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_OptionUI_PaintStatusImage(Self, hDC);
end;

procedure COptionUI.PaintText(hDC: HDC);
begin
  Delphi_OptionUI_PaintText(Self, hDC);
end;

{ CCheckBoxUI }

class function CCheckBoxUI.CppCreate: CCheckBoxUI;
begin
  Result := Delphi_CheckBoxUI_CppCreate;
end;

procedure CCheckBoxUI.CppDestroy;
begin
  Delphi_CheckBoxUI_CppDestroy(Self);
end;

function CCheckBoxUI.GetClass: string;
begin
  Result := Delphi_CheckBoxUI_GetClass(Self);
end;

function CCheckBoxUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_CheckBoxUI_GetInterface(Self, PChar(pstrName));
end;

procedure CCheckBoxUI.SetCheck(bCheck: Boolean; bTriggerEvent: Boolean);
begin
  Delphi_CheckBoxUI_SetCheck(Self, bCheck, bTriggerEvent);
end;

procedure CCheckBoxUI.SetChecked(const Value: Boolean);
begin
  SetCheck(Value);
end;

function CCheckBoxUI.GetCheck: Boolean;
begin
  Result := Delphi_CheckBoxUI_GetCheck(Self);
end;

{ CListContainerElementUI }

class function CListContainerElementUI.CppCreate: CListContainerElementUI;
begin
  Result := Delphi_ListContainerElementUI_CppCreate;
end;

procedure CListContainerElementUI.CppDestroy;
begin
  Delphi_ListContainerElementUI_CppDestroy(Self);
end;

function CListContainerElementUI.GetClass: string;
begin
  Result := Delphi_ListContainerElementUI_GetClass(Self);
end;

function CListContainerElementUI.GetControlFlags: UINT;
begin
  Result := Delphi_ListContainerElementUI_GetControlFlags(Self);
end;

function CListContainerElementUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListContainerElementUI_GetInterface(Self, PChar(pstrName));
end;

function CListContainerElementUI.GetIndex: Integer;
begin
  Result := Delphi_ListContainerElementUI_GetIndex(Self);
end;

procedure CListContainerElementUI.SetIndex(iIndex: Integer);
begin
  Delphi_ListContainerElementUI_SetIndex(Self, iIndex);
end;

function CListContainerElementUI.GetOwner: IListOwnerUI;
begin
  Result := Delphi_ListContainerElementUI_GetOwner(Self);
end;

procedure CListContainerElementUI.SetOwner(pOwner: CControlUI);
begin
  Delphi_ListContainerElementUI_SetOwner(Self, pOwner);
end;

procedure CListContainerElementUI.SetSelect(const Value: Boolean);
begin
  Select(Value);
end;

procedure CListContainerElementUI.SetVisible(bVisible: Boolean);
begin
  Delphi_ListContainerElementUI_SetVisible(Self, bVisible);
end;

procedure CListContainerElementUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ListContainerElementUI_SetEnabled(Self, bEnable);
end;

procedure CListContainerElementUI.SetExpand(const Value: Boolean);
begin
  Expand(Value);
end;

function CListContainerElementUI.IsSelected: Boolean;
begin
  Result := Delphi_ListContainerElementUI_IsSelected(Self);
end;

function CListContainerElementUI.Select(bSelect: Boolean): Boolean;
begin
  Result := Delphi_ListContainerElementUI_Select(Self, bSelect);
end;

function CListContainerElementUI.IsExpanded: Boolean;
begin
  Result := Delphi_ListContainerElementUI_IsExpanded(Self);
end;

function CListContainerElementUI.Expand(bExpand: Boolean): Boolean;
begin
  Result := Delphi_ListContainerElementUI_Expand(Self, bExpand);
end;

procedure CListContainerElementUI.Invalidate;
begin
  Delphi_ListContainerElementUI_Invalidate(Self);
end;

function CListContainerElementUI.Activate: Boolean;
begin
  Result := Delphi_ListContainerElementUI_Activate(Self);
end;

procedure CListContainerElementUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ListContainerElementUI_DoEvent(Self, AEvent);
end;

procedure CListContainerElementUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ListContainerElementUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CListContainerElementUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ListContainerElementUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CListContainerElementUI.DrawItemText(hDC: HDC; const rcItem: TRect);
begin
  Delphi_ListContainerElementUI_DrawItemText(Self, hDC, rcItem);
end;

procedure CListContainerElementUI.DrawItemBk(hDC: HDC; const rcItem: TRect);
begin
  Delphi_ListContainerElementUI_DrawItemBk(Self, hDC, rcItem);
end;

{ CComboUI }

class function CComboUI.CppCreate: CComboUI;
begin
  Result := Delphi_ComboUI_CppCreate;
end;

procedure CComboUI.CppDestroy;
begin
  Delphi_ComboUI_CppDestroy(Self);
end;

function CComboUI.GetClass: string;
begin
  Result := Delphi_ComboUI_GetClass(Self);
end;

function CComboUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ComboUI_GetInterface(Self, PChar(pstrName));
end;

procedure CComboUI.DoInit;
begin
  Delphi_ComboUI_DoInit(Self);
end;

function CComboUI.GetControlFlags: UINT;
begin
  Result := Delphi_ComboUI_GetControlFlags(Self);
end;

function CComboUI.GetText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ComboUI_GetText(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ComboUI_GetText(Self));
{$ENDIF}
end;

procedure CComboUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ComboUI_SetEnabled(Self, bEnable);
end;

function CComboUI.GetDropBoxAttributeList: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ComboUI_GetDropBoxAttributeList(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ComboUI_GetDropBoxAttributeList(Self));
{$ENDIF}
end;

procedure CComboUI.SetDropBoxAttributeList(pstrList: string);
begin
  Delphi_ComboUI_SetDropBoxAttributeList(Self, PChar(pstrList));
end;

function CComboUI.GetDropBoxSize: TSize;
begin
  Delphi_ComboUI_GetDropBoxSize(Self, Result);
end;

procedure CComboUI.SetDropBoxSize(szDropBox: TSize);
begin
  Delphi_ComboUI_SetDropBoxSize(Self, szDropBox);
end;

function CComboUI.GetCurSel: Integer;
begin
  Result := Delphi_ComboUI_GetCurSel(Self);
end;

function CComboUI.GetSelectCloseFlag: Boolean;
begin
  Result := Delphi_ComboUI_GetSelectCloseFlag(Self);
end;

procedure CComboUI.SetSelectCloseFlag(flag: Boolean);
begin
  Delphi_ComboUI_SetSelectCloseFlag(Self, flag);
end;

function CComboUI.SelectItem(iIndex: Integer; bTakeFocus: Boolean; bTriggerEvent: Boolean): Boolean;
begin
  Result := Delphi_ComboUI_SelectItem(Self, iIndex, bTakeFocus, bTriggerEvent);
end;

function CComboUI.SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ComboUI_SetItemIndex(Self, pControl, iIndex);
end;

function CComboUI.Add(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ComboUI_Add(Self, pControl);
end;

function CComboUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_ComboUI_AddAt(Self, pControl, iIndex);
end;

function CComboUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_ComboUI_Remove(Self, pControl);
end;

function CComboUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := Delphi_ComboUI_RemoveAt(Self, iIndex);
end;

procedure CComboUI.RemoveAll;
begin
  Delphi_ComboUI_RemoveAll(Self);
end;

function CComboUI.Activate: Boolean;
begin
  Result := Delphi_ComboUI_Activate(Self);
end;

function CComboUI.GetShowText: Boolean;
begin
  Result := Delphi_ComboUI_GetShowText(Self);
end;

procedure CComboUI.SetShowText(flag: Boolean);
begin
  Delphi_ComboUI_SetShowText(Self, flag);
end;

function CComboUI.GetTextPadding: TRect;
begin
  Delphi_ComboUI_GetTextPadding(Self, Result);
end;

procedure CComboUI.SetTextPadding(rc: TRect);
begin
  Delphi_ComboUI_SetTextPadding(Self, rc);
end;

function CComboUI.GetNormalImage: string;
begin
  Result := Delphi_ComboUI_GetNormalImage(Self);
end;

procedure CComboUI.SetNormalImage(pStrImage: string);
begin
  Delphi_ComboUI_SetNormalImage(Self, PChar(pStrImage));
end;

function CComboUI.GetHotImage: string;
begin
  Result := Delphi_ComboUI_GetHotImage(Self);
end;

procedure CComboUI.SetHotImage(pStrImage: string);
begin
  Delphi_ComboUI_SetHotImage(Self, PChar(pStrImage));
end;

function CComboUI.GetPushedImage: string;
begin
  Result := Delphi_ComboUI_GetPushedImage(Self);
end;

procedure CComboUI.SetPushedImage(pStrImage: string);
begin
  Delphi_ComboUI_SetPushedImage(Self, PChar(pStrImage));
end;

function CComboUI.GetFocusedImage: string;
begin
  Result := Delphi_ComboUI_GetFocusedImage(Self);
end;

procedure CComboUI.SetFocusedImage(pStrImage: string);
begin
  Delphi_ComboUI_SetFocusedImage(Self, PChar(pStrImage));
end;

function CComboUI.GetDisabledImage: string;
begin
  Result := Delphi_ComboUI_GetDisabledImage(Self);
end;

procedure CComboUI.SetDisabledImage(pStrImage: string);
begin
  Delphi_ComboUI_SetDisabledImage(Self, PChar(pStrImage));
end;

function CComboUI.GetListInfo: PListInfoUI;
begin
  Result := Delphi_ComboUI_GetListInfo(Self);
end;

procedure CComboUI.SetItemFont(index: Integer);
begin
  Delphi_ComboUI_SetItemFont(Self, index);
end;

procedure CComboUI.SetItemTextStyle(uStyle: UINT);
begin
  Delphi_ComboUI_SetItemTextStyle(Self, uStyle);
end;

function CComboUI.GetItemTextPadding: TRect;
begin
  Delphi_ComboUI_GetItemTextPadding(Self, Result);
end;

procedure CComboUI.SetItemTextPadding(rc: TRect);
begin
  Delphi_ComboUI_SetItemTextPadding(Self, rc);
end;

function CComboUI.GetItemTextColor: DWORD;
begin
  Result := Delphi_ComboUI_GetItemTextColor(Self);
end;

procedure CComboUI.SetItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ComboUI_SetItemTextColor(Self, dwTextColor);
end;

function CComboUI.GetItemBkColor: DWORD;
begin
  Result := Delphi_ComboUI_GetItemBkColor(Self);
end;

procedure CComboUI.SetItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ComboUI_SetItemBkColor(Self, dwBkColor);
end;

function CComboUI.GetItemBkImage: string;
begin
  Result := Delphi_ComboUI_GetItemBkImage(Self);
end;

procedure CComboUI.SetItemBkImage(pStrImage: string);
begin
  Delphi_ComboUI_SetItemBkImage(Self, PChar(pStrImage));
end;

function CComboUI.IsAlternateBk: Boolean;
begin
  Result := Delphi_ComboUI_IsAlternateBk(Self);
end;

procedure CComboUI.SetAlternateBk(bAlternateBk: Boolean);
begin
  Delphi_ComboUI_SetAlternateBk(Self, bAlternateBk);
end;

function CComboUI.GetSelectedItemTextColor: DWORD;
begin
  Result := Delphi_ComboUI_GetSelectedItemTextColor(Self);
end;

procedure CComboUI.SetSelectedItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ComboUI_SetSelectedItemTextColor(Self, dwTextColor);
end;

function CComboUI.GetSelectedItemBkColor: DWORD;
begin
  Result := Delphi_ComboUI_GetSelectedItemBkColor(Self);
end;

procedure CComboUI.SetSelectedItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ComboUI_SetSelectedItemBkColor(Self, dwBkColor);
end;

function CComboUI.GetSelectedItemImage: string;
begin
  Result := Delphi_ComboUI_GetSelectedItemImage(Self);
end;

procedure CComboUI.SetSelectedItemImage(pStrImage: string);
begin
  Delphi_ComboUI_SetSelectedItemImage(Self, PChar(pStrImage));
end;

function CComboUI.GetHotItemTextColor: DWORD;
begin
  Result := Delphi_ComboUI_GetHotItemTextColor(Self);
end;

procedure CComboUI.SetHotItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ComboUI_SetHotItemTextColor(Self, dwTextColor);
end;

function CComboUI.GetHotItemBkColor: DWORD;
begin
  Result := Delphi_ComboUI_GetHotItemBkColor(Self);
end;

procedure CComboUI.SetHotItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ComboUI_SetHotItemBkColor(Self, dwBkColor);
end;

function CComboUI.GetHotItemImage: string;
begin
  Result := Delphi_ComboUI_GetHotItemImage(Self);
end;

procedure CComboUI.SetHotItemImage(pStrImage: string);
begin
  Delphi_ComboUI_SetHotItemImage(Self, PChar(pStrImage));
end;

function CComboUI.GetDisabledItemTextColor: DWORD;
begin
  Result := Delphi_ComboUI_GetDisabledItemTextColor(Self);
end;

procedure CComboUI.SetDisabledItemTextColor(dwTextColor: DWORD);
begin
  Delphi_ComboUI_SetDisabledItemTextColor(Self, dwTextColor);
end;

function CComboUI.GetDisabledItemBkColor: DWORD;
begin
  Result := Delphi_ComboUI_GetDisabledItemBkColor(Self);
end;

procedure CComboUI.SetDisabledItemBkColor(dwBkColor: DWORD);
begin
  Delphi_ComboUI_SetDisabledItemBkColor(Self, dwBkColor);
end;

function CComboUI.GetDisabledItemImage: string;
begin
  Result := Delphi_ComboUI_GetDisabledItemImage(Self);
end;

procedure CComboUI.SetDisabledItemImage(pStrImage: string);
begin
  Delphi_ComboUI_SetDisabledItemImage(Self, PChar(pStrImage));
end;

function CComboUI.GetItemLineColor: DWORD;
begin
  Result := Delphi_ComboUI_GetItemLineColor(Self);
end;

procedure CComboUI.SetItemLineColor(dwLineColor: DWORD);
begin
  Delphi_ComboUI_SetItemLineColor(Self, dwLineColor);
end;

function CComboUI.IsItemShowHtml: Boolean;
begin
  Result := Delphi_ComboUI_IsItemShowHtml(Self);
end;

procedure CComboUI.SetItemShowHtml(bShowHtml: Boolean);
begin
  Delphi_ComboUI_SetItemShowHtml(Self, bShowHtml);
end;

function CComboUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ComboUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CComboUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_ComboUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CComboUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_ComboUI_Move(Self, szOffset, bNeedInvalidate);
end;

procedure CComboUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ComboUI_DoEvent(Self, AEvent);
end;

procedure CComboUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ComboUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CComboUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ComboUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CComboUI.PaintText(hDC: HDC);
begin
  Delphi_ComboUI_PaintText(Self, hDC);
end;

procedure CComboUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_ComboUI_PaintStatusImage(Self, hDC);
end;

{ CDateTimeUI }

class function CDateTimeUI.CppCreate: CDateTimeUI;
begin
  Result := Delphi_DateTimeUI_CppCreate;
end;

procedure CDateTimeUI.CppDestroy;
begin
  Delphi_DateTimeUI_CppDestroy(Self);
end;

function CDateTimeUI.GetClass: string;
begin
  Result := Delphi_DateTimeUI_GetClass(Self);
end;

function CDateTimeUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_DateTimeUI_GetInterface(Self, PChar(pstrName));
end;

function CDateTimeUI.GetControlFlags: UINT;
begin
  Result := Delphi_DateTimeUI_GetControlFlags(Self);
end;

function CDateTimeUI.GetNativeWindow: HWND;
begin
  Result := Delphi_DateTimeUI_GetNativeWindow(Self);
end;

function CDateTimeUI.GetTime: TDateTime;
var
  LSysDateTime: TSystemTime;
begin
  LSysDateTime:= Delphi_DateTimeUI_GetTime(Self)^;
  Result := EncodeDateTime(LSysDateTime.wYear, LSysDateTime.wMonth, LSysDateTime.wDay,
                 LSysDateTime.wHour, LSysDateTime.wMinute, LSysDateTime.wSecond,
                 LSysDateTime.wMilliseconds);
end;

procedure CDateTimeUI.SetTime(pst: TDateTime);
var
  LSysDateTime: TSYSTEMTIME;
begin
  DecodeDateTime(pst, LSysDateTime.wYear, LSysDateTime.wMonth, LSysDateTime.wDay,
                 LSysDateTime.wHour, LSysDateTime.wMinute, LSysDateTime.wSecond,
                 LSysDateTime.wMilliseconds);
  LSysDateTime.wDayOfWeek := DayOfTheWeek(pst);
  Delphi_DateTimeUI_SetTime(Self, @LSysDateTime);
end;

procedure CDateTimeUI.SetReadOnly(bReadOnly: Boolean);
begin
  Delphi_DateTimeUI_SetReadOnly(Self, bReadOnly);
end;

function CDateTimeUI.IsReadOnly: Boolean;
begin
  Result := Delphi_DateTimeUI_IsReadOnly(Self);
end;

procedure CDateTimeUI.UpdateText;
begin
  Delphi_DateTimeUI_UpdateText(Self);
end;

procedure CDateTimeUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_DateTimeUI_DoEvent(Self, AEvent);
end;

{ CEditUI }

class function CEditUI.CppCreate: CEditUI;
begin
  Result := Delphi_EditUI_CppCreate;
end;

procedure CEditUI.CppDestroy;
begin
  Delphi_EditUI_CppDestroy(Self);
end;

function CEditUI.GetClass: string;
begin
  Result := Delphi_EditUI_GetClass(Self);
end;

function CEditUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_EditUI_GetInterface(Self, PChar(pstrName));
end;

function CEditUI.GetControlFlags: UINT;
begin
  Result := Delphi_EditUI_GetControlFlags(Self);
end;

function CEditUI.GetNativeWindow: HWND;
begin
  Result := Delphi_EditUI_GetNativeWindow(Self);
end;

procedure CEditUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_EditUI_SetEnabled(Self, bEnable);
end;

procedure CEditUI.SetText(pstrText: string);
begin
  Delphi_EditUI_SetText(Self, PChar(pstrText));
end;

procedure CEditUI.SetMaxChar(uMax: UINT);
begin
  Delphi_EditUI_SetMaxChar(Self, uMax);
end;

function CEditUI.GetMaxChar: UINT;
begin
  Result := Delphi_EditUI_GetMaxChar(Self);
end;

procedure CEditUI.SetReadOnly(bReadOnly: Boolean);
begin
  Delphi_EditUI_SetReadOnly(Self, bReadOnly);
end;

function CEditUI.IsReadOnly: Boolean;
begin
  Result := Delphi_EditUI_IsReadOnly(Self);
end;

procedure CEditUI.SetPasswordMode(bPasswordMode: Boolean);
begin
  Delphi_EditUI_SetPasswordMode(Self, bPasswordMode);
end;

function CEditUI.IsPasswordMode: Boolean;
begin
  Result := Delphi_EditUI_IsPasswordMode(Self);
end;

procedure CEditUI.SetPasswordChar(cPasswordChar: Char);
begin
  Delphi_EditUI_SetPasswordChar(Self, cPasswordChar);
end;

function CEditUI.GetPasswordChar: Char;
begin
  Result := Delphi_EditUI_GetPasswordChar(Self);
end;

procedure CEditUI.SetNumberOnly(bNumberOnly: Boolean);
begin
  Delphi_EditUI_SetNumberOnly(Self, bNumberOnly);
end;

function CEditUI.IsNumberOnly: Boolean;
begin
  Result := Delphi_EditUI_IsNumberOnly(Self);
end;

function CEditUI.GetWindowStyls: Integer;
begin
  Result := Delphi_EditUI_GetWindowStyls(Self);
end;

function CEditUI.GetNativeEditHWND: HWND;
begin
  Result := Delphi_EditUI_GetNativeEditHWND(Self);
end;

function CEditUI.GetNormalImage: string;
begin
  Result := Delphi_EditUI_GetNormalImage(Self);
end;

procedure CEditUI.SetNormalImage(pStrImage: string);
begin
  Delphi_EditUI_SetNormalImage(Self, PChar(pStrImage));
end;

function CEditUI.GetHotImage: string;
begin
  Result := Delphi_EditUI_GetHotImage(Self);
end;

procedure CEditUI.SetHotImage(pStrImage: string);
begin
  Delphi_EditUI_SetHotImage(Self, PChar(pStrImage));
end;

function CEditUI.GetFocusedImage: string;
begin
  Result := Delphi_EditUI_GetFocusedImage(Self);
end;

procedure CEditUI.SetFocusedImage(pStrImage: string);
begin
  Delphi_EditUI_SetFocusedImage(Self, PChar(pStrImage));
end;

function CEditUI.GetDisabledImage: string;
begin
  Result := Delphi_EditUI_GetDisabledImage(Self);
end;

procedure CEditUI.SetDisabledImage(pStrImage: string);
begin
  Delphi_EditUI_SetDisabledImage(Self, PChar(pStrImage));
end;

procedure CEditUI.SetNativeEditBkColor(dwBkColor: DWORD);
begin
  Delphi_EditUI_SetNativeEditBkColor(Self, dwBkColor);
end;

function CEditUI.GetNativeEditBkColor: DWORD;
begin
  Result := Delphi_EditUI_GetNativeEditBkColor(Self);
end;

procedure CEditUI.SetSel(nStartChar: LongInt; nEndChar: LongInt);
begin
  Delphi_EditUI_SetSel(Self, nStartChar, nEndChar);
end;

procedure CEditUI.SetSelAll;
begin
  Delphi_EditUI_SetSelAll(Self);
end;

procedure CEditUI.SetReplaceSel(lpszReplace: string);
begin
  Delphi_EditUI_SetReplaceSel(Self, PChar(lpszReplace));
end;

procedure CEditUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_EditUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CEditUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_EditUI_Move(Self, szOffset, bNeedInvalidate);
end;

procedure CEditUI.SetVisible(bVisible: Boolean);
begin
  Delphi_EditUI_SetVisible(Self, bVisible);
end;

procedure CEditUI.SetInternVisible(bVisible: Boolean);
begin
  Delphi_EditUI_SetInternVisible(Self, bVisible);
end;

function CEditUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_EditUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CEditUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_EditUI_DoEvent(Self, AEvent);
end;

procedure CEditUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_EditUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CEditUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_EditUI_PaintStatusImage(Self, hDC);
end;

procedure CEditUI.PaintText(hDC: HDC);
begin
  Delphi_EditUI_PaintText(Self, hDC);
end;

{ CProgressUI }

class function CProgressUI.CppCreate: CProgressUI;
begin
  Result := Delphi_ProgressUI_CppCreate;
end;

procedure CProgressUI.CppDestroy;
begin
  Delphi_ProgressUI_CppDestroy(Self);
end;

function CProgressUI.GetClass: string;
begin
  Result := Delphi_ProgressUI_GetClass(Self);
end;

function CProgressUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ProgressUI_GetInterface(Self, PChar(pstrName));
end;

function CProgressUI.IsHorizontal: Boolean;
begin
  Result := Delphi_ProgressUI_IsHorizontal(Self);
end;

procedure CProgressUI.SetHorizontal(bHorizontal: Boolean);
begin
  Delphi_ProgressUI_SetHorizontal(Self, bHorizontal);
end;

function CProgressUI.IsStretchForeImage: Boolean;
begin
  Result := Delphi_ProgressUI_IsStretchForeImage(Self);
end;

procedure CProgressUI.SetStretchForeImage(bStretchForeImage: Boolean);
begin
  Delphi_ProgressUI_SetStretchForeImage(Self, bStretchForeImage);
end;

function CProgressUI.GetMinValue: Integer;
begin
  Result := Delphi_ProgressUI_GetMinValue(Self);
end;

procedure CProgressUI.SetMinValue(nMin: Integer);
begin
  Delphi_ProgressUI_SetMinValue(Self, nMin);
end;

function CProgressUI.GetMaxValue: Integer;
begin
  Result := Delphi_ProgressUI_GetMaxValue(Self);
end;

procedure CProgressUI.SetMaxValue(nMax: Integer);
begin
  Delphi_ProgressUI_SetMaxValue(Self, nMax);
end;

function CProgressUI.GetValue: Integer;
begin
  Result := Delphi_ProgressUI_GetValue(Self);
end;

procedure CProgressUI.SetValue(nValue: Integer);
begin
  Delphi_ProgressUI_SetValue(Self, nValue);
end;

function CProgressUI.GetForeImage: string;
begin
  Result := Delphi_ProgressUI_GetForeImage(Self);
end;

procedure CProgressUI.SetForeImage(pStrImage: string);
begin
  Delphi_ProgressUI_SetForeImage(Self, PChar(pStrImage));
end;

procedure CProgressUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ProgressUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CProgressUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_ProgressUI_PaintStatusImage(Self, hDC);
end;


{ CScrollBarUI }

class function CScrollBarUI.CppCreate: CScrollBarUI;
begin
  Result := Delphi_ScrollBarUI_CppCreate;
end;

procedure CScrollBarUI.CppDestroy;
begin
  Delphi_ScrollBarUI_CppDestroy(Self);
end;

function CScrollBarUI.GetClass: string;
begin
  Result := Delphi_ScrollBarUI_GetClass(Self);
end;

function CScrollBarUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ScrollBarUI_GetInterface(Self, PChar(pstrName));
end;

function CScrollBarUI.GetOwner: CContainerUI;
begin
  Result := Delphi_ScrollBarUI_GetOwner(Self);
end;

procedure CScrollBarUI.SetOwner(pOwner: CContainerUI);
begin
  Delphi_ScrollBarUI_SetOwner(Self, pOwner);
end;

procedure CScrollBarUI.SetVisible(bVisible: Boolean);
begin
  Delphi_ScrollBarUI_SetVisible(Self, bVisible);
end;

procedure CScrollBarUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ScrollBarUI_SetEnabled(Self, bEnable);
end;

procedure CScrollBarUI.SetFocus;
begin
  Delphi_ScrollBarUI_SetFocus(Self);
end;

function CScrollBarUI.IsHorizontal: Boolean;
begin
  Result := Delphi_ScrollBarUI_IsHorizontal(Self);
end;

procedure CScrollBarUI.SetHorizontal(bHorizontal: Boolean);
begin
  Delphi_ScrollBarUI_SetHorizontal(Self, bHorizontal);
end;

function CScrollBarUI.GetScrollRange: Integer;
begin
  Result := Delphi_ScrollBarUI_GetScrollRange(Self);
end;

procedure CScrollBarUI.SetScrollRange(nRange: Integer);
begin
  Delphi_ScrollBarUI_SetScrollRange(Self, nRange);
end;

function CScrollBarUI.GetScrollPos: Integer;
begin
  Result := Delphi_ScrollBarUI_GetScrollPos(Self);
end;

procedure CScrollBarUI.SetScrollPos(nPos: Integer; bTriggerEvent: Boolean);
begin
  Delphi_ScrollBarUI_SetScrollPos(Self, nPos, bTriggerEvent);
end;

function CScrollBarUI.GetLineSize: Integer;
begin
  Result := Delphi_ScrollBarUI_GetLineSize(Self);
end;

procedure CScrollBarUI.SetLineSize(nSize: Integer);
begin
  Delphi_ScrollBarUI_SetLineSize(Self, nSize);
end;

function CScrollBarUI.GetShowButton1: Boolean;
begin
  Result := Delphi_ScrollBarUI_GetShowButton1(Self);
end;

procedure CScrollBarUI.SetShowButton1(bShow: Boolean);
begin
  Delphi_ScrollBarUI_SetShowButton1(Self, bShow);
end;

function CScrollBarUI.GetButton1Color: DWORD;
begin
  Result := Delphi_ScrollBarUI_GetButton1Color(Self);
end;

procedure CScrollBarUI.SetButton1Color(dwColor: DWORD);
begin
  Delphi_ScrollBarUI_SetButton1Color(Self, dwColor);
end;

function CScrollBarUI.GetButton1NormalImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton1NormalImage(Self);
end;

procedure CScrollBarUI.SetButton1NormalImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton1NormalImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton1HotImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton1HotImage(Self);
end;

procedure CScrollBarUI.SetButton1HotImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton1HotImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton1PushedImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton1PushedImage(Self);
end;

procedure CScrollBarUI.SetButton1PushedImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton1PushedImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton1DisabledImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton1DisabledImage(Self);
end;

procedure CScrollBarUI.SetButton1DisabledImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton1DisabledImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetShowButton2: Boolean;
begin
  Result := Delphi_ScrollBarUI_GetShowButton2(Self);
end;

procedure CScrollBarUI.SetShowButton2(bShow: Boolean);
begin
  Delphi_ScrollBarUI_SetShowButton2(Self, bShow);
end;

function CScrollBarUI.GetButton2Color: DWORD;
begin
  Result := Delphi_ScrollBarUI_GetButton2Color(Self);
end;

procedure CScrollBarUI.SetButton2Color(dwColor: DWORD);
begin
  Delphi_ScrollBarUI_SetButton2Color(Self, dwColor);
end;

function CScrollBarUI.GetButton2NormalImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton2NormalImage(Self);
end;

procedure CScrollBarUI.SetButton2NormalImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton2NormalImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton2HotImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton2HotImage(Self);
end;

procedure CScrollBarUI.SetButton2HotImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton2HotImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton2PushedImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton2PushedImage(Self);
end;

procedure CScrollBarUI.SetButton2PushedImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton2PushedImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetButton2DisabledImage: string;
begin
  Result := Delphi_ScrollBarUI_GetButton2DisabledImage(Self);
end;

procedure CScrollBarUI.SetButton2DisabledImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetButton2DisabledImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetThumbColor: DWORD;
begin
  Result := Delphi_ScrollBarUI_GetThumbColor(Self);
end;

procedure CScrollBarUI.SetThumbColor(dwColor: DWORD);
begin
  Delphi_ScrollBarUI_SetThumbColor(Self, dwColor);
end;

function CScrollBarUI.GetThumbNormalImage: string;
begin
  Result := Delphi_ScrollBarUI_GetThumbNormalImage(Self);
end;

procedure CScrollBarUI.SetThumbNormalImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetThumbNormalImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetThumbHotImage: string;
begin
  Result := Delphi_ScrollBarUI_GetThumbHotImage(Self);
end;

procedure CScrollBarUI.SetThumbHotImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetThumbHotImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetThumbPushedImage: string;
begin
  Result := Delphi_ScrollBarUI_GetThumbPushedImage(Self);
end;

procedure CScrollBarUI.SetThumbPushedImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetThumbPushedImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetThumbDisabledImage: string;
begin
  Result := Delphi_ScrollBarUI_GetThumbDisabledImage(Self);
end;

procedure CScrollBarUI.SetThumbDisabledImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetThumbDisabledImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetRailNormalImage: string;
begin
  Result := Delphi_ScrollBarUI_GetRailNormalImage(Self);
end;

procedure CScrollBarUI.SetRailNormalImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetRailNormalImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetRailHotImage: string;
begin
  Result := Delphi_ScrollBarUI_GetRailHotImage(Self);
end;

procedure CScrollBarUI.SetRailHotImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetRailHotImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetRailPushedImage: string;
begin
  Result := Delphi_ScrollBarUI_GetRailPushedImage(Self);
end;

procedure CScrollBarUI.SetRailPushedImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetRailPushedImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetRailDisabledImage: string;
begin
  Result := Delphi_ScrollBarUI_GetRailDisabledImage(Self);
end;

procedure CScrollBarUI.SetRailDisabledImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetRailDisabledImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetBkNormalImage: string;
begin
  Result := Delphi_ScrollBarUI_GetBkNormalImage(Self);
end;

procedure CScrollBarUI.SetBkNormalImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetBkNormalImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetBkHotImage: string;
begin
  Result := Delphi_ScrollBarUI_GetBkHotImage(Self);
end;

procedure CScrollBarUI.SetBkHotImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetBkHotImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetBkPushedImage: string;
begin
  Result := Delphi_ScrollBarUI_GetBkPushedImage(Self);
end;

procedure CScrollBarUI.SetBkPushedImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetBkPushedImage(Self, PChar(pStrImage));
end;

function CScrollBarUI.GetBkDisabledImage: string;
begin
  Result := Delphi_ScrollBarUI_GetBkDisabledImage(Self);
end;

procedure CScrollBarUI.SetBkDisabledImage(pStrImage: string);
begin
  Delphi_ScrollBarUI_SetBkDisabledImage(Self, PChar(pStrImage));
end;

procedure CScrollBarUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_ScrollBarUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CScrollBarUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ScrollBarUI_DoEvent(Self, AEvent);
end;

procedure CScrollBarUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ScrollBarUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CScrollBarUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ScrollBarUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CScrollBarUI.PaintBk(hDC: HDC);
begin
  Delphi_ScrollBarUI_PaintBk(Self, hDC);
end;

procedure CScrollBarUI.PaintButton1(hDC: HDC);
begin
  Delphi_ScrollBarUI_PaintButton1(Self, hDC);
end;

procedure CScrollBarUI.PaintButton2(hDC: HDC);
begin
  Delphi_ScrollBarUI_PaintButton2(Self, hDC);
end;

procedure CScrollBarUI.PaintThumb(hDC: HDC);
begin
  Delphi_ScrollBarUI_PaintThumb(Self, hDC);
end;

procedure CScrollBarUI.PaintRail(hDC: HDC);
begin
  Delphi_ScrollBarUI_PaintRail(Self, hDC);
end;

{ CSliderUI }

class function CSliderUI.CppCreate: CSliderUI;
begin
  Result := Delphi_SliderUI_CppCreate;
end;

procedure CSliderUI.CppDestroy;
begin
  Delphi_SliderUI_CppDestroy(Self);
end;

function CSliderUI.GetClass: string;
begin
  Result := Delphi_SliderUI_GetClass(Self);
end;

function CSliderUI.GetControlFlags: UINT;
begin
  Result := Delphi_SliderUI_GetControlFlags(Self);
end;

function CSliderUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_SliderUI_GetInterface(Self, PChar(pstrName));
end;

procedure CSliderUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_SliderUI_SetEnabled(Self, bEnable);
end;

function CSliderUI.GetChangeStep: Integer;
begin
  Result := Delphi_SliderUI_GetChangeStep(Self);
end;

procedure CSliderUI.SetChangeStep(step: Integer);
begin
  Delphi_SliderUI_SetChangeStep(Self, step);
end;

procedure CSliderUI.SetThumbSize(szXY: TSize);
begin
  Delphi_SliderUI_SetThumbSize(Self, szXY);
end;

function CSliderUI.GetThumbRect: TRect;
begin
  Delphi_SliderUI_GetThumbRect(Self, Result);
end;

function CSliderUI.GetThumbImage: string;
begin
  Result := Delphi_SliderUI_GetThumbImage(Self);
end;

procedure CSliderUI.SetThumbImage(pStrImage: string);
begin
  Delphi_SliderUI_SetThumbImage(Self, PChar(pStrImage));
end;

function CSliderUI.GetThumbHotImage: string;
begin
  Result := Delphi_SliderUI_GetThumbHotImage(Self);
end;

procedure CSliderUI.SetThumbHotImage(pStrImage: string);
begin
  Delphi_SliderUI_SetThumbHotImage(Self, PChar(pStrImage));
end;

function CSliderUI.GetThumbPushedImage: string;
begin
  Result := Delphi_SliderUI_GetThumbPushedImage(Self);
end;

procedure CSliderUI.SetThumbPushedImage(pStrImage: string);
begin
  Delphi_SliderUI_SetThumbPushedImage(Self, PChar(pStrImage));
end;

procedure CSliderUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_SliderUI_DoEvent(Self, AEvent);
end;

procedure CSliderUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_SliderUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CSliderUI.PaintStatusImage(hDC: HDC);
begin
  Delphi_SliderUI_PaintStatusImage(Self, hDC);
end;

{ CTextUI }

class function CTextUI.CppCreate: CTextUI;
begin
  Result := Delphi_TextUI_CppCreate;
end;

procedure CTextUI.CppDestroy;
begin
  Delphi_TextUI_CppDestroy(Self);
end;

function CTextUI.GetClass: string;
begin
  Result := Delphi_TextUI_GetClass(Self);
end;

function CTextUI.GetControlFlags: UINT;
begin
  Result := Delphi_TextUI_GetControlFlags(Self);
end;

function CTextUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_TextUI_GetInterface(Self, PChar(pstrName));
end;

function CTextUI.GetLinkContent(iIndex: Integer): string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_TextUI_GetLinkContent(Self, iIndex);
{$ELSE}
  Result := DuiStringToString(Delphi_TextUI_GetLinkContent(Self, iIndex));
{$ENDIF}
end;

procedure CTextUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_TextUI_DoEvent(Self, AEvent);
end;

function CTextUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_TextUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CTextUI.PaintText(hDC: HDC);
begin
  Delphi_TextUI_PaintText(Self, hDC);
end;

{ CTreeNodeUI }

class function CTreeNodeUI.CppCreate(_ParentNode: CTreeNodeUI = nil): CTreeNodeUI;
begin
  Result := Delphi_TreeNodeUI_CppCreate(_ParentNode);
end;

procedure CTreeNodeUI.CppDestroy;
begin
  Delphi_TreeNodeUI_CppDestroy(Self);
end;

function CTreeNodeUI.GetClass: string;
begin
  Result := Delphi_TreeNodeUI_GetClass(Self);
end;

function CTreeNodeUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_TreeNodeUI_GetInterface(Self, PChar(pstrName));
end;

procedure CTreeNodeUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_TreeNodeUI_DoEvent(Self, AEvent);
end;

procedure CTreeNodeUI.Invalidate;
begin
  Delphi_TreeNodeUI_Invalidate(Self);
end;

function CTreeNodeUI.Select(bSelect: Boolean; bTriggerEvent: Boolean): Boolean;
begin
  Result := Delphi_TreeNodeUI_Select(Self, bSelect, bTriggerEvent);
end;

function CTreeNodeUI.Add(_pTreeNodeUI: CControlUI): Boolean;
begin
  Result := Delphi_TreeNodeUI_Add(Self, _pTreeNodeUI);
end;

function CTreeNodeUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_TreeNodeUI_AddAt(Self, pControl, iIndex);
end;

function CTreeNodeUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_TreeNodeUI_Remove(Self, pControl);
end;

procedure CTreeNodeUI.SetVisibleTag(_IsVisible: Boolean);
begin
  Delphi_TreeNodeUI_SetVisibleTag(Self, _IsVisible);
end;

function CTreeNodeUI.GetVisibleTag: Boolean;
begin
  Result := Delphi_TreeNodeUI_GetVisibleTag(Self);
end;

procedure CTreeNodeUI.SetItemText(pstrValue: string);
begin
  Delphi_TreeNodeUI_SetItemText(Self, PChar(pstrValue));
end;

function CTreeNodeUI.GetItemText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_TreeNodeUI_GetItemText(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_TreeNodeUI_GetItemText(Self));
{$ENDIF}
end;

procedure CTreeNodeUI.SetCheckBoxSelected(_Selected: Boolean);
begin
  Delphi_TreeNodeUI_CheckBoxSelected(Self, _Selected);
end;

function CTreeNodeUI.IsCheckBoxSelected: Boolean;
begin
  Result := Delphi_TreeNodeUI_IsCheckBoxSelected(Self);
end;

function CTreeNodeUI.IsHasChild: Boolean;
begin
  Result := Delphi_TreeNodeUI_IsHasChild(Self);
end;

function CTreeNodeUI.AddChildNode(_pTreeNodeUI: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeNodeUI_AddChildNode(Self, _pTreeNodeUI);
end;

function CTreeNodeUI.RemoveAt(_pTreeNodeUI: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeNodeUI_RemoveAt(Self, _pTreeNodeUI);
end;

procedure CTreeNodeUI.SetParentNode(_pParentTreeNode: CTreeNodeUI);
begin
  Delphi_TreeNodeUI_SetParentNode(Self, _pParentTreeNode);
end;

function CTreeNodeUI.GetParentNode: CTreeNodeUI;
begin
  Result := Delphi_TreeNodeUI_GetParentNode(Self);
end;

function CTreeNodeUI.GetCountChild: LongInt;
begin
  Result := Delphi_TreeNodeUI_GetCountChild(Self);
end;

procedure CTreeNodeUI.SetTreeView(_CTreeViewUI: CTreeViewUI);
begin
  Delphi_TreeNodeUI_SetTreeView(Self, _CTreeViewUI);
end;

function CTreeNodeUI.GetTreeView: CTreeViewUI;
begin
  Result := Delphi_TreeNodeUI_GetTreeView(Self);
end;

function CTreeNodeUI.GetChildNode(_nIndex: Integer): CTreeNodeUI;
begin
  Result := Delphi_TreeNodeUI_GetChildNode(Self, _nIndex);
end;

procedure CTreeNodeUI.SetVisibleFolderBtn(_IsVisibled: Boolean);
begin
  Delphi_TreeNodeUI_SetVisibleFolderBtn(Self, _IsVisibled);
end;

function CTreeNodeUI.GetVisibleFolderBtn: Boolean;
begin
  Result := Delphi_TreeNodeUI_GetVisibleFolderBtn(Self);
end;

procedure CTreeNodeUI.SetVisibleCheckBtn(_IsVisibled: Boolean);
begin
  Delphi_TreeNodeUI_SetVisibleCheckBtn(Self, _IsVisibled);
end;

function CTreeNodeUI.GetVisibleCheckBtn: Boolean;
begin
  Result := Delphi_TreeNodeUI_GetVisibleCheckBtn(Self);
end;

procedure CTreeNodeUI.SetItemTextColor(_dwItemTextColor: DWORD);
begin
  Delphi_TreeNodeUI_SetItemTextColor(Self, _dwItemTextColor);
end;

function CTreeNodeUI.GetItemTextColor: DWORD;
begin
  Result := Delphi_TreeNodeUI_GetItemTextColor(Self);
end;

procedure CTreeNodeUI.SetItemHotTextColor(_dwItemHotTextColor: DWORD);
begin
  Delphi_TreeNodeUI_SetItemHotTextColor(Self, _dwItemHotTextColor);
end;

function CTreeNodeUI.GetItemHotTextColor: DWORD;
begin
  Result := Delphi_TreeNodeUI_GetItemHotTextColor(Self);
end;

procedure CTreeNodeUI.SetSelItemTextColor(_dwSelItemTextColor: DWORD);
begin
  Delphi_TreeNodeUI_SetSelItemTextColor(Self, _dwSelItemTextColor);
end;

function CTreeNodeUI.GetSelItemTextColor: DWORD;
begin
  Result := Delphi_TreeNodeUI_GetSelItemTextColor(Self);
end;

procedure CTreeNodeUI.SetSelItemHotTextColor(_dwSelHotItemTextColor: DWORD);
begin
  Delphi_TreeNodeUI_SetSelItemHotTextColor(Self, _dwSelHotItemTextColor);
end;

function CTreeNodeUI.GetSelItemHotTextColor: DWORD;
begin
  Result := Delphi_TreeNodeUI_GetSelItemHotTextColor(Self);
end;

procedure CTreeNodeUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_TreeNodeUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

function CTreeNodeUI.GetTreeNodes: CStdPtrArray;
begin
  Result := Delphi_TreeNodeUI_GetTreeNodes(Self);
end;

function CTreeNodeUI.GetTreeIndex: Integer;
begin
  Result := Delphi_TreeNodeUI_GetTreeIndex(Self);
end;

function CTreeNodeUI.GetNodeIndex: Integer;
begin
  Result := Delphi_TreeNodeUI_GetNodeIndex(Self);
end;

{ CTreeViewUI }

class function CTreeViewUI.CppCreate: CTreeViewUI;
begin
  Result := Delphi_TreeViewUI_CppCreate;
end;

procedure CTreeViewUI.CppDestroy;
begin
  Delphi_TreeViewUI_CppDestroy(Self);
end;

function CTreeViewUI.GetClass: string;
begin
  Result := Delphi_TreeViewUI_GetClass(Self);
end;

function CTreeViewUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_TreeViewUI_GetInterface(Self, PChar(pstrName));
end;

function CTreeViewUI.Add(pControl: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeViewUI_Add(Self, pControl);
end;

function CTreeViewUI.AddAt(pControl: CTreeNodeUI; iIndex: Integer): LongInt;
begin
  Result := Delphi_TreeViewUI_AddAt_01(Self, pControl, iIndex);
end;

function CTreeViewUI.AddAt(pControl: CTreeNodeUI; _IndexNode: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeViewUI_AddAt_02(Self, pControl, _IndexNode);
end;

function CTreeViewUI.Remove(pControl: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeViewUI_Remove(Self, pControl);
end;

function CTreeViewUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := Delphi_TreeViewUI_RemoveAt(Self, iIndex);
end;

procedure CTreeViewUI.RemoveAll;
begin
  Delphi_TreeViewUI_RemoveAll(Self);
end;

function CTreeViewUI.OnCheckBoxChanged(param: PPointer): Boolean;
begin
  Result := Delphi_TreeViewUI_OnCheckBoxChanged(Self, param);
end;

function CTreeViewUI.OnFolderChanged(param: PPointer): Boolean;
begin
  Result := Delphi_TreeViewUI_OnFolderChanged(Self, param);
end;

function CTreeViewUI.OnDBClickItem(param: PPointer): Boolean;
begin
  Result := Delphi_TreeViewUI_OnDBClickItem(Self, param);
end;

function CTreeViewUI.SetItemCheckBox(_Selected: Boolean; _TreeNode: CTreeNodeUI): Boolean;
begin
  Result := Delphi_TreeViewUI_SetItemCheckBox(Self, _Selected, _TreeNode);
end;

procedure CTreeViewUI.SetItemExpand(_Expanded: Boolean; _TreeNode: CTreeNodeUI);
begin
  Delphi_TreeViewUI_SetItemExpand(Self, _Expanded, _TreeNode);
end;

procedure CTreeViewUI.Notify(var msg: TNotifyUI);
begin
  Delphi_TreeViewUI_Notify(Self, msg);
end;

procedure CTreeViewUI.SetVisibleFolderBtn(_IsVisibled: Boolean);
begin
  Delphi_TreeViewUI_SetVisibleFolderBtn(Self, _IsVisibled);
end;

function CTreeViewUI.GetVisibleFolderBtn: Boolean;
begin
  Result := Delphi_TreeViewUI_GetVisibleFolderBtn(Self);
end;

procedure CTreeViewUI.SetVisibleCheckBtn(_IsVisibled: Boolean);
begin
  Delphi_TreeViewUI_SetVisibleCheckBtn(Self, _IsVisibled);
end;

function CTreeViewUI.GetVisibleCheckBtn: Boolean;
begin
  Result := Delphi_TreeViewUI_GetVisibleCheckBtn(Self);
end;

procedure CTreeViewUI.SetItemMinWidth(_ItemMinWidth: UINT);
begin
  Delphi_TreeViewUI_SetItemMinWidth(Self, _ItemMinWidth);
end;

function CTreeViewUI.GetItemMinWidth: UINT;
begin
  Result := Delphi_TreeViewUI_GetItemMinWidth(Self);
end;

procedure CTreeViewUI.SetItemTextColor(_dwItemTextColor: DWORD);
begin
  Delphi_TreeViewUI_SetItemTextColor(Self, _dwItemTextColor);
end;

procedure CTreeViewUI.SetItemHotTextColor(_dwItemHotTextColor: DWORD);
begin
  Delphi_TreeViewUI_SetItemHotTextColor(Self, _dwItemHotTextColor);
end;

procedure CTreeViewUI.SetSelItemTextColor(_dwSelItemTextColor: DWORD);
begin
  Delphi_TreeViewUI_SetSelItemTextColor(Self, _dwSelItemTextColor);
end;

procedure CTreeViewUI.SetSelItemHotTextColor(_dwSelHotItemTextColor: DWORD);
begin
  Delphi_TreeViewUI_SetSelItemHotTextColor(Self, _dwSelHotItemTextColor);
end;

procedure CTreeViewUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_TreeViewUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

{ CTabLayoutUI }

class function CTabLayoutUI.CppCreate: CTabLayoutUI;
begin
  Result := Delphi_TabLayoutUI_CppCreate;
end;

procedure CTabLayoutUI.CppDestroy;
begin
  Delphi_TabLayoutUI_CppDestroy(Self);
end;

function CTabLayoutUI.GetClass: string;
begin
  Result := Delphi_TabLayoutUI_GetClass(Self);
end;

function CTabLayoutUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_TabLayoutUI_GetInterface(Self, PChar(pstrName));
end;

function CTabLayoutUI.Add(pControl: CControlUI): Boolean;
begin
  Result := Delphi_TabLayoutUI_Add(Self, pControl);
end;

function CTabLayoutUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_TabLayoutUI_AddAt(Self, pControl, iIndex);
end;

function CTabLayoutUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_TabLayoutUI_Remove(Self, pControl);
end;

procedure CTabLayoutUI.RemoveAll;
begin
  Delphi_TabLayoutUI_RemoveAll(Self);
end;

function CTabLayoutUI.GetCurSel: Integer;
begin
  Result := Delphi_TabLayoutUI_GetCurSel(Self);
end;

function CTabLayoutUI.SelectItem(iIndex: Integer; bTriggerEvent: Boolean): Boolean;
begin
  Result := Delphi_TabLayoutUI_SelectItem_01(Self, iIndex, bTriggerEvent);
end;

function CTabLayoutUI.SelectItem(pControl: CControlUI; bTriggerEvent: Boolean): Boolean;
begin
  Result := Delphi_TabLayoutUI_SelectItem_02(Self, pControl, bTriggerEvent);
end;

procedure CTabLayoutUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_TabLayoutUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CTabLayoutUI.SetSelectItem(const Value: Integer);
begin
  SelectItem(Value);
end;

procedure CTabLayoutUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_TabLayoutUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

{ CHorizontalLayoutUI }

class function CHorizontalLayoutUI.CppCreate: CHorizontalLayoutUI;
begin
  Result := Delphi_HorizontalLayoutUI_CppCreate;
end;

procedure CHorizontalLayoutUI.CppDestroy;
begin
  Delphi_HorizontalLayoutUI_CppDestroy(Self);
end;

function CHorizontalLayoutUI.GetClass: string;
begin
  Result := Delphi_HorizontalLayoutUI_GetClass(Self);
end;

function CHorizontalLayoutUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_HorizontalLayoutUI_GetInterface(Self, PChar(pstrName));
end;

function CHorizontalLayoutUI.GetControlFlags: UINT;
begin
  Result := Delphi_HorizontalLayoutUI_GetControlFlags(Self);
end;

procedure CHorizontalLayoutUI.SetSepWidth(iWidth: Integer);
begin
  Delphi_HorizontalLayoutUI_SetSepWidth(Self, iWidth);
end;

function CHorizontalLayoutUI.GetSepWidth: Integer;
begin
  Result := Delphi_HorizontalLayoutUI_GetSepWidth(Self);
end;

procedure CHorizontalLayoutUI.SetSepImmMode(bImmediately: Boolean);
begin
  Delphi_HorizontalLayoutUI_SetSepImmMode(Self, bImmediately);
end;

function CHorizontalLayoutUI.IsSepImmMode: Boolean;
begin
  Result := Delphi_HorizontalLayoutUI_IsSepImmMode(Self);
end;

procedure CHorizontalLayoutUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_HorizontalLayoutUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CHorizontalLayoutUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_HorizontalLayoutUI_DoEvent(Self, AEvent);
end;

procedure CHorizontalLayoutUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_HorizontalLayoutUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CHorizontalLayoutUI.DoPostPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_HorizontalLayoutUI_DoPostPaint(Self, hDC, rcPaint);
end;

function CHorizontalLayoutUI.GetThumbRect(bUseNew: Boolean): TRect;
begin
  Delphi_HorizontalLayoutUI_GetThumbRect(Self, bUseNew, Result);
end;

{ CListHeaderUI }

class function CListHeaderUI.CppCreate: CListHeaderUI;
begin
  Result := Delphi_ListHeaderUI_CppCreate;
end;

procedure CListHeaderUI.CppDestroy;
begin
  Delphi_ListHeaderUI_CppDestroy(Self);
end;

function CListHeaderUI.GetClass: string;
begin
  Result := Delphi_ListHeaderUI_GetClass(Self);
end;

function CListHeaderUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListHeaderUI_GetInterface(Self, PChar(pstrName));
end;

function CListHeaderUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ListHeaderUI_EstimateSize(Self, szAvailable, Result);
end;

{ CRenderClip }

class function CRenderClip.CppCreate: CRenderClip;
begin
  Result := Delphi_RenderClip_CppCreate;
end;

procedure CRenderClip.CppDestroy;
begin
  Delphi_RenderClip_CppDestroy(Self);
end;

class procedure CRenderClip.GenerateClip(hDC: HDC; rc: TRect; var clip: CRenderClip);
begin
  Delphi_RenderClip_GenerateClip(hDC, rc, clip);
end;

class procedure CRenderClip.GenerateRoundClip(hDC: HDC; rc: TRect; rcItem: TRect; width: Integer; height: Integer; var clip: CRenderClip);
begin
  Delphi_RenderClip_GenerateRoundClip(hDC, rc, rcItem, width, height, clip);
end;

class procedure CRenderClip.UseOldClipBegin(hDC: HDC; var clip: CRenderClip);
begin
  Delphi_RenderClip_UseOldClipBegin(hDC, clip);
end;

class procedure CRenderClip.UseOldClipEnd(hDC: HDC; var clip: CRenderClip);
begin
  Delphi_RenderClip_UseOldClipEnd(hDC, clip);
end;

{ CRenderEngine }

class function CRenderEngine.CppCreate: CRenderEngine;
begin
  Result := Delphi_RenderEngine_CppCreate;
end;

procedure CRenderEngine.CppDestroy;
begin
  Delphi_RenderEngine_CppDestroy(Self);
end;

class function CRenderEngine.AdjustColor(dwColor: DWORD; H: Short; S: Short; L: Short): DWORD;
begin
  Result := Delphi_RenderEngine_AdjustColor(dwColor, H, S, L);
end;

class function CRenderEngine.CreateARGB32Bitmap(hDC: HDC; cx: Integer; cy: Integer; pBits: COLORREF): HBITMAP;
begin
  Result := Delphi_RenderEngine_CreateARGB32Bitmap(hDC, cx, cy, pBits);
end;

class procedure CRenderEngine.AdjustImage(bUseHSL: Boolean; imageInfo: PImageInfo; H: Short; S: Short; L: Short);
begin
  Delphi_RenderEngine_AdjustImage(bUseHSL, imageInfo, H, S, L);
end;

class function CRenderEngine.LoadImage(bitmap: string; AType: string; mask: DWORD): PImageInfo;
begin
  Result := Delphi_RenderEngine_LoadImage(STRINGorID(bitmap), PChar(AType), mask);
end;

class procedure CRenderEngine.FreeImage(bitmap: PImageInfo; bDelete: Boolean);
begin
  Delphi_RenderEngine_FreeImage(bitmap, bDelete);
end;

class procedure CRenderEngine.DrawImage(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcCorners: TRect; alphaChannel: Boolean; uFade: Byte; hole: Boolean; xtiled: Boolean; ytiled: Boolean);
begin
  Delphi_RenderEngine_DrawImage_01(hDC, hBitmap, rc, rcPaint, rcBmpPart, rcCorners, alphaChannel, uFade, hole, xtiled, ytiled);
end;

class function CRenderEngine.DrawImage(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean;
begin
  Result := Delphi_RenderEngine_DrawImage_02(hDC, pManager, rcItem, rcPaint, drawInfo);
end;

class procedure CRenderEngine.DrawColor(hDC: HDC; var rc: TRect; color: DWORD);
begin
  Delphi_RenderEngine_DrawColor(hDC, rc, color);
end;

class procedure CRenderEngine.DrawGradient(hDC: HDC; var rc: TRect; dwFirst: DWORD; dwSecond: DWORD; bVertical: Boolean; nSteps: Integer);
begin
  Delphi_RenderEngine_DrawGradient(hDC, rc, dwFirst, dwSecond, bVertical, nSteps);
end;

class procedure CRenderEngine.DrawLine(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer);
begin
  Delphi_RenderEngine_DrawLine(hDC, rc, nSize, dwPenColor, nStyle);
end;

class procedure CRenderEngine.DrawRect(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer);
begin
  Delphi_RenderEngine_DrawRect(hDC, rc, nSize, dwPenColor, nStyle);
end;

class procedure CRenderEngine.DrawRoundRect(hDC: HDC; var rc: TRect; width: Integer; height: Integer; nSize: Integer; dwPenColor: DWORD; nStyle: Integer);
begin
  Delphi_RenderEngine_DrawRoundRect(hDC, rc, width, height, nSize, dwPenColor, nStyle);
end;

class procedure CRenderEngine.DrawText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; iFont: Integer; uStyle: UINT);
begin
  Delphi_RenderEngine_DrawText(hDC, pManager, rc, PChar(pstrText), dwTextColor, iFont, uStyle);
end;

class procedure CRenderEngine.DrawHtmlText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; pLinks: PRect; sLinks: string; var nLinkRects: Integer; uStyle: UINT);
{$IFDEF UseLowVer}
var
  LsLinks: CDuiString;
{$ENDIF}
begin
{$IFNDEF UseLowVer}
  Delphi_RenderEngine_DrawHtmlText(hDC, pManager, rc, PChar(pstrText), dwTextColor, pLinks, sLinks, nLinkRects, uStyle);
{$ELSE}
  LsLinks := StringToDuiString(sLinks);
  Delphi_RenderEngine_DrawHtmlText(hDC, pManager, rc, PChar(pstrText), dwTextColor, pLinks, LsLinks, nLinkRects, uStyle);
  sLinks := DuiStringToString(LsLinks);
{$ENDIF}
end;

class function CRenderEngine.GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect): HBITMAP;
begin
  Result := Delphi_RenderEngine_GenerateBitmap(pManager, pControl, rc);
end;

class function CRenderEngine.GetTextSize(hDC: HDC; pManager: CPaintManagerUI; pstrText: string; iFont: Integer; uStyle: UINT): TSize;
begin
  Delphi_RenderEngine_GetTextSize(hDC, pManager, PChar(pstrText), iFont, uStyle, Result);
end;


{ CListElementUI }

function CListElementUI.GetClass: string;
begin
  Result := Delphi_ListElementUI_GetClass(Self);
end;

function CListElementUI.GetControlFlags: UINT;
begin
  Result := Delphi_ListElementUI_GetControlFlags(Self);
end;

function CListElementUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListElementUI_GetInterface(Self, PChar(pstrName));
end;

procedure CListElementUI.SetEnabled(bEnable: Boolean);
begin
  Delphi_ListElementUI_SetEnabled(Self, bEnable);
end;

procedure CListElementUI.SetExpanded(const Value: Boolean);
begin
  Expand(Value);
end;

function CListElementUI.GetIndex: Integer;
begin
  Result := Delphi_ListElementUI_GetIndex(Self);
end;

procedure CListElementUI.SetIndex(iIndex: Integer);
begin
  Delphi_ListElementUI_SetIndex(Self, iIndex);
end;

function CListElementUI.GetOwner: IListOwnerUI;
begin
  Result := Delphi_ListElementUI_GetOwner(Self);
end;

procedure CListElementUI.SetOwner(pOwner: CControlUI);
begin
  Delphi_ListElementUI_SetOwner(Self, pOwner);
end;

procedure CListElementUI.SetSelect(const Value: Boolean);
begin
  Select(Value);
end;

procedure CListElementUI.SetVisible(bVisible: Boolean);
begin
  Delphi_ListElementUI_SetVisible(Self, bVisible);
end;

function CListElementUI.IsSelected: Boolean;
begin
  Result := Delphi_ListElementUI_IsSelected(Self);
end;

function CListElementUI.Select(bSelect: Boolean): Boolean;
begin
  Result := Delphi_ListElementUI_Select(Self, bSelect);
end;

function CListElementUI.IsExpanded: Boolean;
begin
  Result := Delphi_ListElementUI_IsExpanded(Self);
end;

function CListElementUI.Expand(bExpand: Boolean): Boolean;
begin
  Result := Delphi_ListElementUI_Expand(Self, bExpand);
end;

procedure CListElementUI.Invalidate;
begin
  Delphi_ListElementUI_Invalidate(Self);
end;

function CListElementUI.Activate: Boolean;
begin
  Result := Delphi_ListElementUI_Activate(Self);
end;

procedure CListElementUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ListElementUI_DoEvent(Self, AEvent);
end;

procedure CListElementUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ListElementUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

procedure CListElementUI.DrawItemBk(hDC: HDC; const rcItem: TRect);
begin
  Delphi_ListElementUI_DrawItemBk(Self, hDC, rcItem);
end;

{ CListLabelElementUI }

class function CListLabelElementUI.CppCreate: CListLabelElementUI;
begin
  Result := Delphi_ListLabelElementUI_CppCreate;
end;

procedure CListLabelElementUI.CppDestroy;
begin
  Delphi_ListLabelElementUI_CppDestroy(Self);
end;

function CListLabelElementUI.GetClass: string;
begin
  Result := Delphi_ListLabelElementUI_GetClass(Self);
end;

function CListLabelElementUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListLabelElementUI_GetInterface(Self, PChar(pstrName));
end;

procedure CListLabelElementUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ListLabelElementUI_DoEvent(Self, AEvent);
end;

function CListLabelElementUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ListLabelElementUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CListLabelElementUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_ListLabelElementUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CListLabelElementUI.DrawItemText(hDC: HDC; const rcItem: TRect);
begin
  Delphi_ListLabelElementUI_DrawItemText(Self, hDC, rcItem);
end;

{ CListTextElementUI }

class function CListTextElementUI.CppCreate: CListTextElementUI;
begin
  Result := Delphi_ListTextElementUI_CppCreate;
end;

procedure CListTextElementUI.CppDestroy;
begin
  Delphi_ListTextElementUI_CppDestroy(Self);
end;

function CListTextElementUI.GetClass: string;
begin
  Result := Delphi_ListTextElementUI_GetClass(Self);
end;

function CListTextElementUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ListTextElementUI_GetInterface(Self, PChar(pstrName));
end;

function CListTextElementUI.GetControlFlags: UINT;
begin
  Result := Delphi_ListTextElementUI_GetControlFlags(Self);
end;

function CListTextElementUI.GetText(iIndex: Integer): string;
begin
  Result := Delphi_ListTextElementUI_GetText(Self, iIndex);
end;

procedure CListTextElementUI.SetText(iIndex: Integer; pstrText: string);
begin
  Delphi_ListTextElementUI_SetText(Self, iIndex, PChar(pstrText));
end;

procedure CListTextElementUI.SetOwner(pOwner: CControlUI);
begin
  Delphi_ListTextElementUI_SetOwner(Self, pOwner);
end;

function CListTextElementUI.GetLinkContent(iIndex: Integer): string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ListTextElementUI_GetLinkContent(Self, iIndex);
{$ELSE}
  Result := DuiStringToString(Delphi_ListTextElementUI_GetLinkContent(Self, iIndex));
{$ENDIF}
end;

procedure CListTextElementUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_ListTextElementUI_DoEvent(Self, AEvent);
end;

function CListTextElementUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ListTextElementUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CListTextElementUI.DrawItemText(hDC: HDC; const rcItem: TRect);
begin
  Delphi_ListTextElementUI_DrawItemText(Self, hDC, rcItem);
end;

{ CGifAnimUI }

class function CGifAnimUI.CppCreate: CGifAnimUI;
begin
  Result := Delphi_GifAnimUI_CppCreate;
end;

procedure CGifAnimUI.CppDestroy;
begin
  Delphi_GifAnimUI_CppDestroy(Self);
end;

function CGifAnimUI.GetClass: string;
begin
  Result := Delphi_GifAnimUI_GetClass(Self);
end;

function CGifAnimUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_GifAnimUI_GetInterface(Self, LPCTSTR(pstrName));
end;

procedure CGifAnimUI.DoInit;
begin
  Delphi_GifAnimUI_DoInit(Self);
end;

procedure CGifAnimUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_GifAnimUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CGifAnimUI.DoEvent(var AEvent: TEventUI);
begin
  Delphi_GifAnimUI_DoEvent(Self, AEvent);
end;

procedure CGifAnimUI.SetVisible(bVisible: Boolean);
begin
  Delphi_GifAnimUI_SetVisible(Self, bVisible);
end;

procedure CGifAnimUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_GifAnimUI_SetAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrValue));
end;

procedure CGifAnimUI.SetBkImage(pStrImage: string);
begin
  Delphi_GifAnimUI_SetBkImage(Self, LPCTSTR(pStrImage));
end;

function CGifAnimUI.GetBkImage: string;
begin
  Result := Delphi_GifAnimUI_GetBkImage(Self);
end;

procedure CGifAnimUI.SetAutoPlay(bIsAuto: Boolean);
begin
  Delphi_GifAnimUI_SetAutoPlay(Self, bIsAuto);
end;

function CGifAnimUI.IsAutoPlay: Boolean;
begin
  Result := Delphi_GifAnimUI_IsAutoPlay(Self);
end;

procedure CGifAnimUI.SetAutoSize(bIsAuto: Boolean);
begin
  Delphi_GifAnimUI_SetAutoSize(Self, bIsAuto);
end;

function CGifAnimUI.IsAutoSize: Boolean;
begin
  Result := Delphi_GifAnimUI_IsAutoSize(Self);
end;

procedure CGifAnimUI.PlayGif;
begin
  Delphi_GifAnimUI_PlayGif(Self);
end;

procedure CGifAnimUI.PauseGif;
begin
  Delphi_GifAnimUI_PauseGif(Self);
end;

procedure CGifAnimUI.StopGif;
begin
  Delphi_GifAnimUI_StopGif(Self);
end;

{ CChildLayoutUI }

class function CChildLayoutUI.CppCreate: CChildLayoutUI;
begin
  Result := Delphi_ChildLayoutUI_CppCreate;
end;

procedure CChildLayoutUI.CppDestroy;
begin
  Delphi_ChildLayoutUI_CppDestroy(Self);
end;

procedure CChildLayoutUI.Init;
begin
  Delphi_ChildLayoutUI_Init(Self);
end;

procedure CChildLayoutUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_ChildLayoutUI_SetAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrValue));
end;

procedure CChildLayoutUI.SetChildLayoutXML(pXML: string);
begin
{$IFNDEF UseLowVer}
  Delphi_ChildLayoutUI_SetChildLayoutXML(Self, pXML);
{$ELSE}
  Delphi_ChildLayoutUI_SetChildLayoutXML(Self, StringToDuiString(pXML));
{$ENDIF}
end;

function CChildLayoutUI.GetChildLayoutXML: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ChildLayoutUI_GetChildLayoutXML(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_ChildLayoutUI_GetChildLayoutXML(Self));
{$ENDIF}
end;

function CChildLayoutUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_ChildLayoutUI_GetInterface(Self, LPCTSTR(pstrName));
end;

function CChildLayoutUI.GetClass: string;
begin
  Result := Delphi_ChildLayoutUI_GetClass(Self);
end;

{ CTileLayoutUI }

class function CTileLayoutUI.CppCreate: CTileLayoutUI;
begin
  Result := Delphi_TileLayoutUI_CppCreate;
end;

procedure CTileLayoutUI.CppDestroy;
begin
  Delphi_TileLayoutUI_CppDestroy(Self);
end;

function CTileLayoutUI.GetClass: string;
begin
  Result := Delphi_TileLayoutUI_GetClass(Self);
end;

function CTileLayoutUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_TileLayoutUI_GetInterface(Self, LPCTSTR(pstrName));
end;

procedure CTileLayoutUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_TileLayoutUI_SetPos(Self, rc, bNeedInvalidate);
end;

function CTileLayoutUI.GetItemSize: TSize;
begin
  Delphi_TileLayoutUI_GetItemSize(Self, Result);
end;

procedure CTileLayoutUI.SetItemSize(szItem: TSize);
begin
  Delphi_TileLayoutUI_SetItemSize(Self, szItem);
end;

function CTileLayoutUI.GetColumns: Integer;
begin
  Result := Delphi_TileLayoutUI_GetColumns(Self);
end;

procedure CTileLayoutUI.SetColumns(nCols: Integer);
begin
  Delphi_TileLayoutUI_SetColumns(Self, nCols);
end;

procedure CTileLayoutUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_TileLayoutUI_SetAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrValue));
end;

{ CNativeControlUI }

class function CNativeControlUI.CppCreate(hWnd: HWND): CNativeControlUI;
begin
  Result := Delphi_NativeControlUI_CppCreate(hWnd);
end;

procedure CNativeControlUI.CppDestroy;
begin
  Delphi_NativeControlUI_CppDestroy(Self);
end;

procedure CNativeControlUI.SetInternVisible(bVisible: Boolean);
begin
  Delphi_NativeControlUI_SetInternVisible(Self, bVisible);
end;

procedure CNativeControlUI.SetVisible(bVisible: Boolean);
begin
  Delphi_NativeControlUI_SetVisible(Self, bVisible);
end;

procedure CNativeControlUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_NativeControlUI_SetPos(Self, rc, bNeedInvalidate);
end;

function CNativeControlUI.GetClass: string;
begin
  Result := Delphi_NativeControlUI_GetClass(Self);
end;

function CNativeControlUI.GetText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_NativeControlUI_GetText(Self);
{$ElSE}
  Result := DuiStringToString(Delphi_NativeControlUI_GetText(Self));
{$ENDIF}
end;

procedure CNativeControlUI.SetText(pstrText: string);
begin
  Delphi_NativeControlUI_SetText(Self, LPCTSTR(pstrText));
end;

procedure CNativeControlUI.SetNativeHandle(hWd: HWND);
begin
  Delphi_NativeControlUI_SetNativeHandle(Self, hWd);
end;

//================================CStdStringPtrMap============================

function Delphi_StdStringPtrMap_CppCreate; external DuiLibdll name 'Delphi_StdStringPtrMap_CppCreate';
procedure Delphi_StdStringPtrMap_CppDestroy; external DuiLibdll name 'Delphi_StdStringPtrMap_CppDestroy';
procedure Delphi_StdStringPtrMap_Resize; external DuiLibdll name 'Delphi_StdStringPtrMap_Resize';
function Delphi_StdStringPtrMap_Find; external DuiLibdll name 'Delphi_StdStringPtrMap_Find';
function Delphi_StdStringPtrMap_Insert; external DuiLibdll name 'Delphi_StdStringPtrMap_Insert';
function Delphi_StdStringPtrMap_Set; external DuiLibdll name 'Delphi_StdStringPtrMap_Set';
function Delphi_StdStringPtrMap_Remove; external DuiLibdll name 'Delphi_StdStringPtrMap_Remove';
procedure Delphi_StdStringPtrMap_RemoveAll; external DuiLibdll name 'Delphi_StdStringPtrMap_RemoveAll';
function Delphi_StdStringPtrMap_GetSize; external DuiLibdll name 'Delphi_StdStringPtrMap_GetSize';
function Delphi_StdStringPtrMap_GetAt; external DuiLibdll name 'Delphi_StdStringPtrMap_GetAt';

//================================CStdValArray============================

function Delphi_StdValArray_CppCreate; external DuiLibdll name 'Delphi_StdValArray_CppCreate';
procedure Delphi_StdValArray_CppDestroy; external DuiLibdll name 'Delphi_StdValArray_CppDestroy';
procedure Delphi_StdValArray_Empty; external DuiLibdll name 'Delphi_StdValArray_Empty';
function Delphi_StdValArray_IsEmpty; external DuiLibdll name 'Delphi_StdValArray_IsEmpty';
function Delphi_StdValArray_Add; external DuiLibdll name 'Delphi_StdValArray_Add';
function Delphi_StdValArray_Remove; external DuiLibdll name 'Delphi_StdValArray_Remove';
function Delphi_StdValArray_GetSize; external DuiLibdll name 'Delphi_StdValArray_GetSize';
function Delphi_StdValArray_GetData; external DuiLibdll name 'Delphi_StdValArray_GetData';
function Delphi_StdValArray_GetAt; external DuiLibdll name 'Delphi_StdValArray_GetAt';

//================================CStdPtrArray============================

function Delphi_StdPtrArray_CppCreate; external DuiLibdll name 'Delphi_StdPtrArray_CppCreate';
procedure Delphi_StdPtrArray_CppDestroy; external DuiLibdll name 'Delphi_StdPtrArray_CppDestroy';
procedure Delphi_StdPtrArray_Empty; external DuiLibdll name 'Delphi_StdPtrArray_Empty';
procedure Delphi_StdPtrArray_Resize; external DuiLibdll name 'Delphi_StdPtrArray_Resize';
function Delphi_StdPtrArray_IsEmpty; external DuiLibdll name 'Delphi_StdPtrArray_IsEmpty';
function Delphi_StdPtrArray_Find; external DuiLibdll name 'Delphi_StdPtrArray_Find';
function Delphi_StdPtrArray_Add; external DuiLibdll name 'Delphi_StdPtrArray_Add';
function Delphi_StdPtrArray_SetAt; external DuiLibdll name 'Delphi_StdPtrArray_SetAt';
function Delphi_StdPtrArray_InsertAt; external DuiLibdll name 'Delphi_StdPtrArray_InsertAt';
function Delphi_StdPtrArray_Remove; external DuiLibdll name 'Delphi_StdPtrArray_Remove';
function Delphi_StdPtrArray_GetSize; external DuiLibdll name 'Delphi_StdPtrArray_GetSize';
function Delphi_StdPtrArray_GetData; external DuiLibdll name 'Delphi_StdPtrArray_GetData';
function Delphi_StdPtrArray_GetAt; external DuiLibdll name 'Delphi_StdPtrArray_GetAt';

//================================CNotifyPump============================

function Delphi_NotifyPump_CppCreate; external DuiLibdll name 'Delphi_NotifyPump_CppCreate';
procedure Delphi_NotifyPump_CppDestroy; external DuiLibdll name 'Delphi_NotifyPump_CppDestroy';
function Delphi_NotifyPump_AddVirtualWnd; external DuiLibdll name 'Delphi_NotifyPump_AddVirtualWnd';
function Delphi_NotifyPump_RemoveVirtualWnd; external DuiLibdll name 'Delphi_NotifyPump_RemoveVirtualWnd';
procedure Delphi_NotifyPump_NotifyPump; external DuiLibdll name 'Delphi_NotifyPump_NotifyPump';
function Delphi_NotifyPump_LoopDispatch; external DuiLibdll name 'Delphi_NotifyPump_LoopDispatch';

//================================CDialogBuilder============================

function Delphi_DialogBuilder_CppCreate; external DuiLibdll name 'Delphi_DialogBuilder_CppCreate';
procedure Delphi_DialogBuilder_CppDestroy; external DuiLibdll name 'Delphi_DialogBuilder_CppDestroy';
function Delphi_DialogBuilder_Create_01; external DuiLibdll name 'Delphi_DialogBuilder_Create_01';
function Delphi_DialogBuilder_Create_02; external DuiLibdll name 'Delphi_DialogBuilder_Create_02';
function Delphi_DialogBuilder_GetMarkup; external DuiLibdll name 'Delphi_DialogBuilder_GetMarkup';
procedure Delphi_DialogBuilder_GetLastErrorMessage; external DuiLibdll name 'Delphi_DialogBuilder_GetLastErrorMessage';
procedure Delphi_DialogBuilder_GetLastErrorLocation; external DuiLibdll name 'Delphi_DialogBuilder_GetLastErrorLocation';

//================================CMarkup============================

function Delphi_Markup_CppCreate; external DuiLibdll name 'Delphi_Markup_CppCreate';
procedure Delphi_Markup_CppDestroy; external DuiLibdll name 'Delphi_Markup_CppDestroy';
function Delphi_Markup_Load; external DuiLibdll name 'Delphi_Markup_Load';
function Delphi_Markup_LoadFromMem; external DuiLibdll name 'Delphi_Markup_LoadFromMem';
function Delphi_Markup_LoadFromFile; external DuiLibdll name 'Delphi_Markup_LoadFromFile';
procedure Delphi_Markup_Release; external DuiLibdll name 'Delphi_Markup_Release';
function Delphi_Markup_IsValid; external DuiLibdll name 'Delphi_Markup_IsValid';
procedure Delphi_Markup_SetPreserveWhitespace; external DuiLibdll name 'Delphi_Markup_SetPreserveWhitespace';
procedure Delphi_Markup_GetLastErrorMessage; external DuiLibdll name 'Delphi_Markup_GetLastErrorMessage';
procedure Delphi_Markup_GetLastErrorLocation; external DuiLibdll name 'Delphi_Markup_GetLastErrorLocation';
function Delphi_Markup_GetRoot; external DuiLibdll name 'Delphi_Markup_GetRoot';

//================================CMarkupNode============================

function Delphi_MarkupNode_CppCreate; external DuiLibdll name 'Delphi_MarkupNode_CppCreate';
procedure Delphi_MarkupNode_CppDestroy; external DuiLibdll name 'Delphi_MarkupNode_CppDestroy';
function Delphi_MarkupNode_IsValid; external DuiLibdll name 'Delphi_MarkupNode_IsValid';
function Delphi_MarkupNode_GetParent; external DuiLibdll name 'Delphi_MarkupNode_GetParent';
function Delphi_MarkupNode_GetSibling; external DuiLibdll name 'Delphi_MarkupNode_GetSibling';
function Delphi_MarkupNode_GetChild_01; external DuiLibdll name 'Delphi_MarkupNode_GetChild_01';
function Delphi_MarkupNode_GetChild_02; external DuiLibdll name 'Delphi_MarkupNode_GetChild_02';
function Delphi_MarkupNode_HasSiblings; external DuiLibdll name 'Delphi_MarkupNode_HasSiblings';
function Delphi_MarkupNode_HasChildren; external DuiLibdll name 'Delphi_MarkupNode_HasChildren';
function Delphi_MarkupNode_GetName; external DuiLibdll name 'Delphi_MarkupNode_GetName';
function Delphi_MarkupNode_GetValue; external DuiLibdll name 'Delphi_MarkupNode_GetValue';
function Delphi_MarkupNode_HasAttributes; external DuiLibdll name 'Delphi_MarkupNode_HasAttributes';
function Delphi_MarkupNode_HasAttribute; external DuiLibdll name 'Delphi_MarkupNode_HasAttribute';
function Delphi_MarkupNode_GetAttributeCount; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeCount';
function Delphi_MarkupNode_GetAttributeName; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeName';
function Delphi_MarkupNode_GetAttributeValue_01; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeValue_01';
function Delphi_MarkupNode_GetAttributeValue_02; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeValue_02';
function Delphi_MarkupNode_GetAttributeValue_03; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeValue_03';
function Delphi_MarkupNode_GetAttributeValue_04; external DuiLibdll name 'Delphi_MarkupNode_GetAttributeValue_04';

//================================CControlUI============================

function Delphi_ControlUI_CppCreate; external DuiLibdll name 'Delphi_ControlUI_CppCreate';
procedure Delphi_ControlUI_CppDestroy; external DuiLibdll name 'Delphi_ControlUI_CppDestroy';
function Delphi_ControlUI_GetName; external DuiLibdll name 'Delphi_ControlUI_GetName';
procedure Delphi_ControlUI_SetName; external DuiLibdll name 'Delphi_ControlUI_SetName';
function Delphi_ControlUI_GetClass; external DuiLibdll name 'Delphi_ControlUI_GetClass';
function Delphi_ControlUI_GetInterface; external DuiLibdll name 'Delphi_ControlUI_GetInterface';
function Delphi_ControlUI_GetControlFlags; external DuiLibdll name 'Delphi_ControlUI_GetControlFlags';
function Delphi_ControlUI_GetNativeWindow; external DuiLibdll name 'Delphi_ControlUI_GetNativeWindow';
function Delphi_ControlUI_Activate; external DuiLibdll name 'Delphi_ControlUI_Activate';
function Delphi_ControlUI_GetManager; external DuiLibdll name 'Delphi_ControlUI_GetManager';
procedure Delphi_ControlUI_SetManager; external DuiLibdll name 'Delphi_ControlUI_SetManager';
function Delphi_ControlUI_GetParent; external DuiLibdll name 'Delphi_ControlUI_GetParent';
function Delphi_ControlUI_GetText; external DuiLibdll name 'Delphi_ControlUI_GetText';
procedure Delphi_ControlUI_SetText; external DuiLibdll name 'Delphi_ControlUI_SetText';
function Delphi_ControlUI_GetBkColor; external DuiLibdll name 'Delphi_ControlUI_GetBkColor';
procedure Delphi_ControlUI_SetBkColor; external DuiLibdll name 'Delphi_ControlUI_SetBkColor';
function Delphi_ControlUI_GetBkColor2; external DuiLibdll name 'Delphi_ControlUI_GetBkColor2';
procedure Delphi_ControlUI_SetBkColor2; external DuiLibdll name 'Delphi_ControlUI_SetBkColor2';
function Delphi_ControlUI_GetBkColor3; external DuiLibdll name 'Delphi_ControlUI_GetBkColor3';
procedure Delphi_ControlUI_SetBkColor3; external DuiLibdll name 'Delphi_ControlUI_SetBkColor3';
function Delphi_ControlUI_GetBkImage; external DuiLibdll name 'Delphi_ControlUI_GetBkImage';
procedure Delphi_ControlUI_SetBkImage; external DuiLibdll name 'Delphi_ControlUI_SetBkImage';
function Delphi_ControlUI_GetFocusBorderColor; external DuiLibdll name 'Delphi_ControlUI_GetFocusBorderColor';
procedure Delphi_ControlUI_SetFocusBorderColor; external DuiLibdll name 'Delphi_ControlUI_SetFocusBorderColor';
function Delphi_ControlUI_IsColorHSL; external DuiLibdll name 'Delphi_ControlUI_IsColorHSL';
procedure Delphi_ControlUI_SetColorHSL; external DuiLibdll name 'Delphi_ControlUI_SetColorHSL';
procedure Delphi_ControlUI_GetBorderRound; external DuiLibdll name 'Delphi_ControlUI_GetBorderRound';
procedure Delphi_ControlUI_SetBorderRound; external DuiLibdll name 'Delphi_ControlUI_SetBorderRound';
function Delphi_ControlUI_DrawImage; external DuiLibdll name 'Delphi_ControlUI_DrawImage';
function Delphi_ControlUI_GetBorderColor; external DuiLibdll name 'Delphi_ControlUI_GetBorderColor';
procedure Delphi_ControlUI_SetBorderColor; external DuiLibdll name 'Delphi_ControlUI_SetBorderColor';
procedure Delphi_ControlUI_GetBorderSize; external DuiLibdll name 'Delphi_ControlUI_GetBorderSize';
procedure Delphi_ControlUI_SetBorderSize_01; external DuiLibdll name 'Delphi_ControlUI_SetBorderSize_01';
procedure Delphi_ControlUI_SetBorderSize_02; external DuiLibdll name 'Delphi_ControlUI_SetBorderSize_02';
function Delphi_ControlUI_GetBorderStyle; external DuiLibdll name 'Delphi_ControlUI_GetBorderStyle';
procedure Delphi_ControlUI_SetBorderStyle; external DuiLibdll name 'Delphi_ControlUI_SetBorderStyle';
function Delphi_ControlUI_GetPos; external DuiLibdll name 'Delphi_ControlUI_GetPos';
procedure Delphi_ControlUI_GetRelativePos; external DuiLibdll name 'Delphi_ControlUI_GetRelativePos';
procedure Delphi_ControlUI_GetClientPos; external DuiLibdll name 'Delphi_ControlUI_GetClientPos';
procedure Delphi_ControlUI_SetPos; external DuiLibdll name 'Delphi_ControlUI_SetPos';
procedure Delphi_ControlUI_Move; external DuiLibdll name 'Delphi_ControlUI_Move';
function Delphi_ControlUI_GetWidth; external DuiLibdll name 'Delphi_ControlUI_GetWidth';
function Delphi_ControlUI_GetHeight; external DuiLibdll name 'Delphi_ControlUI_GetHeight';
function Delphi_ControlUI_GetX; external DuiLibdll name 'Delphi_ControlUI_GetX';
function Delphi_ControlUI_GetY; external DuiLibdll name 'Delphi_ControlUI_GetY';
procedure Delphi_ControlUI_GetPadding; external DuiLibdll name 'Delphi_ControlUI_GetPadding';
procedure Delphi_ControlUI_SetPadding; external DuiLibdll name 'Delphi_ControlUI_SetPadding';
procedure Delphi_ControlUI_GetFixedXY; external DuiLibdll name 'Delphi_ControlUI_GetFixedXY';
procedure Delphi_ControlUI_SetFixedXY; external DuiLibdll name 'Delphi_ControlUI_SetFixedXY';
function Delphi_ControlUI_GetFixedWidth; external DuiLibdll name 'Delphi_ControlUI_GetFixedWidth';
procedure Delphi_ControlUI_SetFixedWidth; external DuiLibdll name 'Delphi_ControlUI_SetFixedWidth';
function Delphi_ControlUI_GetFixedHeight; external DuiLibdll name 'Delphi_ControlUI_GetFixedHeight';
procedure Delphi_ControlUI_SetFixedHeight; external DuiLibdll name 'Delphi_ControlUI_SetFixedHeight';
function Delphi_ControlUI_GetMinWidth; external DuiLibdll name 'Delphi_ControlUI_GetMinWidth';
procedure Delphi_ControlUI_SetMinWidth; external DuiLibdll name 'Delphi_ControlUI_SetMinWidth';
function Delphi_ControlUI_GetMaxWidth; external DuiLibdll name 'Delphi_ControlUI_GetMaxWidth';
procedure Delphi_ControlUI_SetMaxWidth; external DuiLibdll name 'Delphi_ControlUI_SetMaxWidth';
function Delphi_ControlUI_GetMinHeight; external DuiLibdll name 'Delphi_ControlUI_GetMinHeight';
procedure Delphi_ControlUI_SetMinHeight; external DuiLibdll name 'Delphi_ControlUI_SetMinHeight';
function Delphi_ControlUI_GetMaxHeight; external DuiLibdll name 'Delphi_ControlUI_GetMaxHeight';
procedure Delphi_ControlUI_SetMaxHeight; external DuiLibdll name 'Delphi_ControlUI_SetMaxHeight';
function Delphi_ControlUI_GetFloatPercent; external DuiLibdll name 'Delphi_ControlUI_GetFloatPercent';
procedure Delphi_ControlUI_SetFloatPercent; external DuiLibdll name 'Delphi_ControlUI_SetFloatPercent';
function Delphi_ControlUI_GetToolTip; external DuiLibdll name 'Delphi_ControlUI_GetToolTip';
procedure Delphi_ControlUI_SetToolTip; external DuiLibdll name 'Delphi_ControlUI_SetToolTip';
procedure Delphi_ControlUI_SetToolTipWidth; external DuiLibdll name 'Delphi_ControlUI_SetToolTipWidth';
function Delphi_ControlUI_GetToolTipWidth; external DuiLibdll name 'Delphi_ControlUI_GetToolTipWidth';
function Delphi_ControlUI_GetShortcut; external DuiLibdll name 'Delphi_ControlUI_GetShortcut';
procedure Delphi_ControlUI_SetShortcut; external DuiLibdll name 'Delphi_ControlUI_SetShortcut';
function Delphi_ControlUI_IsContextMenuUsed; external DuiLibdll name 'Delphi_ControlUI_IsContextMenuUsed';
procedure Delphi_ControlUI_SetContextMenuUsed; external DuiLibdll name 'Delphi_ControlUI_SetContextMenuUsed';
function Delphi_ControlUI_GetUserData; external DuiLibdll name 'Delphi_ControlUI_GetUserData';
procedure Delphi_ControlUI_SetUserData; external DuiLibdll name 'Delphi_ControlUI_SetUserData';
function Delphi_ControlUI_GetTag; external DuiLibdll name 'Delphi_ControlUI_GetTag';
procedure Delphi_ControlUI_SetTag; external DuiLibdll name 'Delphi_ControlUI_SetTag';
function Delphi_ControlUI_IsVisible; external DuiLibdll name 'Delphi_ControlUI_IsVisible';
procedure Delphi_ControlUI_SetVisible; external DuiLibdll name 'Delphi_ControlUI_SetVisible';
procedure Delphi_ControlUI_SetInternVisible; external DuiLibdll name 'Delphi_ControlUI_SetInternVisible';
function Delphi_ControlUI_IsEnabled; external DuiLibdll name 'Delphi_ControlUI_IsEnabled';
procedure Delphi_ControlUI_SetEnabled; external DuiLibdll name 'Delphi_ControlUI_SetEnabled';
function Delphi_ControlUI_IsMouseEnabled; external DuiLibdll name 'Delphi_ControlUI_IsMouseEnabled';
procedure Delphi_ControlUI_SetMouseEnabled; external DuiLibdll name 'Delphi_ControlUI_SetMouseEnabled';
function Delphi_ControlUI_IsKeyboardEnabled; external DuiLibdll name 'Delphi_ControlUI_IsKeyboardEnabled';
procedure Delphi_ControlUI_SetKeyboardEnabled; external DuiLibdll name 'Delphi_ControlUI_SetKeyboardEnabled';
function Delphi_ControlUI_IsFocused; external DuiLibdll name 'Delphi_ControlUI_IsFocused';
procedure Delphi_ControlUI_SetFocus; external DuiLibdll name 'Delphi_ControlUI_SetFocus';
function Delphi_ControlUI_IsFloat; external DuiLibdll name 'Delphi_ControlUI_IsFloat';
procedure Delphi_ControlUI_SetFloat; external DuiLibdll name 'Delphi_ControlUI_SetFloat';
procedure Delphi_ControlUI_AddCustomAttribute; external DuiLibdll name 'Delphi_ControlUI_AddCustomAttribute';
function Delphi_ControlUI_GetCustomAttribute; external DuiLibdll name 'Delphi_ControlUI_GetCustomAttribute';
function Delphi_ControlUI_RemoveCustomAttribute; external DuiLibdll name 'Delphi_ControlUI_RemoveCustomAttribute';
procedure Delphi_ControlUI_RemoveAllCustomAttribute; external DuiLibdll name 'Delphi_ControlUI_RemoveAllCustomAttribute';
function Delphi_ControlUI_FindControl; external DuiLibdll name 'Delphi_ControlUI_FindControl';
procedure Delphi_ControlUI_Invalidate; external DuiLibdll name 'Delphi_ControlUI_Invalidate';
function Delphi_ControlUI_IsUpdateNeeded; external DuiLibdll name 'Delphi_ControlUI_IsUpdateNeeded';
procedure Delphi_ControlUI_NeedUpdate; external DuiLibdll name 'Delphi_ControlUI_NeedUpdate';
procedure Delphi_ControlUI_NeedParentUpdate; external DuiLibdll name 'Delphi_ControlUI_NeedParentUpdate';
function Delphi_ControlUI_GetAdjustColor; external DuiLibdll name 'Delphi_ControlUI_GetAdjustColor';
procedure Delphi_ControlUI_Init; external DuiLibdll name 'Delphi_ControlUI_Init';
procedure Delphi_ControlUI_DoInit; external DuiLibdll name 'Delphi_ControlUI_DoInit';
procedure Delphi_ControlUI_Event; external DuiLibdll name 'Delphi_ControlUI_Event';
procedure Delphi_ControlUI_DoEvent; external DuiLibdll name 'Delphi_ControlUI_DoEvent';
procedure Delphi_ControlUI_SetAttribute; external DuiLibdll name 'Delphi_ControlUI_SetAttribute';
function Delphi_ControlUI_ApplyAttributeList; external DuiLibdll name 'Delphi_ControlUI_ApplyAttributeList';
procedure Delphi_ControlUI_EstimateSize; external DuiLibdll name 'Delphi_ControlUI_EstimateSize';
procedure Delphi_ControlUI_DoPaint; external DuiLibdll name 'Delphi_ControlUI_DoPaint';
procedure Delphi_ControlUI_Paint; external DuiLibdll name 'Delphi_ControlUI_Paint';
procedure Delphi_ControlUI_PaintBkColor; external DuiLibdll name 'Delphi_ControlUI_PaintBkColor';
procedure Delphi_ControlUI_PaintBkImage; external DuiLibdll name 'Delphi_ControlUI_PaintBkImage';
procedure Delphi_ControlUI_PaintStatusImage; external DuiLibdll name 'Delphi_ControlUI_PaintStatusImage';
procedure Delphi_ControlUI_PaintText; external DuiLibdll name 'Delphi_ControlUI_PaintText';
procedure Delphi_ControlUI_PaintBorder; external DuiLibdll name 'Delphi_ControlUI_PaintBorder';
procedure Delphi_ControlUI_DoPostPaint; external DuiLibdll name 'Delphi_ControlUI_DoPostPaint';
procedure Delphi_ControlUI_SetVirtualWnd; external DuiLibdll name 'Delphi_ControlUI_SetVirtualWnd';
function Delphi_ControlUI_GetVirtualWnd; external DuiLibdll name 'Delphi_ControlUI_GetVirtualWnd';


//================================CDelphi_WindowImplBase============================

function Delphi_Delphi_WindowImplBase_CppCreate; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_CppCreate';
procedure Delphi_Delphi_WindowImplBase_CppDestroy; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_CppDestroy';
function Delphi_Delphi_WindowImplBase_GetHWND; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_GetHWND';
function Delphi_Delphi_WindowImplBase_RegisterWindowClass; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_RegisterWindowClass';
function Delphi_Delphi_WindowImplBase_RegisterSuperclass; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_RegisterSuperclass';
function Delphi_Delphi_WindowImplBase_Create_01; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_Create_01';
function Delphi_Delphi_WindowImplBase_Create_02; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_Create_02';
function Delphi_Delphi_WindowImplBase_CreateDuiWindow; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_CreateDuiWindow';
function Delphi_Delphi_WindowImplBase_Subclass; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_Subclass';
procedure Delphi_Delphi_WindowImplBase_Unsubclass; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_Unsubclass';
procedure Delphi_Delphi_WindowImplBase_ShowWindow; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_ShowWindow';
function Delphi_Delphi_WindowImplBase_ShowModal; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_ShowModal';
procedure Delphi_Delphi_WindowImplBase_Close; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_Close';
procedure Delphi_Delphi_WindowImplBase_CenterWindow; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_CenterWindow';
procedure Delphi_Delphi_WindowImplBase_SetIcon; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetIcon';
function Delphi_Delphi_WindowImplBase_SendMessage; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SendMessage';
function Delphi_Delphi_WindowImplBase_PostMessage; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_PostMessage';
procedure Delphi_Delphi_WindowImplBase_ResizeClient; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_ResizeClient';
function Delphi_Delphi_WindowImplBase_AddVirtualWnd; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_AddVirtualWnd';
function Delphi_Delphi_WindowImplBase_RemoveVirtualWnd; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_RemoveVirtualWnd';
procedure Delphi_Delphi_WindowImplBase_NotifyPump; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_NotifyPump';
function Delphi_Delphi_WindowImplBase_LoopDispatch; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_LoopDispatch';
function Delphi_Delphi_WindowImplBase_GetPaintManagerUI; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_GetPaintManagerUI';
procedure Delphi_Delphi_WindowImplBase_SetDelphiSelf; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetDelphiSelf';
procedure Delphi_Delphi_WindowImplBase_SetClassName; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetClassName';
procedure Delphi_Delphi_WindowImplBase_SetSkinFile; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetSkinFile';
procedure Delphi_Delphi_WindowImplBase_SetSkinFolder; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetSkinFolder';
procedure Delphi_Delphi_WindowImplBase_SetZipFileName; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetZipFileName';
procedure Delphi_Delphi_WindowImplBase_SetResourceType; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetResourceType';
procedure Delphi_Delphi_WindowImplBase_SetInitWindow; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetInitWindow';
procedure Delphi_Delphi_WindowImplBase_SetFinalMessage; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetFinalMessage';
procedure Delphi_Delphi_WindowImplBase_SetHandleMessage; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetHandleMessage';
procedure Delphi_Delphi_WindowImplBase_SetNotify; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetNotify';
procedure Delphi_Delphi_WindowImplBase_SetClick; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetClick';
procedure Delphi_Delphi_WindowImplBase_SetMessageHandler; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetMessageHandler';
procedure Delphi_Delphi_WindowImplBase_SetHandleCustomMessage; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetHandleCustomMessage';
procedure Delphi_Delphi_WindowImplBase_SetCreateControl; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetCreateControl';
procedure Delphi_Delphi_WindowImplBase_SetGetItemText; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetGetItemText';
procedure Delphi_Delphi_WindowImplBase_SetGetClassStyle; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetGetClassStyle';
procedure Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_RemoveThisInPaintManager';
procedure Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent; external DuiLibdll name 'Delphi_Delphi_WindowImplBase_SetResponseDefaultKeyEvent';

//================================CPaintManagerUI============================

function Delphi_PaintManagerUI_CppCreate; external DuiLibdll name 'Delphi_PaintManagerUI_CppCreate';
procedure Delphi_PaintManagerUI_CppDestroy; external DuiLibdll name 'Delphi_PaintManagerUI_CppDestroy';
procedure Delphi_PaintManagerUI_Init; external DuiLibdll name 'Delphi_PaintManagerUI_Init';
function Delphi_PaintManagerUI_IsUpdateNeeded; external DuiLibdll name 'Delphi_PaintManagerUI_IsUpdateNeeded';
procedure Delphi_PaintManagerUI_NeedUpdate; external DuiLibdll name 'Delphi_PaintManagerUI_NeedUpdate';
procedure Delphi_PaintManagerUI_Invalidate_01; external DuiLibdll name 'Delphi_PaintManagerUI_Invalidate_01';
procedure Delphi_PaintManagerUI_Invalidate_02; external DuiLibdll name 'Delphi_PaintManagerUI_Invalidate_02';
function Delphi_PaintManagerUI_GetPaintDC; external DuiLibdll name 'Delphi_PaintManagerUI_GetPaintDC';
function Delphi_PaintManagerUI_GetPaintWindow; external DuiLibdll name 'Delphi_PaintManagerUI_GetPaintWindow';
function Delphi_PaintManagerUI_GetTooltipWindow; external DuiLibdll name 'Delphi_PaintManagerUI_GetTooltipWindow';
function Delphi_PaintManagerUI_GetMousePos; external DuiLibdll name 'Delphi_PaintManagerUI_GetMousePos';
procedure Delphi_PaintManagerUI_GetClientSize; external DuiLibdll name 'Delphi_PaintManagerUI_GetClientSize';
procedure Delphi_PaintManagerUI_GetInitSize; external DuiLibdll name 'Delphi_PaintManagerUI_GetInitSize';
procedure Delphi_PaintManagerUI_SetInitSize; external DuiLibdll name 'Delphi_PaintManagerUI_SetInitSize';
function Delphi_PaintManagerUI_GetSizeBox; external DuiLibdll name 'Delphi_PaintManagerUI_GetSizeBox';
procedure Delphi_PaintManagerUI_SetSizeBox; external DuiLibdll name 'Delphi_PaintManagerUI_SetSizeBox';
function Delphi_PaintManagerUI_GetCaptionRect; external DuiLibdll name 'Delphi_PaintManagerUI_GetCaptionRect';
procedure Delphi_PaintManagerUI_SetCaptionRect; external DuiLibdll name 'Delphi_PaintManagerUI_SetCaptionRect';
procedure Delphi_PaintManagerUI_GetRoundCorner; external DuiLibdll name 'Delphi_PaintManagerUI_GetRoundCorner';
procedure Delphi_PaintManagerUI_SetRoundCorner; external DuiLibdll name 'Delphi_PaintManagerUI_SetRoundCorner';
procedure Delphi_PaintManagerUI_GetMinInfo; external DuiLibdll name 'Delphi_PaintManagerUI_GetMinInfo';
procedure Delphi_PaintManagerUI_SetMinInfo; external DuiLibdll name 'Delphi_PaintManagerUI_SetMinInfo';
procedure Delphi_PaintManagerUI_GetMaxInfo; external DuiLibdll name 'Delphi_PaintManagerUI_GetMaxInfo';
procedure Delphi_PaintManagerUI_SetMaxInfo; external DuiLibdll name 'Delphi_PaintManagerUI_SetMaxInfo';
function Delphi_PaintManagerUI_IsShowUpdateRect; external DuiLibdll name 'Delphi_PaintManagerUI_IsShowUpdateRect';
procedure Delphi_PaintManagerUI_SetShowUpdateRect; external DuiLibdll name 'Delphi_PaintManagerUI_SetShowUpdateRect';
function Delphi_PaintManagerUI_GetInstance; external DuiLibdll name 'Delphi_PaintManagerUI_GetInstance';
function Delphi_PaintManagerUI_GetInstancePath; external DuiLibdll name 'Delphi_PaintManagerUI_GetInstancePath';
function Delphi_PaintManagerUI_GetCurrentPath; external DuiLibdll name 'Delphi_PaintManagerUI_GetCurrentPath';
function Delphi_PaintManagerUI_GetResourceDll; external DuiLibdll name 'Delphi_PaintManagerUI_GetResourceDll';
function Delphi_PaintManagerUI_GetResourcePath; external DuiLibdll name 'Delphi_PaintManagerUI_GetResourcePath';
function Delphi_PaintManagerUI_GetResourceZip; external DuiLibdll name 'Delphi_PaintManagerUI_GetResourceZip';
function Delphi_PaintManagerUI_IsCachedResourceZip; external DuiLibdll name 'Delphi_PaintManagerUI_IsCachedResourceZip';
function Delphi_PaintManagerUI_GetResourceZipHandle; external DuiLibdll name 'Delphi_PaintManagerUI_GetResourceZipHandle';
procedure Delphi_PaintManagerUI_SetInstance; external DuiLibdll name 'Delphi_PaintManagerUI_SetInstance';
procedure Delphi_PaintManagerUI_SetCurrentPath; external DuiLibdll name 'Delphi_PaintManagerUI_SetCurrentPath';
procedure Delphi_PaintManagerUI_SetResourceDll; external DuiLibdll name 'Delphi_PaintManagerUI_SetResourceDll';
procedure Delphi_PaintManagerUI_SetResourcePath; external DuiLibdll name 'Delphi_PaintManagerUI_SetResourcePath';
procedure Delphi_PaintManagerUI_SetResourceZip_01; external DuiLibdll name 'Delphi_PaintManagerUI_SetResourceZip_01';
procedure Delphi_PaintManagerUI_SetResourceZip_02; external DuiLibdll name 'Delphi_PaintManagerUI_SetResourceZip_02';
function Delphi_PaintManagerUI_GetHSL; external DuiLibdll name 'Delphi_PaintManagerUI_GetHSL';
procedure Delphi_PaintManagerUI_ReloadSkin; external DuiLibdll name 'Delphi_PaintManagerUI_ReloadSkin';
function Delphi_PaintManagerUI_LoadPlugin; external DuiLibdll name 'Delphi_PaintManagerUI_LoadPlugin';
function Delphi_PaintManagerUI_GetPlugins; external DuiLibdll name 'Delphi_PaintManagerUI_GetPlugins';
function Delphi_PaintManagerUI_IsForceUseSharedRes; external DuiLibdll name 'Delphi_PaintManagerUI_IsForceUseSharedRes';
procedure Delphi_PaintManagerUI_SetForceUseSharedRes; external DuiLibdll name 'Delphi_PaintManagerUI_SetForceUseSharedRes';
function Delphi_PaintManagerUI_IsPainting; external DuiLibdll name 'Delphi_PaintManagerUI_IsPainting';
procedure Delphi_PaintManagerUI_SetPainting; external DuiLibdll name 'Delphi_PaintManagerUI_SetPainting';
function Delphi_PaintManagerUI_GetDefaultDisabledColor; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultDisabledColor';
procedure Delphi_PaintManagerUI_SetDefaultDisabledColor; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultDisabledColor';
function Delphi_PaintManagerUI_GetDefaultFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultFontColor';
procedure Delphi_PaintManagerUI_SetDefaultFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultFontColor';
function Delphi_PaintManagerUI_GetDefaultLinkFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultLinkFontColor';
procedure Delphi_PaintManagerUI_SetDefaultLinkFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultLinkFontColor';
function Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultLinkHoverFontColor';
procedure Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultLinkHoverFontColor';
function Delphi_PaintManagerUI_GetDefaultSelectedBkColor; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultSelectedBkColor';
procedure Delphi_PaintManagerUI_SetDefaultSelectedBkColor; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultSelectedBkColor';
function Delphi_PaintManagerUI_GetDefaultFontInfo; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultFontInfo';
procedure Delphi_PaintManagerUI_SetDefaultFont; external DuiLibdll name 'Delphi_PaintManagerUI_SetDefaultFont';
function Delphi_PaintManagerUI_GetCustomFontCount; external DuiLibdll name 'Delphi_PaintManagerUI_GetCustomFontCount';
function Delphi_PaintManagerUI_AddFont; external DuiLibdll name 'Delphi_PaintManagerUI_AddFont';
function Delphi_PaintManagerUI_GetFont_01; external DuiLibdll name 'Delphi_PaintManagerUI_GetFont_01';
function Delphi_PaintManagerUI_GetFont_02; external DuiLibdll name 'Delphi_PaintManagerUI_GetFont_02';
function Delphi_PaintManagerUI_GetFontIndex_01; external DuiLibdll name 'Delphi_PaintManagerUI_GetFontIndex_01';
function Delphi_PaintManagerUI_GetFontIndex_02; external DuiLibdll name 'Delphi_PaintManagerUI_GetFontIndex_02';
procedure Delphi_PaintManagerUI_RemoveFont_01; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveFont_01';
procedure Delphi_PaintManagerUI_RemoveFont_02; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveFont_02';
procedure Delphi_PaintManagerUI_RemoveAllFonts; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllFonts';
function Delphi_PaintManagerUI_GetFontInfo_01; external DuiLibdll name 'Delphi_PaintManagerUI_GetFontInfo_01';
function Delphi_PaintManagerUI_GetFontInfo_02; external DuiLibdll name 'Delphi_PaintManagerUI_GetFontInfo_02';
function Delphi_PaintManagerUI_GetImage; external DuiLibdll name 'Delphi_PaintManagerUI_GetImage';
function Delphi_PaintManagerUI_GetImageEx; external DuiLibdll name 'Delphi_PaintManagerUI_GetImageEx';
function Delphi_PaintManagerUI_AddImage_01; external DuiLibdll name 'Delphi_PaintManagerUI_AddImage_01';
function Delphi_PaintManagerUI_AddImage_02; external DuiLibdll name 'Delphi_PaintManagerUI_AddImage_02';
procedure Delphi_PaintManagerUI_RemoveImage; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveImage';
procedure Delphi_PaintManagerUI_RemoveAllImages; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllImages';
procedure Delphi_PaintManagerUI_ReloadSharedImages; external DuiLibdll name 'Delphi_PaintManagerUI_ReloadSharedImages';
procedure Delphi_PaintManagerUI_ReloadImages; external DuiLibdll name 'Delphi_PaintManagerUI_ReloadImages';
procedure Delphi_PaintManagerUI_AddDefaultAttributeList; external DuiLibdll name 'Delphi_PaintManagerUI_AddDefaultAttributeList';
function Delphi_PaintManagerUI_GetDefaultAttributeList; external DuiLibdll name 'Delphi_PaintManagerUI_GetDefaultAttributeList';
function Delphi_PaintManagerUI_RemoveDefaultAttributeList; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveDefaultAttributeList';
procedure Delphi_PaintManagerUI_RemoveAllDefaultAttributeList; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllDefaultAttributeList';
procedure Delphi_PaintManagerUI_AddMultiLanguageString; external DuiLibdll name 'Delphi_PaintManagerUI_AddMultiLanguageString';
function Delphi_PaintManagerUI_GetMultiLanguageString; external DuiLibdll name 'Delphi_PaintManagerUI_GetMultiLanguageString';
function Delphi_PaintManagerUI_RemoveMultiLanguageString; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveMultiLanguageString';
procedure Delphi_PaintManagerUI_RemoveAllMultiLanguageString; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllMultiLanguageString';
procedure Delphi_PaintManagerUI_ProcessMultiLanguageTokens; external DuiLibdll name 'Delphi_PaintManagerUI_ProcessMultiLanguageTokens';
function Delphi_PaintManagerUI_AttachDialog; external DuiLibdll name 'Delphi_PaintManagerUI_AttachDialog';
function Delphi_PaintManagerUI_InitControls; external DuiLibdll name 'Delphi_PaintManagerUI_InitControls';
procedure Delphi_PaintManagerUI_ReapObjects; external DuiLibdll name 'Delphi_PaintManagerUI_ReapObjects';
function Delphi_PaintManagerUI_AddOptionGroup; external DuiLibdll name 'Delphi_PaintManagerUI_AddOptionGroup';
function Delphi_PaintManagerUI_GetOptionGroup; external DuiLibdll name 'Delphi_PaintManagerUI_GetOptionGroup';
procedure Delphi_PaintManagerUI_RemoveOptionGroup; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveOptionGroup';
procedure Delphi_PaintManagerUI_RemoveAllOptionGroups; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllOptionGroups';
function Delphi_PaintManagerUI_GetFocus; external DuiLibdll name 'Delphi_PaintManagerUI_GetFocus';
procedure Delphi_PaintManagerUI_SetFocus; external DuiLibdll name 'Delphi_PaintManagerUI_SetFocus';
procedure Delphi_PaintManagerUI_SetFocusNeeded; external DuiLibdll name 'Delphi_PaintManagerUI_SetFocusNeeded';
function Delphi_PaintManagerUI_SetNextTabControl; external DuiLibdll name 'Delphi_PaintManagerUI_SetNextTabControl';
function Delphi_PaintManagerUI_SetTimer; external DuiLibdll name 'Delphi_PaintManagerUI_SetTimer';
function Delphi_PaintManagerUI_KillTimer_01; external DuiLibdll name 'Delphi_PaintManagerUI_KillTimer_01';
procedure Delphi_PaintManagerUI_KillTimer_02; external DuiLibdll name 'Delphi_PaintManagerUI_KillTimer_02';
procedure Delphi_PaintManagerUI_RemoveAllTimers; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllTimers';
procedure Delphi_PaintManagerUI_SetCapture; external DuiLibdll name 'Delphi_PaintManagerUI_SetCapture';
procedure Delphi_PaintManagerUI_ReleaseCapture; external DuiLibdll name 'Delphi_PaintManagerUI_ReleaseCapture';
function Delphi_PaintManagerUI_IsCaptured; external DuiLibdll name 'Delphi_PaintManagerUI_IsCaptured';
function Delphi_PaintManagerUI_AddNotifier; external DuiLibdll name 'Delphi_PaintManagerUI_AddNotifier';
function Delphi_PaintManagerUI_RemoveNotifier; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveNotifier';
procedure Delphi_PaintManagerUI_SendNotify_01; external DuiLibdll name 'Delphi_PaintManagerUI_SendNotify_01';
procedure Delphi_PaintManagerUI_SendNotify_02; external DuiLibdll name 'Delphi_PaintManagerUI_SendNotify_02';
function Delphi_PaintManagerUI_AddPreMessageFilter; external DuiLibdll name 'Delphi_PaintManagerUI_AddPreMessageFilter';
function Delphi_PaintManagerUI_RemovePreMessageFilter; external DuiLibdll name 'Delphi_PaintManagerUI_RemovePreMessageFilter';
function Delphi_PaintManagerUI_AddMessageFilter; external DuiLibdll name 'Delphi_PaintManagerUI_AddMessageFilter';
function Delphi_PaintManagerUI_RemoveMessageFilter; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveMessageFilter';
function Delphi_PaintManagerUI_GetPostPaintCount; external DuiLibdll name 'Delphi_PaintManagerUI_GetPostPaintCount';
function Delphi_PaintManagerUI_AddPostPaint; external DuiLibdll name 'Delphi_PaintManagerUI_AddPostPaint';
function Delphi_PaintManagerUI_RemovePostPaint; external DuiLibdll name 'Delphi_PaintManagerUI_RemovePostPaint';
function Delphi_PaintManagerUI_SetPostPaintIndex; external DuiLibdll name 'Delphi_PaintManagerUI_SetPostPaintIndex';
function Delphi_PaintManagerUI_GetNativeWindowCount; external DuiLibdll name 'Delphi_PaintManagerUI_GetNativeWindowCount';
function Delphi_PaintManagerUI_AddNativeWindow; external DuiLibdll name 'Delphi_PaintManagerUI_AddNativeWindow';
function Delphi_PaintManagerUI_RemoveNativeWindow; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveNativeWindow';
procedure Delphi_PaintManagerUI_AddDelayedCleanup; external DuiLibdll name 'Delphi_PaintManagerUI_AddDelayedCleanup';
function Delphi_PaintManagerUI_AddTranslateAccelerator; external DuiLibdll name 'Delphi_PaintManagerUI_AddTranslateAccelerator';
function Delphi_PaintManagerUI_RemoveTranslateAccelerator; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveTranslateAccelerator';
function Delphi_PaintManagerUI_TranslateAccelerator; external DuiLibdll name 'Delphi_PaintManagerUI_TranslateAccelerator';
function Delphi_PaintManagerUI_GetRoot; external DuiLibdll name 'Delphi_PaintManagerUI_GetRoot';
function Delphi_PaintManagerUI_FindControl_01; external DuiLibdll name 'Delphi_PaintManagerUI_FindControl_01';
function Delphi_PaintManagerUI_FindControl_02; external DuiLibdll name 'Delphi_PaintManagerUI_FindControl_02';
function Delphi_PaintManagerUI_FindSubControlByPoint; external DuiLibdll name 'Delphi_PaintManagerUI_FindSubControlByPoint';
function Delphi_PaintManagerUI_FindSubControlByName; external DuiLibdll name 'Delphi_PaintManagerUI_FindSubControlByName';
function Delphi_PaintManagerUI_FindSubControlByClass; external DuiLibdll name 'Delphi_PaintManagerUI_FindSubControlByClass';
function Delphi_PaintManagerUI_FindSubControlsByClass; external DuiLibdll name 'Delphi_PaintManagerUI_FindSubControlsByClass';
procedure Delphi_PaintManagerUI_MessageLoop; external DuiLibdll name 'Delphi_PaintManagerUI_MessageLoop';
function Delphi_PaintManagerUI_TranslateMessage; external DuiLibdll name 'Delphi_PaintManagerUI_TranslateMessage';
procedure Delphi_PaintManagerUI_Term; external DuiLibdll name 'Delphi_PaintManagerUI_Term';
function Delphi_PaintManagerUI_MessageHandler; external DuiLibdll name 'Delphi_PaintManagerUI_MessageHandler';
function Delphi_PaintManagerUI_PreMessageHandler; external DuiLibdll name 'Delphi_PaintManagerUI_PreMessageHandler';
procedure Delphi_PaintManagerUI_UsedVirtualWnd; external DuiLibdll name 'Delphi_PaintManagerUI_UsedVirtualWnd';
function Delphi_PaintManagerUI_GetName; external DuiLibdll name 'Delphi_PaintManagerUI_GetName';
function Delphi_PaintManagerUI_GetTooltipWindowWidth; external DuiLibdll name 'Delphi_PaintManagerUI_GetTooltipWindowWidth';
procedure Delphi_PaintManagerUI_SetTooltipWindowWidth; external DuiLibdll name 'Delphi_PaintManagerUI_SetTooltipWindowWidth';
function Delphi_PaintManagerUI_GetHoverTime; external DuiLibdll name 'Delphi_PaintManagerUI_GetHoverTime';
procedure Delphi_PaintManagerUI_SetHoverTime; external DuiLibdll name 'Delphi_PaintManagerUI_SetHoverTime';
function Delphi_PaintManagerUI_GetOpacity; external DuiLibdll name 'Delphi_PaintManagerUI_GetOpacity';
procedure Delphi_PaintManagerUI_SetOpacity; external DuiLibdll name 'Delphi_PaintManagerUI_SetOpacity';
function Delphi_PaintManagerUI_IsLayered; external DuiLibdll name 'Delphi_PaintManagerUI_IsLayered';
procedure Delphi_PaintManagerUI_SetLayered; external DuiLibdll name 'Delphi_PaintManagerUI_SetLayered';
function Delphi_PaintManagerUI_GetLayeredInset; external DuiLibdll name 'Delphi_PaintManagerUI_GetLayeredInset';
procedure Delphi_PaintManagerUI_SetLayeredInset; external DuiLibdll name 'Delphi_PaintManagerUI_SetLayeredInset';
function Delphi_PaintManagerUI_GetLayeredOpacity; external DuiLibdll name 'Delphi_PaintManagerUI_GetLayeredOpacity';
procedure Delphi_PaintManagerUI_SetLayeredOpacity; external DuiLibdll name 'Delphi_PaintManagerUI_SetLayeredOpacity';
function Delphi_PaintManagerUI_GetLayeredImage; external DuiLibdll name 'Delphi_PaintManagerUI_GetLayeredImage';
procedure Delphi_PaintManagerUI_SetLayeredImage; external DuiLibdll name 'Delphi_PaintManagerUI_SetLayeredImage';
function Delphi_PaintManagerUI_GetPaintManager; external DuiLibdll name 'Delphi_PaintManagerUI_GetPaintManager';
function Delphi_PaintManagerUI_GetPaintManagers; external DuiLibdll name 'Delphi_PaintManagerUI_GetPaintManagers';
procedure Delphi_PaintManagerUI_AddWindowCustomAttribute; external DuiLibdll name 'Delphi_PaintManagerUI_AddWindowCustomAttribute';
function Delphi_PaintManagerUI_GetWindowCustomAttribute; external DuiLibdll name 'Delphi_PaintManagerUI_GetWindowCustomAttribute';
function Delphi_PaintManagerUI_RemoveWindowCustomAttribute; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveWindowCustomAttribute';
procedure Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute; external DuiLibdll name 'Delphi_PaintManagerUI_RemoveAllWindowCustomAttribute';

//================================CContainerUI============================

function Delphi_ContainerUI_CppCreate; external DuiLibdll name 'Delphi_ContainerUI_CppCreate';
procedure Delphi_ContainerUI_CppDestroy; external DuiLibdll name 'Delphi_ContainerUI_CppDestroy';
function Delphi_ContainerUI_GetClass; external DuiLibdll name 'Delphi_ContainerUI_GetClass';
function Delphi_ContainerUI_GetInterface; external DuiLibdll name 'Delphi_ContainerUI_GetInterface';
function Delphi_ContainerUI_GetItemAt; external DuiLibdll name 'Delphi_ContainerUI_GetItemAt';
function Delphi_ContainerUI_GetItemIndex; external DuiLibdll name 'Delphi_ContainerUI_GetItemIndex';
function Delphi_ContainerUI_SetItemIndex; external DuiLibdll name 'Delphi_ContainerUI_SetItemIndex';
function Delphi_ContainerUI_GetCount; external DuiLibdll name 'Delphi_ContainerUI_GetCount';
function Delphi_ContainerUI_Add; external DuiLibdll name 'Delphi_ContainerUI_Add';
function Delphi_ContainerUI_AddAt; external DuiLibdll name 'Delphi_ContainerUI_AddAt';
function Delphi_ContainerUI_Remove; external DuiLibdll name 'Delphi_ContainerUI_Remove';
function Delphi_ContainerUI_RemoveAt; external DuiLibdll name 'Delphi_ContainerUI_RemoveAt';
procedure Delphi_ContainerUI_RemoveAll; external DuiLibdll name 'Delphi_ContainerUI_RemoveAll';
procedure Delphi_ContainerUI_DoEvent; external DuiLibdll name 'Delphi_ContainerUI_DoEvent';
procedure Delphi_ContainerUI_SetVisible; external DuiLibdll name 'Delphi_ContainerUI_SetVisible';
procedure Delphi_ContainerUI_SetInternVisible; external DuiLibdll name 'Delphi_ContainerUI_SetInternVisible';
procedure Delphi_ContainerUI_SetMouseEnabled; external DuiLibdll name 'Delphi_ContainerUI_SetMouseEnabled';
procedure Delphi_ContainerUI_GetInset; external DuiLibdll name 'Delphi_ContainerUI_GetInset';
procedure Delphi_ContainerUI_SetInset; external DuiLibdll name 'Delphi_ContainerUI_SetInset';
function Delphi_ContainerUI_GetChildPadding; external DuiLibdll name 'Delphi_ContainerUI_GetChildPadding';
procedure Delphi_ContainerUI_SetChildPadding; external DuiLibdll name 'Delphi_ContainerUI_SetChildPadding';
function Delphi_ContainerUI_IsAutoDestroy; external DuiLibdll name 'Delphi_ContainerUI_IsAutoDestroy';
procedure Delphi_ContainerUI_SetAutoDestroy; external DuiLibdll name 'Delphi_ContainerUI_SetAutoDestroy';
function Delphi_ContainerUI_IsDelayedDestroy; external DuiLibdll name 'Delphi_ContainerUI_IsDelayedDestroy';
procedure Delphi_ContainerUI_SetDelayedDestroy; external DuiLibdll name 'Delphi_ContainerUI_SetDelayedDestroy';
function Delphi_ContainerUI_IsMouseChildEnabled; external DuiLibdll name 'Delphi_ContainerUI_IsMouseChildEnabled';
procedure Delphi_ContainerUI_SetMouseChildEnabled; external DuiLibdll name 'Delphi_ContainerUI_SetMouseChildEnabled';
function Delphi_ContainerUI_FindSelectable; external DuiLibdll name 'Delphi_ContainerUI_FindSelectable';
procedure Delphi_ContainerUI_GetClientPos; external DuiLibdll name 'Delphi_ContainerUI_GetClientPos';
procedure Delphi_ContainerUI_SetPos; external DuiLibdll name 'Delphi_ContainerUI_SetPos';
procedure Delphi_ContainerUI_Move; external DuiLibdll name 'Delphi_ContainerUI_Move';
procedure Delphi_ContainerUI_DoPaint; external DuiLibdll name 'Delphi_ContainerUI_DoPaint';
procedure Delphi_ContainerUI_SetAttribute; external DuiLibdll name 'Delphi_ContainerUI_SetAttribute';
procedure Delphi_ContainerUI_SetManager; external DuiLibdll name 'Delphi_ContainerUI_SetManager';
function Delphi_ContainerUI_FindControl; external DuiLibdll name 'Delphi_ContainerUI_FindControl';
function Delphi_ContainerUI_SetSubControlText; external DuiLibdll name 'Delphi_ContainerUI_SetSubControlText';
function Delphi_ContainerUI_SetSubControlFixedHeight; external DuiLibdll name 'Delphi_ContainerUI_SetSubControlFixedHeight';
function Delphi_ContainerUI_SetSubControlFixedWdith; external DuiLibdll name 'Delphi_ContainerUI_SetSubControlFixedWdith';
function Delphi_ContainerUI_SetSubControlUserData; external DuiLibdll name 'Delphi_ContainerUI_SetSubControlUserData';
function Delphi_ContainerUI_GetSubControlText; external DuiLibdll name 'Delphi_ContainerUI_GetSubControlText';
function Delphi_ContainerUI_GetSubControlFixedHeight; external DuiLibdll name 'Delphi_ContainerUI_GetSubControlFixedHeight';
function Delphi_ContainerUI_GetSubControlFixedWdith; external DuiLibdll name 'Delphi_ContainerUI_GetSubControlFixedWdith';
function Delphi_ContainerUI_GetSubControlUserData; external DuiLibdll name 'Delphi_ContainerUI_GetSubControlUserData';
function Delphi_ContainerUI_FindSubControl; external DuiLibdll name 'Delphi_ContainerUI_FindSubControl';
procedure Delphi_ContainerUI_GetScrollPos; external DuiLibdll name 'Delphi_ContainerUI_GetScrollPos';
procedure Delphi_ContainerUI_GetScrollRange; external DuiLibdll name 'Delphi_ContainerUI_GetScrollRange';
procedure Delphi_ContainerUI_SetScrollPos; external DuiLibdll name 'Delphi_ContainerUI_SetScrollPos';
procedure Delphi_ContainerUI_LineUp; external DuiLibdll name 'Delphi_ContainerUI_LineUp';
procedure Delphi_ContainerUI_LineDown; external DuiLibdll name 'Delphi_ContainerUI_LineDown';
procedure Delphi_ContainerUI_PageUp; external DuiLibdll name 'Delphi_ContainerUI_PageUp';
procedure Delphi_ContainerUI_PageDown; external DuiLibdll name 'Delphi_ContainerUI_PageDown';
procedure Delphi_ContainerUI_HomeUp; external DuiLibdll name 'Delphi_ContainerUI_HomeUp';
procedure Delphi_ContainerUI_EndDown; external DuiLibdll name 'Delphi_ContainerUI_EndDown';
procedure Delphi_ContainerUI_LineLeft; external DuiLibdll name 'Delphi_ContainerUI_LineLeft';
procedure Delphi_ContainerUI_LineRight; external DuiLibdll name 'Delphi_ContainerUI_LineRight';
procedure Delphi_ContainerUI_PageLeft; external DuiLibdll name 'Delphi_ContainerUI_PageLeft';
procedure Delphi_ContainerUI_PageRight; external DuiLibdll name 'Delphi_ContainerUI_PageRight';
procedure Delphi_ContainerUI_HomeLeft; external DuiLibdll name 'Delphi_ContainerUI_HomeLeft';
procedure Delphi_ContainerUI_EndRight; external DuiLibdll name 'Delphi_ContainerUI_EndRight';
procedure Delphi_ContainerUI_EnableScrollBar; external DuiLibdll name 'Delphi_ContainerUI_EnableScrollBar';
function Delphi_ContainerUI_GetVerticalScrollBar; external DuiLibdll name 'Delphi_ContainerUI_GetVerticalScrollBar';
function Delphi_ContainerUI_GetHorizontalScrollBar; external DuiLibdll name 'Delphi_ContainerUI_GetHorizontalScrollBar';

//================================CVerticalLayoutUI============================

function Delphi_VerticalLayoutUI_CppCreate; external DuiLibdll name 'Delphi_VerticalLayoutUI_CppCreate';
procedure Delphi_VerticalLayoutUI_CppDestroy; external DuiLibdll name 'Delphi_VerticalLayoutUI_CppDestroy';
function Delphi_VerticalLayoutUI_GetClass; external DuiLibdll name 'Delphi_VerticalLayoutUI_GetClass';
function Delphi_VerticalLayoutUI_GetInterface; external DuiLibdll name 'Delphi_VerticalLayoutUI_GetInterface';
function Delphi_VerticalLayoutUI_GetControlFlags; external DuiLibdll name 'Delphi_VerticalLayoutUI_GetControlFlags';
procedure Delphi_VerticalLayoutUI_SetSepHeight; external DuiLibdll name 'Delphi_VerticalLayoutUI_SetSepHeight';
function Delphi_VerticalLayoutUI_GetSepHeight; external DuiLibdll name 'Delphi_VerticalLayoutUI_GetSepHeight';
procedure Delphi_VerticalLayoutUI_SetSepImmMode; external DuiLibdll name 'Delphi_VerticalLayoutUI_SetSepImmMode';
function Delphi_VerticalLayoutUI_IsSepImmMode; external DuiLibdll name 'Delphi_VerticalLayoutUI_IsSepImmMode';
procedure Delphi_VerticalLayoutUI_SetAttribute; external DuiLibdll name 'Delphi_VerticalLayoutUI_SetAttribute';
procedure Delphi_VerticalLayoutUI_DoEvent; external DuiLibdll name 'Delphi_VerticalLayoutUI_DoEvent';
procedure Delphi_VerticalLayoutUI_SetPos; external DuiLibdll name 'Delphi_VerticalLayoutUI_SetPos';
procedure Delphi_VerticalLayoutUI_DoPostPaint; external DuiLibdll name 'Delphi_VerticalLayoutUI_DoPostPaint';
procedure Delphi_VerticalLayoutUI_GetThumbRect; external DuiLibdll name 'Delphi_VerticalLayoutUI_GetThumbRect';

//================================CListUI============================

function Delphi_ListUI_CppCreate; external DuiLibdll name 'Delphi_ListUI_CppCreate';
procedure Delphi_ListUI_CppDestroy; external DuiLibdll name 'Delphi_ListUI_CppDestroy';
function Delphi_ListUI_GetClass; external DuiLibdll name 'Delphi_ListUI_GetClass';
function Delphi_ListUI_GetControlFlags; external DuiLibdll name 'Delphi_ListUI_GetControlFlags';
function Delphi_ListUI_GetInterface; external DuiLibdll name 'Delphi_ListUI_GetInterface';
function Delphi_ListUI_GetScrollSelect; external DuiLibdll name 'Delphi_ListUI_GetScrollSelect';
procedure Delphi_ListUI_SetScrollSelect; external DuiLibdll name 'Delphi_ListUI_SetScrollSelect';
function Delphi_ListUI_GetCurSel; external DuiLibdll name 'Delphi_ListUI_GetCurSel';
function Delphi_ListUI_SelectItem; external DuiLibdll name 'Delphi_ListUI_SelectItem';
function Delphi_ListUI_GetHeader; external DuiLibdll name 'Delphi_ListUI_GetHeader';
function Delphi_ListUI_GetList; external DuiLibdll name 'Delphi_ListUI_GetList';
function Delphi_ListUI_GetListInfo; external DuiLibdll name 'Delphi_ListUI_GetListInfo';
function Delphi_ListUI_GetItemAt; external DuiLibdll name 'Delphi_ListUI_GetItemAt';
function Delphi_ListUI_GetItemIndex; external DuiLibdll name 'Delphi_ListUI_GetItemIndex';
function Delphi_ListUI_SetItemIndex; external DuiLibdll name 'Delphi_ListUI_SetItemIndex';
function Delphi_ListUI_GetCount; external DuiLibdll name 'Delphi_ListUI_GetCount';
function Delphi_ListUI_Add; external DuiLibdll name 'Delphi_ListUI_Add';
function Delphi_ListUI_AddAt; external DuiLibdll name 'Delphi_ListUI_AddAt';
function Delphi_ListUI_Remove; external DuiLibdll name 'Delphi_ListUI_Remove';
function Delphi_ListUI_RemoveAt; external DuiLibdll name 'Delphi_ListUI_RemoveAt';
procedure Delphi_ListUI_RemoveAll; external DuiLibdll name 'Delphi_ListUI_RemoveAll';
procedure Delphi_ListUI_EnsureVisible; external DuiLibdll name 'Delphi_ListUI_EnsureVisible';
procedure Delphi_ListUI_Scroll; external DuiLibdll name 'Delphi_ListUI_Scroll';
function Delphi_ListUI_GetChildPadding; external DuiLibdll name 'Delphi_ListUI_GetChildPadding';
procedure Delphi_ListUI_SetChildPadding; external DuiLibdll name 'Delphi_ListUI_SetChildPadding';
procedure Delphi_ListUI_SetItemFont; external DuiLibdll name 'Delphi_ListUI_SetItemFont';
procedure Delphi_ListUI_SetItemTextStyle; external DuiLibdll name 'Delphi_ListUI_SetItemTextStyle';
procedure Delphi_ListUI_SetItemTextPadding; external DuiLibdll name 'Delphi_ListUI_SetItemTextPadding';
procedure Delphi_ListUI_SetItemTextColor; external DuiLibdll name 'Delphi_ListUI_SetItemTextColor';
procedure Delphi_ListUI_SetItemBkColor; external DuiLibdll name 'Delphi_ListUI_SetItemBkColor';
procedure Delphi_ListUI_SetItemBkImage; external DuiLibdll name 'Delphi_ListUI_SetItemBkImage';
function Delphi_ListUI_IsAlternateBk; external DuiLibdll name 'Delphi_ListUI_IsAlternateBk';
procedure Delphi_ListUI_SetAlternateBk; external DuiLibdll name 'Delphi_ListUI_SetAlternateBk';
procedure Delphi_ListUI_SetSelectedItemTextColor; external DuiLibdll name 'Delphi_ListUI_SetSelectedItemTextColor';
procedure Delphi_ListUI_SetSelectedItemBkColor; external DuiLibdll name 'Delphi_ListUI_SetSelectedItemBkColor';
procedure Delphi_ListUI_SetSelectedItemImage; external DuiLibdll name 'Delphi_ListUI_SetSelectedItemImage';
procedure Delphi_ListUI_SetHotItemTextColor; external DuiLibdll name 'Delphi_ListUI_SetHotItemTextColor';
procedure Delphi_ListUI_SetHotItemBkColor; external DuiLibdll name 'Delphi_ListUI_SetHotItemBkColor';
procedure Delphi_ListUI_SetHotItemImage; external DuiLibdll name 'Delphi_ListUI_SetHotItemImage';
procedure Delphi_ListUI_SetDisabledItemTextColor; external DuiLibdll name 'Delphi_ListUI_SetDisabledItemTextColor';
procedure Delphi_ListUI_SetDisabledItemBkColor; external DuiLibdll name 'Delphi_ListUI_SetDisabledItemBkColor';
procedure Delphi_ListUI_SetDisabledItemImage; external DuiLibdll name 'Delphi_ListUI_SetDisabledItemImage';
procedure Delphi_ListUI_SetItemLineColor; external DuiLibdll name 'Delphi_ListUI_SetItemLineColor';
function Delphi_ListUI_IsItemShowHtml; external DuiLibdll name 'Delphi_ListUI_IsItemShowHtml';
procedure Delphi_ListUI_SetItemShowHtml; external DuiLibdll name 'Delphi_ListUI_SetItemShowHtml';
procedure Delphi_ListUI_GetItemTextPadding; external DuiLibdll name 'Delphi_ListUI_GetItemTextPadding';
function Delphi_ListUI_GetItemTextColor; external DuiLibdll name 'Delphi_ListUI_GetItemTextColor';
function Delphi_ListUI_GetItemBkColor; external DuiLibdll name 'Delphi_ListUI_GetItemBkColor';
function Delphi_ListUI_GetItemBkImage; external DuiLibdll name 'Delphi_ListUI_GetItemBkImage';
function Delphi_ListUI_GetSelectedItemTextColor; external DuiLibdll name 'Delphi_ListUI_GetSelectedItemTextColor';
function Delphi_ListUI_GetSelectedItemBkColor; external DuiLibdll name 'Delphi_ListUI_GetSelectedItemBkColor';
function Delphi_ListUI_GetSelectedItemImage; external DuiLibdll name 'Delphi_ListUI_GetSelectedItemImage';
function Delphi_ListUI_GetHotItemTextColor; external DuiLibdll name 'Delphi_ListUI_GetHotItemTextColor';
function Delphi_ListUI_GetHotItemBkColor; external DuiLibdll name 'Delphi_ListUI_GetHotItemBkColor';
function Delphi_ListUI_GetHotItemImage; external DuiLibdll name 'Delphi_ListUI_GetHotItemImage';
function Delphi_ListUI_GetDisabledItemTextColor; external DuiLibdll name 'Delphi_ListUI_GetDisabledItemTextColor';
function Delphi_ListUI_GetDisabledItemBkColor; external DuiLibdll name 'Delphi_ListUI_GetDisabledItemBkColor';
function Delphi_ListUI_GetDisabledItemImage; external DuiLibdll name 'Delphi_ListUI_GetDisabledItemImage';
function Delphi_ListUI_GetItemLineColor; external DuiLibdll name 'Delphi_ListUI_GetItemLineColor';
procedure Delphi_ListUI_SetMultiExpanding; external DuiLibdll name 'Delphi_ListUI_SetMultiExpanding';
function Delphi_ListUI_GetExpandedItem; external DuiLibdll name 'Delphi_ListUI_GetExpandedItem';
function Delphi_ListUI_ExpandItem; external DuiLibdll name 'Delphi_ListUI_ExpandItem';
procedure Delphi_ListUI_SetPos; external DuiLibdll name 'Delphi_ListUI_SetPos';
procedure Delphi_ListUI_Move; external DuiLibdll name 'Delphi_ListUI_Move';
procedure Delphi_ListUI_DoEvent; external DuiLibdll name 'Delphi_ListUI_DoEvent';
procedure Delphi_ListUI_SetAttribute; external DuiLibdll name 'Delphi_ListUI_SetAttribute';
function Delphi_ListUI_GetTextCallback; external DuiLibdll name 'Delphi_ListUI_GetTextCallback';
procedure Delphi_ListUI_SetTextCallback; external DuiLibdll name 'Delphi_ListUI_SetTextCallback';
procedure Delphi_ListUI_GetScrollPos; external DuiLibdll name 'Delphi_ListUI_GetScrollPos';
procedure Delphi_ListUI_GetScrollRange; external DuiLibdll name 'Delphi_ListUI_GetScrollRange';
procedure Delphi_ListUI_SetScrollPos; external DuiLibdll name 'Delphi_ListUI_SetScrollPos';
procedure Delphi_ListUI_LineUp; external DuiLibdll name 'Delphi_ListUI_LineUp';
procedure Delphi_ListUI_LineDown; external DuiLibdll name 'Delphi_ListUI_LineDown';
procedure Delphi_ListUI_PageUp; external DuiLibdll name 'Delphi_ListUI_PageUp';
procedure Delphi_ListUI_PageDown; external DuiLibdll name 'Delphi_ListUI_PageDown';
procedure Delphi_ListUI_HomeUp; external DuiLibdll name 'Delphi_ListUI_HomeUp';
procedure Delphi_ListUI_EndDown; external DuiLibdll name 'Delphi_ListUI_EndDown';
procedure Delphi_ListUI_LineLeft; external DuiLibdll name 'Delphi_ListUI_LineLeft';
procedure Delphi_ListUI_LineRight; external DuiLibdll name 'Delphi_ListUI_LineRight';
procedure Delphi_ListUI_PageLeft; external DuiLibdll name 'Delphi_ListUI_PageLeft';
procedure Delphi_ListUI_PageRight; external DuiLibdll name 'Delphi_ListUI_PageRight';
procedure Delphi_ListUI_HomeLeft; external DuiLibdll name 'Delphi_ListUI_HomeLeft';
procedure Delphi_ListUI_EndRight; external DuiLibdll name 'Delphi_ListUI_EndRight';
procedure Delphi_ListUI_EnableScrollBar; external DuiLibdll name 'Delphi_ListUI_EnableScrollBar';
function Delphi_ListUI_GetVerticalScrollBar; external DuiLibdll name 'Delphi_ListUI_GetVerticalScrollBar';
function Delphi_ListUI_GetHorizontalScrollBar; external DuiLibdll name 'Delphi_ListUI_GetHorizontalScrollBar';
function Delphi_ListUI_SortItems; external DuiLibdll name 'Delphi_ListUI_SortItems';

//================================CDelphi_ListUI============================

function Delphi_Delphi_ListUI_CppCreate; external DuiLibdll name 'Delphi_Delphi_ListUI_CppCreate';
procedure Delphi_Delphi_ListUI_CppDestroy; external DuiLibdll name 'Delphi_Delphi_ListUI_CppDestroy';
procedure Delphi_Delphi_ListUI_SetDelphiSelf; external DuiLibdll name 'Delphi_Delphi_ListUI_SetDelphiSelf';
procedure Delphi_Delphi_ListUI_SetDoEvent; external DuiLibdll name 'Delphi_Delphi_ListUI_SetDoEvent';

//================================CLabelUI============================

function Delphi_LabelUI_CppCreate; external DuiLibdll name 'Delphi_LabelUI_CppCreate';
procedure Delphi_LabelUI_CppDestroy; external DuiLibdll name 'Delphi_LabelUI_CppDestroy';
function Delphi_LabelUI_GetClass; external DuiLibdll name 'Delphi_LabelUI_GetClass';
procedure Delphi_LabelUI_SetText; external DuiLibdll name 'Delphi_LabelUI_SetText';
function Delphi_LabelUI_GetInterface; external DuiLibdll name 'Delphi_LabelUI_GetInterface';
procedure Delphi_LabelUI_SetTextStyle; external DuiLibdll name 'Delphi_LabelUI_SetTextStyle';
function Delphi_LabelUI_GetTextStyle; external DuiLibdll name 'Delphi_LabelUI_GetTextStyle';
procedure Delphi_LabelUI_SetTextColor; external DuiLibdll name 'Delphi_LabelUI_SetTextColor';
function Delphi_LabelUI_GetTextColor; external DuiLibdll name 'Delphi_LabelUI_GetTextColor';
procedure Delphi_LabelUI_SetDisabledTextColor; external DuiLibdll name 'Delphi_LabelUI_SetDisabledTextColor';
function Delphi_LabelUI_GetDisabledTextColor; external DuiLibdll name 'Delphi_LabelUI_GetDisabledTextColor';
procedure Delphi_LabelUI_SetFont; external DuiLibdll name 'Delphi_LabelUI_SetFont';
function Delphi_LabelUI_GetFont; external DuiLibdll name 'Delphi_LabelUI_GetFont';
procedure Delphi_LabelUI_GetTextPadding; external DuiLibdll name 'Delphi_LabelUI_GetTextPadding';
procedure Delphi_LabelUI_SetTextPadding; external DuiLibdll name 'Delphi_LabelUI_SetTextPadding';
function Delphi_LabelUI_IsShowHtml; external DuiLibdll name 'Delphi_LabelUI_IsShowHtml';
procedure Delphi_LabelUI_SetShowHtml; external DuiLibdll name 'Delphi_LabelUI_SetShowHtml';
procedure Delphi_LabelUI_EstimateSize; external DuiLibdll name 'Delphi_LabelUI_EstimateSize';
procedure Delphi_LabelUI_DoEvent; external DuiLibdll name 'Delphi_LabelUI_DoEvent';
procedure Delphi_LabelUI_SetAttribute; external DuiLibdll name 'Delphi_LabelUI_SetAttribute';
procedure Delphi_LabelUI_PaintText; external DuiLibdll name 'Delphi_LabelUI_PaintText';
procedure Delphi_LabelUI_SetEnabledEffect; external DuiLibdll name 'Delphi_LabelUI_SetEnabledEffect';
function Delphi_LabelUI_GetEnabledEffect; external DuiLibdll name 'Delphi_LabelUI_GetEnabledEffect';
procedure Delphi_LabelUI_SetEnabledLuminous; external DuiLibdll name 'Delphi_LabelUI_SetEnabledLuminous';
function Delphi_LabelUI_GetEnabledLuminous; external DuiLibdll name 'Delphi_LabelUI_GetEnabledLuminous';
procedure Delphi_LabelUI_SetLuminousFuzzy; external DuiLibdll name 'Delphi_LabelUI_SetLuminousFuzzy';
function Delphi_LabelUI_GetLuminousFuzzy; external DuiLibdll name 'Delphi_LabelUI_GetLuminousFuzzy';
procedure Delphi_LabelUI_SetGradientLength; external DuiLibdll name 'Delphi_LabelUI_SetGradientLength';
function Delphi_LabelUI_GetGradientLength; external DuiLibdll name 'Delphi_LabelUI_GetGradientLength';
procedure Delphi_LabelUI_SetShadowOffset; external DuiLibdll name 'Delphi_LabelUI_SetShadowOffset';
procedure Delphi_LabelUI_GetShadowOffset; external DuiLibdll name 'Delphi_LabelUI_GetShadowOffset';
procedure Delphi_LabelUI_SetTextColor1; external DuiLibdll name 'Delphi_LabelUI_SetTextColor1';
function Delphi_LabelUI_GetTextColor1; external DuiLibdll name 'Delphi_LabelUI_GetTextColor1';
procedure Delphi_LabelUI_SetTextShadowColorA; external DuiLibdll name 'Delphi_LabelUI_SetTextShadowColorA';
function Delphi_LabelUI_GetTextShadowColorA; external DuiLibdll name 'Delphi_LabelUI_GetTextShadowColorA';
procedure Delphi_LabelUI_SetTextShadowColorB; external DuiLibdll name 'Delphi_LabelUI_SetTextShadowColorB';
function Delphi_LabelUI_GetTextShadowColorB; external DuiLibdll name 'Delphi_LabelUI_GetTextShadowColorB';
procedure Delphi_LabelUI_SetStrokeColor; external DuiLibdll name 'Delphi_LabelUI_SetStrokeColor';
function Delphi_LabelUI_GetStrokeColor; external DuiLibdll name 'Delphi_LabelUI_GetStrokeColor';
procedure Delphi_LabelUI_SetGradientAngle; external DuiLibdll name 'Delphi_LabelUI_SetGradientAngle';
function Delphi_LabelUI_GetGradientAngle; external DuiLibdll name 'Delphi_LabelUI_GetGradientAngle';
procedure Delphi_LabelUI_SetEnabledStroke; external DuiLibdll name 'Delphi_LabelUI_SetEnabledStroke';
function Delphi_LabelUI_GetEnabledStroke; external DuiLibdll name 'Delphi_LabelUI_GetEnabledStroke';
procedure Delphi_LabelUI_SetEnabledShadow; external DuiLibdll name 'Delphi_LabelUI_SetEnabledShadow';
function Delphi_LabelUI_GetEnabledShadow; external DuiLibdll name 'Delphi_LabelUI_GetEnabledShadow';

//================================CButtonUI============================

function Delphi_ButtonUI_CppCreate; external DuiLibdll name 'Delphi_ButtonUI_CppCreate';
procedure Delphi_ButtonUI_CppDestroy; external DuiLibdll name 'Delphi_ButtonUI_CppDestroy';
function Delphi_ButtonUI_GetClass; external DuiLibdll name 'Delphi_ButtonUI_GetClass';
function Delphi_ButtonUI_GetInterface; external DuiLibdll name 'Delphi_ButtonUI_GetInterface';
function Delphi_ButtonUI_GetControlFlags; external DuiLibdll name 'Delphi_ButtonUI_GetControlFlags';
function Delphi_ButtonUI_Activate; external DuiLibdll name 'Delphi_ButtonUI_Activate';
procedure Delphi_ButtonUI_SetEnabled; external DuiLibdll name 'Delphi_ButtonUI_SetEnabled';
procedure Delphi_ButtonUI_DoEvent; external DuiLibdll name 'Delphi_ButtonUI_DoEvent';
function Delphi_ButtonUI_GetNormalImage; external DuiLibdll name 'Delphi_ButtonUI_GetNormalImage';
procedure Delphi_ButtonUI_SetNormalImage; external DuiLibdll name 'Delphi_ButtonUI_SetNormalImage';
function Delphi_ButtonUI_GetHotImage; external DuiLibdll name 'Delphi_ButtonUI_GetHotImage';
procedure Delphi_ButtonUI_SetHotImage; external DuiLibdll name 'Delphi_ButtonUI_SetHotImage';
function Delphi_ButtonUI_GetPushedImage; external DuiLibdll name 'Delphi_ButtonUI_GetPushedImage';
procedure Delphi_ButtonUI_SetPushedImage; external DuiLibdll name 'Delphi_ButtonUI_SetPushedImage';
function Delphi_ButtonUI_GetFocusedImage; external DuiLibdll name 'Delphi_ButtonUI_GetFocusedImage';
procedure Delphi_ButtonUI_SetFocusedImage; external DuiLibdll name 'Delphi_ButtonUI_SetFocusedImage';
function Delphi_ButtonUI_GetDisabledImage; external DuiLibdll name 'Delphi_ButtonUI_GetDisabledImage';
procedure Delphi_ButtonUI_SetDisabledImage; external DuiLibdll name 'Delphi_ButtonUI_SetDisabledImage';
function Delphi_ButtonUI_GetForeImage; external DuiLibdll name 'Delphi_ButtonUI_GetForeImage';
procedure Delphi_ButtonUI_SetForeImage; external DuiLibdll name 'Delphi_ButtonUI_SetForeImage';
function Delphi_ButtonUI_GetHotForeImage; external DuiLibdll name 'Delphi_ButtonUI_GetHotForeImage';
procedure Delphi_ButtonUI_SetHotForeImage; external DuiLibdll name 'Delphi_ButtonUI_SetHotForeImage';
procedure Delphi_ButtonUI_SetHotBkColor; external DuiLibdll name 'Delphi_ButtonUI_SetHotBkColor';
function Delphi_ButtonUI_GetHotBkColor; external DuiLibdll name 'Delphi_ButtonUI_GetHotBkColor';
procedure Delphi_ButtonUI_SetHotTextColor; external DuiLibdll name 'Delphi_ButtonUI_SetHotTextColor';
function Delphi_ButtonUI_GetHotTextColor; external DuiLibdll name 'Delphi_ButtonUI_GetHotTextColor';
procedure Delphi_ButtonUI_SetPushedTextColor; external DuiLibdll name 'Delphi_ButtonUI_SetPushedTextColor';
function Delphi_ButtonUI_GetPushedTextColor; external DuiLibdll name 'Delphi_ButtonUI_GetPushedTextColor';
procedure Delphi_ButtonUI_SetFocusedTextColor; external DuiLibdll name 'Delphi_ButtonUI_SetFocusedTextColor';
function Delphi_ButtonUI_GetFocusedTextColor; external DuiLibdll name 'Delphi_ButtonUI_GetFocusedTextColor';
procedure Delphi_ButtonUI_EstimateSize; external DuiLibdll name 'Delphi_ButtonUI_EstimateSize';
procedure Delphi_ButtonUI_SetAttribute; external DuiLibdll name 'Delphi_ButtonUI_SetAttribute';
procedure Delphi_ButtonUI_PaintText; external DuiLibdll name 'Delphi_ButtonUI_PaintText';
procedure Delphi_ButtonUI_PaintStatusImage; external DuiLibdll name 'Delphi_ButtonUI_PaintStatusImage';

procedure Delphi_ButtonUI_SetFiveStatusImage; external DuiLibdll name 'Delphi_ButtonUI_SetFiveStatusImage';
procedure Delphi_ButtonUI_SetFadeAlphaDelta; external DuiLibdll name 'Delphi_ButtonUI_SetFadeAlphaDelta';
function Delphi_ButtonUI_GetFadeAlphaDelta; external DuiLibdll name 'Delphi_ButtonUI_GetFadeAlphaDelta';

//================================COptionUI============================

function Delphi_OptionUI_CppCreate; external DuiLibdll name 'Delphi_OptionUI_CppCreate';
procedure Delphi_OptionUI_CppDestroy; external DuiLibdll name 'Delphi_OptionUI_CppDestroy';
function Delphi_OptionUI_GetClass; external DuiLibdll name 'Delphi_OptionUI_GetClass';
function Delphi_OptionUI_GetInterface; external DuiLibdll name 'Delphi_OptionUI_GetInterface';
procedure Delphi_OptionUI_SetManager; external DuiLibdll name 'Delphi_OptionUI_SetManager';
function Delphi_OptionUI_Activate; external DuiLibdll name 'Delphi_OptionUI_Activate';
procedure Delphi_OptionUI_SetEnabled; external DuiLibdll name 'Delphi_OptionUI_SetEnabled';
function Delphi_OptionUI_GetSelectedImage; external DuiLibdll name 'Delphi_OptionUI_GetSelectedImage';
procedure Delphi_OptionUI_SetSelectedImage; external DuiLibdll name 'Delphi_OptionUI_SetSelectedImage';
function Delphi_OptionUI_GetSelectedHotImage; external DuiLibdll name 'Delphi_OptionUI_GetSelectedHotImage';
procedure Delphi_OptionUI_SetSelectedHotImage; external DuiLibdll name 'Delphi_OptionUI_SetSelectedHotImage';
procedure Delphi_OptionUI_SetSelectedTextColor; external DuiLibdll name 'Delphi_OptionUI_SetSelectedTextColor';
function Delphi_OptionUI_GetSelectedTextColor; external DuiLibdll name 'Delphi_OptionUI_GetSelectedTextColor';
procedure Delphi_OptionUI_SetSelectedBkColor; external DuiLibdll name 'Delphi_OptionUI_SetSelectedBkColor';
function Delphi_OptionUI_GetSelectBkColor; external DuiLibdll name 'Delphi_OptionUI_GetSelectBkColor';
function Delphi_OptionUI_GetForeImage; external DuiLibdll name 'Delphi_OptionUI_GetForeImage';
procedure Delphi_OptionUI_SetForeImage; external DuiLibdll name 'Delphi_OptionUI_SetForeImage';
function Delphi_OptionUI_GetGroup; external DuiLibdll name 'Delphi_OptionUI_GetGroup';
procedure Delphi_OptionUI_SetGroup; external DuiLibdll name 'Delphi_OptionUI_SetGroup';
function Delphi_OptionUI_IsSelected; external DuiLibdll name 'Delphi_OptionUI_IsSelected';
procedure Delphi_OptionUI_Selected; external DuiLibdll name 'Delphi_OptionUI_Selected';
procedure Delphi_OptionUI_EstimateSize; external DuiLibdll name 'Delphi_OptionUI_EstimateSize';
procedure Delphi_OptionUI_SetAttribute; external DuiLibdll name 'Delphi_OptionUI_SetAttribute';
procedure Delphi_OptionUI_PaintStatusImage; external DuiLibdll name 'Delphi_OptionUI_PaintStatusImage';
procedure Delphi_OptionUI_PaintText; external DuiLibdll name 'Delphi_OptionUI_PaintText';

//================================CCheckBoxUI============================

function Delphi_CheckBoxUI_CppCreate; external DuiLibdll name 'Delphi_CheckBoxUI_CppCreate';
procedure Delphi_CheckBoxUI_CppDestroy; external DuiLibdll name 'Delphi_CheckBoxUI_CppDestroy';
function Delphi_CheckBoxUI_GetClass; external DuiLibdll name 'Delphi_CheckBoxUI_GetClass';
function Delphi_CheckBoxUI_GetInterface; external DuiLibdll name 'Delphi_CheckBoxUI_GetInterface';
procedure Delphi_CheckBoxUI_SetCheck; external DuiLibdll name 'Delphi_CheckBoxUI_SetCheck';
function Delphi_CheckBoxUI_GetCheck; external DuiLibdll name 'Delphi_CheckBoxUI_GetCheck';

//================================CListContainerElementUI============================

function Delphi_ListContainerElementUI_CppCreate; external DuiLibdll name 'Delphi_ListContainerElementUI_CppCreate';
procedure Delphi_ListContainerElementUI_CppDestroy; external DuiLibdll name 'Delphi_ListContainerElementUI_CppDestroy';
function Delphi_ListContainerElementUI_GetClass; external DuiLibdll name 'Delphi_ListContainerElementUI_GetClass';
function Delphi_ListContainerElementUI_GetControlFlags; external DuiLibdll name 'Delphi_ListContainerElementUI_GetControlFlags';
function Delphi_ListContainerElementUI_GetInterface; external DuiLibdll name 'Delphi_ListContainerElementUI_GetInterface';
function Delphi_ListContainerElementUI_GetIndex; external DuiLibdll name 'Delphi_ListContainerElementUI_GetIndex';
procedure Delphi_ListContainerElementUI_SetIndex; external DuiLibdll name 'Delphi_ListContainerElementUI_SetIndex';
function Delphi_ListContainerElementUI_GetOwner; external DuiLibdll name 'Delphi_ListContainerElementUI_GetOwner';
procedure Delphi_ListContainerElementUI_SetOwner; external DuiLibdll name 'Delphi_ListContainerElementUI_SetOwner';
procedure Delphi_ListContainerElementUI_SetVisible; external DuiLibdll name 'Delphi_ListContainerElementUI_SetVisible';
procedure Delphi_ListContainerElementUI_SetEnabled; external DuiLibdll name 'Delphi_ListContainerElementUI_SetEnabled';
function Delphi_ListContainerElementUI_IsSelected; external DuiLibdll name 'Delphi_ListContainerElementUI_IsSelected';
function Delphi_ListContainerElementUI_Select; external DuiLibdll name 'Delphi_ListContainerElementUI_Select';
function Delphi_ListContainerElementUI_IsExpanded; external DuiLibdll name 'Delphi_ListContainerElementUI_IsExpanded';
function Delphi_ListContainerElementUI_Expand; external DuiLibdll name 'Delphi_ListContainerElementUI_Expand';
procedure Delphi_ListContainerElementUI_Invalidate; external DuiLibdll name 'Delphi_ListContainerElementUI_Invalidate';
function Delphi_ListContainerElementUI_Activate; external DuiLibdll name 'Delphi_ListContainerElementUI_Activate';
procedure Delphi_ListContainerElementUI_DoEvent; external DuiLibdll name 'Delphi_ListContainerElementUI_DoEvent';
procedure Delphi_ListContainerElementUI_SetAttribute; external DuiLibdll name 'Delphi_ListContainerElementUI_SetAttribute';
procedure Delphi_ListContainerElementUI_DoPaint; external DuiLibdll name 'Delphi_ListContainerElementUI_DoPaint';
procedure Delphi_ListContainerElementUI_DrawItemText; external DuiLibdll name 'Delphi_ListContainerElementUI_DrawItemText';
procedure Delphi_ListContainerElementUI_DrawItemBk; external DuiLibdll name 'Delphi_ListContainerElementUI_DrawItemBk';

//================================CComboUI============================

function Delphi_ComboUI_CppCreate; external DuiLibdll name 'Delphi_ComboUI_CppCreate';
procedure Delphi_ComboUI_CppDestroy; external DuiLibdll name 'Delphi_ComboUI_CppDestroy';
function Delphi_ComboUI_GetClass; external DuiLibdll name 'Delphi_ComboUI_GetClass';
function Delphi_ComboUI_GetInterface; external DuiLibdll name 'Delphi_ComboUI_GetInterface';
procedure Delphi_ComboUI_DoInit; external DuiLibdll name 'Delphi_ComboUI_DoInit';
function Delphi_ComboUI_GetControlFlags; external DuiLibdll name 'Delphi_ComboUI_GetControlFlags';
function Delphi_ComboUI_GetText; external DuiLibdll name 'Delphi_ComboUI_GetText';
procedure Delphi_ComboUI_SetEnabled; external DuiLibdll name 'Delphi_ComboUI_SetEnabled';
function Delphi_ComboUI_GetDropBoxAttributeList; external DuiLibdll name 'Delphi_ComboUI_GetDropBoxAttributeList';
procedure Delphi_ComboUI_SetDropBoxAttributeList; external DuiLibdll name 'Delphi_ComboUI_SetDropBoxAttributeList';
procedure Delphi_ComboUI_GetDropBoxSize; external DuiLibdll name 'Delphi_ComboUI_GetDropBoxSize';
procedure Delphi_ComboUI_SetDropBoxSize; external DuiLibdll name 'Delphi_ComboUI_SetDropBoxSize';
function Delphi_ComboUI_GetCurSel; external DuiLibdll name 'Delphi_ComboUI_GetCurSel';
function Delphi_ComboUI_GetSelectCloseFlag; external DuiLibdll name 'Delphi_ComboUI_GetSelectCloseFlag';
procedure Delphi_ComboUI_SetSelectCloseFlag; external DuiLibdll name 'Delphi_ComboUI_SetSelectCloseFlag';
function Delphi_ComboUI_SelectItem; external DuiLibdll name 'Delphi_ComboUI_SelectItem';
function Delphi_ComboUI_SetItemIndex; external DuiLibdll name 'Delphi_ComboUI_SetItemIndex';
function Delphi_ComboUI_Add; external DuiLibdll name 'Delphi_ComboUI_Add';
function Delphi_ComboUI_AddAt; external DuiLibdll name 'Delphi_ComboUI_AddAt';
function Delphi_ComboUI_Remove; external DuiLibdll name 'Delphi_ComboUI_Remove';
function Delphi_ComboUI_RemoveAt; external DuiLibdll name 'Delphi_ComboUI_RemoveAt';
procedure Delphi_ComboUI_RemoveAll; external DuiLibdll name 'Delphi_ComboUI_RemoveAll';
function Delphi_ComboUI_Activate; external DuiLibdll name 'Delphi_ComboUI_Activate';
function Delphi_ComboUI_GetShowText; external DuiLibdll name 'Delphi_ComboUI_GetShowText';
procedure Delphi_ComboUI_SetShowText; external DuiLibdll name 'Delphi_ComboUI_SetShowText';
procedure Delphi_ComboUI_GetTextPadding; external DuiLibdll name 'Delphi_ComboUI_GetTextPadding';
procedure Delphi_ComboUI_SetTextPadding; external DuiLibdll name 'Delphi_ComboUI_SetTextPadding';
function Delphi_ComboUI_GetNormalImage; external DuiLibdll name 'Delphi_ComboUI_GetNormalImage';
procedure Delphi_ComboUI_SetNormalImage; external DuiLibdll name 'Delphi_ComboUI_SetNormalImage';
function Delphi_ComboUI_GetHotImage; external DuiLibdll name 'Delphi_ComboUI_GetHotImage';
procedure Delphi_ComboUI_SetHotImage; external DuiLibdll name 'Delphi_ComboUI_SetHotImage';
function Delphi_ComboUI_GetPushedImage; external DuiLibdll name 'Delphi_ComboUI_GetPushedImage';
procedure Delphi_ComboUI_SetPushedImage; external DuiLibdll name 'Delphi_ComboUI_SetPushedImage';
function Delphi_ComboUI_GetFocusedImage; external DuiLibdll name 'Delphi_ComboUI_GetFocusedImage';
procedure Delphi_ComboUI_SetFocusedImage; external DuiLibdll name 'Delphi_ComboUI_SetFocusedImage';
function Delphi_ComboUI_GetDisabledImage; external DuiLibdll name 'Delphi_ComboUI_GetDisabledImage';
procedure Delphi_ComboUI_SetDisabledImage; external DuiLibdll name 'Delphi_ComboUI_SetDisabledImage';
function Delphi_ComboUI_GetListInfo; external DuiLibdll name 'Delphi_ComboUI_GetListInfo';
procedure Delphi_ComboUI_SetItemFont; external DuiLibdll name 'Delphi_ComboUI_SetItemFont';
procedure Delphi_ComboUI_SetItemTextStyle; external DuiLibdll name 'Delphi_ComboUI_SetItemTextStyle';
procedure Delphi_ComboUI_GetItemTextPadding; external DuiLibdll name 'Delphi_ComboUI_GetItemTextPadding';
procedure Delphi_ComboUI_SetItemTextPadding; external DuiLibdll name 'Delphi_ComboUI_SetItemTextPadding';
function Delphi_ComboUI_GetItemTextColor; external DuiLibdll name 'Delphi_ComboUI_GetItemTextColor';
procedure Delphi_ComboUI_SetItemTextColor; external DuiLibdll name 'Delphi_ComboUI_SetItemTextColor';
function Delphi_ComboUI_GetItemBkColor; external DuiLibdll name 'Delphi_ComboUI_GetItemBkColor';
procedure Delphi_ComboUI_SetItemBkColor; external DuiLibdll name 'Delphi_ComboUI_SetItemBkColor';
function Delphi_ComboUI_GetItemBkImage; external DuiLibdll name 'Delphi_ComboUI_GetItemBkImage';
procedure Delphi_ComboUI_SetItemBkImage; external DuiLibdll name 'Delphi_ComboUI_SetItemBkImage';
function Delphi_ComboUI_IsAlternateBk; external DuiLibdll name 'Delphi_ComboUI_IsAlternateBk';
procedure Delphi_ComboUI_SetAlternateBk; external DuiLibdll name 'Delphi_ComboUI_SetAlternateBk';
function Delphi_ComboUI_GetSelectedItemTextColor; external DuiLibdll name 'Delphi_ComboUI_GetSelectedItemTextColor';
procedure Delphi_ComboUI_SetSelectedItemTextColor; external DuiLibdll name 'Delphi_ComboUI_SetSelectedItemTextColor';
function Delphi_ComboUI_GetSelectedItemBkColor; external DuiLibdll name 'Delphi_ComboUI_GetSelectedItemBkColor';
procedure Delphi_ComboUI_SetSelectedItemBkColor; external DuiLibdll name 'Delphi_ComboUI_SetSelectedItemBkColor';
function Delphi_ComboUI_GetSelectedItemImage; external DuiLibdll name 'Delphi_ComboUI_GetSelectedItemImage';
procedure Delphi_ComboUI_SetSelectedItemImage; external DuiLibdll name 'Delphi_ComboUI_SetSelectedItemImage';
function Delphi_ComboUI_GetHotItemTextColor; external DuiLibdll name 'Delphi_ComboUI_GetHotItemTextColor';
procedure Delphi_ComboUI_SetHotItemTextColor; external DuiLibdll name 'Delphi_ComboUI_SetHotItemTextColor';
function Delphi_ComboUI_GetHotItemBkColor; external DuiLibdll name 'Delphi_ComboUI_GetHotItemBkColor';
procedure Delphi_ComboUI_SetHotItemBkColor; external DuiLibdll name 'Delphi_ComboUI_SetHotItemBkColor';
function Delphi_ComboUI_GetHotItemImage; external DuiLibdll name 'Delphi_ComboUI_GetHotItemImage';
procedure Delphi_ComboUI_SetHotItemImage; external DuiLibdll name 'Delphi_ComboUI_SetHotItemImage';
function Delphi_ComboUI_GetDisabledItemTextColor; external DuiLibdll name 'Delphi_ComboUI_GetDisabledItemTextColor';
procedure Delphi_ComboUI_SetDisabledItemTextColor; external DuiLibdll name 'Delphi_ComboUI_SetDisabledItemTextColor';
function Delphi_ComboUI_GetDisabledItemBkColor; external DuiLibdll name 'Delphi_ComboUI_GetDisabledItemBkColor';
procedure Delphi_ComboUI_SetDisabledItemBkColor; external DuiLibdll name 'Delphi_ComboUI_SetDisabledItemBkColor';
function Delphi_ComboUI_GetDisabledItemImage; external DuiLibdll name 'Delphi_ComboUI_GetDisabledItemImage';
procedure Delphi_ComboUI_SetDisabledItemImage; external DuiLibdll name 'Delphi_ComboUI_SetDisabledItemImage';
function Delphi_ComboUI_GetItemLineColor; external DuiLibdll name 'Delphi_ComboUI_GetItemLineColor';
procedure Delphi_ComboUI_SetItemLineColor; external DuiLibdll name 'Delphi_ComboUI_SetItemLineColor';
function Delphi_ComboUI_IsItemShowHtml; external DuiLibdll name 'Delphi_ComboUI_IsItemShowHtml';
procedure Delphi_ComboUI_SetItemShowHtml; external DuiLibdll name 'Delphi_ComboUI_SetItemShowHtml';
procedure Delphi_ComboUI_EstimateSize; external DuiLibdll name 'Delphi_ComboUI_EstimateSize';
procedure Delphi_ComboUI_SetPos; external DuiLibdll name 'Delphi_ComboUI_SetPos';
procedure Delphi_ComboUI_Move; external DuiLibdll name 'Delphi_ComboUI_Move';
procedure Delphi_ComboUI_DoEvent; external DuiLibdll name 'Delphi_ComboUI_DoEvent';
procedure Delphi_ComboUI_SetAttribute; external DuiLibdll name 'Delphi_ComboUI_SetAttribute';
procedure Delphi_ComboUI_DoPaint; external DuiLibdll name 'Delphi_ComboUI_DoPaint';
procedure Delphi_ComboUI_PaintText; external DuiLibdll name 'Delphi_ComboUI_PaintText';
procedure Delphi_ComboUI_PaintStatusImage; external DuiLibdll name 'Delphi_ComboUI_PaintStatusImage';

//================================CDateTimeUI============================

function Delphi_DateTimeUI_CppCreate; external DuiLibdll name 'Delphi_DateTimeUI_CppCreate';
procedure Delphi_DateTimeUI_CppDestroy; external DuiLibdll name 'Delphi_DateTimeUI_CppDestroy';
function Delphi_DateTimeUI_GetClass; external DuiLibdll name 'Delphi_DateTimeUI_GetClass';
function Delphi_DateTimeUI_GetInterface; external DuiLibdll name 'Delphi_DateTimeUI_GetInterface';
function Delphi_DateTimeUI_GetControlFlags; external DuiLibdll name 'Delphi_DateTimeUI_GetControlFlags';
function Delphi_DateTimeUI_GetNativeWindow; external DuiLibdll name 'Delphi_DateTimeUI_GetNativeWindow';
function Delphi_DateTimeUI_GetTime; external DuiLibdll name 'Delphi_DateTimeUI_GetTime';
procedure Delphi_DateTimeUI_SetTime; external DuiLibdll name 'Delphi_DateTimeUI_SetTime';
procedure Delphi_DateTimeUI_SetReadOnly; external DuiLibdll name 'Delphi_DateTimeUI_SetReadOnly';
function Delphi_DateTimeUI_IsReadOnly; external DuiLibdll name 'Delphi_DateTimeUI_IsReadOnly';
procedure Delphi_DateTimeUI_UpdateText; external DuiLibdll name 'Delphi_DateTimeUI_UpdateText';
procedure Delphi_DateTimeUI_DoEvent; external DuiLibdll name 'Delphi_DateTimeUI_DoEvent';

//================================CEditUI============================

function Delphi_EditUI_CppCreate; external DuiLibdll name 'Delphi_EditUI_CppCreate';
procedure Delphi_EditUI_CppDestroy; external DuiLibdll name 'Delphi_EditUI_CppDestroy';
function Delphi_EditUI_GetClass; external DuiLibdll name 'Delphi_EditUI_GetClass';
function Delphi_EditUI_GetInterface; external DuiLibdll name 'Delphi_EditUI_GetInterface';
function Delphi_EditUI_GetControlFlags; external DuiLibdll name 'Delphi_EditUI_GetControlFlags';
function Delphi_EditUI_GetNativeWindow; external DuiLibdll name 'Delphi_EditUI_GetNativeWindow';
procedure Delphi_EditUI_SetEnabled; external DuiLibdll name 'Delphi_EditUI_SetEnabled';
procedure Delphi_EditUI_SetText; external DuiLibdll name 'Delphi_EditUI_SetText';
procedure Delphi_EditUI_SetMaxChar; external DuiLibdll name 'Delphi_EditUI_SetMaxChar';
function Delphi_EditUI_GetMaxChar; external DuiLibdll name 'Delphi_EditUI_GetMaxChar';
procedure Delphi_EditUI_SetReadOnly; external DuiLibdll name 'Delphi_EditUI_SetReadOnly';
function Delphi_EditUI_IsReadOnly; external DuiLibdll name 'Delphi_EditUI_IsReadOnly';
procedure Delphi_EditUI_SetPasswordMode; external DuiLibdll name 'Delphi_EditUI_SetPasswordMode';
function Delphi_EditUI_IsPasswordMode; external DuiLibdll name 'Delphi_EditUI_IsPasswordMode';
procedure Delphi_EditUI_SetPasswordChar; external DuiLibdll name 'Delphi_EditUI_SetPasswordChar';
function Delphi_EditUI_GetPasswordChar; external DuiLibdll name 'Delphi_EditUI_GetPasswordChar';
procedure Delphi_EditUI_SetNumberOnly; external DuiLibdll name 'Delphi_EditUI_SetNumberOnly';
function Delphi_EditUI_IsNumberOnly; external DuiLibdll name 'Delphi_EditUI_IsNumberOnly';
function Delphi_EditUI_GetWindowStyls; external DuiLibdll name 'Delphi_EditUI_GetWindowStyls';
function Delphi_EditUI_GetNativeEditHWND; external DuiLibdll name 'Delphi_EditUI_GetNativeEditHWND';
function Delphi_EditUI_GetNormalImage; external DuiLibdll name 'Delphi_EditUI_GetNormalImage';
procedure Delphi_EditUI_SetNormalImage; external DuiLibdll name 'Delphi_EditUI_SetNormalImage';
function Delphi_EditUI_GetHotImage; external DuiLibdll name 'Delphi_EditUI_GetHotImage';
procedure Delphi_EditUI_SetHotImage; external DuiLibdll name 'Delphi_EditUI_SetHotImage';
function Delphi_EditUI_GetFocusedImage; external DuiLibdll name 'Delphi_EditUI_GetFocusedImage';
procedure Delphi_EditUI_SetFocusedImage; external DuiLibdll name 'Delphi_EditUI_SetFocusedImage';
function Delphi_EditUI_GetDisabledImage; external DuiLibdll name 'Delphi_EditUI_GetDisabledImage';
procedure Delphi_EditUI_SetDisabledImage; external DuiLibdll name 'Delphi_EditUI_SetDisabledImage';
procedure Delphi_EditUI_SetNativeEditBkColor; external DuiLibdll name 'Delphi_EditUI_SetNativeEditBkColor';
function Delphi_EditUI_GetNativeEditBkColor; external DuiLibdll name 'Delphi_EditUI_GetNativeEditBkColor';
procedure Delphi_EditUI_SetSel; external DuiLibdll name 'Delphi_EditUI_SetSel';
procedure Delphi_EditUI_SetSelAll; external DuiLibdll name 'Delphi_EditUI_SetSelAll';
procedure Delphi_EditUI_SetReplaceSel; external DuiLibdll name 'Delphi_EditUI_SetReplaceSel';
procedure Delphi_EditUI_SetPos; external DuiLibdll name 'Delphi_EditUI_SetPos';
procedure Delphi_EditUI_Move; external DuiLibdll name 'Delphi_EditUI_Move';
procedure Delphi_EditUI_SetVisible; external DuiLibdll name 'Delphi_EditUI_SetVisible';
procedure Delphi_EditUI_SetInternVisible; external DuiLibdll name 'Delphi_EditUI_SetInternVisible';
procedure Delphi_EditUI_EstimateSize; external DuiLibdll name 'Delphi_EditUI_EstimateSize';
procedure Delphi_EditUI_DoEvent; external DuiLibdll name 'Delphi_EditUI_DoEvent';
procedure Delphi_EditUI_SetAttribute; external DuiLibdll name 'Delphi_EditUI_SetAttribute';
procedure Delphi_EditUI_PaintStatusImage; external DuiLibdll name 'Delphi_EditUI_PaintStatusImage';
procedure Delphi_EditUI_PaintText; external DuiLibdll name 'Delphi_EditUI_PaintText';

//================================CProgressUI============================

function Delphi_ProgressUI_CppCreate; external DuiLibdll name 'Delphi_ProgressUI_CppCreate';
procedure Delphi_ProgressUI_CppDestroy; external DuiLibdll name 'Delphi_ProgressUI_CppDestroy';
function Delphi_ProgressUI_GetClass; external DuiLibdll name 'Delphi_ProgressUI_GetClass';
function Delphi_ProgressUI_GetInterface; external DuiLibdll name 'Delphi_ProgressUI_GetInterface';
function Delphi_ProgressUI_IsHorizontal; external DuiLibdll name 'Delphi_ProgressUI_IsHorizontal';
procedure Delphi_ProgressUI_SetHorizontal; external DuiLibdll name 'Delphi_ProgressUI_SetHorizontal';
function Delphi_ProgressUI_IsStretchForeImage; external DuiLibdll name 'Delphi_ProgressUI_IsStretchForeImage';
procedure Delphi_ProgressUI_SetStretchForeImage; external DuiLibdll name 'Delphi_ProgressUI_SetStretchForeImage';
function Delphi_ProgressUI_GetMinValue; external DuiLibdll name 'Delphi_ProgressUI_GetMinValue';
procedure Delphi_ProgressUI_SetMinValue; external DuiLibdll name 'Delphi_ProgressUI_SetMinValue';
function Delphi_ProgressUI_GetMaxValue; external DuiLibdll name 'Delphi_ProgressUI_GetMaxValue';
procedure Delphi_ProgressUI_SetMaxValue; external DuiLibdll name 'Delphi_ProgressUI_SetMaxValue';
function Delphi_ProgressUI_GetValue; external DuiLibdll name 'Delphi_ProgressUI_GetValue';
procedure Delphi_ProgressUI_SetValue; external DuiLibdll name 'Delphi_ProgressUI_SetValue';
function Delphi_ProgressUI_GetForeImage; external DuiLibdll name 'Delphi_ProgressUI_GetForeImage';
procedure Delphi_ProgressUI_SetForeImage; external DuiLibdll name 'Delphi_ProgressUI_SetForeImage';
procedure Delphi_ProgressUI_SetAttribute; external DuiLibdll name 'Delphi_ProgressUI_SetAttribute';
procedure Delphi_ProgressUI_PaintStatusImage; external DuiLibdll name 'Delphi_ProgressUI_PaintStatusImage';

//================================CScrollBarUI============================

function Delphi_ScrollBarUI_CppCreate; external DuiLibdll name 'Delphi_ScrollBarUI_CppCreate';
procedure Delphi_ScrollBarUI_CppDestroy; external DuiLibdll name 'Delphi_ScrollBarUI_CppDestroy';
function Delphi_ScrollBarUI_GetClass; external DuiLibdll name 'Delphi_ScrollBarUI_GetClass';
function Delphi_ScrollBarUI_GetInterface; external DuiLibdll name 'Delphi_ScrollBarUI_GetInterface';
function Delphi_ScrollBarUI_GetOwner; external DuiLibdll name 'Delphi_ScrollBarUI_GetOwner';
procedure Delphi_ScrollBarUI_SetOwner; external DuiLibdll name 'Delphi_ScrollBarUI_SetOwner';
procedure Delphi_ScrollBarUI_SetVisible; external DuiLibdll name 'Delphi_ScrollBarUI_SetVisible';
procedure Delphi_ScrollBarUI_SetEnabled; external DuiLibdll name 'Delphi_ScrollBarUI_SetEnabled';
procedure Delphi_ScrollBarUI_SetFocus; external DuiLibdll name 'Delphi_ScrollBarUI_SetFocus';
function Delphi_ScrollBarUI_IsHorizontal; external DuiLibdll name 'Delphi_ScrollBarUI_IsHorizontal';
procedure Delphi_ScrollBarUI_SetHorizontal; external DuiLibdll name 'Delphi_ScrollBarUI_SetHorizontal';
function Delphi_ScrollBarUI_GetScrollRange; external DuiLibdll name 'Delphi_ScrollBarUI_GetScrollRange';
procedure Delphi_ScrollBarUI_SetScrollRange; external DuiLibdll name 'Delphi_ScrollBarUI_SetScrollRange';
function Delphi_ScrollBarUI_GetScrollPos; external DuiLibdll name 'Delphi_ScrollBarUI_GetScrollPos';
procedure Delphi_ScrollBarUI_SetScrollPos; external DuiLibdll name 'Delphi_ScrollBarUI_SetScrollPos';
function Delphi_ScrollBarUI_GetLineSize; external DuiLibdll name 'Delphi_ScrollBarUI_GetLineSize';
procedure Delphi_ScrollBarUI_SetLineSize; external DuiLibdll name 'Delphi_ScrollBarUI_SetLineSize';
function Delphi_ScrollBarUI_GetShowButton1; external DuiLibdll name 'Delphi_ScrollBarUI_GetShowButton1';
procedure Delphi_ScrollBarUI_SetShowButton1; external DuiLibdll name 'Delphi_ScrollBarUI_SetShowButton1';
function Delphi_ScrollBarUI_GetButton1Color; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton1Color';
procedure Delphi_ScrollBarUI_SetButton1Color; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton1Color';
function Delphi_ScrollBarUI_GetButton1NormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton1NormalImage';
procedure Delphi_ScrollBarUI_SetButton1NormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton1NormalImage';
function Delphi_ScrollBarUI_GetButton1HotImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton1HotImage';
procedure Delphi_ScrollBarUI_SetButton1HotImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton1HotImage';
function Delphi_ScrollBarUI_GetButton1PushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton1PushedImage';
procedure Delphi_ScrollBarUI_SetButton1PushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton1PushedImage';
function Delphi_ScrollBarUI_GetButton1DisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton1DisabledImage';
procedure Delphi_ScrollBarUI_SetButton1DisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton1DisabledImage';
function Delphi_ScrollBarUI_GetShowButton2; external DuiLibdll name 'Delphi_ScrollBarUI_GetShowButton2';
procedure Delphi_ScrollBarUI_SetShowButton2; external DuiLibdll name 'Delphi_ScrollBarUI_SetShowButton2';
function Delphi_ScrollBarUI_GetButton2Color; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton2Color';
procedure Delphi_ScrollBarUI_SetButton2Color; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton2Color';
function Delphi_ScrollBarUI_GetButton2NormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton2NormalImage';
procedure Delphi_ScrollBarUI_SetButton2NormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton2NormalImage';
function Delphi_ScrollBarUI_GetButton2HotImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton2HotImage';
procedure Delphi_ScrollBarUI_SetButton2HotImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton2HotImage';
function Delphi_ScrollBarUI_GetButton2PushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton2PushedImage';
procedure Delphi_ScrollBarUI_SetButton2PushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton2PushedImage';
function Delphi_ScrollBarUI_GetButton2DisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetButton2DisabledImage';
procedure Delphi_ScrollBarUI_SetButton2DisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetButton2DisabledImage';
function Delphi_ScrollBarUI_GetThumbColor; external DuiLibdll name 'Delphi_ScrollBarUI_GetThumbColor';
procedure Delphi_ScrollBarUI_SetThumbColor; external DuiLibdll name 'Delphi_ScrollBarUI_SetThumbColor';
function Delphi_ScrollBarUI_GetThumbNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetThumbNormalImage';
procedure Delphi_ScrollBarUI_SetThumbNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetThumbNormalImage';
function Delphi_ScrollBarUI_GetThumbHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetThumbHotImage';
procedure Delphi_ScrollBarUI_SetThumbHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetThumbHotImage';
function Delphi_ScrollBarUI_GetThumbPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetThumbPushedImage';
procedure Delphi_ScrollBarUI_SetThumbPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetThumbPushedImage';
function Delphi_ScrollBarUI_GetThumbDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetThumbDisabledImage';
procedure Delphi_ScrollBarUI_SetThumbDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetThumbDisabledImage';
function Delphi_ScrollBarUI_GetRailNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetRailNormalImage';
procedure Delphi_ScrollBarUI_SetRailNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetRailNormalImage';
function Delphi_ScrollBarUI_GetRailHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetRailHotImage';
procedure Delphi_ScrollBarUI_SetRailHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetRailHotImage';
function Delphi_ScrollBarUI_GetRailPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetRailPushedImage';
procedure Delphi_ScrollBarUI_SetRailPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetRailPushedImage';
function Delphi_ScrollBarUI_GetRailDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetRailDisabledImage';
procedure Delphi_ScrollBarUI_SetRailDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetRailDisabledImage';
function Delphi_ScrollBarUI_GetBkNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetBkNormalImage';
procedure Delphi_ScrollBarUI_SetBkNormalImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetBkNormalImage';
function Delphi_ScrollBarUI_GetBkHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetBkHotImage';
procedure Delphi_ScrollBarUI_SetBkHotImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetBkHotImage';
function Delphi_ScrollBarUI_GetBkPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetBkPushedImage';
procedure Delphi_ScrollBarUI_SetBkPushedImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetBkPushedImage';
function Delphi_ScrollBarUI_GetBkDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_GetBkDisabledImage';
procedure Delphi_ScrollBarUI_SetBkDisabledImage; external DuiLibdll name 'Delphi_ScrollBarUI_SetBkDisabledImage';
procedure Delphi_ScrollBarUI_SetPos; external DuiLibdll name 'Delphi_ScrollBarUI_SetPos';
procedure Delphi_ScrollBarUI_DoEvent; external DuiLibdll name 'Delphi_ScrollBarUI_DoEvent';
procedure Delphi_ScrollBarUI_SetAttribute; external DuiLibdll name 'Delphi_ScrollBarUI_SetAttribute';
procedure Delphi_ScrollBarUI_DoPaint; external DuiLibdll name 'Delphi_ScrollBarUI_DoPaint';
procedure Delphi_ScrollBarUI_PaintBk; external DuiLibdll name 'Delphi_ScrollBarUI_PaintBk';
procedure Delphi_ScrollBarUI_PaintButton1; external DuiLibdll name 'Delphi_ScrollBarUI_PaintButton1';
procedure Delphi_ScrollBarUI_PaintButton2; external DuiLibdll name 'Delphi_ScrollBarUI_PaintButton2';
procedure Delphi_ScrollBarUI_PaintThumb; external DuiLibdll name 'Delphi_ScrollBarUI_PaintThumb';
procedure Delphi_ScrollBarUI_PaintRail; external DuiLibdll name 'Delphi_ScrollBarUI_PaintRail';

//================================CSliderUI============================

function Delphi_SliderUI_CppCreate; external DuiLibdll name 'Delphi_SliderUI_CppCreate';
procedure Delphi_SliderUI_CppDestroy; external DuiLibdll name 'Delphi_SliderUI_CppDestroy';
function Delphi_SliderUI_GetClass; external DuiLibdll name 'Delphi_SliderUI_GetClass';
function Delphi_SliderUI_GetControlFlags; external DuiLibdll name 'Delphi_SliderUI_GetControlFlags';
function Delphi_SliderUI_GetInterface; external DuiLibdll name 'Delphi_SliderUI_GetInterface';
procedure Delphi_SliderUI_SetEnabled; external DuiLibdll name 'Delphi_SliderUI_SetEnabled';
function Delphi_SliderUI_GetChangeStep; external DuiLibdll name 'Delphi_SliderUI_GetChangeStep';
procedure Delphi_SliderUI_SetChangeStep; external DuiLibdll name 'Delphi_SliderUI_SetChangeStep';
procedure Delphi_SliderUI_SetThumbSize; external DuiLibdll name 'Delphi_SliderUI_SetThumbSize';
procedure Delphi_SliderUI_GetThumbRect; external DuiLibdll name 'Delphi_SliderUI_GetThumbRect';
function Delphi_SliderUI_GetThumbImage; external DuiLibdll name 'Delphi_SliderUI_GetThumbImage';
procedure Delphi_SliderUI_SetThumbImage; external DuiLibdll name 'Delphi_SliderUI_SetThumbImage';
function Delphi_SliderUI_GetThumbHotImage; external DuiLibdll name 'Delphi_SliderUI_GetThumbHotImage';
procedure Delphi_SliderUI_SetThumbHotImage; external DuiLibdll name 'Delphi_SliderUI_SetThumbHotImage';
function Delphi_SliderUI_GetThumbPushedImage; external DuiLibdll name 'Delphi_SliderUI_GetThumbPushedImage';
procedure Delphi_SliderUI_SetThumbPushedImage; external DuiLibdll name 'Delphi_SliderUI_SetThumbPushedImage';
procedure Delphi_SliderUI_DoEvent; external DuiLibdll name 'Delphi_SliderUI_DoEvent';
procedure Delphi_SliderUI_SetAttribute; external DuiLibdll name 'Delphi_SliderUI_SetAttribute';
procedure Delphi_SliderUI_PaintStatusImage; external DuiLibdll name 'Delphi_SliderUI_PaintStatusImage';

//================================CTextUI============================

function Delphi_TextUI_CppCreate; external DuiLibdll name 'Delphi_TextUI_CppCreate';
procedure Delphi_TextUI_CppDestroy; external DuiLibdll name 'Delphi_TextUI_CppDestroy';
function Delphi_TextUI_GetClass; external DuiLibdll name 'Delphi_TextUI_GetClass';
function Delphi_TextUI_GetControlFlags; external DuiLibdll name 'Delphi_TextUI_GetControlFlags';
function Delphi_TextUI_GetInterface; external DuiLibdll name 'Delphi_TextUI_GetInterface';
function Delphi_TextUI_GetLinkContent; external DuiLibdll name 'Delphi_TextUI_GetLinkContent';
procedure Delphi_TextUI_DoEvent; external DuiLibdll name 'Delphi_TextUI_DoEvent';
procedure Delphi_TextUI_EstimateSize; external DuiLibdll name 'Delphi_TextUI_EstimateSize';
procedure Delphi_TextUI_PaintText; external DuiLibdll name 'Delphi_TextUI_PaintText';

//================================CTreeNodeUI============================

function Delphi_TreeNodeUI_CppCreate; external DuiLibdll name 'Delphi_TreeNodeUI_CppCreate';
procedure Delphi_TreeNodeUI_CppDestroy; external DuiLibdll name 'Delphi_TreeNodeUI_CppDestroy';
function Delphi_TreeNodeUI_GetClass; external DuiLibdll name 'Delphi_TreeNodeUI_GetClass';
function Delphi_TreeNodeUI_GetInterface; external DuiLibdll name 'Delphi_TreeNodeUI_GetInterface';
procedure Delphi_TreeNodeUI_DoEvent; external DuiLibdll name 'Delphi_TreeNodeUI_DoEvent';
procedure Delphi_TreeNodeUI_Invalidate; external DuiLibdll name 'Delphi_TreeNodeUI_Invalidate';
function Delphi_TreeNodeUI_Select; external DuiLibdll name 'Delphi_TreeNodeUI_Select';
function Delphi_TreeNodeUI_Add; external DuiLibdll name 'Delphi_TreeNodeUI_Add';
function Delphi_TreeNodeUI_AddAt; external DuiLibdll name 'Delphi_TreeNodeUI_AddAt';
function Delphi_TreeNodeUI_Remove; external DuiLibdll name 'Delphi_TreeNodeUI_Remove';
procedure Delphi_TreeNodeUI_SetVisibleTag; external DuiLibdll name 'Delphi_TreeNodeUI_SetVisibleTag';
function Delphi_TreeNodeUI_GetVisibleTag; external DuiLibdll name 'Delphi_TreeNodeUI_GetVisibleTag';
procedure Delphi_TreeNodeUI_SetItemText; external DuiLibdll name 'Delphi_TreeNodeUI_SetItemText';
function Delphi_TreeNodeUI_GetItemText; external DuiLibdll name 'Delphi_TreeNodeUI_GetItemText';
procedure Delphi_TreeNodeUI_CheckBoxSelected; external DuiLibdll name 'Delphi_TreeNodeUI_CheckBoxSelected';
function Delphi_TreeNodeUI_IsCheckBoxSelected; external DuiLibdll name 'Delphi_TreeNodeUI_IsCheckBoxSelected';
function Delphi_TreeNodeUI_IsHasChild; external DuiLibdll name 'Delphi_TreeNodeUI_IsHasChild';
function Delphi_TreeNodeUI_AddChildNode; external DuiLibdll name 'Delphi_TreeNodeUI_AddChildNode';
function Delphi_TreeNodeUI_RemoveAt; external DuiLibdll name 'Delphi_TreeNodeUI_RemoveAt';
procedure Delphi_TreeNodeUI_SetParentNode; external DuiLibdll name 'Delphi_TreeNodeUI_SetParentNode';
function Delphi_TreeNodeUI_GetParentNode; external DuiLibdll name 'Delphi_TreeNodeUI_GetParentNode';
function Delphi_TreeNodeUI_GetCountChild; external DuiLibdll name 'Delphi_TreeNodeUI_GetCountChild';
procedure Delphi_TreeNodeUI_SetTreeView; external DuiLibdll name 'Delphi_TreeNodeUI_SetTreeView';
function Delphi_TreeNodeUI_GetTreeView; external DuiLibdll name 'Delphi_TreeNodeUI_GetTreeView';
function Delphi_TreeNodeUI_GetChildNode; external DuiLibdll name 'Delphi_TreeNodeUI_GetChildNode';
procedure Delphi_TreeNodeUI_SetVisibleFolderBtn; external DuiLibdll name 'Delphi_TreeNodeUI_SetVisibleFolderBtn';
function Delphi_TreeNodeUI_GetVisibleFolderBtn; external DuiLibdll name 'Delphi_TreeNodeUI_GetVisibleFolderBtn';
procedure Delphi_TreeNodeUI_SetVisibleCheckBtn; external DuiLibdll name 'Delphi_TreeNodeUI_SetVisibleCheckBtn';
function Delphi_TreeNodeUI_GetVisibleCheckBtn; external DuiLibdll name 'Delphi_TreeNodeUI_GetVisibleCheckBtn';
procedure Delphi_TreeNodeUI_SetItemTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_SetItemTextColor';
function Delphi_TreeNodeUI_GetItemTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_GetItemTextColor';
procedure Delphi_TreeNodeUI_SetItemHotTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_SetItemHotTextColor';
function Delphi_TreeNodeUI_GetItemHotTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_GetItemHotTextColor';
procedure Delphi_TreeNodeUI_SetSelItemTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_SetSelItemTextColor';
function Delphi_TreeNodeUI_GetSelItemTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_GetSelItemTextColor';
procedure Delphi_TreeNodeUI_SetSelItemHotTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_SetSelItemHotTextColor';
function Delphi_TreeNodeUI_GetSelItemHotTextColor; external DuiLibdll name 'Delphi_TreeNodeUI_GetSelItemHotTextColor';
procedure Delphi_TreeNodeUI_SetAttribute; external DuiLibdll name 'Delphi_TreeNodeUI_SetAttribute';
function Delphi_TreeNodeUI_GetTreeNodes; external DuiLibdll name 'Delphi_TreeNodeUI_GetTreeNodes';
function Delphi_TreeNodeUI_GetTreeIndex; external DuiLibdll name 'Delphi_TreeNodeUI_GetTreeIndex';
function Delphi_TreeNodeUI_GetNodeIndex; external DuiLibdll name 'Delphi_TreeNodeUI_GetNodeIndex';

//================================CTreeViewUI============================

function Delphi_TreeViewUI_CppCreate; external DuiLibdll name 'Delphi_TreeViewUI_CppCreate';
procedure Delphi_TreeViewUI_CppDestroy; external DuiLibdll name 'Delphi_TreeViewUI_CppDestroy';
function Delphi_TreeViewUI_GetClass; external DuiLibdll name 'Delphi_TreeViewUI_GetClass';
function Delphi_TreeViewUI_GetInterface; external DuiLibdll name 'Delphi_TreeViewUI_GetInterface';
function Delphi_TreeViewUI_Add; external DuiLibdll name 'Delphi_TreeViewUI_Add';
function Delphi_TreeViewUI_AddAt_01; external DuiLibdll name 'Delphi_TreeViewUI_AddAt_01';
function Delphi_TreeViewUI_AddAt_02; external DuiLibdll name 'Delphi_TreeViewUI_AddAt_02';
function Delphi_TreeViewUI_Remove; external DuiLibdll name 'Delphi_TreeViewUI_Remove';
function Delphi_TreeViewUI_RemoveAt; external DuiLibdll name 'Delphi_TreeViewUI_RemoveAt';
procedure Delphi_TreeViewUI_RemoveAll; external DuiLibdll name 'Delphi_TreeViewUI_RemoveAll';
function Delphi_TreeViewUI_OnCheckBoxChanged; external DuiLibdll name 'Delphi_TreeViewUI_OnCheckBoxChanged';
function Delphi_TreeViewUI_OnFolderChanged; external DuiLibdll name 'Delphi_TreeViewUI_OnFolderChanged';
function Delphi_TreeViewUI_OnDBClickItem; external DuiLibdll name 'Delphi_TreeViewUI_OnDBClickItem';
function Delphi_TreeViewUI_SetItemCheckBox; external DuiLibdll name 'Delphi_TreeViewUI_SetItemCheckBox';
procedure Delphi_TreeViewUI_SetItemExpand; external DuiLibdll name 'Delphi_TreeViewUI_SetItemExpand';
procedure Delphi_TreeViewUI_Notify; external DuiLibdll name 'Delphi_TreeViewUI_Notify';
procedure Delphi_TreeViewUI_SetVisibleFolderBtn; external DuiLibdll name 'Delphi_TreeViewUI_SetVisibleFolderBtn';
function Delphi_TreeViewUI_GetVisibleFolderBtn; external DuiLibdll name 'Delphi_TreeViewUI_GetVisibleFolderBtn';
procedure Delphi_TreeViewUI_SetVisibleCheckBtn; external DuiLibdll name 'Delphi_TreeViewUI_SetVisibleCheckBtn';
function Delphi_TreeViewUI_GetVisibleCheckBtn; external DuiLibdll name 'Delphi_TreeViewUI_GetVisibleCheckBtn';
procedure Delphi_TreeViewUI_SetItemMinWidth; external DuiLibdll name 'Delphi_TreeViewUI_SetItemMinWidth';
function Delphi_TreeViewUI_GetItemMinWidth; external DuiLibdll name 'Delphi_TreeViewUI_GetItemMinWidth';
procedure Delphi_TreeViewUI_SetItemTextColor; external DuiLibdll name 'Delphi_TreeViewUI_SetItemTextColor';
procedure Delphi_TreeViewUI_SetItemHotTextColor; external DuiLibdll name 'Delphi_TreeViewUI_SetItemHotTextColor';
procedure Delphi_TreeViewUI_SetSelItemTextColor; external DuiLibdll name 'Delphi_TreeViewUI_SetSelItemTextColor';
procedure Delphi_TreeViewUI_SetSelItemHotTextColor; external DuiLibdll name 'Delphi_TreeViewUI_SetSelItemHotTextColor';
procedure Delphi_TreeViewUI_SetAttribute; external DuiLibdll name 'Delphi_TreeViewUI_SetAttribute';

//================================CTabLayoutUI============================

function Delphi_TabLayoutUI_CppCreate; external DuiLibdll name 'Delphi_TabLayoutUI_CppCreate';
procedure Delphi_TabLayoutUI_CppDestroy; external DuiLibdll name 'Delphi_TabLayoutUI_CppDestroy';
function Delphi_TabLayoutUI_GetClass; external DuiLibdll name 'Delphi_TabLayoutUI_GetClass';
function Delphi_TabLayoutUI_GetInterface; external DuiLibdll name 'Delphi_TabLayoutUI_GetInterface';
function Delphi_TabLayoutUI_Add; external DuiLibdll name 'Delphi_TabLayoutUI_Add';
function Delphi_TabLayoutUI_AddAt; external DuiLibdll name 'Delphi_TabLayoutUI_AddAt';
function Delphi_TabLayoutUI_Remove; external DuiLibdll name 'Delphi_TabLayoutUI_Remove';
procedure Delphi_TabLayoutUI_RemoveAll; external DuiLibdll name 'Delphi_TabLayoutUI_RemoveAll';
function Delphi_TabLayoutUI_GetCurSel; external DuiLibdll name 'Delphi_TabLayoutUI_GetCurSel';
function Delphi_TabLayoutUI_SelectItem_01; external DuiLibdll name 'Delphi_TabLayoutUI_SelectItem_01';
function Delphi_TabLayoutUI_SelectItem_02; external DuiLibdll name 'Delphi_TabLayoutUI_SelectItem_02';
procedure Delphi_TabLayoutUI_SetPos; external DuiLibdll name 'Delphi_TabLayoutUI_SetPos';
procedure Delphi_TabLayoutUI_SetAttribute; external DuiLibdll name 'Delphi_TabLayoutUI_SetAttribute';

//================================CHorizontalLayoutUI============================

function Delphi_HorizontalLayoutUI_CppCreate; external DuiLibdll name 'Delphi_HorizontalLayoutUI_CppCreate';
procedure Delphi_HorizontalLayoutUI_CppDestroy; external DuiLibdll name 'Delphi_HorizontalLayoutUI_CppDestroy';
function Delphi_HorizontalLayoutUI_GetClass; external DuiLibdll name 'Delphi_HorizontalLayoutUI_GetClass';
function Delphi_HorizontalLayoutUI_GetInterface; external DuiLibdll name 'Delphi_HorizontalLayoutUI_GetInterface';
function Delphi_HorizontalLayoutUI_GetControlFlags; external DuiLibdll name 'Delphi_HorizontalLayoutUI_GetControlFlags';
procedure Delphi_HorizontalLayoutUI_SetSepWidth; external DuiLibdll name 'Delphi_HorizontalLayoutUI_SetSepWidth';
function Delphi_HorizontalLayoutUI_GetSepWidth; external DuiLibdll name 'Delphi_HorizontalLayoutUI_GetSepWidth';
procedure Delphi_HorizontalLayoutUI_SetSepImmMode; external DuiLibdll name 'Delphi_HorizontalLayoutUI_SetSepImmMode';
function Delphi_HorizontalLayoutUI_IsSepImmMode; external DuiLibdll name 'Delphi_HorizontalLayoutUI_IsSepImmMode';
procedure Delphi_HorizontalLayoutUI_SetAttribute; external DuiLibdll name 'Delphi_HorizontalLayoutUI_SetAttribute';
procedure Delphi_HorizontalLayoutUI_DoEvent; external DuiLibdll name 'Delphi_HorizontalLayoutUI_DoEvent';
procedure Delphi_HorizontalLayoutUI_SetPos; external DuiLibdll name 'Delphi_HorizontalLayoutUI_SetPos';
procedure Delphi_HorizontalLayoutUI_DoPostPaint; external DuiLibdll name 'Delphi_HorizontalLayoutUI_DoPostPaint';
procedure Delphi_HorizontalLayoutUI_GetThumbRect; external DuiLibdll name 'Delphi_HorizontalLayoutUI_GetThumbRect';

//================================CListHeaderUI============================

function Delphi_ListHeaderUI_CppCreate; external DuiLibdll name 'Delphi_ListHeaderUI_CppCreate';
procedure Delphi_ListHeaderUI_CppDestroy; external DuiLibdll name 'Delphi_ListHeaderUI_CppDestroy';
function Delphi_ListHeaderUI_GetClass; external DuiLibdll name 'Delphi_ListHeaderUI_GetClass';
function Delphi_ListHeaderUI_GetInterface; external DuiLibdll name 'Delphi_ListHeaderUI_GetInterface';
procedure Delphi_ListHeaderUI_EstimateSize; external DuiLibdll name 'Delphi_ListHeaderUI_EstimateSize';

//================================CRenderClip============================

function Delphi_RenderClip_CppCreate; external DuiLibdll name 'Delphi_RenderClip_CppCreate';
procedure Delphi_RenderClip_CppDestroy; external DuiLibdll name 'Delphi_RenderClip_CppDestroy';
procedure Delphi_RenderClip_GenerateClip; external DuiLibdll name 'Delphi_RenderClip_GenerateClip';
procedure Delphi_RenderClip_GenerateRoundClip; external DuiLibdll name 'Delphi_RenderClip_GenerateRoundClip';
procedure Delphi_RenderClip_UseOldClipBegin; external DuiLibdll name 'Delphi_RenderClip_UseOldClipBegin';
procedure Delphi_RenderClip_UseOldClipEnd; external DuiLibdll name 'Delphi_RenderClip_UseOldClipEnd';

//================================CRenderEngine============================

function Delphi_RenderEngine_CppCreate; external DuiLibdll name 'Delphi_RenderEngine_CppCreate';
procedure Delphi_RenderEngine_CppDestroy; external DuiLibdll name 'Delphi_RenderEngine_CppDestroy';
function Delphi_RenderEngine_AdjustColor; external DuiLibdll name 'Delphi_RenderEngine_AdjustColor';
function Delphi_RenderEngine_CreateARGB32Bitmap; external DuiLibdll name 'Delphi_RenderEngine_CreateARGB32Bitmap';
procedure Delphi_RenderEngine_AdjustImage; external DuiLibdll name 'Delphi_RenderEngine_AdjustImage';
function Delphi_RenderEngine_LoadImage; external DuiLibdll name 'Delphi_RenderEngine_LoadImage';
procedure Delphi_RenderEngine_FreeImage; external DuiLibdll name 'Delphi_RenderEngine_FreeImage';
procedure Delphi_RenderEngine_DrawImage_01; external DuiLibdll name 'Delphi_RenderEngine_DrawImage_01';
function Delphi_RenderEngine_DrawImage_02; external DuiLibdll name 'Delphi_RenderEngine_DrawImage_02';
procedure Delphi_RenderEngine_DrawColor; external DuiLibdll name 'Delphi_RenderEngine_DrawColor';
procedure Delphi_RenderEngine_DrawGradient; external DuiLibdll name 'Delphi_RenderEngine_DrawGradient';
procedure Delphi_RenderEngine_DrawLine; external DuiLibdll name 'Delphi_RenderEngine_DrawLine';
procedure Delphi_RenderEngine_DrawRect; external DuiLibdll name 'Delphi_RenderEngine_DrawRect';
procedure Delphi_RenderEngine_DrawRoundRect; external DuiLibdll name 'Delphi_RenderEngine_DrawRoundRect';
procedure Delphi_RenderEngine_DrawText; external DuiLibdll name 'Delphi_RenderEngine_DrawText';
procedure Delphi_RenderEngine_DrawHtmlText; external DuiLibdll name 'Delphi_RenderEngine_DrawHtmlText';
function Delphi_RenderEngine_GenerateBitmap; external DuiLibdll name 'Delphi_RenderEngine_GenerateBitmap';
procedure Delphi_RenderEngine_GetTextSize; external DuiLibdll name 'Delphi_RenderEngine_GetTextSize';

//================================CListElementUI============================
function Delphi_ListElementUI_GetClass; external DuiLibdll name 'Delphi_ListElementUI_GetClass';
function Delphi_ListElementUI_GetControlFlags; external DuiLibdll name 'Delphi_ListElementUI_GetControlFlags';
function Delphi_ListElementUI_GetInterface; external DuiLibdll name 'Delphi_ListElementUI_GetInterface';
procedure Delphi_ListElementUI_SetEnabled; external DuiLibdll name 'Delphi_ListElementUI_SetEnabled';
function Delphi_ListElementUI_GetIndex; external DuiLibdll name 'Delphi_ListElementUI_GetIndex';
procedure Delphi_ListElementUI_SetIndex; external DuiLibdll name 'Delphi_ListElementUI_SetIndex';
function Delphi_ListElementUI_GetOwner; external DuiLibdll name 'Delphi_ListElementUI_GetOwner';
procedure Delphi_ListElementUI_SetOwner; external DuiLibdll name 'Delphi_ListElementUI_SetOwner';
procedure Delphi_ListElementUI_SetVisible; external DuiLibdll name 'Delphi_ListElementUI_SetVisible';
function Delphi_ListElementUI_IsSelected; external DuiLibdll name 'Delphi_ListElementUI_IsSelected';
function Delphi_ListElementUI_Select; external DuiLibdll name 'Delphi_ListElementUI_Select';
function Delphi_ListElementUI_IsExpanded; external DuiLibdll name 'Delphi_ListElementUI_IsExpanded';
function Delphi_ListElementUI_Expand; external DuiLibdll name 'Delphi_ListElementUI_Expand';
procedure Delphi_ListElementUI_Invalidate; external DuiLibdll name 'Delphi_ListElementUI_Invalidate';
function Delphi_ListElementUI_Activate; external DuiLibdll name 'Delphi_ListElementUI_Activate';
procedure Delphi_ListElementUI_DoEvent; external DuiLibdll name 'Delphi_ListElementUI_DoEvent';
procedure Delphi_ListElementUI_SetAttribute; external DuiLibdll name 'Delphi_ListElementUI_SetAttribute';
procedure Delphi_ListElementUI_DrawItemBk; external DuiLibdll name 'Delphi_ListElementUI_DrawItemBk';

//================================CListLabelElementUI============================

function Delphi_ListLabelElementUI_CppCreate; external DuiLibdll name 'Delphi_ListLabelElementUI_CppCreate';
procedure Delphi_ListLabelElementUI_CppDestroy; external DuiLibdll name 'Delphi_ListLabelElementUI_CppDestroy';
function Delphi_ListLabelElementUI_GetClass; external DuiLibdll name 'Delphi_ListLabelElementUI_GetClass';
function Delphi_ListLabelElementUI_GetInterface; external DuiLibdll name 'Delphi_ListLabelElementUI_GetInterface';
procedure Delphi_ListLabelElementUI_DoEvent; external DuiLibdll name 'Delphi_ListLabelElementUI_DoEvent';
procedure Delphi_ListLabelElementUI_EstimateSize; external DuiLibdll name 'Delphi_ListLabelElementUI_EstimateSize';
procedure Delphi_ListLabelElementUI_DoPaint; external DuiLibdll name 'Delphi_ListLabelElementUI_DoPaint';
procedure Delphi_ListLabelElementUI_DrawItemText; external DuiLibdll name 'Delphi_ListLabelElementUI_DrawItemText';

//================================CListTextElementUI============================

function Delphi_ListTextElementUI_CppCreate; external DuiLibdll name 'Delphi_ListTextElementUI_CppCreate';
procedure Delphi_ListTextElementUI_CppDestroy; external DuiLibdll name 'Delphi_ListTextElementUI_CppDestroy';
function Delphi_ListTextElementUI_GetClass; external DuiLibdll name 'Delphi_ListTextElementUI_GetClass';
function Delphi_ListTextElementUI_GetInterface; external DuiLibdll name 'Delphi_ListTextElementUI_GetInterface';
function Delphi_ListTextElementUI_GetControlFlags; external DuiLibdll name 'Delphi_ListTextElementUI_GetControlFlags';
function Delphi_ListTextElementUI_GetText; external DuiLibdll name 'Delphi_ListTextElementUI_GetText';
procedure Delphi_ListTextElementUI_SetText; external DuiLibdll name 'Delphi_ListTextElementUI_SetText';
procedure Delphi_ListTextElementUI_SetOwner; external DuiLibdll name 'Delphi_ListTextElementUI_SetOwner';
function Delphi_ListTextElementUI_GetLinkContent; external DuiLibdll name 'Delphi_ListTextElementUI_GetLinkContent';
procedure Delphi_ListTextElementUI_DoEvent; external DuiLibdll name 'Delphi_ListTextElementUI_DoEvent';
procedure Delphi_ListTextElementUI_EstimateSize; external DuiLibdll name 'Delphi_ListTextElementUI_EstimateSize';
procedure Delphi_ListTextElementUI_DrawItemText; external DuiLibdll name 'Delphi_ListTextElementUI_DrawItemText';

//================================CGifAnimUI============================

function Delphi_GifAnimUI_CppCreate; external DuiLibdll name 'Delphi_GifAnimUI_CppCreate';
procedure Delphi_GifAnimUI_CppDestroy; external DuiLibdll name 'Delphi_GifAnimUI_CppDestroy';
function Delphi_GifAnimUI_GetClass; external DuiLibdll name 'Delphi_GifAnimUI_GetClass';
function Delphi_GifAnimUI_GetInterface; external DuiLibdll name 'Delphi_GifAnimUI_GetInterface';
procedure Delphi_GifAnimUI_DoInit; external DuiLibdll name 'Delphi_GifAnimUI_DoInit';
procedure Delphi_GifAnimUI_DoPaint; external DuiLibdll name 'Delphi_GifAnimUI_DoPaint';
procedure Delphi_GifAnimUI_DoEvent; external DuiLibdll name 'Delphi_GifAnimUI_DoEvent';
procedure Delphi_GifAnimUI_SetVisible; external DuiLibdll name 'Delphi_GifAnimUI_SetVisible';
procedure Delphi_GifAnimUI_SetAttribute; external DuiLibdll name 'Delphi_GifAnimUI_SetAttribute';
procedure Delphi_GifAnimUI_SetBkImage; external DuiLibdll name 'Delphi_GifAnimUI_SetBkImage';
function Delphi_GifAnimUI_GetBkImage; external DuiLibdll name 'Delphi_GifAnimUI_GetBkImage';
procedure Delphi_GifAnimUI_SetAutoPlay; external DuiLibdll name 'Delphi_GifAnimUI_SetAutoPlay';
function Delphi_GifAnimUI_IsAutoPlay; external DuiLibdll name 'Delphi_GifAnimUI_IsAutoPlay';
procedure Delphi_GifAnimUI_SetAutoSize; external DuiLibdll name 'Delphi_GifAnimUI_SetAutoSize';
function Delphi_GifAnimUI_IsAutoSize; external DuiLibdll name 'Delphi_GifAnimUI_IsAutoSize';
procedure Delphi_GifAnimUI_PlayGif; external DuiLibdll name 'Delphi_GifAnimUI_PlayGif';
procedure Delphi_GifAnimUI_PauseGif; external DuiLibdll name 'Delphi_GifAnimUI_PauseGif';
procedure Delphi_GifAnimUI_StopGif; external DuiLibdll name 'Delphi_GifAnimUI_StopGif';


//================================CChildLayoutUI============================

function Delphi_ChildLayoutUI_CppCreate; external DuiLibdll name 'Delphi_ChildLayoutUI_CppCreate';
procedure Delphi_ChildLayoutUI_CppDestroy; external DuiLibdll name 'Delphi_ChildLayoutUI_CppDestroy';
procedure Delphi_ChildLayoutUI_Init; external DuiLibdll name 'Delphi_ChildLayoutUI_Init';
procedure Delphi_ChildLayoutUI_SetAttribute; external DuiLibdll name 'Delphi_ChildLayoutUI_SetAttribute';
procedure Delphi_ChildLayoutUI_SetChildLayoutXML; external DuiLibdll name 'Delphi_ChildLayoutUI_SetChildLayoutXML';
function Delphi_ChildLayoutUI_GetChildLayoutXML; external DuiLibdll name 'Delphi_ChildLayoutUI_GetChildLayoutXML';
function Delphi_ChildLayoutUI_GetInterface; external DuiLibdll name 'Delphi_ChildLayoutUI_GetInterface';
function Delphi_ChildLayoutUI_GetClass; external DuiLibdll name 'Delphi_ChildLayoutUI_GetClass';

//================================CTileLayoutUI============================

function Delphi_TileLayoutUI_CppCreate; external DuiLibdll name 'Delphi_TileLayoutUI_CppCreate';
procedure Delphi_TileLayoutUI_CppDestroy; external DuiLibdll name 'Delphi_TileLayoutUI_CppDestroy';
function Delphi_TileLayoutUI_GetClass; external DuiLibdll name 'Delphi_TileLayoutUI_GetClass';
function Delphi_TileLayoutUI_GetInterface; external DuiLibdll name 'Delphi_TileLayoutUI_GetInterface';
procedure Delphi_TileLayoutUI_SetPos; external DuiLibdll name 'Delphi_TileLayoutUI_SetPos';
procedure Delphi_TileLayoutUI_GetItemSize; external DuiLibdll name 'Delphi_TileLayoutUI_GetItemSize';
procedure Delphi_TileLayoutUI_SetItemSize; external DuiLibdll name 'Delphi_TileLayoutUI_SetItemSize';
function Delphi_TileLayoutUI_GetColumns; external DuiLibdll name 'Delphi_TileLayoutUI_GetColumns';
procedure Delphi_TileLayoutUI_SetColumns; external DuiLibdll name 'Delphi_TileLayoutUI_SetColumns';
procedure Delphi_TileLayoutUI_SetAttribute; external DuiLibdll name 'Delphi_TileLayoutUI_SetAttribute';


//================================CNativeControlUI============================

function Delphi_NativeControlUI_CppCreate; external DuiLibdll name 'Delphi_NativeControlUI_CppCreate';
procedure Delphi_NativeControlUI_CppDestroy; external DuiLibdll name 'Delphi_NativeControlUI_CppDestroy';
procedure Delphi_NativeControlUI_SetInternVisible; external DuiLibdll name 'Delphi_NativeControlUI_SetInternVisible';
procedure Delphi_NativeControlUI_SetVisible; external DuiLibdll name 'Delphi_NativeControlUI_SetVisible';
procedure Delphi_NativeControlUI_SetPos; external DuiLibdll name 'Delphi_NativeControlUI_SetPos';
function Delphi_NativeControlUI_GetClass; external DuiLibdll name 'Delphi_NativeControlUI_GetClass';
function Delphi_NativeControlUI_GetText; external DuiLibdll name 'Delphi_NativeControlUI_GetText';
procedure Delphi_NativeControlUI_SetText; external DuiLibdll name 'Delphi_NativeControlUI_SetText';
procedure Delphi_NativeControlUI_SetNativeHandle; external DuiLibdll name 'Delphi_NativeControlUI_SetNativeHandle';



end.
