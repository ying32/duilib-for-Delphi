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

  TWkeWebbrowser = class(TDuiBase{$IFDEF SupportGeneric}<CNativeControlUI>{$ENDIF})
  private
    FWebView: TWkeWebView;
  protected
    procedure DoTitleChanged(webView: wkeWebView; ATitle: string); virtual;
    procedure DoURLChanged(webView: wkeWebView; AURL: string); virtual;
  public
    destructor Destroy; override;
  public
    procedure SetWkeWebbrowserUI(web: CNativeControlUI);
    procedure FreeCpp;
    procedure Navigate(const AURL: string);
  end;

implementation


procedure OnwkeTitleChangedCallback(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoTitleChanged(webView,
    {$IFDEF UNICODE}webView.GetStringW{$ELSE}webView.GetString{$ENDIF}(title));
end;

procedure OnwkeURLChangedCallback(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebbrowser(param).DoURLChanged(webView,
    {$IFDEF UNICODE}webView.GetStringW{$ELSE}webView.GetString{$ENDIF}(url));
end;

{ TWkeWebbrowser }

destructor TWkeWebbrowser.Destroy;
begin
  if FWebView <> nil then
    FWebView.DestroyWebWindow;
  inherited;
end;

procedure TWkeWebbrowser.FreeCpp;
begin
  if FThis <> nil then
  begin
    FThis.CppDestroy;
    FThis := nil;
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

procedure TWkeWebbrowser.SetWkeWebbrowserUI(web: CNativeControlUI);
var
  R: TRect;
begin
  if (web <> nil) and (web <> FThis) then
  begin
    FThis := web;
    FWebView := wkeCreateWebWindow(WKE_WINDOW_TYPE_CONTROL, web.GetManager.GetPaintWindow, 0, 0, 1, 1);
    FWebView.OnTitleChanged(OnwkeTitleChangedCallback, Self);
    FWebView.OnURLChanged(OnwkeURLChangedCallback, Self);
    FThis.SetNativeHandle(FWebView.GetWindowHandle);
    R := web.GetPos;
    FWebView.MoveWindow(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
    FWebView.ShowWindow(True);
  end;
end;

procedure TWkeWebbrowser.DoTitleChanged(webView: wkeWebView; ATitle: string);
begin

end;

procedure TWkeWebbrowser.DoURLChanged(webView: wkeWebView; AURL: string);
begin

end;

initialization
   wkeInitialize;

finalization
   wkeFinalize;

end.
