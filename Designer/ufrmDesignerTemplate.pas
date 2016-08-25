unit ufrmDesignerTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Duilib, Vcl.AppEvnts, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, DuiActiveX;

type

  TfrmDesignerTemplate = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    FDragDown: Boolean;
    FDragIndex: Integer;

    procedure OnDuiPaintEvent(Sender: CControlUI; DC: HDC; const rcPaint: TRect);
    procedure OnDuiEvent(Sender: CControlUI; var AEvent: TEventUI);

    procedure Notify(var Msg: TNotifyUI);
    procedure MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT);
    procedure UpdateRect(R: TRect);
    procedure UpdateCurosr(AIndex: Integer);
    function SizeIndex(Pt: TPoint): Integer;
    function NewControlByName(AClass: string; APt: TPoint): CControlUI;
    function LParamToPoint(lParam: LPARAM): TPoint;
    procedure MouseDown(APoint: TPoint);
    procedure MouseUp(APoint: TPoint);
    procedure MouseMove(APoint: TPoint);
    procedure WMSize;
    procedure UpdateUI;
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Msg: TMessage); override;
    function AddControl(AControl: CControlUI): Boolean;
  end;

  function NewDesignerTemplate(AParent: TWinControl): TfrmDesignerTemplate;

implementation

{$R *.dfm}

uses ufrmMain;

(*

class IContainerUI
{
public:
    virtual CControlUI* GetItemAt(int iIndex) const = 0;
    virtual int GetItemIndex(CControlUI* pControl) const  = 0;
    virtual bool SetItemIndex(CControlUI* pControl, int iIndex)  = 0;
    virtual int GetCount() const = 0;
    virtual bool Add(CControlUI* pControl) = 0;
    virtual bool AddAt(CControlUI* pControl, int iIndex)  = 0;
    virtual bool Remove(CControlUI* pControl) = 0;
    virtual bool RemoveAt(int iIndex)  = 0;
    virtual void RemoveAll() = 0;
};

*)
type

  IContainerUI = class
  public
     function _GetItemAt(iIndex: Integer): CControlUI; virtual; stdcall; abstract;
     function _GetItemIndex(pControl: CControlUI): Integer; virtual; stdcall; abstract;
     function _SetItemIndex(pControl: CControlUI; iIndex: Integer): Boolean; virtual; stdcall; abstract;
     function _GetCount: Integer; virtual; stdcall; abstract;
     function _Add(pControl: CControlUI): Boolean; virtual; stdcall; abstract;
     function _AddAt(pControl: CControlUI; iIndex: Integer): Boolean; virtual; stdcall; abstract;
     function _Remove(pControl: CControlUI): Boolean; virtual; stdcall; abstract;
     function _RemoveAt(iIndex: Integer): Boolean; virtual; stdcall; abstract;
     procedure _RemoveAll; virtual; stdcall; abstract;
  end;

  TContainerUI = class(IContainerUI)
  public
    function Add(pControl: CControlUI): Boolean; stdcall;
  end;


function NewDesignerTemplate(AParent: TWinControl): TfrmDesignerTemplate;
begin
  Result := TfrmDesignerTemplate.Create(nil);
//  Result.Parent := AParent;
  // 只能用api的不然会显示不了
  Winapi.Windows.SetParent(Result.Handle, AParent.Handle);
  //Winapi.Windows.SetWindowPos(Result.Handle, HWND_TOP, AParent.Left, AParent.Top, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE);
  Result.Left := 10;
  Result.Top := 10;
  Result.Show;
end;



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

function TfrmDesignerTemplate.AddControl(AControl: CControlUI): Boolean;
var
  LClass: string;
begin
  Result := False;
  if AControl = nil then Exit;
  if FSelectCtl <> nil then
  begin
    LClass := FSelectCtl.GetClass;
    if (LClass <> 'ControlUI') and (LClass <> '') then
    begin
      // 是容器
      if FSelectCtl.GetInterface('IContainer') <> nil then
      begin
        if not CContainerUI(FSelectCtl).Add(AControl) then
        begin
          AControl.CppDestroy;
          Exit;
        end;
        FSelectCtl := AControl;
        Result := True;
      end;
    end;
  end;
end;

procedure TfrmDesignerTemplate.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_NOACTIVATE;
  Params.Style := Params.Style or WS_CHILDWINDOW;
