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
  Windows,
  DateUtils,
  Duilib;

type

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

  {CButtonUIHelper = class helper for CButtonUI
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
  end;      }

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
    property Selected: Boolean read _GetSelected write _SetSelected;
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
      {
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
end;     }

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
  _Selected(Value);
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
