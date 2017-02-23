//***************************************************************************
//
//       名称：DuiVclControl.pas
//       工具：RAD Studio XE6
//       日期：2017/02/23
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2017 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiVclControl;

{$I DDuilib.inc}

interface

uses
  Windows,
  Controls,
  Types,
  Duilib;

type

  CVCLControlUI = class(CContainerUI)
  public
    class function CppCreate(lpObject: Pointer = nil; bisFree: Boolean = True): CVCLControlUI;
    procedure CppDestroy;
    procedure SetInternVisible(bVisible: Boolean = True);
    procedure SetVisible(bVisible: Boolean = True);
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean);
    function GetClass: string;
    function GetVclObject: Pointer;
    procedure SetVclObject(lpObject: Pointer);
    function GetIsFree: Boolean;
    procedure SetIsFree(bisFree: Boolean);
  public
    property IsFree: Boolean read GetIsFree write SetIsFree;
    property VclObject: LPVOID read GetVclObject write SetVclObject;
  end;


//================================CVCLControlUI============================

function Delphi_VCLControlUI_CppCreate(lpObject: Pointer; bisFree: Boolean): CVCLControlUI; cdecl;
procedure Delphi_VCLControlUI_CppDestroy(Handle: CVCLControlUI); cdecl;
procedure Delphi_VCLControlUI_SetInternVisible(Handle: CVCLControlUI; bVisible: Boolean); cdecl;
procedure Delphi_VCLControlUI_SetVisible(Handle: CVCLControlUI; bVisible: Boolean); cdecl;
procedure Delphi_VCLControlUI_SetPos(Handle: CVCLControlUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
function Delphi_VCLControlUI_GetClass(Handle: CVCLControlUI): LPCTSTR; cdecl;
function Delphi_VCLControlUI_GetVclObject(Handle: CVCLControlUI): Pointer; cdecl;
procedure Delphi_VCLControlUI_SetVclObject(Handle: CVCLControlUI; lpObject: Pointer); cdecl;
function Delphi_VCLControlUI_GetIsFree(Handle: CVCLControlUI): Boolean; cdecl;
procedure Delphi_VCLControlUI_SetIsFree(Handle: CVCLControlUI; bisFree: Boolean); cdecl;

implementation

uses
  SysUtils;

{ CVCLControlUI }

class function CVCLControlUI.CppCreate(lpObject: Pointer; bisFree: Boolean): CVCLControlUI;
begin
  Result := Delphi_VCLControlUI_CppCreate(lpObject, bisFree);
end;

procedure CVCLControlUI.CppDestroy;
begin
  Delphi_VCLControlUI_CppDestroy(Self);
end;

procedure CVCLControlUI.SetInternVisible(bVisible: Boolean);
begin
  Delphi_VCLControlUI_SetInternVisible(Self, bVisible);
end;

procedure CVCLControlUI.SetVisible(bVisible: Boolean);
begin
  Delphi_VCLControlUI_SetVisible(Self, bVisible);
end;

procedure CVCLControlUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_VCLControlUI_SetPos(Self, rc, bNeedInvalidate);
end;

function CVCLControlUI.GetClass: string;
begin
  Result := Delphi_VCLControlUI_GetClass(Self);
end;

function CVCLControlUI.GetVclObject: Pointer;
begin
  Result := Delphi_VCLControlUI_GetVclObject(Self);
end;

procedure CVCLControlUI.SetVclObject(lpObject: Pointer);
begin
  Delphi_VCLControlUI_SetVclObject(Self, lpObject);
end;

function CVCLControlUI.GetIsFree: Boolean;
begin
  Result := Delphi_VCLControlUI_GetIsFree(Self);
end;

procedure CVCLControlUI.SetIsFree(bisFree: Boolean);
begin
  Delphi_VCLControlUI_SetIsFree(Self, bisFree);
end;


//================================CVCLControlUI============================

function Delphi_VCLControlUI_CppCreate; external DuiLibdll name 'Delphi_VCLControlUI_CppCreate';
procedure Delphi_VCLControlUI_CppDestroy; external DuiLibdll name 'Delphi_VCLControlUI_CppDestroy';
procedure Delphi_VCLControlUI_SetInternVisible; external DuiLibdll name 'Delphi_VCLControlUI_SetInternVisible';
procedure Delphi_VCLControlUI_SetVisible; external DuiLibdll name 'Delphi_VCLControlUI_SetVisible';
procedure Delphi_VCLControlUI_SetPos; external DuiLibdll name 'Delphi_VCLControlUI_SetPos';
function Delphi_VCLControlUI_GetClass; external DuiLibdll name 'Delphi_VCLControlUI_GetClass';
function Delphi_VCLControlUI_GetVclObject; external DuiLibdll name 'Delphi_VCLControlUI_GetVclObject';
procedure Delphi_VCLControlUI_SetVclObject; external DuiLibdll name 'Delphi_VCLControlUI_SetVclObject';
function Delphi_VCLControlUI_GetIsFree; external DuiLibdll name 'Delphi_VCLControlUI_GetIsFree';
procedure Delphi_VCLControlUI_SetIsFree; external DuiLibdll name 'Delphi_VCLControlUI_SetIsFree';


procedure SetDelphiVisibleMethodPtr(ptr: LPVOID); cdecl; external DuiLibdll name 'SetDelphiVisibleMethodPtr';
procedure SetDelphiFreeMethodPtr(ptr: LPVOID); cdecl; external DuiLibdll name 'SetDelphiFreeMethodPtr';
procedure SetDelphiSetBoundsMethodPtr(ptr: LPVOID); cdecl; external DuiLibdll name 'SetDelphiSetBoundsMethodPtr';
procedure SetDelphiSetParentWindowMethodPtr(ptr: LPVOID); cdecl; external DuiLibdll name 'SetDelphiSetParentWindowMethodPtr';
procedure SetDelphiGetHandleMethodPtr(ptr: LPVOID); cdecl; external DuiLibdll name 'SetDelphiGetHandleMethodPtr';


procedure _DelphiVisibleMethod(AObj: TObject; AVisible: Boolean); cdecl;
begin
  if AObj <> nil then
    TControl(AObj).Visible := AVisible;
end;

procedure _DelphiFreeMethod(AObj: TObject); cdecl;
begin
  if AObj <> nil then
    AObj.Free;
end;

procedure _DelphiSetBoundsMethod(AObj: TObject; ARc: TRect); cdecl;
begin
  if (AObj <> nil) then
    TWinControl(AObj).SetBounds(ARc.Left, ARc.Top, ARc.Width, ARc.Height);
end;

procedure _SetParentWindowMethod(AObj: TObject; AhWnd: HWND); cdecl;
begin
  if (AObj <> nil) and (AObj is TWinControl) then
    TWinControl(AObj).ParentWindow := AhWnd;
end;


function _GetHandleMethod(AObj: TObject): HWND; cdecl;
begin
  Result := 0;
  if (AObj <> nil) and (AObj is TWinControl) then
    Result := TWinControl(AObj).Handle;
end;


initialization
  // 初始相关函数
  SetDelphiVisibleMethodPtr(@_DelphiVisibleMethod);
  SetDelphiFreeMethodPtr(@_DelphiFreeMethod);
  SetDelphiSetBoundsMethodPtr(@_DelphiSetBoundsMethod);
  SetDelphiSetParentWindowMethodPtr(@_SetParentWindowMethod);
  SetDelphiGetHandleMethodPtr(@_GetHandleMethod);

end.
