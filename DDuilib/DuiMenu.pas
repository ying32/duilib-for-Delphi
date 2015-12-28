//***************************************************************************
//
//       名称：DuiMenu.pas
//       工具：RAD Studio XE6
//       日期：2015/12/26 14:22:28
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       此Menu是将原duilib的MenuDemo提取出来后修改的
//       原存在一些bug和不支持响应，现我已经修正了这些
//       问题，并添加了鼠标响应
//
//***************************************************************************
unit DuiMenu;


{$WARN SYMBOL_DEPRECATED OFF}
{$I DDuilib.inc}
{$Z4+}

interface

uses
  Windows,
  DuiConst,
  Duilib;

type

  CMenuElementUI = class;

  MenuAlignment = (
    eMenuAlignment_Left = 1 shr 1,
    eMenuAlignment_Top = 1 shr 2,
    eMenuAlignment_Right = 1 shr 3,
    eMenuAlignment_Bottom = 1 shr 4
  );
  TMenuAlignment = MenuAlignment;

  ContextMenuParam = packed record
    wParam: WPARAM;
    hWnd: HWND;
  end;
  PContextMenuParam = ^TContextMenuParam;
  TContextMenuParam = ContextMenuParam;


  CMenuUI = class(CListUI)
  public
    class function CppCreate: CMenuUI; deprecated {$IFNDEF UseLowVer}'use Create'{$ENDIF};
    procedure CppDestroy; deprecated {$IFNDEF UseLowVer}'use Free'{$ENDIF};
    class function Create: CMenuUI;
    procedure Free;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoEvent(var event: TEventUI);
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function GetItemIndex(pControl: CControlUI): Integer;
    function SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    function EstimateSize(szAvailable: TSize): TSize;
    procedure SetAttribute(pstrName: string; pstrValue: string);
  end;

  CMenuWnd = class//(CWindowWnd)
  public
    class function CppCreate(hParent: HWND = 0; pMainPaint: CPaintManagerUI = nil): CMenuWnd; deprecated {$IFNDEF UseLowVer}'use Create'{$ENDIF};
    procedure CppDestroy; deprecated {$IFNDEF UseLowVer}'use Free'{$ENDIF};
    class function Create(hParent: HWND = 0; pMainPaint: CPaintManagerUI = nil): CMenuWnd;
    procedure Free;
    procedure Init(pOwner: CMenuElementUI; xml: string; pSkinType: string; point: TPoint);
    function GetWindowClassName: string;
    procedure OnFinalMessage(hWnd: HWND);
    function HandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
    function Receive(param: ContextMenuParam): BOOL;
  end;

  CMenuElementUI = class(CListContainerElementUI)
  public
    class function CppCreate: CMenuElementUI; deprecated {$IFNDEF UseLowVer}'use Create'{$ENDIF};
    procedure CppDestroy; deprecated {$IFNDEF UseLowVer}'use Free'{$ENDIF};
    class function Create: CMenuElementUI;
    procedure Free;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure DrawItemText(hDC: HDC; var rcItem: TRect);
    function EstimateSize(szAvailable: TSize): TSize;
    function Activate: Boolean;
    procedure DoEvent(var event: TEventUI);
    function GetMenuWnd: CMenuWnd;
    procedure CreateMenuWnd;
  end;





//================================CMenuUI============================

