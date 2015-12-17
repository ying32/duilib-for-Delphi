//***************************************************************************
//
//       名称：DuiWkeBrowser.pas
//       日期：2015/12/16 21:48:50
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@vip.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       c++ wke内核: https://github.com/BlzFans/wke
//***************************************************************************
unit DuiWkeBrowser;

{$I DDuilib.inc}

interface

uses
  Windows,
  Types,
  Duilib,
  DuiBase,
  Wke;

type

  CWkeWebbrowserUI = class(CControlUI)
  public
    class function CppCreate: CWkeWebbrowserUI;
    procedure CppDestroy;
    procedure SetSetInternVisibleCallback(ACallback: Pointer);
    procedure SetSetPosCallback(ACallback: Pointer);
    procedure SetDelphiSelf(ASelf: Pointer);
    procedure SetDoEventCallback(ACallback: Pointer);
    procedure SetDoPaintCallback(ACallback: Pointer);
  end;


  TWkeWebbrowser = class(TDuiBase{$IFDEF SupportGeneric}<CWkeWebbrowserUI>{$ENDIF})
  private
    FWebView: IWebView;
    FhBitmap: HBITMAP;
    FPixels: Pointer;
    FhDC: HDC;
    FPaintManager: CPaintManagerUI;
    procedure SetInitCWekWebBrowserUI;
{$IFDEF UseLowVer}
  published
{$ELSE}
  protected
{$ENDIF}
    procedure DUI_SetInternVisible(bVisible: Boolean); cdecl;
    procedure DUI_SetPos(rc: TRect; bNeedInvalidate: Boolean); cdecl;
    procedure DUI_DoEvent(var AEvent: TEventUI; var bHandled: Boolean); cdecl;
    procedure DUI_DoPaint(DC: HDC; var rcPaint: TRect; var bHandled: Boolean); cdecl;
  protected
    procedure DoSetInternVisible(bVisible: Boolean); virtual;
    procedure DoSetPos(rc: TRect; bNeedInvalidate: Boolean); virtual;
    procedure DoEvent(var AEvent: TEventUI; var bHandled: Boolean); virtual;
    procedure DoPaint(DC: HDC; var rcPaint: TRect; var bHandled: Boolean); virtual;
  public
    constructor Create; overload;
    constructor Create(web: CWkeWebbrowserUI); overload;
    destructor Destroy; override;
    procedure Invalidate;
  public
    procedure SetWkeWebbrowserUI(web: CWkeWebbrowserUI);
    procedure FreeCpp;
    procedure Navigate(const AURL: string);
  end;


//================================CWkeWebbrowserUI============================

function Delphi_WkeWebbrowserUI_CppCreate: CWkeWebbrowserUI; cdecl;
procedure Delphi_WkeWebbrowserUI_CppDestroy(Handle: CWkeWebbrowserUI); cdecl;
procedure Delphi_WkeWebbrowserUI_SetSetInternVisibleCallback(Handle: CWkeWebbrowserUI; ACallback: Pointer); cdecl;
procedure Delphi_WkeWebbrowserUI_SetSetPosCallback(Handle: CWkeWebbrowserUI; ACallback: Pointer); cdecl;
procedure Delphi_WkeWebbrowserUI_SetDelphiSelf(Handle: CWkeWebbrowserUI; ASelf: Pointer); cdecl;
procedure Delphi_WkeWebbrowserUI_SetDoEventCallback(Handle: CWkeWebbrowserUI; ACallback: Pointer); cdecl;
procedure Delphi_WkeWebbrowserUI_SetDoPaintCallback(Handle: CWkeWebbrowserUI; ACallback: Pointer); cdecl;

implementation


{ CWkeWebbrowserUI }

class function CWkeWebbrowserUI.CppCreate: CWkeWebbrowserUI;
begin
  Result := Delphi_WkeWebbrowserUI_CppCreate;
end;

