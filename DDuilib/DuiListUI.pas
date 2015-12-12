//***************************************************************************
//
//       名称：DuiListUI.pas
//       工具：RAD Studio XE6
//       日期：2015/11/26
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiListUI;

interface

{$I DDuilib.inc}

uses
  Windows,
  SysUtils,
  DuiBase,
  Duilib;

type

  TDuiListUI = class(TDuiBase{$IFDEF SupportGeneric}<CDelphi_ListUI>{$ENDIF})
  private
    FLastSelectIndex: Integer;
    function GetCount: Integer;
    function GetCurSel: Integer;
    function IsItemShowHtml: Boolean;
    procedure SetItemShowHtml(bShowHtml: Boolean);
{$IFDEF UseLowVer}
  published
{$ELSE}
  protected
{$ENDIF}
    // dui
    procedure DUI_DoEvent(var AEvent: TEventUI); cdecl;
  protected
    // delphi
    procedure DoEvent(var AEvent: TEventUI); virtual;
    procedure DoSelectItem; virtual;
  public
    function Add(pControl: CControlUI): Boolean;
    function AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
    function Remove(pControl: CControlUI): Boolean;
    function RemoveAt(iIndex: Integer): Boolean;
    procedure RemoveAll;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   留一个主动释放的接口吧
    /// </summary>
    procedure FreeCpp;
  public
    property Count: Integer read GetCount;
    property CurSel: Integer read GetCurSel;
    property ItemShowHtml: Boolean read IsItemShowHtml write SetItemShowHtml;
    property LastSelectIndex: Integer read FLastSelectIndex;
  end;

implementation

{ TDuiListUI }

constructor TDuiListUI.Create;
begin
  inherited;
  FThis := CDelphi_ListUI.CppCreate;
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.SetDelphiSelf(Self);
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.SetDoEvent(GetMethodAddr('DUI_DoEvent'));
  FLastSelectIndex := -1;
end;

destructor TDuiListUI.Destroy;
begin
  //FThis.CppDestroy; 由交PaintManagerUI去释放？
  inherited;
end;

procedure TDuiListUI.DoEvent(var AEvent: TEventUI);
begin
  // virutial;
end;

procedure TDuiListUI.DUI_DoEvent(var AEvent: TEventUI);
begin
  DoEvent(AEvent);
end;

procedure TDuiListUI.FreeCpp;
begin
  if FThis <> nil then
    {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.CppDestroy;
end;

function TDuiListUI.GetCount: Integer;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.GetCount;
end;

function TDuiListUI.GetCurSel: Integer;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.GetCurSel;
end;

function TDuiListUI.IsItemShowHtml: Boolean;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.IsItemShowHtml;
end;

function TDuiListUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.Remove(pControl);
end;

procedure TDuiListUI.RemoveAll;
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.RemoveAll;
end;

function TDuiListUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.RemoveAt(iIndex);
end;

procedure TDuiListUI.DoSelectItem;
begin
  FLastSelectIndex := CurSel;
end;

procedure TDuiListUI.SetItemShowHtml(bShowHtml: Boolean);
begin
  {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.SetItemShowHtml(bShowHtml);
end;

function TDuiListUI.Add(pControl: CControlUI): Boolean;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.Add(pControl);
end;

function TDuiListUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := {$IFNDEF UseLowVer}FThis{$ELSE}CDelphi_ListUI(FThis){$ENDIF}.AddAt(pControl, iIndex);
end;



end.
