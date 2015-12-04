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
    function _GetDateTime: TDateTime;
    procedure _SetDateTime(const Value: TDateTime);
  public
    property Time: TDateTime read _GetDateTime write _SetDateTime;
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

end.