procedure CWkeWebbrowserUI.CppDestroy;
begin
  Delphi_WkeWebbrowserUI_CppDestroy(Self);
end;

procedure CWkeWebbrowserUI.SetSetInternVisibleCallback(ACallback: Pointer);
begin
  Delphi_WkeWebbrowserUI_SetSetInternVisibleCallback(Self, ACallback);
end;

procedure CWkeWebbrowserUI.SetSetPosCallback(ACallback: Pointer);
begin
  Delphi_WkeWebbrowserUI_SetSetPosCallback(Self, ACallback);
end;

procedure CWkeWebbrowserUI.SetDelphiSelf(ASelf: Pointer);
begin
  Delphi_WkeWebbrowserUI_SetDelphiSelf(Self, ASelf);
end;

procedure CWkeWebbrowserUI.SetDoEventCallback(ACallback: Pointer);
begin
  Delphi_WkeWebbrowserUI_SetDoEventCallback(Self, ACallback);
end;

procedure CWkeWebbrowserUI.SetDoPaintCallback(ACallback: Pointer);
begin
  Delphi_WkeWebbrowserUI_SetDoPaintCallback(Self, ACallback);
end;


{ TWkeWebbrowser }

constructor TWkeWebbrowser.Create;
begin
  inherited;
  FhDC := CreateCompatibleDC(0);
  FWebView := wkeCreateWebView;
end;

constructor TWkeWebbrowser.Create(web: CWkeWebbrowserUI);
begin
  Create;
  FThis := web;
  SetInitCWekWebBrowserUI;
end;

destructor TWkeWebbrowser.Destroy;
begin
  if FhDC <> 0 then
    DeleteDC(FhDC);
  if FhBitmap <>0 then
    DeleteObject(FhBitmap);
  wkeDestroyWebView(FWebView);
  inherited;
end;

procedure TWkeWebbrowser.DoEvent(var AEvent: TEventUI; var bHandled: Boolean);
begin
  // virtual
  if AEvent.AType = UIEVENT_TIMER then
  begin

  end else Writeln(Integer(AEvent.AType));
  //Invalidate;
end;

procedure TWkeWebbrowser.DoPaint(DC: HDC; var rcPaint: TRect;
  var bHandled: Boolean);
var
  bi: TBitmapInfo;
  hbmp: HBITMAP;
  LR: TRect;
