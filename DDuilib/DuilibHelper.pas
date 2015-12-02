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
  System.DateUtils,
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
    function _GetEnabled: Boolean;
    procedure _SetEnabled(const Value: Boolean);
  public
    procedure Hide;
    procedure Show;
  public
    property Text: string read _GetText write _SetText;
    property ToolTip: string read _GetToolTip write _SetToolTip;
    property ToolTipWidth: Integer read _GetToolTipWidth write _SetToolTipWidth;
    property Name: string read _GetName write _SetName;
    property ClassName: string read _GetClassName;
    property Enabled: Boolean read _GetEnabled write _SetEnabled;
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

  CButtonUIHelper = class helper for CButtonUI
  private
    function _GetNormalImage: string;
    procedure _SetNormalImage(const Value: string);
    function _GetHotImage: string;
    procedure _SetHotImage(const Value: string);
    function _GetPushedImage: string;
    procedure _SetPushedImage(const Value: string);
    function _GetFocusedImage: string;
    procedure _SetFocusedImage(const Value: string);
    function _GetDisabledImage: string;
    procedure _SetDisabledImage(const Value: string);
    function _GetForeImage: string;
    procedure _SetForeImage(const Value: string);
    function _GetHotForeImage: string;
    procedure _SetHotForeImage(const Value: string);
    function _GetHotBkColor: DWORD;
    procedure _SetHotBkColor(const Value: DWORD);
    function _GetHotTextColor: DWORD;
    procedure _SetHotTextColor(const Value: DWORD);
    function _GetPushedTextColor: DWORD;
    procedure _SetPushedTextColor(const Value: DWORD);
    function _GetFocusedTextColor: DWORD;
    procedure _SetFocusedTextColor(const Value: DWORD);
  public
    property NormalImage: string read _GetNormalImage write _SetNormalImage;
    property HotImage: string read _GetHotImage write _SetHotImage;
    property PushedImage: string read _GetPushedImage write _SetPushedImage;
    property FocusedImage: string read _GetFocusedImage write _SetFocusedImage;
    property DisabledImage: string read _GetDisabledImage write _SetDisabledImage;
    property ForeImage: string read _GetForeImage write _SetForeImage;
    property HotForeImage: string read _GetHotForeImage write _SetHotForeImage;
    property HotBkColor: DWORD read _GetHotBkColor write _SetHotBkColor;
    property HotTextColor: DWORD read _GetHotTextColor write _SetHotTextColor;
    property PushedTextColor: DWORD read _GetPushedTextColor write _SetPushedTextColor;
    property FocusedTextColor: DWORD read _GetFocusedTextColor write _SetFocusedTextColor;
  end;

  COptionUIHelper = class helper for COptionUI
  private
    function _GetSelectedImage: string;
    procedure _SetSelectedImage(const Value: string);
    function _GetSelectedHotImage: string;
    procedure _SetSelectedHotImage(const Value: string);
    function _GetSelectedTextColor: DWORD;
    procedure _SetSelectedTextColor(const Value: DWORD);
    function _GetSelectedBkColor: DWORD;
    procedure _SetSelectedBkColor(const Value: DWORD);
    function _GetForeImage: string;
    procedure _SetForeImage(const Value: string);
    function _GetGroup: string;
    procedure _SetGroup(const Value: string);
    function _GetSelected: Boolean;
    procedure _SetSelected(const Value: Boolean);
  public
    property SelectedImage: string read _GetSelectedImage write _SetSelectedImage;
    property SelectedHotImage: string read _GetSelectedHotImage write _SetSelectedHotImage;
    property SelectedTextColor: DWORD read _GetSelectedTextColor write _SetSelectedTextColor;
    property SelectedBkColor: DWORD read _GetSelectedBkColor write _SetSelectedBkColor;
    property ForeImage: string read _GetForeImage write _SetForeImage;
    property Group: string read _GetGroup write _SetGroup;
    property _Selected: Boolean read _GetSelected write _SetSelected;
  end;

  CCheckBoxUIHelper = class helper for CCheckBoxUI
  private
    function _GetChecked: Boolean;
    procedure _SetChecked(const Value: Boolean);
  public
    property Checked: Boolean read _GetChecked write _SetChecked;
  end;

  CListContainerElementUIHelper = class helper for CListContainerElementUI
  private
    function _GetIndex: Integer;
    procedure _SetIndex(const Value: Integer);
    function _GetOwner: IListOwnerUI;
    procedure _SetOwner(const Value: IListOwnerUI);
    function _GetSelected: Boolean;
    procedure _SetSelected(const Value: Boolean);
    function _GetExpanded: Boolean;
    procedure _SetExpanded(const Value: Boolean);
  public
    property Index: Integer read _GetIndex write _SetIndex;
    property Owner: IListOwnerUI read _GetOwner write _SetOwner;
    property Selected: Boolean read _GetSelected write _SetSelected;
    property Expanded: Boolean  read _GetExpanded write _SetExpanded;
  end;

  CDateTimeUIHelper = class helper for CDateTimeUI
  private
    function _GetReadOnly: Boolean;
    procedure _SetReadOnly(const Value: Boolean);
    function _GetDateTime: TDateTime;
    procedure _SetDateTime(const Value: TDateTime);
  public
    property ReadOnly: Boolean read _GetReadOnly write _SetReadOnly;
    property Time: TDateTime read _GetDateTime write _SetDateTime;
  end;

  CProgressUIHelper = class helper for CProgressUI
  private
    function _GetMinValue: Integer;
    procedure _SetMinValue(const Value: Integer);
    function _GetMaxValue: Integer;
    procedure _SetMaxValue(const Value: Integer);
    function _GetValue: Integer;
    procedure _SetValue(const Value: Integer);
    function _GetForeImage: string;
    procedure _SetForeImage(const Value: string);
  public
    property Value: Integer read _GetValue write _SetValue;
    property MinValue: Integer read _GetMinValue write _SetMinValue;
    property MaxValue: Integer read _GetMaxValue write _SetMaxValue;
    property ForeImage: string read _GetForeImage write _SetForeImage;
  end;


  CSliderUIHelper = class helper for CSliderUI
  private
    function _GetChangeStep: Integer;
    procedure _SetChangeStep(const Value: Integer);
    function _GetThumbRect: TRect;
    function _GetThumbImage: string;
    procedure _SetThumbImage(const Value: string);
    function _GetThumbHotImage: string;
    procedure _SetThumbHotImage(const Value: string);
    function _GetThumbPushedImage: string;
    procedure _SetThumbPushedImage(const Value: string);
  public
    property ChangeStep: Integer read _GetChangeStep write _SetChangeStep;
    property ThumbRect: TRect read _GetThumbRect;
    property ThumbImage: string read _GetThumbImage write _SetThumbImage;
    property ThumbHotImage: string read _GetThumbHotImage write _SetThumbHotImage;
    property ThumbPushedImage: string read _GetThumbPushedImage write _SetThumbPushedImage;
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

