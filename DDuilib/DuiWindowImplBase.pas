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

interface

uses
  Winapi.Windows,
  System.SysUtils,
  DuiBase,
  Duilib;

type

  TDuiWindowImplBase = class(TDuiBase<CDelphi_WindowImplBase>)
  private
    FParentHandle: HWND;
    FPaintManagerUI: CPaintManagerUI;
    function GetHandle: HWND;
    function GetInitSize: TSize;
  protected
    // 回调函数
    procedure DUI_InitWindow; cdecl;
    procedure DUI_Click(var Msg: TNotifyUI); cdecl;
    procedure DUI_Notify(var Msg: TNotifyUI); cdecl;
    function  DUI_HandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
    function  DUI_MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; cdecl;
    procedure DUI_FinalMessage(hWd: HWND); cdecl;
    function  DUI_HandleCustomMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; cdecl;
    function  DUI_CreateControl(pstrStr: LPCTSTR): CControlUI; cdecl;
    // Delphi虚函数
    procedure DoInitWindow; virtual;
    procedure DoNotify(var Msg: TNotifyUI); virtual;
    procedure DoClick(var msg: TNotifyUI); virtual;
    function  DoHandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; virtual;
    function  DoMessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; virtual;
    procedure DoFinalMessage(hWd: HWND); virtual;
    function  DoHandleCustomMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: BOOL): LRESULT; virtual;
    function  DoCreateControl(pstrStr: string): CControlUI; virtual;
  public
    procedure Show;
    procedure Hide;
    function ShowModal: UINT;
    procedure CenterWindow;
    procedure Close;
    procedure CreateDuiWindow(AParent: HWND; ATitle: string);
    procedure CreateWindow(hwndParent: HWND; ATitle: string; dwStyle: DWORD; dwExStyle: DWORD; const rc: TRect; hMenu: HMENU); overload;
    procedure CreateWindow(hwndParent: HWND; ATitle: string; dwStyle: DWORD; dwExStyle: DWORD; x: Integer = Integer(CW_USEDEFAULT); y: Integer = Integer(CW_USEDEFAULT); cx: Integer = Integer(CW_USEDEFAULT); cy: Integer = Integer(CW_USEDEFAULT); hMenu: HMENU = 0); overload;

    procedure SetIcon(nRes: UINT);
    function FindControl(const AName: string): CControlUI; overload;
    function FindControl(const pt: TPoint): CControlUI; overload;
    function Perform(uMsg: UINT; wParam: WPARAM = 0; lParam: LPARAM = 0): LRESULT;
  public
    constructor Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType);  overload;
    constructor Create(ASkinFile, ASkinFolder: string; ARType: TResourceType);  overload;
    constructor Create(ASkinFile, ASkinFolder: string);  overload;
    constructor Create(ASkinFile, ASkinFolder, AZipFileName: string);  overload;
    destructor Destroy; override;
    procedure OnReceive(Param: Pointer); virtual;
  public
    property Handle: HWND read GetHandle;
    property ParentHandle: HWND read FParentHandle;
    property PaintManagerUI: CPaintManagerUI read FPaintManagerUI;
    property InitSize: TSize read GetInitSize;
  end;


implementation

{ TWindowImplBase }

constructor TDuiWindowImplBase.Create(ASkinFile, ASkinFolder, AZipFileName: string; ARType: TResourceType);
begin
  FThis := CDelphi_WindowImplBase.CppCreate;
  FPaintManagerUI := FThis.GetPaintManagerUI;
  FThis.SetClassName(PChar(ClassName));
  FThis.SetSkinFile(PChar(ASkinFile));
  FThis.SetSkinFolder(PChar(ASkinFolder));
  FThis.SetZipFileName('');
  FThis.SetResourceType(ARType);
  FThis.SetDelphiSelf(Self);