begin
  // virtual
  if FWebView <> nil then
  begin
    Writeln(rcPaint.Right - rcPaint.Left);
    Writeln(rcPaint.Bottom - rcPaint.Top);
  {  if FPixels = nil then
    begin
      FillChar(bi, SizeOf(TBitmapInfo), #0);
      bi.bmiHeader.biSize := sizeof(TBitmapInfoHeader);
      bi.bmiHeader.biWidth         := rcPaint.Right - rcPaint.Left;
      bi.bmiHeader.biHeight        := -(rcPaint.Bottom - rcPaint.Top);
      bi.bmiHeader.biPlanes        := 1;
      bi.bmiHeader.biBitCount      := 32;
      bi.bmiHeader.biCompression   := BI_RGB;
      hbmp := CreateDIBSection(0, bi, DIB_RGB_COLORS, FPixels, 0, 0);
      SelectObject(FhDC, hbmp);
      if FhBitmap <> 0 then
        DeleteObject(FhBitmap);
      FhBitmap := hbmp;
    end;
    if FPixels <> nil then
    begin
      FWebView.paint(FPixels, 0);
//      LR := Rect(0, 0, 100, 200);
//      DrawText(FhDC, PChar('fffffffffffffffffffffffffffff'), -1, LR, 0);

      BitBlt(DC, 0, 0, rcPaint.Right - rcPaint.Left, rcPaint.Bottom - rcPaint.Top, FhDC, 0, 0, SRCCOPY);
      bHandled := False;
    end;   }
  end;
end;

procedure TWkeWebbrowser.DoSetInternVisible(bVisible: Boolean);
begin
  // virtual
end;

procedure TWkeWebbrowser.DoSetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  // virtual
  if FWebView <> nil then
    FWebView.resize(rc.Right - rc.Left, rc.Bottom - rc.Top);
end;

procedure TWkeWebbrowser.DUI_DoEvent(var AEvent: TEventUI;
  var bHandled: Boolean);
begin
  DoEvent(AEvent, bHandled);
end;

procedure TWkeWebbrowser.DUI_DoPaint(DC: HDC; var rcPaint: TRect;
  var bHandled: Boolean);
begin
  DoPaint(DC, rcPaint, bHandled);
end;

procedure TWkeWebbrowser.DUI_SetInternVisible(bVisible: Boolean);
begin
  DoSetInternVisible(bVisible);
end;

procedure TWkeWebbrowser.DUI_SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  DoSetPos(rc, bNeedInvalidate);
end;

procedure TWkeWebbrowser.FreeCpp;
begin
  if FThis <> nil then
  begin
    FThis.CppDestroy;
    FThis := nil;
  end;
end;

procedure TWkeWebbrowser.Invalidate;
begin
  if FWebView <> nil then
  begin
    //if FWebView.isDirty then
      {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.Invalidate;
  end;
end;

procedure TWkeWebbrowser.Navigate(const AURL: string);
begin
  if FWebView <> nil then
  {$IFDEF UNICODE}
    FWebView.loadURLW(PChar(AURL));
  {$ELSE}
    FWebView.loadURLA(PChar(AURL));
  {$ENDIF}
end;

procedure TWkeWebbrowser.SetInitCWekWebBrowserUI;
begin
  if FThis <> nil then
  begin
    FPaintManager := {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.GetManager;
    {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.SetDelphiSelf(Self);
    {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.SetSetInternVisibleCallback(GetMethodAddr('DUI_SetInternVisible'));
    {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.SetSetPosCallback(GetMethodAddr('DUI_SetPos'));
    {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.SetDoEventCallback(GetMethodAddr('DUI_DoEvent'));
    {$IFDEF SupportGeneric}FThis{$ELSE}CWkeWebbrowserUI(FThis){$ENDIF}.SetDoPaintCallback(GetMethodAddr('DUI_DoPaint'));
  end;
end;

procedure TWkeWebbrowser.SetWkeWebbrowserUI(web: CWkeWebbrowserUI);
begin
  if (web <> nil) and (web <> FThis) then
  begin
    FThis := web;
    SetInitCWekWebBrowserUI;
  end;
end;

//================================CWkeWebbrowserUI============================

function Delphi_WkeWebbrowserUI_CppCreate; external DuiLibdll name 'Delphi_WkeWebbrowserUI_CppCreate';
procedure Delphi_WkeWebbrowserUI_CppDestroy; external DuiLibdll name 'Delphi_WkeWebbrowserUI_CppDestroy';
procedure Delphi_WkeWebbrowserUI_SetSetInternVisibleCallback; external DuiLibdll name 'Delphi_WkeWebbrowserUI_SetSetInternVisibleCallback';
procedure Delphi_WkeWebbrowserUI_SetSetPosCallback; external DuiLibdll name 'Delphi_WkeWebbrowserUI_SetSetPosCallback';
procedure Delphi_WkeWebbrowserUI_SetDelphiSelf; external DuiLibdll name 'Delphi_WkeWebbrowserUI_SetDelphiSelf';
procedure Delphi_WkeWebbrowserUI_SetDoEventCallback; external DuiLibdll name 'Delphi_WkeWebbrowserUI_SetDoEventCallback';
procedure Delphi_WkeWebbrowserUI_SetDoPaintCallback; external DuiLibdll name 'Delphi_WkeWebbrowserUI_SetDoPaintCallback';


initialization
   wkeInit;

finalization
   wkeShutdown;

end.