function Delphi_MenuUI_CppCreate: CMenuUI; cdecl;
procedure Delphi_MenuUI_CppDestroy(Handle: CMenuUI); cdecl;
function Delphi_MenuUI_GetClass(Handle: CMenuUI): LPCTSTR; cdecl;
function Delphi_MenuUI_GetInterface(Handle: CMenuUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_MenuUI_DoEvent(Handle: CMenuUI; var event: TEventUI); cdecl;
function Delphi_MenuUI_Add(Handle: CMenuUI; pControl: CControlUI): Boolean; cdecl;
function Delphi_MenuUI_AddAt(Handle: CMenuUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_MenuUI_GetItemIndex(Handle: CMenuUI; pControl: CControlUI): Integer; cdecl;
function Delphi_MenuUI_SetItemIndex(Handle: CMenuUI; pControl: CControlUI; iIndex: Integer): Boolean; cdecl;
function Delphi_MenuUI_Remove(Handle: CMenuUI; pControl: CControlUI): Boolean; cdecl;
procedure Delphi_MenuUI_EstimateSize(Handle: CMenuUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_MenuUI_SetAttribute(Handle: CMenuUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;

//================================CMenuWnd============================

function Delphi_MenuWnd_CppCreate(hParent: HWND; pMainPaint: CPaintManagerUI): CMenuWnd; cdecl;
procedure Delphi_MenuWnd_CppDestroy(Handle: CMenuWnd); cdecl;
procedure Delphi_MenuWnd_Init(Handle: CMenuWnd; pOwner: CMenuElementUI; xml: STRINGorID; pSkinType: LPCTSTR; point: TPoint); cdecl;
function Delphi_MenuWnd_GetWindowClassName(Handle: CMenuWnd): LPCTSTR; cdecl;
procedure Delphi_MenuWnd_OnFinalMessage(Handle: CMenuWnd; hWnd: HWND); cdecl;
function Delphi_MenuWnd_HandleMessage(Handle: CMenuWnd; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl;
function Delphi_MenuWnd_Receive(Handle: CMenuWnd; param: ContextMenuParam): BOOL; cdecl;

//================================CMenuElementUI============================

function Delphi_MenuElementUI_CppCreate: CMenuElementUI; cdecl;
procedure Delphi_MenuElementUI_CppDestroy(Handle: CMenuElementUI); cdecl;
function Delphi_MenuElementUI_GetClass(Handle: CMenuElementUI): LPCTSTR; cdecl;
function Delphi_MenuElementUI_GetInterface(Handle: CMenuElementUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_MenuElementUI_DoPaint(Handle: CMenuElementUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_MenuElementUI_DrawItemText(Handle: CMenuElementUI; hDC: HDC; var rcItem: TRect); cdecl;
procedure Delphi_MenuElementUI_EstimateSize(Handle: CMenuElementUI; szAvailable: TSize; var Result: TSize); cdecl;
function Delphi_MenuElementUI_Activate(Handle: CMenuElementUI): Boolean; cdecl;
procedure Delphi_MenuElementUI_DoEvent(Handle: CMenuElementUI; var event: TEventUI); cdecl;
function Delphi_MenuElementUI_GetMenuWnd(Handle: CMenuElementUI): CMenuWnd; cdecl;
procedure Delphi_MenuElementUI_CreateMenuWnd(Handle: CMenuElementUI); cdecl;


implementation


{ CMenuUI }

class function CMenuUI.CppCreate: CMenuUI;
begin
  Result := Delphi_MenuUI_CppCreate;
end;

procedure CMenuUI.CppDestroy;
begin
  Delphi_MenuUI_CppDestroy(Self);
end;

class function CMenuUI.Create: CMenuUI;
begin
  Result := Delphi_MenuUI_CppCreate;
end;

procedure CMenuUI.Free;
begin
  Delphi_MenuUI_CppDestroy(Self);
end;

function CMenuUI.GetClass: string;
begin
  Result := Delphi_MenuUI_GetClass(Self);
end;

function CMenuUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_MenuUI_GetInterface(Self, LPCTSTR(pstrName));
end;

procedure CMenuUI.DoEvent(var event: TEventUI);
begin
  Delphi_MenuUI_DoEvent(Self, event);
end;

function CMenuUI.Add(pControl: CControlUI): Boolean;
begin
  Result := Delphi_MenuUI_Add(Self, pControl);
end;

function CMenuUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_MenuUI_AddAt(Self, pControl, iIndex);
end;

function CMenuUI.GetItemIndex(pControl: CControlUI): Integer;
begin
  Result := Delphi_MenuUI_GetItemIndex(Self, pControl);
end;

function CMenuUI.SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := Delphi_MenuUI_SetItemIndex(Self, pControl, iIndex);
end;

function CMenuUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := Delphi_MenuUI_Remove(Self, pControl);
end;

function CMenuUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_MenuUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CMenuUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_MenuUI_SetAttribute(Self, LPCTSTR(pstrName), LPCTSTR(pstrValue));
end;

{ CMenuWnd }

class function CMenuWnd.CppCreate(hParent: HWND; pMainPaint: CPaintManagerUI): CMenuWnd;
begin
  Result := Delphi_MenuWnd_CppCreate(hParent, pMainPaint);
end;

procedure CMenuWnd.CppDestroy;
begin
  Delphi_MenuWnd_CppDestroy(Self);
end;

class function CMenuWnd.Create(hParent: HWND = 0; pMainPaint: CPaintManagerUI = nil): CMenuWnd;
begin
  Result := Delphi_MenuWnd_CppCreate(hParent, pMainPaint);
end;

procedure CMenuWnd.Free;
begin
  Delphi_MenuWnd_CppDestroy(Self);
end;

procedure CMenuWnd.Init(pOwner: CMenuElementUI; xml: string; pSkinType: string; point: TPoint);
begin
  Delphi_MenuWnd_Init(Self, pOwner, STRINGorID(xml), LPCTSTR(pSkinType), point);
end;

function CMenuWnd.GetWindowClassName: string;
begin
  Result := Delphi_MenuWnd_GetWindowClassName(Self);
end;

procedure CMenuWnd.OnFinalMessage(hWnd: HWND);
begin
  Delphi_MenuWnd_OnFinalMessage(Self, hWnd);
end;

function CMenuWnd.HandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := Delphi_MenuWnd_HandleMessage(Self, uMsg, wParam, lParam);
end;

function CMenuWnd.Receive(param: ContextMenuParam): BOOL;
begin
  Result := Delphi_MenuWnd_Receive(Self, param);
end;

{ CMenuElementUI }

class function CMenuElementUI.CppCreate: CMenuElementUI;
begin
  Result := Delphi_MenuElementUI_CppCreate;
end;

procedure CMenuElementUI.CppDestroy;
begin
  Delphi_MenuElementUI_CppDestroy(Self);
end;

class function CMenuElementUI.Create: CMenuElementUI;
begin
  Result := Delphi_MenuElementUI_CppCreate;
end;

procedure CMenuElementUI.Free;
begin
  Delphi_MenuElementUI_CppDestroy(Self);
end;

function CMenuElementUI.GetClass: string;
begin
  Result := Delphi_MenuElementUI_GetClass(Self);
end;

function CMenuElementUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_MenuElementUI_GetInterface(Self, LPCTSTR(pstrName));
end;

procedure CMenuElementUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_MenuElementUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CMenuElementUI.DrawItemText(hDC: HDC; var rcItem: TRect);
begin
  Delphi_MenuElementUI_DrawItemText(Self, hDC, rcItem);
end;

function CMenuElementUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_MenuElementUI_EstimateSize(Self, szAvailable, Result);
end;

function CMenuElementUI.Activate: Boolean;
begin
  Result := Delphi_MenuElementUI_Activate(Self);
end;

procedure CMenuElementUI.DoEvent(var event: TEventUI);
begin
  Delphi_MenuElementUI_DoEvent(Self, event);
end;

function CMenuElementUI.GetMenuWnd: CMenuWnd;
begin
  Result := Delphi_MenuElementUI_GetMenuWnd(Self);
end;

procedure CMenuElementUI.CreateMenuWnd;
begin
  Delphi_MenuElementUI_CreateMenuWnd(Self);
end;



//================================CMenuUI============================

function Delphi_MenuUI_CppCreate; external DuiLibdll name 'Delphi_MenuUI_CppCreate';
procedure Delphi_MenuUI_CppDestroy; external DuiLibdll name 'Delphi_MenuUI_CppDestroy';
function Delphi_MenuUI_GetClass; external DuiLibdll name 'Delphi_MenuUI_GetClass';
function Delphi_MenuUI_GetInterface; external DuiLibdll name 'Delphi_MenuUI_GetInterface';
procedure Delphi_MenuUI_DoEvent; external DuiLibdll name 'Delphi_MenuUI_DoEvent';
function Delphi_MenuUI_Add; external DuiLibdll name 'Delphi_MenuUI_Add';
function Delphi_MenuUI_AddAt; external DuiLibdll name 'Delphi_MenuUI_AddAt';
function Delphi_MenuUI_GetItemIndex; external DuiLibdll name 'Delphi_MenuUI_GetItemIndex';
function Delphi_MenuUI_SetItemIndex; external DuiLibdll name 'Delphi_MenuUI_SetItemIndex';
function Delphi_MenuUI_Remove; external DuiLibdll name 'Delphi_MenuUI_Remove';
procedure Delphi_MenuUI_EstimateSize; external DuiLibdll name 'Delphi_MenuUI_EstimateSize';
procedure Delphi_MenuUI_SetAttribute; external DuiLibdll name 'Delphi_MenuUI_SetAttribute';

//================================CMenuWnd============================

function Delphi_MenuWnd_CppCreate; external DuiLibdll name 'Delphi_MenuWnd_CppCreate';
procedure Delphi_MenuWnd_CppDestroy; external DuiLibdll name 'Delphi_MenuWnd_CppDestroy';
procedure Delphi_MenuWnd_Init; external DuiLibdll name 'Delphi_MenuWnd_Init';
function Delphi_MenuWnd_GetWindowClassName; external DuiLibdll name 'Delphi_MenuWnd_GetWindowClassName';
procedure Delphi_MenuWnd_OnFinalMessage; external DuiLibdll name 'Delphi_MenuWnd_OnFinalMessage';
function Delphi_MenuWnd_HandleMessage; external DuiLibdll name 'Delphi_MenuWnd_HandleMessage';
function Delphi_MenuWnd_Receive; external DuiLibdll name 'Delphi_MenuWnd_Receive';

//================================CMenuElementUI============================

function Delphi_MenuElementUI_CppCreate; external DuiLibdll name 'Delphi_MenuElementUI_CppCreate';
procedure Delphi_MenuElementUI_CppDestroy; external DuiLibdll name 'Delphi_MenuElementUI_CppDestroy';
function Delphi_MenuElementUI_GetClass; external DuiLibdll name 'Delphi_MenuElementUI_GetClass';
function Delphi_MenuElementUI_GetInterface; external DuiLibdll name 'Delphi_MenuElementUI_GetInterface';
procedure Delphi_MenuElementUI_DoPaint; external DuiLibdll name 'Delphi_MenuElementUI_DoPaint';
procedure Delphi_MenuElementUI_DrawItemText; external DuiLibdll name 'Delphi_MenuElementUI_DrawItemText';
procedure Delphi_MenuElementUI_EstimateSize; external DuiLibdll name 'Delphi_MenuElementUI_EstimateSize';
function Delphi_MenuElementUI_Activate; external DuiLibdll name 'Delphi_MenuElementUI_Activate';
procedure Delphi_MenuElementUI_DoEvent; external DuiLibdll name 'Delphi_MenuElementUI_DoEvent';
function Delphi_MenuElementUI_GetMenuWnd; external DuiLibdll name 'Delphi_MenuElementUI_GetMenuWnd';
procedure Delphi_MenuElementUI_CreateMenuWnd; external DuiLibdll name 'Delphi_MenuElementUI_CreateMenuWnd';

end.
