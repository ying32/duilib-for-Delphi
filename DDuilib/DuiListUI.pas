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

uses
  Windows,
  SysUtils,
  DuiBase,
  Duilib;

type

  TDuiListUI = class(TDuiBase<CDelphi_ListUI>)
  private
    FLastSelectIndex: Integer;
    function GetCount: Integer;
    function GetCurSel: Integer;
    function IsItemShowHtml: Boolean;
    procedure SetItemShowHtml(bShowHtml: Boolean);
  protected
    // dui
    procedure DUI_DoEvent(var AEvent: TEventUI); cdecl;
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
  FThis.SetDelphiSelf(Self);
  FThis.SetDoEvent(GetMethodAddr('DUI_DoEvent'));
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
    FThis.CppDestroy;
end;

function TDuiListUI.GetCount: Integer;
begin
  Result := FThis.GetCount;
end;

function TDuiListUI.GetCurSel: Integer;
begin
  Result := FThis.GetCurSel;
end;

function TDuiListUI.IsItemShowHtml: Boolean;
begin
  Result := FThis.IsItemShowHtml;
end;

function TDuiListUI.Remove(pControl: CControlUI): Boolean;
begin
  Result := FThis.Remove(pControl);
end;

procedure TDuiListUI.RemoveAll;
begin
  FThis.RemoveAll;
end;

function TDuiListUI.RemoveAt(iIndex: Integer): Boolean;
begin
  Result := FThis.RemoveAt(iIndex);
end;

procedure TDuiListUI.DoSelectItem;
begin
  FLastSelectIndex := CurSel;
end;

procedure TDuiListUI.SetItemShowHtml(bShowHtml: Boolean);
begin
  FThis.SetItemShowHtml(bShowHtml);
end;

function TDuiListUI.Add(pControl: CControlUI): Boolean;
begin
  Result := FThis.Add(pControl);
end;

function TDuiListUI.AddAt(pControl: CControlUI; iIndex: Integer): Boolean;
begin
  Result := FThis.AddAt(pControl, iIndex);
end;



end.
