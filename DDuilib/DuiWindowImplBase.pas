//***************************************************************************
//
//       名称：DuiWindowImplBase.pas
//       工具：RAD Studio XE6
//       日期：2015/11/18
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiWindowImplBase;

{$I DDuilib.inc}

interface

uses
  Windows,
  Messages,
  Types,
{$IFDEF SuppoertGeneric}
  Generics.Collections,
{$ENDIF}
  SysUtils,
  DuiBase,
  DuiConst,
  Duilib;

type
  TDuiWindowImplBaseClass = class of TDuiWindowImplBase;

  TDuiWindowImplBase = class(TDuiBase{$IFDEF SuppoertGeneric}<CDelphi_WindowImplBase>{$ENDIF})
  private
    FHandle: HWND;
    FParentHandle: HWND;
    FPaintManagerUI: CPaintManagerUI;
    function GetHandle: HWND;
    function GetInitSize: TSize;
    function GetScreenSize: TSize;
    function GetWorkAreaRect: TRect;
    function GetMousePos: TPoint;
    function GetClientRect: TRect;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetParentHandle(const Value: HWND);
{$IFDEF UseLowVer}
  published
{$ELSE}
  protected
{$ENDIF}
    // 回调函数
    procedure DUI_InitWindow; cdecl;
    procedure DUI_Click(var Msg: TNotifyUI); cdecl;
    procedure DUI_Notify(var Msg: TNotifyUI); cdecl;
    function  DUI_HandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; cdecl;
    function  DUI_MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; cdecl;
    procedure DUI_FinalMessage(hWd: HWND); cdecl;
    function  DUI_HandleCustomMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; cdecl;
    function  DUI_CreateControl(pstrStr: LPCTSTR): CControlUI; cdecl;
    function DUI_GetItemText(pControl: CControlUI; iIndex, iSubItem: Integer): LPCTSTR; cdecl;
  protected
    // Delphi虚函数
    procedure DoInitWindow; virtual;
    procedure DoNotify(var Msg: TNotifyUI); virtual;
    procedure DoClick(var msg: TNotifyUI); virtual;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); virtual;
    procedure DoMessageHandler(var Msg: TMessage; var bHandled: BOOL); virtual;
    procedure DoFinalMessage(hWd: HWND); virtual;
    procedure DoHandleCustomMessage(var Msg: TMessage; var bHandled: BOOL); virtual;
    function DoCreateControl(pstrStr: string): CControlUI; virtual;
    function DoGetItemText(pControl: CControlUI; iIndex, iSubItem: Integer): string; virtual;
  public
    procedure Show;
    procedure Hide;
    function ShowModal: Integer;
    procedure CenterWindow;
    procedure Close;
    procedure CreateDuiWindow(AParent: HWND; ATitle: string);
    procedure CreateWindow(hwndParent: HWND; ATitle: string; dwStyle: DWORD; dwExStyle: DWORD;
       const rc: TRect; hMenu: HMENU); overload;
    procedure CreateWindow(hwndParent: HWND; ATitle: string; dwStyle: DWORD; dwExStyle: DWORD;
       x: Integer = Integer(CW_USEDEFAULT); y: Integer = Integer(CW_USEDEFAULT);
       cx: Integer = Integer(CW_USEDEFAULT); cy: Integer = Integer(CW_USEDEFAULT); hMenu: HMENU = 0); overload;
    procedure SetClassStyle(nStyle: UINT);
    procedure SetIcon(nRes: UINT);
    function FindControl(const AName: string): CControlUI; overload;
    function FindControl(const pt: TPoint): CControlUI; overload;
    function Perform(uMsg: UINT; wParam: WPARAM = 0; lParam: LPARAM = 0): LRESULT;
    procedure Minimize;
    procedure Restore;
    procedure Maximize;
    procedure RemoveThisInPaintManager;
  public
    constructor Create; overload;
    constructor Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType); overload;
    constructor Create(ASkinFile, ASkinFolder: string; ARType: TResourceType); overload;
    constructor Create(ASkinFile, ASkinFolder: string);  overload;
    constructor Create(ASkinFile, ASkinFolder, AZipFileName: string); overload;
    destructor Destroy; override;
    procedure OnReceive(Param: Pointer); virtual;
    procedure ShowMessage(const Fmt: string; Args: array of const); overload;
    procedure ShowMessage(const Msg: string); overload;
  public
    property Left: Integer read GetLeft;
    property Top: Integer read GetTop;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property ClientRect: TRect read GetClientRect;
    property Handle: HWND read GetHandle;
    property ParentHandle: HWND read FParentHandle write SetParentHandle;
    property PaintManagerUI: CPaintManagerUI read FPaintManagerUI;
    property InitSize: TSize read GetInitSize;
    property ScreenSize: TSize read GetScreenSize;
    property WorkAreaRect: TRect read GetWorkAreaRect;
    property MousePos: TPoint read GetMousePos;
  end;

  TSimplePopupMenu = class(TDuiWindowImplBase)
  private
    FLostFocusFree: Boolean;
    procedure Popup(X: Integer = -1; Y: Integer = -1);
  protected
    FParentPaintManager: CPaintManagerUI;
    FMsg: string;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    procedure DoInitWindow; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType;
       const AParentPaintManager: CPaintManagerUI; const AMsg: string; ALostFocusFree: Boolean = True);
    destructor Destroy; override;
  public
    property Msg: string read FMsg;
  end;

  TDuiApplication = class
  public
    procedure Initialize;
    procedure Run;
    procedure Terminate;
  public
    constructor Create;
    destructor Destroy; override;
  end;


