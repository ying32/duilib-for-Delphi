unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Duilib, Vcl.AppEvnts, Vcl.ExtCtrls,
  Vcl.StdCtrls;
type
  TForm1 = class(TForm)
    aplctnvnts1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
  private
    FPaintMgr: CPaintManagerUI;
    FRoot: CVerticalLayoutUI;
    FSelectCtl: CControlUI;
    FNotifyPump: CNotifyPump;
    FNotifyUI: INotifyUI;
    FMessageFilterUI: IMessageFilterUI;
    FRectList: array[0..7] of TRect;
    FPosList: array[0..7] of TCursor;

    FIsDown: Boolean;
    FDownPoint: TPoint;
    FDownSize: TSize;

    procedure OnDuiPaintEvent(Sender: CControlUI; DC: HDC; const rcPaint: TRect); cdecl;
    procedure OnDuiEvent(Sender: CControlUI; var AEvent: TEventUI); cdecl;

    procedure Notify(var Msg: TNotifyUI);
    procedure MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT);
    procedure UpdateRect(R: TRect);
    function SizeIndex(Pt: TPoint): Integer;
  public
    procedure WndProc(var Msg: TMessage); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

const
  SizeR = 8;

function MakeColor(a, r, g, b: Byte): Cardinal;
begin
  Result := ((DWORD(a) shl 24) or
             (DWORD(r) shl 16) or
             (DWORD(g) shl 8) or
             (DWORD(b) shl 0));
end;

function ColorToARGB(AColor: TColor): Cardinal;
begin
  Result := MakeColor($FF, GetRValue(AColor), GetGValue(AColor), GetBValue(AColor));
end;

procedure TForm1.aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  CPaintManagerUI.TranslateMessage(@Msg);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  LResourcePath, pDefaultAttributes: string;
  LLable: CLabelUI;
begin
  FSelectCtl := nil;
  FPosList[0] := crSizeNWSE; //htTopLeft;
  FPosList[1] := crSizeNS;// htTop;
  FPosList[2] := crSizeNESW; //htTopRight;
  FPosList[3] := crSizeWE; //htRight;
  FPosList[4] := crSizeNWSE; //htBottomRight;
  FPosList[5] := crSizeNS;// htBottom;
  FPosList[6] := crSizeNESW; //htBottomLeft;
  FPosList[7] := crSizeWE; //htLeft;


  FNotifyUI := INotifyUI.Create(Notify);
  FMessageFilterUI := IMessageFilterUI.Create(MessageHandler);
  FNotifyPump := CNotifyPump.CppCreate;
  FPaintMgr := CPaintManagerUI.CppCreate;
  LResourcePath := FPaintMgr.GetResourcePath;
  if LResourcePath = '' then
    LResourcePath := ExtractFilePath(ParamStr(0));// + FSkinFolder;
  FPaintMgr.SetResourcePath(LResourcePath);

  FPaintMgr.Init(Handle);
  FPaintMgr.AddMessageFilter(FMessageFilterUI);
  FPaintMgr.SetInitSize(ClientWidth, ClientHeight);
  FPaintMgr.SetSizeBox(Rect(3, 3, 3, 3));
  FPaintMgr.SetCaptionRect(Rect(0, 0, 0, 36));

  FRoot := CVerticalLayoutUI.CppCreate;
  FRoot.OnDuiPaint := OnDuiPaintEvent;
  FRoot.OnDuiEvent := OnDuiEvent;
  FRoot.BkColor := ColorToARGB(clGreen);// ColorToARGB(clBtnFace);

//  FRoot.SetAttribute('bkcolor', '#F0F00000');
//  FRoot.SetAttribute('pos', '180,183,0,0');
//  FRoot.SetAttribute('width', '100');
//  FRoot.SetAttribute('height', '100');
//  FRoot.SetAttribute('float', 'true');
//  FRoot.SetAttribute('text', '这是一个测试');
//  FRoot.SetAttribute('textcolor', '#FF000000');


  LLable := CLabelUI.CppCreate;
  if not FRoot.Add(LLable) then
    LLable.CppDestroy;
  LLable.SetManager(FPaintMgr, nil);
//  pDefaultAttributes := FPaintMgr.GetDefaultAttributeList(LLable.GetClass);
//  if pDefaultAttributes <> '' then
//    LLable.ApplyAttributeList(pDefaultAttributes);
  LLable.OnDuiPaint := OnDuiPaintEvent;
  LLable.OnDuiEvent := OnDuiEvent;
  LLable.SetAttribute('text', '这是一个测试');
  LLable.SetAttribute('float', 'true');
  LLable.SetAttribute('pos', '180,183,0,0');
  LLable.SetAttribute('width', '100');
  LLable.SetAttribute('height', '30');
  LLable.SetAttribute('textcolor', '#FF000000');
  LLable.SetManager(nil, nil);

  Writeln(Format('LButton.textcolor=%.8x', [LLable.textcolor]));

  FPaintMgr.AttachDialog(FRoot);
  FPaintMgr.AddNotifier(FNotifyUI);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPaintMgr.RemovePreMessageFilter(FMessageFilterUI);
  FPaintMgr.RemoveNotifier(FNotifyUI);
  FPaintMgr.ReapObjects(FPaintMgr.GetRoot);
  FPaintMgr.CppDestroy;
  FNotifyPump.CppDestroy;
  FMessageFilterUI.Free;
  FNotifyUI.Free;
end;

procedure TForm1.MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM;
  var bHandled: Boolean; var Result: LRESULT);
var
  LMouse: TMessage;
  LCtl: CControlUI;
begin
  if FSelectCtl <> nil then
  begin
    //PtInRect()
  end;