function CControlUIHelper._GetEnabled: Boolean;
begin
  Result := IsEnabled;
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

procedure CControlUIHelper._SetEnabled(const Value: Boolean);
begin
  SetEnabled(Value);
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

{ CButtonUIHelper }

function CButtonUIHelper._GetDisabledImage: string;
begin
  Result := GetDisabledImage;
end;

function CButtonUIHelper._GetFocusedImage: string;
begin
  Result := GetFocusedImage;
end;

function CButtonUIHelper._GetFocusedTextColor: DWORD;
begin
  Result := GetFocusedTextColor;
end;

function CButtonUIHelper._GetForeImage: string;
begin
  Result := GetForeImage;
end;

function CButtonUIHelper._GetHotBkColor: DWORD;
begin
  Result := GetHotBkColor;
end;

function CButtonUIHelper._GetHotForeImage: string;
begin
  Result := GetHotForeImage;
end;

function CButtonUIHelper._GetHotImage: string;
begin
  Result := GetHotImage;
end;

function CButtonUIHelper._GetHotTextColor: DWORD;
begin
  Result := GetHotTextColor;
end;

function CButtonUIHelper._GetNormalImage: string;
begin
  Result := GetNormalImage;
end;

function CButtonUIHelper._GetPushedImage: string;
begin
  Result := GetPushedImage;