//  Delphi_PaintManagerUI_GetInitSize(FThis.GetPaintManagerUI);
//  Writeln(Format('Delphi PaintManagerUI = %p', [Pointer(PaintManagerUI)]));
//  FThis.GetPaintManagerUI.GetInitSize;

  FThis.SetInitWindow(GetMethodAddr('DUI_InitWindow'));
  FThis.SetClick(GetMethodAddr('DUI_Click'));
  FThis.SetNotify(GetMethodAddr('DUI_Notify'));
  FThis.SetMessageHandler(GetMethodAddr('DUI_MessageHandler'));
  FThis.SetFinalMessage(GetMethodAddr('DUI_FinalMessage'));
  FThis.SetHandleMessage(GetMethodAddr('DUI_HandleMessage'));
  FThis.SetHandleCustomMessage(GetMethodAddr('DUI_HandleCustomMessage'));
  FThis.SetCreateControl(GetMethodAddr('DUI_CreateControl'));
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

destructor TDuiWindowImplBase.Destroy;
begin
  if FThis <> nil then
    FThis.CppDestroy;
  inherited;
end;

procedure TDuiWindowImplBase.CreateDuiWindow(AParent: HWND; ATitle: string);
begin
  FParentHandle := AParent;
  FThis.CreateDuiWindow(AParent, PChar(ATitle), UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE);
end;

procedure TDuiWindowImplBase.CreateWindow(hwndParent: HWND; ATitle: string;
  dwStyle, dwExStyle: DWORD; x, y, cx, cy: Integer; hMenu: HMENU);
begin
  FThis.Create(hwndParent, PChar(ATitle), dwStyle, dwExStyle, x, y, cx, cy, hMenu);
end;

procedure TDuiWindowImplBase.CreateWindow(hwndParent: HWND; ATitle: string;
  dwStyle, dwExStyle: DWORD; const rc: TRect; hMenu: HMENU);
begin
  FThis.Create(hwndParent, PChar(ATitle), dwStyle, dwExStyle, rc, hMenu);
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
end;

function TDuiWindowImplBase.DoHandleCustomMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
begin
  // virtual method
  Result := 0;
end;

function TDuiWindowImplBase.DoHandleMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  // virtual method
  Result := 0;
end;

procedure TDuiWindowImplBase.DoInitWindow;
begin
  // virtual method
end;

function TDuiWindowImplBase.DoMessageHandler(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
begin
  // virtual method
  Result := 0;
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
  Result := DoCreateControl(pstrStr)
end;

procedure TDuiWindowImplBase.DUI_FinalMessage(hWd: HWND);
begin
  DoFinalMessage(hWd);
end;

function TDuiWindowImplBase.DUI_HandleCustomMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
begin
  Result := DoHandleCustomMessage(uMsg, wParam, lParam, bHandled);
end;

function TDuiWindowImplBase.DUI_HandleMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  Result := DoHandleMessage(uMsg, wParam, lParam);
end;

procedure TDuiWindowImplBase.DUI_InitWindow;
begin
  DoInitWindow;
end;

function TDuiWindowImplBase.DUI_MessageHandler(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: BOOL): LRESULT;
begin
  Result := DoMessageHandler(uMsg, wParam, lParam, bHandled);
end;

procedure TDuiWindowImplBase.DUI_Notify(var Msg: TNotifyUI);
begin
  DoNotify(Msg);
end;

function TDuiWindowImplBase.FindControl(const pt: TPoint): CControlUI;
begin
  Result := FPaintManagerUI.FindControl(pt);
end;

function TDuiWindowImplBase.GetHandle: HWND;
begin
  Result := FThis.GetHWND;
end;

function TDuiWindowImplBase.GetInitSize: TSize;
begin
  Result := FPaintManagerUI.GetInitSize;
end;

function TDuiWindowImplBase.FindControl(const AName: string): CControlUI;
begin
  Result := FPaintManagerUI.FindControl(PChar(AName));
end;

procedure TDuiWindowImplBase.Hide;
begin
  FThis.ShowWindow(False, False);
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

procedure TDuiWindowImplBase.SetIcon(nRes: UINT);
begin
  FThis.SetIcon(nRes);
end;

procedure TDuiWindowImplBase.Show;
begin
  FThis.ShowWindow(True, False);
end;

function TDuiWindowImplBase.ShowModal: UINT;
begin
  Result := FThis.ShowModal;
end;

procedure TDuiWindowImplBase.CenterWindow;
begin
  FThis.CenterWindow;
end;

procedure TDuiWindowImplBase.Close;
begin
  FThis.Close();
end;

end.
