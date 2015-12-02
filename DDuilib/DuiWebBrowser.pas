//***************************************************************************
//
//       名称：DuiWebBrowser.pas
//       工具：RAD Studio XE6
//       日期：2015/12/2
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       注：这个单元是使用自动转换后手动建立的
//***************************************************************************
unit DuiWebBrowser;

interface

uses
  Winapi.Windows,
  Winapi.ActiveX,
  SHDocVw,
  Duilib,
  DuiActiveX;

type

  CWebBrowserUI = class(CActiveXUI)
  private
    procedure NavigateUrl(lpszUrl: LPCTSTR); overload;
    procedure Navigate2(lpszUrl: LPCTSTR); overload;
    procedure SetHomePage(lpszUrl: LPCTSTR);
    function GetHomePage: LPCTSTR;
    function GetWebBrowser2: IWebBrowser2;
    function GetHtmlWindow: IDispatch;
  public
    class function CppCreate: CWebBrowserUI;
    procedure CppDestroy;
    function GetClass: LPCTSTR;
    function GetInterface(pstrName: LPCTSTR): Pointer;
    procedure SetAutoNavigation(bAuto: Boolean = TRUE);
    function IsAutoNavigation: Boolean;
    procedure SetWebBrowserEventHandler(pEventHandler: CWebBrowserEventHandler);
    procedure Navigate2(AURL: string); overload;
    procedure Refresh;
    procedure Refresh2(Level: Integer);
    procedure GoBack;
    procedure GoForward;
    procedure NavigateHomePage;
    procedure NavigateUrl(AURL: string); overload;
    function DoCreateControl: Boolean;
    class function FindId(pObj: IDispatch; pName: POleStr): LONG;
    class function InvokeMethod(pObj: IDispatch; pMehtod: POleStr; pVarResult: PVARIANT; ps: PVARIANT; cArgs: Integer): HRESULT;
    class function GetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT;
    class function SetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT;
  private
    function _GetHomePage: string;
    procedure _SetHomePage(const Value: string);
  public
    property HomePage: string read _GetHomePage write _SetHomePage;
    property WebBrowser2: IWebBrowser2 read GetWebBrowser2;
    property HtmlWindow: IDispatch read GetHtmlWindow;
  end;



//================================CWebBrowserUI============================

function Delphi_WebBrowserUI_CppCreate: CWebBrowserUI; cdecl;
procedure Delphi_WebBrowserUI_CppDestroy(Handle: CWebBrowserUI); cdecl;
function Delphi_WebBrowserUI_GetClass(Handle: CWebBrowserUI): LPCTSTR; cdecl;
function Delphi_WebBrowserUI_GetInterface(Handle: CWebBrowserUI; pstrName: LPCTSTR): Pointer; cdecl;
procedure Delphi_WebBrowserUI_SetHomePage(Handle: CWebBrowserUI; lpszUrl: LPCTSTR); cdecl;
function Delphi_WebBrowserUI_GetHomePage(Handle: CWebBrowserUI): LPCTSTR; cdecl;
procedure Delphi_WebBrowserUI_SetAutoNavigation(Handle: CWebBrowserUI; bAuto: Boolean); cdecl;
function Delphi_WebBrowserUI_IsAutoNavigation(Handle: CWebBrowserUI): Boolean; cdecl;
procedure Delphi_WebBrowserUI_SetWebBrowserEventHandler(Handle: CWebBrowserUI; pEventHandler: CWebBrowserEventHandler); cdecl;
procedure Delphi_WebBrowserUI_Navigate2(Handle: CWebBrowserUI; lpszUrl: LPCTSTR); cdecl;
procedure Delphi_WebBrowserUI_Refresh(Handle: CWebBrowserUI); cdecl;
procedure Delphi_WebBrowserUI_Refresh2(Handle: CWebBrowserUI; Level: Integer); cdecl;
procedure Delphi_WebBrowserUI_GoBack(Handle: CWebBrowserUI); cdecl;
procedure Delphi_WebBrowserUI_GoForward(Handle: CWebBrowserUI); cdecl;
procedure Delphi_WebBrowserUI_NavigateHomePage(Handle: CWebBrowserUI); cdecl;
procedure Delphi_WebBrowserUI_NavigateUrl(Handle: CWebBrowserUI; lpszUrl: LPCTSTR); cdecl;
function Delphi_WebBrowserUI_DoCreateControl(Handle: CWebBrowserUI): Boolean; cdecl;
function Delphi_WebBrowserUI_GetWebBrowser2(Handle: CWebBrowserUI): IWebBrowser2; cdecl;
function Delphi_WebBrowserUI_GetHtmlWindow(Handle: CWebBrowserUI): IDispatch; cdecl;
function Delphi_WebBrowserUI_FindId(pObj: IDispatch; pName: POleStr): LONG; cdecl;
function Delphi_WebBrowserUI_InvokeMethod(pObj: IDispatch; pMehtod: POleStr; pVarResult: PVARIANT; ps: PVARIANT; cArgs: Integer): HRESULT; cdecl;
function Delphi_WebBrowserUI_GetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT; cdecl;
function Delphi_WebBrowserUI_SetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT; cdecl;