end;

function CButtonUIHelper._GetPushedTextColor: DWORD;
begin
  Result := GetPushedTextColor;
end;

procedure CButtonUIHelper._SetDisabledImage(const Value: string);
begin
  SetDisabledImage(PChar(Value));
end;

procedure CButtonUIHelper._SetFocusedImage(const Value: string);
begin
  SetFocusedImage(PChar(Value));
end;

procedure CButtonUIHelper._SetFocusedTextColor(const Value: DWORD);
begin
  SetFocusedTextColor(Value);
end;

procedure CButtonUIHelper._SetForeImage(const Value: string);
begin
  SetForeImage(PChar(Value));
end;

procedure CButtonUIHelper._SetHotBkColor(const Value: DWORD);
begin
  SetHotBkColor(Value);
end;

procedure CButtonUIHelper._SetHotForeImage(const Value: string);
begin
  SetHotForeImage(PChar(Value));
end;

procedure CButtonUIHelper._SetHotImage(const Value: string);
begin
  SetHotImage(PChar(Value));
end;

procedure CButtonUIHelper._SetHotTextColor(const Value: DWORD);
begin
  SetHotTextColor(Value);
end;

procedure CButtonUIHelper._SetNormalImage(const Value: string);
begin
  SetNormalImage(PChar(Value));
end;

procedure CButtonUIHelper._SetPushedImage(const Value: string);
begin
  SetPushedImage(PChar(Value));
end;

procedure CButtonUIHelper._SetPushedTextColor(const Value: DWORD);
begin
  SetPushedTextColor(Value);
end;

{ COptionUIHelper }

function COptionUIHelper._GetForeImage: string;
begin
  Result := GetForeImage;
end;

function COptionUIHelper._GetGroup: string;
begin
  Result := GetGroup;
end;

function COptionUIHelper._GetSelected: Boolean;
begin
  Result := IsSelected;
end;

function COptionUIHelper._GetSelectedBkColor: DWORD;
begin
  Result := GetSelectBkColor;
end;

function COptionUIHelper._GetSelectedHotImage: string;
begin
  Result := GetSelectedHotImage;
end;

function COptionUIHelper._GetSelectedImage: string;
begin
  Result := GetSelectedImage;
end;

function COptionUIHelper._GetSelectedTextColor: DWORD;
begin
  Result := GetSelectedTextColor;
end;

procedure COptionUIHelper._SetForeImage(const Value: string);
begin
  SetForeImage(PChar(Value));
end;

procedure COptionUIHelper._SetGroup(const Value: string);
begin
  SetGroup(PChar(Value));
end;

procedure COptionUIHelper._SetSelected(const Value: Boolean);
begin
  Selected(Value);
end;

procedure COptionUIHelper._SetSelectedBkColor(const Value: DWORD);
begin
  SetSelectedBkColor(Value);
end;

procedure COptionUIHelper._SetSelectedHotImage(const Value: string);
begin
  SetSelectedHotImage(PChar(Value));
end;

procedure COptionUIHelper._SetSelectedImage(const Value: string);
begin
  SetSelectedImage(PChar(Value));
end;

procedure COptionUIHelper._SetSelectedTextColor(const Value: DWORD);
begin
  SetSelectedTextColor(Value);
end;

{ CCheckBoxUIHelper }

function CCheckBoxUIHelper._GetChecked: Boolean;
begin
  Result := GetCheck;
end;

procedure CCheckBoxUIHelper._SetChecked(const Value: Boolean);
begin
  SetCheck(Value);
end;

{ CListContainerElementUIHelper }

function CListContainerElementUIHelper._GetExpanded: Boolean;
begin
  Result := IsExpanded;
end;

function CListContainerElementUIHelper._GetIndex: Integer;
begin
  Result := GetIndex;
end;