var
  DuiApplication: TDuiApplication;

implementation

{ TWindowImplBase }

constructor TDuiWindowImplBase.Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType);
begin
  Create;
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetClassName(ClassName);
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetSkinFile(ASkinFile);
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetSkinFolder(ASkinFolder);
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetZipFileName('');
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetResourceType(ARType);
end;

constructor TDuiWindowImplBase.Create(ASkinFile, ASkinFolder: string; ARType: TResourceType);
begin
  Create(ASkinFile, ASkinFolder, '', ARType);
end;

constructor TDuiWindowImplBase.Create(ASkinFile, ASkinFolder: string);
begin
  Create(ASkinFile, ASkinFolder, UILIB_FILE);
end;

constructor TDuiWindowImplBase.Create(ASkinFile, ASkinFolder,
  AZipFileName: string);
begin
  Create(ASkinFile, ASkinFolder, AZipFileName, UILIB_ZIP);
end;

constructor TDuiWindowImplBase.Create;
begin
  FThis := CDelphi_WindowImplBase.CppCreate;
  FPaintManagerUI := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.GetPaintManagerUI;

  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetDelphiSelf(Self);
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetInitWindow(GetMethodAddr('DUI_InitWindow'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetClick(GetMethodAddr('DUI_Click'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetNotify(GetMethodAddr('DUI_Notify'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetMessageHandler(GetMethodAddr('DUI_MessageHandler'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetFinalMessage(GetMethodAddr('DUI_FinalMessage'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetHandleMessage(GetMethodAddr('DUI_HandleMessage'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetHandleCustomMessage(GetMethodAddr('DUI_HandleCustomMessage'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetCreateControl(GetMethodAddr('DUI_CreateControl'));
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetGetItemText(GetMethodAddr('DUI_GetItemText'));
end;

destructor TDuiWindowImplBase.Destroy;
begin
  if FThis <> nil then
    {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.CppDestroy;
  inherited;
end;

procedure TDuiWindowImplBase.CreateDuiWindow(AParent: HWND; ATitle: string);
begin
  FParentHandle := AParent;
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.CreateDuiWindow(AParent, ATitle, UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE);
end;

procedure TDuiWindowImplBase.CreateWindow(hwndParent: HWND; ATitle: string;
  dwStyle, dwExStyle: DWORD; x, y, cx, cy: Integer; hMenu: HMENU);
begin
  FParentHandle := hwndParent;
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.Create(hwndParent, ATitle, dwStyle, dwExStyle, x, y, cx, cy, hMenu);
end;

procedure TDuiWindowImplBase.CreateWindow(hwndParent: HWND; ATitle: string;
  dwStyle, dwExStyle: DWORD; const rc: TRect; hMenu: HMENU);
begin
  FParentHandle := hwndParent;
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.Create(hwndParent, ATitle, dwStyle, dwExStyle, rc, hMenu);
end;

procedure TDuiWindowImplBase.DoClick(var Msg: TNotifyUI);
begin
  // virtual method
end;

function TDuiWindowImplBase.DoCreateControl(pstrStr: string): CControlUI;
begin
  // virtual method
  Result := nil;
end;

procedure TDuiWindowImplBase.DoFinalMessage(hWd: HWND);
begin
  // virtual method
  RemoveThisInPaintManager;
end;

function TDuiWindowImplBase.DoGetItemText(pControl: CControlUI; iIndex,
  iSubItem: Integer): string;
begin
  Result := '';
end;

procedure TDuiWindowImplBase.DoHandleCustomMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  // virtual method
end;

procedure TDuiWindowImplBase.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  // virtual method
end;

procedure TDuiWindowImplBase.DoInitWindow;
begin
  // virtual method
end;

procedure TDuiWindowImplBase.DoMessageHandler(var Msg: TMessage; var bHandled: BOOL);
begin
  // virtual method
end;

procedure TDuiWindowImplBase.DoNotify(var Msg: TNotifyUI);
begin
  // virtual method
end;

procedure TDuiWindowImplBase.DUI_Click(var Msg: TNotifyUI);
begin
  DoClick(Msg);
end;

function TDuiWindowImplBase.DUI_CreateControl(pstrStr: LPCTSTR): CControlUI;
begin
  Result := DoCreateControl(pstrStr);
end;

procedure TDuiWindowImplBase.DUI_FinalMessage(hWd: HWND);
begin
  DoFinalMessage(hWd);
end;

function TDuiWindowImplBase.DUI_GetItemText(pControl: CControlUI; iIndex,
  iSubItem: Integer): LPCTSTR;
begin
  Result := PChar(DoGetItemText(pControl, iIndex, iSubItem));
end;

function TDuiWindowImplBase.DUI_HandleCustomMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
var
  LMsg: TMessage;
begin
  LMsg.Msg := uMsg;
  LMsg.WParam := wParam;
  LMsg.LParam := lParam;
  LMsg.Result := 0;
  DoHandleCustomMessage(LMsg, bHandled);
  Result := LMsg.Result;
end;

function TDuiWindowImplBase.DUI_HandleMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
var
  LMsg: TMessage;
begin
  LMsg.Msg := uMsg;
  LMsg.WParam := wParam;
  LMsg.LParam := lParam;
  LMsg.Result := 0;
  DoHandleMessage(LMsg, bHandled);
  Result := LMsg.Result;
end;

procedure TDuiWindowImplBase.DUI_InitWindow;
begin
  DoInitWindow;
end;

function TDuiWindowImplBase.DUI_MessageHandler(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
var
  LMsg: TMessage;
begin
  LMsg.Msg := uMsg;
  LMsg.WParam := wParam;
  LMsg.LParam := lParam;
  LMsg.Result := 0;
  DoMessageHandler(LMsg, bHandled);
  Result := LMsg.Result;
end;

procedure TDuiWindowImplBase.DUI_Notify(var Msg: TNotifyUI);
begin
  DoNotify(Msg);
end;

function TDuiWindowImplBase.FindControl(const pt: TPoint): CControlUI;
begin
  Result := FPaintManagerUI.FindControl(pt);
end;

function TDuiWindowImplBase.GetClientRect: TRect;
begin
  Windows.GetWindowRect(Handle, Result);
end;

function TDuiWindowImplBase.GetHandle: HWND;
begin
  if FHandle = 0 then
    FHandle := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.GetHWND;
   Result := FHandle;
end;

function TDuiWindowImplBase.GetHeight: Integer;
begin
  Result := ClientRect.Height;
end;

function TDuiWindowImplBase.GetInitSize: TSize;
begin
  Result := FPaintManagerUI.GetInitSize;
end;

function TDuiWindowImplBase.GetLeft: Integer;
begin
  Result := ClientRect.Left;
end;

function TDuiWindowImplBase.GetMousePos: TPoint;
begin
  GetCursorPos(Result);
end;

function TDuiWindowImplBase.GetScreenSize: TSize;
begin
  Result.cx := GetSystemMetrics(SM_CXSCREEN);
  Result.cy := GetSystemMetrics(SM_CYSCREEN);
end;

function TDuiWindowImplBase.GetTop: Integer;
begin
  Result := ClientRect.Top;
end;

function TDuiWindowImplBase.GetWidth: Integer;
begin
  Result := ClientRect.Width;
end;

function TDuiWindowImplBase.GetWorkAreaRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, Result, 0);
end;

function TDuiWindowImplBase.FindControl(const AName: string): CControlUI;
begin
  Result := FPaintManagerUI.FindControl(AName);
end;

procedure TDuiWindowImplBase.Hide;
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.ShowWindow(False, False);
end;

procedure TDuiWindowImplBase.Maximize;
begin
  Perform(WM_SYSCOMMAND, SC_MAXIMIZE);
end;

procedure TDuiWindowImplBase.Minimize;
begin
  Perform(WM_SYSCOMMAND, SC_MINIMIZE);
end;

procedure TDuiWindowImplBase.ShowMessage(const Fmt: string; Args: array of const);
begin
  MessageBox(Handle, PChar(Format(Fmt, Args)), '消息', MB_OK or MB_ICONINFORMATION);
end;

procedure TDuiWindowImplBase.ShowMessage(const Msg: string);
begin
  ShowMessage(Msg, []);
end;

procedure TDuiWindowImplBase.OnReceive(Param: Pointer);
begin
  // virtual method
end;

function TDuiWindowImplBase.Perform(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  Result := SendMessage(Handle, uMsg, wParam, lParam);
end;

procedure TDuiWindowImplBase.RemoveThisInPaintManager;
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.RemoveThisInPaintManager;
end;

procedure TDuiWindowImplBase.Restore;
begin
  Perform(WM_SYSCOMMAND, SC_RESTORE);
end;

procedure TDuiWindowImplBase.SetClassStyle(nStyle: UINT);
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetGetClassStyle(nStyle);
end;

procedure TDuiWindowImplBase.SetIcon(nRes: UINT);
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.SetIcon(nRes);
end;

procedure TDuiWindowImplBase.SetParentHandle(const Value: HWND);
begin
  if FParentHandle <> Value then
  begin
    FParentHandle := Value;
    SetParent(Handle, FParentHandle);
  end;
end;

procedure TDuiWindowImplBase.Show;
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.ShowWindow(True, False);
end;

function TDuiWindowImplBase.ShowModal: Integer;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.ShowModal;
end;

procedure TDuiWindowImplBase.CenterWindow;
var
  LParnetRect: TRect;
begin
  if (FParentHandle <> 0) and IsWindow(FParentHandle) then
  begin
    GetWindowRect(FParentHandle, LParnetRect);
    SetWindowPos(Handle, HWND_TOP, LParnetRect.Left + (LParnetRect.Width div 2 - Width div 2),
      LParnetRect.Top + (LParnetRect.Height div 2 - Height div 2), 0, 0, SWP_NOSIZE or SWP_NOREDRAW);
  end else
    {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.CenterWindow;
end;

procedure TDuiWindowImplBase.Close;
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_WindowImplBase(FThis){$ENDIF}.Close;
end;



{ TDuiApplication }

constructor TDuiApplication.Create;
begin
  inherited;
end;


destructor TDuiApplication.Destroy;
begin
  inherited;
end;

procedure TDuiApplication.Initialize;
begin
  CPaintManagerUI.SetInstance(HInstance);
end;

procedure TDuiApplication.Run;
begin
  CPaintManagerUI.MessageLoop;
end;

procedure TDuiApplication.Terminate;
begin
  PostQuitMessage(0);
end;

{ TSimplePopupMenu }

constructor TSimplePopupMenu.Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType;
  const AParentPaintManager: CPaintManagerUI; const AMsg: string; ALostFocusFree: Boolean);
begin
  FMsg := AMsg;
  FParentPaintManager := AParentPaintManager;
  FLostFocusFree := ALostFocusFree;
  inherited Create(ASkinFile, ASkinFolder, AZipFileName, ARType);
  CreateWindow(0, ClassName, WS_POPUP, WS_EX_TOOLWINDOW or WS_EX_TOPMOST);
end;

destructor TSimplePopupMenu.Destroy;
begin
  if not FLostFocusFree then
    RemoveThisInPaintManager;
  inherited;
end;

procedure TSimplePopupMenu.DoFinalMessage(hWd: HWND);
begin
  if FLostFocusFree then
  begin
    inherited;
    Free;
  end;
end;

procedure TSimplePopupMenu.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_KILLFOCUS then
  begin
    if FLostFocusFree then
      Close
    else Hide;
    Msg.Result := 1;
  end;
end;

procedure TSimplePopupMenu.DoInitWindow;
begin
  inherited;
  Popup;
end;

procedure TSimplePopupMenu.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if {$IFDEF UseLowVer}DuiStringToString(Msg.sType){$ELSE}Msg.sType{$ENDIF} = DUI_MSGTYPE_ITEMSELECT then
    Close
  else if {$IFDEF UseLowVer}DuiStringToString(Msg.sType){$ELSE}Msg.sType{$ENDIF} = DUI_MSGTYPE_ITEMCLICK then
    FParentPaintManager.SendNotify(Msg.pSender, FMsg);
end;

procedure TSimplePopupMenu.Popup(X, Y: Integer);
var
  LSize, LScreenSize: TSize;
  LP: TPoint;
begin
  LSize := InitSize;
  if (X = -1) and (Y = -1) then
    LP := MousePos
  else LP := Point(X, Y);
  LScreenSize := ScreenSize;
  if LP.X + LSize.cx >= LScreenSize.cx then
    LP.X := LP.X - LSize.cx;
  if LP.Y + LSize.cy >= LScreenSize.cy then
    LP.Y := LP.Y - LSize.cy;
  SetWindowPos(Handle, HWND_TOPMOST, LP.X, LP.Y, 0, 0, SWP_NOSIZE);
  if IsWindow(Handle) and not IsWindowVisible(Handle) then
    ShowWindow(Handle, SW_SHOWNORMAL or SWP_NOREDRAW);
end;

initialization
   DuiApplication := TDuiApplication.Create;

finalization
   DuiApplication.Free;


end.
