//***************************************************************************
//
//       名称：Duilib.pas
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       本单元由CppConvert工具自动生成于2015-11-28 17:01:00
//       版权所有 (C) 2015-2016 ying32 All Rights Reserved
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
{$I DDuilib.inc}

interface

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

  PCOLORREF = ^COLORREF;
  
// cpux86
{$IF not Declared(SIZE_T)}
  SIZE_T = Cardinal;
{$IFEND}
{$IF not Declared(UIntPtr)} 
  UIntPtr = Cardinal;
{$IFEND}
{$IF not Declared(UINT_PTR)} 
  UINT_PTR = Cardinal;
{$IFEND}
{$IF not Declared(LPCVOID)} 
  LPCVOID = Pointer;
{$IFEND}
{$IF not Declared(LONG)} 
  LONG = Longint;
{$IFEND}
{$IF not Declared(TRectF)} 
  TRectF = record
    Left, Top, Right, Bottom: Single;
  end;
{$IFEND}
{$IF not Declared(LPVOID)} 
  LPVOID = Pointer;
{$IFEND}
{$IF not Declared(LPBYTE)} 
  LPBYTE = PByte;
{$IFEND}
{$IF not Declared(BOOL)} 
  BOOL = LongBool;
{$IFEND}
 
  FINDCONTROLPROC = function(AControl: CControlUI; P: LPVOID): CControlUI; cdecl;
  TFindControlProc = FINDCONTROLPROC;




  //  IMessageFilterUI = Pointer;
  TMessageHandlerEvent = procedure(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT) of object;
  IMessageFilterUI = class
  private
    FEvent: TMessageHandlerEvent;
  protected
    function MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean): LRESULT; virtual; cdecl;
  public
    constructor Create(AEvent: TMessageHandlerEvent);
  public
    property OnMessageHandler: TMessageHandlerEvent read FEvent write FEvent;
  end;

  //  IDialogBuilderCallback = Pointer;
  TDialogBuilderCallbackEvent = procedure(pstrClass: string) of object;
  IDialogBuilderCallback = class
  private
    FEvent: TDialogBuilderCallbackEvent;
  protected
    function CreateControl(pstrClass: PChar): CControlUI; virtual; cdecl;
  public
    constructor Create(AEvent: TDialogBuilderCallbackEvent);
  public
    property OnDialogBuilderCallback: TDialogBuilderCallbackEvent read FEvent write FEvent;
  end;

  CWebBrowserEventHandler = class(TObject) end;
  ITranslateAccelerator = Pointer;

  IListOwnerUI = Pointer;

  //IListCallbackUI = Pointer;
  TListGetItemTextEvent = procedure(pList: CControlUI; iItem, iSubItem: Integer; var Result: string) of object;
  IListCallbackUI = class
  private
    FEvent: TListGetItemTextEvent;
  protected
    function GetItemText(pList: CControlUI; iItem, iSubItem: Integer): LPCTSTR; virtual; cdecl;
  public
    constructor Create(AEvent: TListGetItemTextEvent);
  public
    property OnItemText: TListGetItemTextEvent read FEvent write FEvent;
  end;

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

  TDuiEvent = procedure(Sender: CControlUI; var AEvent: TEventUI) of object;
  TDuiPaintEvent = procedure(Sender: CControlUI; DC: HDC; const rcPaint: TRect) of object;

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
    rcScale9: TRect;
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

  // CommCtrol
  tagTOOLINFO = packed record
    cbSize: UINT;
    uFlags: UINT;
    hwnd: HWND;
    uId: UIntPtr;
    Rect: TRect;
    hInst: HINST;
    lpszText: PChar;
    lParam: LPARAM;
    lpReserved: Pointer;
  end;
  PToolInfo = ^TToolInfo;
  TToolInfo = tagTOOLINFO;
  TOOLINFO = TToolInfo;


  TNotifyUI = packed record
    sType: CDuiString;
    sVirtualWnd: CDuiString;
    pSender: CControlUI;
    dwTimestamp: DWORD;
    ptMouse: TPoint;
    wParam: WPARAM;
    lParam: LPARAM;
  end;

  //  INotifyUI = Pointer;
  TNotifyUIEvent = procedure(var Msg: TNotifyUI) of object;
  INotifyUI = class
  private
    FEvent: TNotifyUIEvent;
  protected
    procedure Notify(var Msg: TNotifyUI); virtual; cdecl;
  public
    constructor Create(AEvent: TNotifyUIEvent);
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
  protected
    m_sName: CDuiString;
    m_hWndPaint: HWND;
    m_hDcPaint: HDC;
    m_hDcOffscreen: HDC;
    m_hDcBackground: HDC;
    m_hbmpOffscreen: HBITMAP;
    m_pOffscreenBits: PCOLORREF;
    m_hbmpBackground: HBITMAP;
    m_pBackgroundBits: PCOLORREF;
    m_iTooltipWidth: Integer;
    m_hwndTooltip: HWND;
    m_ToolTip: TOOLINFO;
    m_iHoverTime: Integer;
    m_bShowUpdateRect: Boolean;
    //
    m_pRoot: CControlUI;
    m_pFocus: CControlUI;
    m_pEventHover: CControlUI;
    m_pEventClick: CControlUI;
    m_pEventKey: CControlUI;

    m_ptLastMousePos: TPoint;
    m_szMinWindow: TSize;
    m_szMaxWindow: TSize;
    m_szInitWindowSize: TSize;
    m_rcSizeBox: TRect;
    m_szRoundCorner: TSize;
    m_rcCaption: TRect;
    m_uTimerID: UINT;
    m_bFirstLayout: Boolean;
    m_bUpdateNeeded: Boolean;
    m_bFocusNeeded: Boolean;
    m_bOffscreenPaint: Boolean;

    m_nOpacity: Byte;
    m_bLayered: Boolean;
    m_rcLayeredInset: TRect;
    m_bLayeredChanged: TRect;
    m_rcLayeredUpdate: TRect;
    m_diLayered: TDrawInfo;

    m_bMouseTracking: Boolean;
    m_bMouseCapture: Boolean;
    m_bIsPainting: Boolean;
    m_bUsedVirtualWnd: Boolean;
    m_bAsyncNotifyPosted: Boolean;
{
    //
    CStdPtrArray m_aNotifiers;
    CStdPtrArray m_aTimers;
    CStdPtrArray m_aPreMessageFilters;
    CStdPtrArray m_aMessageFilters;
    CStdPtrArray m_aPostPaintControls;
    CStdPtrArray m_aNativeWindow;
    CStdPtrArray m_aNativeWindowControl;
    CStdPtrArray m_aDelayedCleanup;
    CStdPtrArray m_aAsyncNotify;
    CStdPtrArray m_aFoundControls;
    CStdStringPtrMap m_mNameHash;
    CStdStringPtrMap m_mWindowCustomAttrHash;
    CStdStringPtrMap m_mOptionGroup;

    //
    bool m_bForceUseSharedRes;
    TResInfo m_ResInfo;
}

  public
    class function CppCreate: CPaintManagerUI;
    procedure CppDestroy;
    procedure Init(hWnd: HWND; pstrName: string = '');
    function IsUpdateNeeded: Boolean;
    procedure NeedUpdate;
    procedure Invalidate; overload;
    procedure Invalidate(const rcItem: TRect); overload;
    function GetPaintDC: HDC;
    function GetPaintOffscreenBitmap: HBITMAP;
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
    function RenameControl(pControl: CControlUI; pstrName: string): Boolean;
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
    function GetNativeWindowRect(hChildWnd: HWND): TRect;
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
    function CreateFromFile(XmlName: string; pCallback: IDialogBuilderCallback = nil; pManager: CPaintManagerUI = nil; pParent: CControlUI = nil): CControlUI;
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
  private // 先占个位用
    // 根据c++初始化的规则，此时对应的地址会被填充到变量中
    ____OnInit: CEventSource;
    ____OnDestroy: CEventSource;
    ____OnSize: CEventSource;
    ____OnEvent: CEventSource;
    ____OnNotify: CEventSource;
    ____OnPaint: CEventSource;
    ____OnPostPaint: CEventSource;
  private
    m_DoEventCallback: TMethod;
    m_DoPaintCallback: TMethod;
    m_DelphiClass: Pointer;
    m_DelphiFreeProc: Pointer;
    function GetDuiEvent: TDuiEvent;
    procedure SetDuiEvent(const Value: TDuiEvent);
    function GetDuiPaint: TDuiPaintEvent;
    procedure SetDuiPaint(const Value: TDuiPaintEvent);
  protected
    m_pManager: CPaintManagerUI;
    m_pParent: CControlUI;
    m_sVirtualWnd: CDuiString;
    m_sName: CDuiString;
    m_bUpdateNeeded: Boolean;
    m_bMenuUsed: Boolean;
    m_rcItem: TRect;
    m_rcPadding: TRect;
    m_cXY: TSize;
    m_cxyFixed: TSize;
    m_cxyMin: TSize;
    m_cxyMax: TSize;
    m_bVisible: Boolean;
    m_bInternVisible: Boolean;
    m_bEnabled: Boolean;
    m_bMouseEnabled: Boolean;
    m_bKeyboardEnabled: Boolean;
    m_bFocused: Boolean;
    m_bFloat: Boolean;
    m_piFloatPercent: TPercentInfo;
    m_bSetPos: Boolean;

    m_sText: CDuiString;
    m_sToolTip: CDuiString;
    m_chShortcut: Char;
    m_sUserData: CDuiString;
    m_pTag: UINT_PTR;

    m_dwBackColor: DWORD;
    m_dwBackColor2: DWORD;
    m_dwBackColor3: DWORD;
    m_diBk: TDrawInfo;
    m_diFore: TDrawInfo;
    m_dwBorderColor: DWORD;
    m_dwFocusBorderColor: DWORD;
    m_bColorHSL: Boolean;
    m_nBorderStyle: Integer;
    m_nTooltipWidth: Integer;
    m_cxyBorderRound: TSize;
    m_rcPaint: TRect;
    m_rcBorderSize: TRect;
    // m_mCustomAttrHash: CStdStringPtrMap;

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
    function GetAttributeList: string;
    function EstimateSize(szAvailable: TSize): TSize;
    procedure Paint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI = nil);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    property DelphiClass: Pointer read m_DelphiClass write m_DelphiClass;
    property DelphiFreeProc: Pointer read m_DelphiFreeProc write m_DelphiFreeProc;
    property OnDuiEvent: TDuiEvent read GetDuiEvent write SetDuiEvent;
    property OnDuiPaint: TDuiPaintEvent read GetDuiPaint write SetDuiPaint;
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
    function CreateDelphiWindow(DelphiHandle: HWND): HWND;
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
    procedure SetResSkin(ResSkin: string);
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
    function DelphiMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
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
    function GetChildAlign: UINT;
    procedure SetChildAlign(iAlign: UINT);
    function GetChildVAlign: UINT;
    procedure SetChildVAlign(iVAlign: UINT);
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    function IsMultiLine: Boolean;
    procedure SetMultiLine(bMultiLine: Boolean = True);
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
    property MultiLine: Boolean read IsMultiLine write SetMultiLine;
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
    function GetFadeAlphaDelta: Byte;
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    procedure SetCurSel(nIndex: Integer);
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
    procedure PaintText(hDC: HDC);
    procedure PaintStatusImage(hDC: HDC);
  public
    property DropBoxAttributeList: string read GetDropBoxAttributeList write SetDropBoxAttributeList;
	  property DropBoxSize: TSize read GetDropBoxSize write SetDropBoxSize;
    property CurSel: Integer read GetCurSel write SetCurSel;
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
    function IsAutoSelAll: Boolean;
    procedure SetAutoSelAll(bAutoSelAll: Boolean);
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
    property AutoSelAll: Boolean read IsAutoSelAll write SetAutoSelAll;
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    function IsImmMode: Boolean;
    procedure SetImmMode(bImmMode: Boolean);
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
    class procedure DrawImage(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcScale9: TRect; alphaChannel: Boolean; uFade: Byte = 255; hole: Boolean = False; xtiled: Boolean = False; ytiled: Boolean = False); overload;
    class function DrawImage(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean; overload;
    class function GenerateBitmap(pManager: CPaintManagerUI; rc: TRect; pStopControl: CControlUI = nil; dwFilterColor: DWORD = 0): HBITMAP; overload;
    class function GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect; dwFilterColor: DWORD = 0): HBITMAP; overload;
    class procedure DrawColor(hDC: HDC; var rc: TRect; color: DWORD);
    class procedure DrawGradient(hDC: HDC; var rc: TRect; dwFirst: DWORD; dwSecond: DWORD; bVertical: Boolean; nSteps: Integer);
    class procedure DrawLine(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawRect(hDC: HDC; var rc: TRect; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawRoundRect(hDC: HDC; var rc: TRect; width: Integer; height: Integer; nSize: Integer; dwPenColor: DWORD; nStyle: Integer = PS_SOLID);
    class procedure DrawText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; iFont: Integer; uStyle: UINT);
    class procedure DrawHtmlText(hDC: HDC; pManager: CPaintManagerUI; var rc: TRect; pstrText: string; dwTextColor: DWORD; pLinks: PRect; sLinks: string; var nLinkRects: Integer; uStyle: UINT);
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    procedure DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
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
    function GetFixedColumns: Integer;
    procedure SetFixedColumns(iColums: Integer);
    function GetChildVPadding: Integer;
    procedure SetChildVPadding(iPadding: Integer);
    function GetItemSize: TSize;
    procedure SetItemSize(szSize: TSize);
    function GetColumns: Integer;
    function GetRows: Integer;
    procedure SetAttribute(pstrName: string; pstrValue: string);
  public
    property ItemSize: TSize read GetItemSize write SetItemSize;
    property FixedColumns: Integer read GetFixedColumns write SetFixedColumns;
    property ChildVPadding: Integer read GetChildVPadding write SetChildVPadding;
    //property Columns: Integer read GetColumns write SetColumns;
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




 // 文件过大，dll函数放入inc文件中，不然编辑器太卡了
{$I DuilibImportA.inc}


{$IFDEF UseLowVer}
  function StringToDuiString(const AStr: string): CDuiString; {$IFDEF SupportInline}inline;{$ENDIF}
  function DuiStringToString(ADuiStr: CDuiString): string; {$IFDEF SupportInline}inline;{$ENDIF}
{$ENDIF UseLowVer}
implementation


// 传回c++类中的
procedure CppFreeAndNil(var Obj: Pointer); cdecl;
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;

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
  Result := Self.Length = 0;
end;

function CDuiString.Length: Integer;
begin
  Result := System.Length(ToString);
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
  Result := m_pstr;
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

function CDialogBuilder.CreateFromFile(XmlName: string; pCallback: IDialogBuilderCallback = nil; pManager: CPaintManagerUI = nil; pParent: CControlUI = nil): CControlUI;
begin
  Result := Delphi_DialogBuilder_Create_01(Self, STRINGorID(XmlName), nil, pCallback, pManager, pParent);
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

procedure CControlUI.SetDuiEvent(const Value: TDuiEvent);
begin
  if Assigned(Value) then
  begin
    TMethod(m_DoEventCallback).Data := TMethod(Value).Data;
    TMethod(m_DoEventCallback).Code := TMethod(Value).Code;
  end else
    FillChar(m_DoEventCallback, SizeOf(m_DoEventCallback), #0);
end;

procedure CControlUI.SetDuiPaint(const Value: TDuiPaintEvent);
begin
  if Assigned(Value) then
  begin
    TMethod(m_DoPaintCallback).Data := TMethod(Value).Data;
    TMethod(m_DoPaintCallback).Code := TMethod(Value).Code;
  end else
    FillChar(m_DoPaintCallback, SizeOf(m_DoPaintCallback), #0);
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

function CControlUI.GetDuiEvent: TDuiEvent;
begin
 Result := TDuiEvent(m_DoEventCallback);
end;

function CControlUI.GetDuiPaint: TDuiPaintEvent;
begin
  Result := TDuiPaintEvent(m_DoPaintCallback);
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

function CControlUI.GetAttributeList: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_ControlUI_GetAttributeList(Self);
{$ELSE}
  Result := Delphi_ControlUI_GetAttributeList(Self).m_pstr;
{$ENDIF}
end;

function CControlUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_ControlUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CControlUI.Paint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ControlUI_Paint(Self, hDC, rcPaint, pStopControl);
end;

procedure CControlUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ControlUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

function CDelphi_WindowImplBase.CreateDelphiWindow(DelphiHandle: HWND): HWND;
begin
  Result := Delphi_Delphi_WindowImplBase_CreateDelphiWindow(Self, DelphiHandle);
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

function CDelphi_WindowImplBase.DelphiMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  Result := Delphi_Delphi_WindowImplBase_DelphiMessage(Self, uMsg, wParam, lParam);
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

procedure CDelphi_WindowImplBase.SetResSkin(ResSkin: string);
begin
  Delphi_Delphi_WindowImplBase_SetZipFileName(Self, PChar(ResSkin));
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

function CPaintManagerUI.GetPaintOffscreenBitmap: HBITMAP;
begin
  Result := Delphi_PaintManagerUI_GetPaintOffscreenBitmap(Self);
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

function CPaintManagerUI.RenameControl(pControl: CControlUI; pstrName: string): Boolean;
begin
  Result := Delphi_PaintManagerUI_RenameControl(Self, pControl, LPCTSTR(pstrName));
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

function CPaintManagerUI.GetNativeWindowRect(hChildWnd: HWND): TRect;
begin
  Delphi_PaintManagerUI_GetNativeWindowRect(Self, hChildWnd, Result);
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

function CContainerUI.GetChildAlign: UINT;
begin
  Result := Delphi_ContainerUI_GetChildAlign(Self);
end;

procedure CContainerUI.SetChildAlign(iAlign: UINT);
begin
  Delphi_ContainerUI_SetChildAlign(Self, iAlign);
end;

function CContainerUI.GetChildVAlign: UINT;
begin
  Result := Delphi_ContainerUI_GetChildVAlign(Self);
end;

procedure CContainerUI.SetChildVAlign(iVAlign: UINT);
begin
  Delphi_ContainerUI_SetChildVAlign(Self, iVAlign);
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

procedure CContainerUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ContainerUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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
  Result.DelphiFreeProc := @CppFreeAndNil;
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

function CLabelUI.IsMultiLine: Boolean;
begin
  Result := Delphi_LabelUI_IsMultiLine(Self);
end;

procedure CLabelUI.SetMultiLine(bMultiLine: Boolean);
begin
  Delphi_LabelUI_SetMultiLine(Self, bMultiLine);
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

function CButtonUI.GetFadeAlphaDelta: Byte;
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

procedure CListContainerElementUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ListContainerElementUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

procedure CComboUI.SetCurSel(nIndex: Integer);
begin
  Delphi_ComboUI_SelectItem(Self, nIndex, False, True);
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

procedure CComboUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ComboUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

function CEditUI.IsAutoSelAll: Boolean;
begin
  Result := Delphi_EditUI_IsAutoSelAll(Self);
end;

procedure CEditUI.SetAutoSelAll(bAutoSelAll: Boolean);
begin
  Delphi_EditUI_SetAutoSelAll(Self, bAutoSelAll);
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

procedure CScrollBarUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ScrollBarUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

function CSliderUI.IsImmMode: Boolean;
begin
  Result := Delphi_SliderUI_IsImmMode(Self);
end;

procedure CSliderUI.SetImmMode(bImmMode: Boolean);
begin
  Delphi_SliderUI_SetImmMode(Self, bImmMode);
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

class procedure CRenderEngine.DrawImage(hDC: HDC; hBitmap: HBITMAP; var rc: TRect; var rcPaint: TRect; var rcBmpPart: TRect; var rcScale9: TRect; alphaChannel: Boolean; uFade: Byte; hole: Boolean; xtiled: Boolean; ytiled: Boolean);
begin
  Delphi_RenderEngine_DrawImage_01(hDC, hBitmap, rc, rcPaint, rcBmpPart, rcScale9, alphaChannel, uFade, hole, xtiled, ytiled);
end;

class function CRenderEngine.DrawImage(hDC: HDC; pManager: CPaintManagerUI; var rcItem: TRect; var rcPaint: TRect; var drawInfo: TDrawInfo): Boolean;
begin
  Result := Delphi_RenderEngine_DrawImage_02(hDC, pManager, rcItem, rcPaint, drawInfo);
end;

class function CRenderEngine.GenerateBitmap(pManager: CPaintManagerUI; rc: TRect; pStopControl: CControlUI; dwFilterColor: DWORD): HBITMAP;
begin
  Result := Delphi_RenderEngine_GenerateBitmap_01(pManager, rc, pStopControl, dwFilterColor);
end;

class function CRenderEngine.GenerateBitmap(pManager: CPaintManagerUI; pControl: CControlUI; rc: TRect; dwFilterColor: DWORD): HBITMAP;
begin
  Result := Delphi_RenderEngine_GenerateBitmap_02(pManager, pControl, rc, dwFilterColor);
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

procedure CListLabelElementUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_ListLabelElementUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

procedure CGifAnimUI.DoPaint(hDC: HDC; var rcPaint: TRect; pStopControl: CControlUI);
begin
  Delphi_GifAnimUI_DoPaint(Self, hDC, rcPaint, pStopControl);
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

function CTileLayoutUI.GetFixedColumns: Integer;
begin
  Result := Delphi_TileLayoutUI_GetFixedColumns(Self);
end;

procedure CTileLayoutUI.SetFixedColumns(iColums: Integer);
begin
  Delphi_TileLayoutUI_SetFixedColumns(Self, iColums);
end;

function CTileLayoutUI.GetChildVPadding: Integer;
begin
  Result := Delphi_TileLayoutUI_GetChildVPadding(Self);
end;

procedure CTileLayoutUI.SetChildVPadding(iPadding: Integer);
begin
  Delphi_TileLayoutUI_SetChildVPadding(Self, iPadding);
end;

function CTileLayoutUI.GetItemSize: TSize;
begin
  Delphi_TileLayoutUI_GetItemSize(Self, Result);
end;

procedure CTileLayoutUI.SetItemSize(szSize: TSize);
begin
  Delphi_TileLayoutUI_SetItemSize(Self, szSize);
end;

function CTileLayoutUI.GetColumns: Integer;
begin
  Result := Delphi_TileLayoutUI_GetColumns(Self);
end;

function CTileLayoutUI.GetRows: Integer;
begin
  Result := Delphi_TileLayoutUI_GetRows(Self);
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

constructor IListCallbackUI.Create(AEvent: TListGetItemTextEvent);
begin
  FEvent := AEvent;
end;

function IListCallbackUI.GetItemText(pList: CControlUI; iItem, iSubItem: Integer): LPCTSTR;
var
  S: string;
begin
  S := '';
  if Assigned(FEvent) then
    FEvent(pList, iItem, iSubItem, S);
  Result := PChar(S);
end;

constructor INotifyUI.Create(AEvent: TNotifyUIEvent);
begin
  FEvent := AEvent;
end;

procedure INotifyUI.Notify(var Msg: TNotifyUI);
begin
  if Assigned(FEvent) then
    FEvent(Msg);
end;

constructor IMessageFilterUI.Create(AEvent: TMessageHandlerEvent);
begin
  FEvent := AEvent;
end;

function IMessageFilterUI.MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM;
  var bHandled: Boolean): LRESULT;
begin
  Result := 0;
  if Assigned(FEvent) then
    FEvent(uMsg, wParam, lParam, bHandled, Result);
end;


constructor IDialogBuilderCallback.Create(AEvent: TDialogBuilderCallbackEvent);
begin
  FEvent := AEvent;
end;

function IDialogBuilderCallback.CreateControl(pstrClass: PChar): CControlUI;
begin
  Result := nil;
  if Assigned(FEvent) then
    FEvent(pstrClass);
end;


{$I DuilibImportB.inc}


end.