end;

procedure TfrmDesignerTemplate.FormCreate(Sender: TObject);
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

  LLable := CLabelUI.CppCreate;
  if not FRoot.Add(LLable) then
    LLable.CppDestroy;
  LLable.SetManager(FPaintMgr, nil);
  pDefaultAttributes := FPaintMgr.GetDefaultAttributeList(LLable.GetClass);
  if pDefaultAttributes <> '' then
    LLable.ApplyAttributeList(pDefaultAttributes);
  LLable.OnDuiPaint := OnDuiPaintEvent;
  LLable.OnDuiEvent := OnDuiEvent;
  LLable.SetAttribute('text', '这是一个测试');
  LLable.SetAttribute('float', 'true');
  LLable.SetAttribute('pos', '180,183,0,0');
  LLable.SetAttribute('width', '100');
  LLable.SetAttribute('height', '30');
  LLable.SetAttribute('textcolor', '#FF000000');
//  LLable.SetFixedWidth(100);
//  LLable.SetFixedWidth(80);
  LLable.SetManager(nil, nil);

  Writeln(Format('LButton.textcolor=%.8x', [LLable.textcolor]));

  FPaintMgr.AttachDialog(FRoot);
  FPaintMgr.AddNotifier(FNotifyUI);
end;

procedure TfrmDesignerTemplate.FormDestroy(Sender: TObject);
begin
  FPaintMgr.RemovePreMessageFilter(FMessageFilterUI);
  FPaintMgr.RemoveNotifier(FNotifyUI);
  FPaintMgr.ReapObjects(FPaintMgr.GetRoot);
  FPaintMgr.CppDestroy;
  FNotifyPump.CppDestroy;
  FMessageFilterUI.Free;
  FNotifyUI.Free;
end;

function TfrmDesignerTemplate.LParamToPoint(lParam: LPARAM): TPoint;
var
  M: TMessage;
begin
  M.LParam := lParam;
  Result.X := TWMMouse(M).XPos;
  Result.Y := TWMMouse(M).YPos;
end;

procedure TfrmDesignerTemplate.MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM;
  var bHandled: Boolean; var Result: LRESULT);
var
  R: TRect;
  P, MP: TPoint;
  I: Integer;
begin
  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONUP,
    WM_MOUSEMOVE:
      begin
        MP := LParamToPoint(lParam);
        case uMsg of
          WM_LBUTTONDOWN:
            MouseDown(MP);
          WM_LBUTTONUP:
            MouseUp(MP);
          WM_MOUSEMOVE:
            MouseMove(MP);
        end;
      end;
    WM_SIZE:
      WMSize;
  end;
end;

procedure TfrmDesignerTemplate.MouseDown(APoint: TPoint);
var
  R: TRect;
begin
  // 添加控件
  if frmMain.IsSelect then
  begin
    if Copy(frmMain.CurCtl.Name, 1, 8) = 'btn_ctl_' then
    begin
      if AddControl(NewControlByName(Copy(frmMain.CurCtl.Name, 9, Length(frmMain.CurCtl.Name) - 8), APoint)) then
      begin
        frmMain.ClearSel;
        FPaintMgr.Invalidate;
        Exit;
      end;
    end;
  end;
  // 确定调整
  FDragIndex := SizeIndex(APoint);
  FDragDown := FDragIndex <> -1;
  FDownPoint := APoint;
  FSelectCtl := FPaintMgr.FindControl(APoint);
  if FSelectCtl <> nil then
  begin
    FIsDown := True;
    R := FSelectCtl.GetPos;
    UpdateRect(R);
    FDownSize := TSize.Create(FDownPoint.X - R.Left, FDownPoint.Y - R.Top);
    FPaintMgr.Invalidate;
  end;
end;

procedure TfrmDesignerTemplate.MouseMove(APoint: TPoint);
var
  I: Integer;