function CListContainerElementUIHelper._GetOwner: IListOwnerUI;
begin
  Result := GetOwner;
end;

function CListContainerElementUIHelper._GetSelected: Boolean;
begin
  Result := IsSelected;
end;

procedure CListContainerElementUIHelper._SetExpanded(const Value: Boolean);
begin
  Expand(Value);
end;

procedure CListContainerElementUIHelper._SetIndex(const Value: Integer);
begin
  SetIndex(Value);
end;

procedure CListContainerElementUIHelper._SetOwner(const Value: IListOwnerUI);
begin
  SetOwner(Value);
end;

procedure CListContainerElementUIHelper._SetSelected(const Value: Boolean);
begin
  Select(Value);
end;

{ CDateTimeUIHelper }

function CDateTimeUIHelper._GetDateTime: TDateTime;
var
  LSysDateTime: PSYSTEMTIME;
begin
  LSysDateTime:= GetTime;
  Result := EncodeDateTime(LSysDateTime.wYear, LSysDateTime.wMonth, LSysDateTime.wDay,
                 LSysDateTime.wHour, LSysDateTime.wMinute, LSysDateTime.wSecond,
                 LSysDateTime.wMilliseconds);
end;

function CDateTimeUIHelper._GetReadOnly: Boolean;
begin
  Result := IsReadOnly;
end;

procedure CDateTimeUIHelper._SetDateTime(const Value: TDateTime);
var
  LSysDateTime: TSYSTEMTIME;
begin
  DecodeDateTime(Value, LSysDateTime.wYear, LSysDateTime.wMonth, LSysDateTime.wDay,
                 LSysDateTime.wHour, LSysDateTime.wMinute, LSysDateTime.wSecond,
                 LSysDateTime.wMilliseconds);
  LSysDateTime.wDayOfWeek := DayOfTheWeek(Value);
  SetTime(@LSysDateTime);
end;

procedure CDateTimeUIHelper._SetReadOnly(const Value: Boolean);
begin
  SetReadOnly(Value);
end;

{ CProgressUIHelper }

function CProgressUIHelper._GetForeImage: string;
begin
  Result := GetForeImage;
end;

function CProgressUIHelper._GetMaxValue: Integer;
begin
  Result := GetMaxValue;
end;

function CProgressUIHelper._GetMinValue: Integer;
begin
  Result := GetMinValue;
end;

function CProgressUIHelper._GetValue: Integer;
begin
  Result := GetValue;
end;

procedure CProgressUIHelper._SetForeImage(const Value: string);
begin
  SetForeImage(PChar(Value));
end;

procedure CProgressUIHelper._SetMaxValue(const Value: Integer);
begin
  SetMaxValue(Value);
end;

procedure CProgressUIHelper._SetMinValue(const Value: Integer);
begin
  SetMinValue(Value);
end;

procedure CProgressUIHelper._SetValue(const Value: Integer);
begin
  SetValue(Value);
end;

{ CSliderUIHelper }

function CSliderUIHelper._GetChangeStep: Integer;
begin
  Result := GetChangeStep;
end;

function CSliderUIHelper._GetThumbHotImage: string;
begin
  Result := GetThumbHotImage;
end;

function CSliderUIHelper._GetThumbImage: string;
begin
  Result := GetThumbImage;
end;

function CSliderUIHelper._GetThumbPushedImage: string;
begin
  Result := GetThumbPushedImage;
end;

function CSliderUIHelper._GetThumbRect: TRect;
begin
  Result := GetThumbRect;
end;

procedure CSliderUIHelper._SetChangeStep(const Value: Integer);
begin
  SetChangeStep(Value);
end;

procedure CSliderUIHelper._SetThumbHotImage(const Value: string);
begin
  SetThumbHotImage(PChar(Value));
end;

procedure CSliderUIHelper._SetThumbImage(const Value: string);
begin
  SetThumbImage(PChar(Value));
end;

procedure CSliderUIHelper._SetThumbPushedImage(const Value: string);
begin
  SetThumbPushedImage(PChar(Value));
end;

end.