//  if uMsg = WM_LBUTTONDOWN then
//  begin
//    LMouse.WParam := wParam;
//    LMouse.LParam := lParam;
//    if Assigned(FPaintMgr) then
//    begin
//      FSelectCtl := FPaintMgr.FindControl(TWMMouse(LMouse).Pos);
//      if FSelectCtl <> nil then
//      begin
//        Writeln('mouse select = ', FSelectCtl.GetClass);
//        FPaintMgr.Invalidate;
//      end else
//        FSelectCtl := nil;
//    end;
//  end else if uMsg = WM_MOUSEMOVE then
//  begin
//    if FSelectCtl <> nil then
//    begin
//
//    end;
//  end;
end;

procedure TForm1.Notify(var Msg: TNotifyUI);
begin
  FNotifyPump.NotifyPump(Msg);
end;

procedure TForm1.OnDuiEvent(Sender: CControlUI; var AEvent: TEventUI);
var
  R: TRect;
  P: TPoint;
  M: TMessage;
  I: Integer;
begin
  if AEvent.AType = UIEVENT_BUTTONDOWN then
  begin
    FSelectCtl := Sender;
    if FSelectCtl <> nil then
    begin
      FDownPoint := AEvent.ptMouse;
      FIsDown := True;
      R := FSelectCtl.GetPos;
      UpdateRect(R);
      FDownSize := TSize.Create(FDownPoint.X - R.Left, FDownPoint.Y - R.Top);
      FPaintMgr.Invalidate;
    end;
  end else
  if AEvent.AType = UIEVENT_BUTTONUP then
  begin
    FIsDown := False;
  end else
  if AEvent.AType = UIEVENT_WINDOWSIZE then
  begin
    if FSelectCtl <> nil then
    begin
      R := FSelectCtl.GetPos;
      UpdateRect(R);
    end;
  end else
  if AEvent.AType = UIEVENT_MOUSEENTER then
  begin

  end else
  if AEvent.AType = UIEVENT_MOUSELEAVE then
  begin
    Cursor := crDefault;
  end else
  if AEvent.AType = UIEVENT_MOUSEMOVE then
  begin
    if FSelectCtl <> nil then
    begin
      if SizeIndex(AEvent.ptMouse) <> -1 then
        Exit;
    end;

    if (FSelectCtl <> nil) and (Sender = FSelectCtl) and (FSelectCtl <> FRoot) then
      Cursor := crSizeAll
    else
      Cursor := crDefault;
    if FIsDown and (FSelectCtl <> nil) then
    begin
      if Sender <> nil then
      begin
        FSelectCtl.SetFixedXY(TSize.Create(AEvent.ptMouse.X - FDownSize.cx, AEvent.ptMouse.Y - FDownSize.cy));
        UpdateRect(FSelectCtl.GetPos);
        FPaintMgr.NeedUpdate;
      end;
    end;
  end;
end;

procedure TForm1.OnDuiPaintEvent(Sender: CControlUI; DC: HDC;
  const rcPaint: TRect);
var
  R2: TRect;
  I: Integer;
begin
  R2 := Sender.GetPos;
//  Writeln(Sender.GetClass, '   ',
//   Format('R.Left=%d, R.Top=%d, R.Right=%d, R.Bottom=%d', [R2.Left, R2.Top, R2.Right, R2.Bottom]));
  Writeln(Format('p1sel=%p,  p2sender=%p', [Pointer(FSelectCtl), Pointer(Sender)]));
  if FSelectCtl = Sender then
  begin
    CRenderEngine.DrawRect(DC, R2, 1, ColorToARGB(clRed), PS_SOLID);
    for I := 0 to 7 do
    begin
      CRenderEngine.DrawColor(DC, FRectList[I], ColorToARGB(clWhite));
      CRenderEngine.DrawRect(DC, FRectList[I], 1, ColorToARGB(clGray), PS_SOLID);
    end;
  end
  else
    CRenderEngine.DrawRect(DC, R2, 1, ColorToARGB(clBlue), PS_SOLID);
end;

function TForm1.SizeIndex(Pt: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to 7 do
  begin
    if PtInRect(FRectList[I], Pt) then
    begin
      Cursor := FPosList[I];
      Exit(I);
    end;
  end;
end;

procedure TForm1.UpdateRect(R: TRect);
begin
  FRectList[0] := Rect(R.Left, R.Top, R.Left + SizeR, R.Top + SizeR);
  FRectList[1] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top, R.Left + (R.Width - SizeR) div 2 + SizeR,  R.Top + SizeR);
  FRectList[2] := Rect(R.Left + R.Width - SizeR, R.Top, R.Left + R.Width, R.Top + SizeR);

  FRectList[3] := Rect(R.Left + R.Width - SizeR, R.Top +  (R.Height - SizeR ) div 2, R.Left + R.Width, R.Top + (R.Height - SizeR) div 2 + SizeR);
  FRectList[4] := Rect(R.Left + R.Width - SizeR, R.Top + R.Height - SizeR, R.Left +  R.Width, R.Top + R.Height);
  FRectList[5] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top + R.Height - SizeR, R.Left + (R.Width - SizeR) div 2 + SizeR, R.Top + R.Height);

  FRectList[6] := Rect(R.Left, R.Top + R.Height - SizeR, R.Left + SizeR, R.Top + R.Height);
  FRectList[7] := Rect(R.Left, R.Top + (R.Height - SizeR) div 2, R.Left + SizeR, R.Top + (R.Height - SizeR) div 2 + SizeR);
end;

procedure TForm1.WndProc(var Msg: TMessage);
begin
  if Assigned(FPaintMgr) then
  begin
    if FPaintMgr.MessageHandler(Msg.Msg, Msg.WParam, Msg.LParam, Msg.Result) then
      Exit;
  end;
  inherited;
end;

end.