begin
  Writeln('FDragDown=', FDragDown);
  if FSelectCtl <> nil then
  begin
    I := SizeIndex(APoint);
    if I <> -1 then
    begin
      Writeln('在索引=', I);
      UpdateRect(FSelectCtl.GetPos);
      Exit;
    end;
  end;
  if not FDragDown then
  begin
    if (FSelectCtl <> nil) and (FSelectCtl <> FRoot) then
      Cursor := crSizeAll
    else
      Cursor := crDefault;
    if FIsDown and (FSelectCtl <> nil) then
    begin
      if FSelectCtl <> nil then
      begin
        FSelectCtl.SetFixedXY(TSize.Create(APoint.X - FDownSize.cx, APoint.Y - FDownSize.cy));
        UpdateRect(FSelectCtl.GetPos);
      end;
    end;
//
  end;
end;

procedure TfrmDesignerTemplate.MouseUp(APoint: TPoint);
begin
  FIsDown := False;
  FDragDown := False;
  FDragIndex := -1;
  FPaintMgr.Invalidate;
end;

function TfrmDesignerTemplate.NewControlByName(AClass: string; APt: TPoint): CControlUI;
var
  R: TRect;
  pDefaultAttributes: string;
  LClass: string;
begin
  Writeln('Class=', AClass);
  Result := nil;
  if SameStr(AClass, 'ControlUI') then
  begin
    Result := CControlUI.CppCreate;
  end
  else
  if SameStr(AClass, 'CLableUI') then
  begin
    Result := CLabelUI.CppCreate;
    Result.Text := 'Label';
  end
  else
  if SameStr(AClass, 'CTextUI') then
  begin
    Result := CTextUI.CppCreate;
    Result.Text := 'Text';
  end
  else
  if SameStr(AClass, 'CEditUI') then
  begin
    Result := CEditUI.CppCreate;
    Result.Text := 'Edit';
  end
  else
  if SameStr(AClass, 'COptionUI') then
  begin
    Result := COptionUI.CppCreate;
    Result.Text := 'Option';
  end
  else
  if SameStr(AClass, 'CComboUI') then
  begin
    Result := CComboUI.CppCreate;
    Result.Text := 'Option';
  end
  else
  if SameStr(AClass, 'CListUI') then
  begin
    Result := CListUI.CppCreate;
  end
  else
  if SameStr(AClass, 'CSliderUI') then
  begin
    Result := CSliderUI.CppCreate;
  end
  else
  if SameStr(AClass, 'CActiveXUI') then
    Result := CActiveXUI.CppCreate
  else
  if SameStr(AClass, 'CProgressUI') then
  begin
    Result := CProgressUI.CppCreate;
  end
  else
  if SameStr(AClass, 'CButtonUI') then
  begin
    Result := CButtonUI.CppCreate;
    Result.Text := 'Button';
  end
  else
  if SameStr(AClass, 'CHorizontalLayoutUI') then
    Result := CHorizontalLayoutUI.CppCreate
  else
  if SameStr(AClass, 'CTabLayoutUI') then
    Result := CTabLayoutUI.CppCreate
  else
  if SameStr(AClass, 'CTileLayoutUI') then
    Result := CTileLayoutUI.CppCreate
  else
  if SameStr(AClass, 'CContainerUI') then
    Result := CContainerUI.CppCreate
  else
  if SameStr(AClass, 'CVerticalLayoutUI') then
    Result := CVerticalLayoutUI.CppCreate;
  if Result <> nil then
  begin
    Result.OnDuiEvent := OnDuiEvent;
    Result.OnDuiPaint := OnDuiPaintEvent;
    LClass := Result.GetClass;
    Result.SetManager(FPaintMgr, nil, False);
    pDefaultAttributes := FPaintMgr.GetDefaultAttributeList(LClass);
    if pDefaultAttributes <> '' then
      Result.ApplyAttributeList(pDefaultAttributes);
    Result.SetFixedWidth(100);
    Result.SetFixedHeight(60);
    // 是容器类
    if (Result.GetInterface('IContainer') = nil) or
        LClass.Equals('ActiveXUI') or
       (LClass.Equals('ListUI')) or
       (LClass.Equals('ComboUI')) then
    begin
      Result.SetFloat;
      Result.SetFixedHeight(30);
      Result.SetFixedXY(TSize.Create(TSize.Create(APt.X, APt.Y)));
    end;
    Result.SetManager(nil, nil, False);
  end;
end;

procedure TfrmDesignerTemplate.Notify(var Msg: TNotifyUI);
begin
  FNotifyPump.NotifyPump(Msg);
end;

procedure TfrmDesignerTemplate.OnDuiEvent(Sender: CControlUI; var AEvent: TEventUI);
begin

