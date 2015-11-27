//***************************************************************************
//
//       名称：DuilibHelper.pas
//       工具：RAD Studio XE6
//       日期：2015/11/27 22:33:08
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuilibHelper;

interface

uses
  Winapi.Windows,
  Duilib;


type
  CControlUIHelper = class helper for CControlUI
  private
    procedure _SetText(const Value: string);
    function _GetText: string;
    function _GetName: string;
    procedure _SetName(const Value: string);
    function _GetClassName: string;
    function _GetParent: CControlUI;
    function _GetBkColor: DWORD;
    procedure _SetBkColor(const Value: DWORD);
    function _GetBkColor2: DWORD;
    procedure _SetBkColor2(const Value: DWORD);
    function _GetBkColor3: DWORD;
    procedure _SetBkColor3(const Value: DWORD);
    function _GetBkImage: string;
    procedure _SetBkImage(const Value: string);
    function _GetFocusBorderColor: DWORD;
    procedure _SetFocusBorderColor(const Value: DWORD);
    function _GetColorHSL: Boolean;
    procedure _SetColorHSL(const Value: Boolean);
    function _GetBorderRound: TSize;
    procedure _SetBorderRound(const Value: TSize);
    function _GetBorderSize: Integer;
    procedure _SetBorderSize(const Value: Integer);
    function _GetToolTip: string;
    procedure _SetToolTip(const Value: string);
    function _GetToolTipWidth: Integer;
    procedure _SetToolTipWidth(const Value: Integer);
    function _GetShortcut: Char;
    procedure _SetShortcut(const Value: Char);
    procedure _SetContextMenuUsed(const Value: Boolean);
    function _GetContextMenuUsed: Boolean;
    function _GetVirtualWnd: string;
    procedure _SetVirtualWnd(const Value: string);
    function _GetVisible: Boolean;
    procedure _SetVisible(const Value: Boolean);
    function _GetTag: UIntPtr;
    procedure _SetTag(const Value: UIntPtr);
    function _GetFixedHeight: Integer;
    procedure _SetFixedHeight(const Value: Integer);
  public
    procedure Hide;
    procedure Show;
  public
    property Text: string read _GetText write _SetText;
    property ToolTip: string read _GetToolTip write _SetToolTip;
    property ToolTipWidth: Integer read _GetToolTipWidth write _SetToolTipWidth;
    property Name: string read _GetName write _SetName;
    property ClassName: string read _GetClassName;
    property Parent: CControlUI read _GetParent;
    property BkColor: DWORD read _GetBkColor write _SetBkColor;
    property BkColor2: DWORD read _GetBkColor2 write _SetBkColor2;
    property BkColor3: DWORD read _GetBkColor3 write _SetBkColor3;
    property BkImage: string read _GetBkImage write _SetBkImage;
    property FocusBorderColor: DWORD read _GetFocusBorderColor write _SetFocusBorderColor;
    property ColorHSL: Boolean read _GetColorHSL write _SetColorHSL;
    property BorderRound: TSize read _GetBorderRound write _SetBorderRound;
    property BorderSize: Integer read _GetBorderSize write _SetBorderSize;
    property Shortcut: Char read _GetShortcut write _SetShortcut;
    property ContextMenuUsed: Boolean read _GetContextMenuUsed write _SetContextMenuUsed;
    property VirtualWnd: string read _GetVirtualWnd write _SetVirtualWnd;
    property Visible: Boolean read _GetVisible write _SetVisible;
    property Tag: UIntPtr read _GetTag write _SetTag;
    property FixedHeight: Integer read _GetFixedHeight write _SetFixedHeight;
  end;

  CTabLayoutUIHelper = class helper for CTabLayoutUI
  private
    function _GetSelectIndex: Integer;
    procedure _SetSelectIndex(const Value: Integer);
  public
    property SelectIndex: Integer read _GetSelectIndex write _SetSelectIndex;
  end;

  CLabelUIHelper = class helper for CLabelUI
  private
    function _GetShowHtml: Boolean;
    procedure _SetShowHtml(const Value: Boolean);
  public
    property ShowHtml: Boolean read _GetShowHtml write _SetShowHtml;
  end;


implementation

{ CControlUIHelper }

procedure CControlUIHelper.Hide;
begin
  SetVisible(False);
end;

procedure CControlUIHelper.Show;
begin
  SetVisible(True);
end;

function CControlUIHelper._GetBkColor: DWORD;
begin
  Result := GetBkColor;
end;

function CControlUIHelper._GetBkColor2: DWORD;
begin
  Result := GetBkColor2;
end;