implementation

{ CWebBrowserUI }

class function CWebBrowserUI.CppCreate: CWebBrowserUI;
begin
  Result := Delphi_WebBrowserUI_CppCreate;
end;

procedure CWebBrowserUI.CppDestroy;
begin
  Delphi_WebBrowserUI_CppDestroy(Self);
end;

function CWebBrowserUI.GetClass: LPCTSTR;
begin
  Result := Delphi_WebBrowserUI_GetClass(Self);
end;

function CWebBrowserUI.GetInterface(pstrName: LPCTSTR): Pointer;
begin
  Result := Delphi_WebBrowserUI_GetInterface(Self, pstrName);
end;

procedure CWebBrowserUI.SetHomePage(lpszUrl: LPCTSTR);
begin
  Delphi_WebBrowserUI_SetHomePage(Self, lpszUrl);
end;

function CWebBrowserUI.GetHomePage: LPCTSTR;
begin
  Result := Delphi_WebBrowserUI_GetHomePage(Self);
end;

procedure CWebBrowserUI.SetAutoNavigation(bAuto: Boolean);
begin
  Delphi_WebBrowserUI_SetAutoNavigation(Self, bAuto);
end;

function CWebBrowserUI.IsAutoNavigation: Boolean;
begin
  Result := Delphi_WebBrowserUI_IsAutoNavigation(Self);
end;

procedure CWebBrowserUI.SetWebBrowserEventHandler(pEventHandler: CWebBrowserEventHandler);
begin
  Delphi_WebBrowserUI_SetWebBrowserEventHandler(Self, pEventHandler);
end;

function CWebBrowserUI._GetHomePage: string;
begin
  Result := GetHomePage;
end;

procedure CWebBrowserUI._SetHomePage(const Value: string);
begin
  SetHomePage(PChar(Value));
end;

procedure CWebBrowserUI.Navigate2(lpszUrl: LPCTSTR);
begin
  Delphi_WebBrowserUI_Navigate2(Self, lpszUrl);
end;

procedure CWebBrowserUI.Refresh;
begin
  Delphi_WebBrowserUI_Refresh(Self);
end;

procedure CWebBrowserUI.Refresh2(Level: Integer);
begin
  Delphi_WebBrowserUI_Refresh2(Self, Level);
end;

procedure CWebBrowserUI.GoBack;
begin
  Delphi_WebBrowserUI_GoBack(Self);
end;

procedure CWebBrowserUI.GoForward;
begin
  Delphi_WebBrowserUI_GoForward(Self);
end;

procedure CWebBrowserUI.Navigate2(AURL: string);
begin
  Navigate2(PChar(AURL));
end;

procedure CWebBrowserUI.NavigateHomePage;
begin
  Delphi_WebBrowserUI_NavigateHomePage(Self);
end;

procedure CWebBrowserUI.NavigateUrl(AURL: string);
begin
  NavigateUrl(PChar(AURL));
end;

procedure CWebBrowserUI.NavigateUrl(lpszUrl: LPCTSTR);
begin
  Delphi_WebBrowserUI_NavigateUrl(Self, lpszUrl);
end;

function CWebBrowserUI.DoCreateControl: Boolean;
begin
  Result := Delphi_WebBrowserUI_DoCreateControl(Self);
end;

function CWebBrowserUI.GetWebBrowser2: IWebBrowser2;
begin
  Result := Delphi_WebBrowserUI_GetWebBrowser2(Self);
end;