end;

procedure TfrmDesignerTemplate.OnDuiPaintEvent(Sender: CControlUI; DC: HDC;
  const rcPaint: TRect);
var
  R2: TRect;
  I: Integer;
begin
  R2 := Sender.GetPos;
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

function TfrmDesignerTemplate.SizeIndex(Pt: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to 7 do
  begin
    if PtInRect(FRectList[I], Pt) then
    begin
      UpdateCurosr(I);
      Exit(I);
    end;
  end;
end;



procedure TfrmDesignerTemplate.UpdateCurosr(AIndex: Integer);
begin
  if AIndex = -1 then Exit;
  Cursor := FPosList[AIndex];
end;

procedure TfrmDesignerTemplate.UpdateRect(R: TRect);
begin
  FRectList[0] := Rect(R.Left - SizeR, R.Top - SizeR, R.Left, R.Top);
  FRectList[1] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top - SizeR, R.Left + (R.Width - SizeR) div 2 + SizeR,  R.Top);
  FRectList[2] := Rect(R.Right, R.Top - SizeR, R.Right + SizeR, R.Top);

  FRectList[3] := Rect(R.Right, R.Top + (R.Height - SizeR ) div 2, R.Right + SizeR, R.Top + (R.Height - SizeR) div 2 + SizeR);
  FRectList[4] := Rect(R.Left + R.Width - SizeR, R.Top + R.Height - SizeR, R.Left +  R.Width, R.Top + R.Height);

  FRectList[5] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top + R.Height - SizeR, R.Left + (R.Width - SizeR) div 2 + SizeR, R.Top + R.Height);
  FRectList[6] := Rect(R.Left, R.Top + R.Height - SizeR, R.Left + SizeR, R.Top + R.Height);
  FRectList[7] := Rect(R.Left, R.Top + (R.Height - SizeR) div 2, R.Left + SizeR, R.Top + (R.Height - SizeR) div 2 + SizeR);
end;

//procedure TfrmDesignerTemplate.UpdateRect(R: TRect);
//begin
//  FRectList[0] := Rect(R.Left, R.Top, R.Left + SizeR, R.Top + SizeR);
//  FRectList[1] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top, R.Left + (R.Width - SizeR) div 2 + SizeR,  R.Top + SizeR);
//  FRectList[2] := Rect(R.Left + R.Width - SizeR, R.Top, R.Left + R.Width, R.Top + SizeR);
//
//  FRectList[3] := Rect(R.Left + R.Width - SizeR, R.Top +  (R.Height - SizeR ) div 2, R.Left + R.Width, R.Top + (R.Height - SizeR) div 2 + SizeR);
//  FRectList[4] := Rect(R.Left + R.Width - SizeR, R.Top + R.Height - SizeR, R.Left +  R.Width, R.Top + R.Height);
//  FRectList[5] := Rect(R.Left + (R.Width - SizeR) div 2, R.Top + R.Height - SizeR, R.Left + (R.Width - SizeR) div 2 + SizeR, R.Top + R.Height);
//
//  FRectList[6] := Rect(R.Left, R.Top + R.Height - SizeR, R.Left + SizeR, R.Top + R.Height);
//  FRectList[7] := Rect(R.Left, R.Top + (R.Height - SizeR) div 2, R.Left + SizeR, R.Top + (R.Height - SizeR) div 2 + SizeR);
//end;

procedure TfrmDesignerTemplate.UpdateUI;
begin
  PostMessage(Handle, WM_PAINT, 0, 0);
end;

procedure TfrmDesignerTemplate.WMSize;
begin
  if FSelectCtl <> nil then
    UpdateRect(FSelectCtl.GetPos);
end;

procedure TfrmDesignerTemplate.WndProc(var Msg: TMessage);
begin
  if Assigned(FPaintMgr) then
  begin
    case Msg.Msg of
      WM_SETCURSOR:;
    else
      if FPaintMgr.MessageHandler(Msg.Msg, Msg.WParam, Msg.LParam, Msg.Result) then
        Exit;
    end;
  end;
  inherited;
end;

{ TContainerUI }

function TContainerUI.Add(pControl: CControlUI): Boolean;
asm
  MOV ECX, Self
  JMP _Add
end;

end.