function CControlUIHelper._GetBkColor3: DWORD;
begin
  Result := GetBkColor3;
end;

function CControlUIHelper._GetBkImage: string;
begin
  Result := GetBkImage;
end;

function CControlUIHelper._GetBorderRound: TSize;
begin
  Result := GetBorderRound;
end;

function CControlUIHelper._GetBorderSize: Integer;
begin
  Result := GetBorderSize;
end;

function CControlUIHelper._GetClassName: string;
begin
  Result := GetClass;
end;

function CControlUIHelper._GetColorHSL: Boolean;
begin
  Result := IsColorHSL;
end;

function CControlUIHelper._GetContextMenuUsed: Boolean;
begin
  Result := IsContextMenuUsed;
end;

function CControlUIHelper._GetFixedHeight: Integer;
begin
  Result := GetFixedHeight;
end;

function CControlUIHelper._GetFocusBorderColor: DWORD;
begin
  Result := GetFocusBorderColor;
end;

function CControlUIHelper._GetName: string;
begin
  Result := GetName;
end;

function CControlUIHelper._GetParent: CControlUI;
begin
  Result := GetParent;
end;

function CControlUIHelper._GetShortcut: Char;
begin
  Result := GetShortcut;
end;

function CControlUIHelper._GetTag: UIntPtr;
begin
  Result := GetTag;
end;

function CControlUIHelper._GetText: string;
begin
  Result := GetText;
end;

function CControlUIHelper._GetToolTip: string;
begin
  Result := GetToolTip;
end;

function CControlUIHelper._GetToolTipWidth: Integer;
begin
  Result := GetToolTipWidth;
end;

function CControlUIHelper._GetVirtualWnd: string;
begin
  Result := GetVirtualWnd;
end;

function CControlUIHelper._GetVisible: Boolean;
begin
  Result := IsVisible;
end;

procedure CControlUIHelper._SetBkColor(const Value: DWORD);
begin
  SetBkColor(Value);
end;

procedure CControlUIHelper._SetBkColor2(const Value: DWORD);
begin
  SetBkColor2(Value);
end;

procedure CControlUIHelper._SetBkColor3(const Value: DWORD);
begin
  SetBkColor3(Value);
end;

procedure CControlUIHelper._SetBkImage(const Value: string);
begin
  SetBkImage(PChar(Value));
end;

procedure CControlUIHelper._SetBorderRound(const Value: TSize);
begin
  SetBorderRound(Value);
end;

procedure CControlUIHelper._SetBorderSize(const Value: Integer);
begin
  SetBorderSize(Value);
end;

procedure CControlUIHelper._SetColorHSL(const Value: Boolean);
begin
  SetColorHSL(Value);
end;

procedure CControlUIHelper._SetContextMenuUsed(const Value: Boolean);
begin
  SetContextMenuUsed(Value);
end;

procedure CControlUIHelper._SetFixedHeight(const Value: Integer);
begin
  SetFixedHeight(Value);
end;

procedure CControlUIHelper._SetFocusBorderColor(const Value: DWORD);
begin
  SetFocusBorderColor(Value);
end;

procedure CControlUIHelper._SetName(const Value: string);
begin
  SetName(PChar(Value));
end;

procedure CControlUIHelper._SetShortcut(const Value: Char);
begin
  SetShortcut(Value);
end;

procedure CControlUIHelper._SetTag(const Value: UIntPtr);
begin
  SetTag(Value);
end;

procedure CControlUIHelper._SetText(const Value: string);
begin
  SetText(PChar(Value));
end;

procedure CControlUIHelper._SetToolTip(const Value: string);
begin
  SetToolTip(PChar(Value));
end;

procedure CControlUIHelper._SetToolTipWidth(const Value: Integer);
begin
  SetToolTipWidth(Value);
end;

procedure CControlUIHelper._SetVirtualWnd(const Value: string);
begin
  SetVirtualWnd(PChar(Value));
end;

procedure CControlUIHelper._SetVisible(const Value: Boolean);
begin
  SetVisible(Value);
end;

{ CTabLayoutUIHelper }

function CTabLayoutUIHelper._GetSelectIndex: Integer;
begin
  Result := GetCurSel;
end;

procedure CTabLayoutUIHelper._SetSelectIndex(const Value: Integer);
begin
  SelectItem(Value);
end;

{ CLabelUIHelper }

function CLabelUIHelper._GetShowHtml: Boolean;
begin
  Result := IsShowHtml;
end;

procedure CLabelUIHelper._SetShowHtml(const Value: Boolean);
begin
  SetShowHtml(Value);
end;

end.