function CWebBrowserUI.GetHtmlWindow: IDispatch;
begin
  Result := Delphi_WebBrowserUI_GetHtmlWindow(Self);
end;

class function CWebBrowserUI.FindId(pObj: IDispatch; pName: POleStr): LONG;
begin
  Result := Delphi_WebBrowserUI_FindId(pObj, pName);
end;

class function CWebBrowserUI.InvokeMethod(pObj: IDispatch; pMehtod: POleStr; pVarResult: PVARIANT; ps: PVARIANT; cArgs: Integer): HRESULT;
begin
  Result := Delphi_WebBrowserUI_InvokeMethod(pObj, pMehtod, pVarResult, ps, cArgs);
end;

class function CWebBrowserUI.GetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT;
begin
  Result := Delphi_WebBrowserUI_GetProperty(pObj, pName, pValue);
end;

class function CWebBrowserUI.SetProperty(pObj: IDispatch; pName: POleStr; pValue: PVARIANT): HRESULT;
begin
  Result := Delphi_WebBrowserUI_SetProperty(pObj, pName, pValue);
end;


//================================CWebBrowserUI============================

function Delphi_WebBrowserUI_CppCreate; external DuiLibdll name 'Delphi_WebBrowserUI_CppCreate';
procedure Delphi_WebBrowserUI_CppDestroy; external DuiLibdll name 'Delphi_WebBrowserUI_CppDestroy';
function Delphi_WebBrowserUI_GetClass; external DuiLibdll name 'Delphi_WebBrowserUI_GetClass';
function Delphi_WebBrowserUI_GetInterface; external DuiLibdll name 'Delphi_WebBrowserUI_GetInterface';
procedure Delphi_WebBrowserUI_SetHomePage; external DuiLibdll name 'Delphi_WebBrowserUI_SetHomePage';
function Delphi_WebBrowserUI_GetHomePage; external DuiLibdll name 'Delphi_WebBrowserUI_GetHomePage';
procedure Delphi_WebBrowserUI_SetAutoNavigation; external DuiLibdll name 'Delphi_WebBrowserUI_SetAutoNavigation';
function Delphi_WebBrowserUI_IsAutoNavigation; external DuiLibdll name 'Delphi_WebBrowserUI_IsAutoNavigation';
procedure Delphi_WebBrowserUI_SetWebBrowserEventHandler; external DuiLibdll name 'Delphi_WebBrowserUI_SetWebBrowserEventHandler';
procedure Delphi_WebBrowserUI_Navigate2; external DuiLibdll name 'Delphi_WebBrowserUI_Navigate2';
procedure Delphi_WebBrowserUI_Refresh; external DuiLibdll name 'Delphi_WebBrowserUI_Refresh';
procedure Delphi_WebBrowserUI_Refresh2; external DuiLibdll name 'Delphi_WebBrowserUI_Refresh2';
procedure Delphi_WebBrowserUI_GoBack; external DuiLibdll name 'Delphi_WebBrowserUI_GoBack';
procedure Delphi_WebBrowserUI_GoForward; external DuiLibdll name 'Delphi_WebBrowserUI_GoForward';
procedure Delphi_WebBrowserUI_NavigateHomePage; external DuiLibdll name 'Delphi_WebBrowserUI_NavigateHomePage';
procedure Delphi_WebBrowserUI_NavigateUrl; external DuiLibdll name 'Delphi_WebBrowserUI_NavigateUrl';
function Delphi_WebBrowserUI_DoCreateControl; external DuiLibdll name 'Delphi_WebBrowserUI_DoCreateControl';
function Delphi_WebBrowserUI_GetWebBrowser2; external DuiLibdll name 'Delphi_WebBrowserUI_GetWebBrowser2';
function Delphi_WebBrowserUI_GetHtmlWindow; external DuiLibdll name 'Delphi_WebBrowserUI_GetHtmlWindow';
function Delphi_WebBrowserUI_FindId; external DuiLibdll name 'Delphi_WebBrowserUI_FindId';
function Delphi_WebBrowserUI_InvokeMethod; external DuiLibdll name 'Delphi_WebBrowserUI_InvokeMethod';
function Delphi_WebBrowserUI_GetProperty; external DuiLibdll name 'Delphi_WebBrowserUI_GetProperty';
function Delphi_WebBrowserUI_SetProperty; external DuiLibdll name 'Delphi_WebBrowserUI_SetProperty';

end.
