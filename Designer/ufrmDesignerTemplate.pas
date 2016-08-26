unit ufrmDesignerTemplate;
// 本设计器参考了 directx-gui 的设计器源码，发现他有些比我写的简便更好用，所
// 以就使用了他的方法，当然有些得改动，以便适应duilib的

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Duilib, Vcl.AppEvnts, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, DuiActiveX, System.Generics.Collections,
  uPropertyClass;

type

  TSelectControlEvent = procedure(Sender: TObject; AControl: CControlUI) of object;

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

    FDragPoints: array[1..3, 1..3] of TPoint;
    FDragPoint: TPoint;
    FDragRect: TRect;
    FDragStart: TPoint;
    FDragActive: Boolean;

    FDuiWindow: TDWindow;
 

    FSelList: TList<CControlUI>;
    FOnSelectControl: TSelectControlEvent;
    FOnControlChanged: TNotifyEvent;

    procedure OnDuiPaintEvent(Sender: CControlUI; DC: HDC; const rcPaint: TRect);
    procedure OnDuiEvent(Sender: CControlUI; var AEvent: TEventUI);

    procedure Notify(var Msg: TNotifyUI);
    procedure MessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT);

    function NewControlByName(AClass: string; APt: TPoint): CControlUI;
    function LParamToPoint(lParam: LPARAM): TPoint;
    procedure DuiMouseDown(APoint: TPoint);
    procedure DuiMouseUp(APoint: TPoint);
    procedure DuiMouseMove(APoint: TPoint);
    procedure DuiReSize;

    function CalculateDragPoints: Boolean;
    function GetDragPointIndex(X, Y: Integer): TPoint;
    procedure PaintDragPoints(DC: HDC);
    procedure UpdateCurosr(APoint: TPoint);
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Msg: TMessage); override;
    function AddControl(AControl: CControlUI): Boolean;
  public
    property DuiWindow: TDWindow read FDuiWindow;
    property OnSelectControl: TSelectControlEvent read FOnSelectControl write FOnSelectControl;
    property OnControlChanged: TNotifyEvent read FOnControlChanged write FOnControlChanged;
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
  SizeR = 4;

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

function TfrmDesignerTemplate.CalculateDragPoints: Boolean;
var
  R: TRect;
  X, Y: Integer;
begin
  Result := False;
  if FSelectCtl = nil then Exit;
  R := FSelectCtl.GetPos;
  R.Inflate(-SizeR, SizeR);
  for Y := 1 to 3 do
  begin
    for X := 1 to 3 do
    begin
      case X of
        1: FDragPoints[Y, X].X := R.Left;
        2: FDragPoints[Y, X].X := Round((R.Left + R.Right) / 2);
        3: FDragPoints[Y, X].X := R.Right;
      end;
      case Y of
        1: FDragPoints[Y, X].Y := R.Top;
        2: FDragPoints[Y, X].Y := Round((R.Top + R.Bottom) / 2);
        3: FDragPoints[Y, X].Y := R.Bottom;
      end;
    end;
  end;
  Result := True;
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
  FSelList := TList<CControlUI>.Create;
  FSelectCtl := nil;
  FDuiWindow := TDWindow.Create;
  
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
  FSelList.Free;
  FDuiWindow.Free;
end;

function TfrmDesignerTemplate.GetDragPointIndex(X, Y: Integer): TPoint;
var
  I, J: Integer;
begin
  Result.X := 0;
  Result.Y := 0;
  for I := 1 to 3 do
  begin
    for J := 1 to 3 do
    begin
      if (X >= FDragPoints[J, I].X - SizeR) and
         (X <= FDragPoints[J, I].X + SizeR) and
         (Y >= FDragPoints[J, I].Y - SizeR) and
         (Y <= FDragPoints[J, I].Y + SizeR) then
      begin
        Result.X := I;
        Result.Y := J;
        Break;
      end;
    end;
  end;
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
  MP: TPoint;
begin
  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONUP,
    WM_MOUSEMOVE:
      begin
        MP := LParamToPoint(lParam);
        case uMsg of
          WM_LBUTTONDOWN:
            DuiMouseDown(MP);
          WM_LBUTTONUP:
            DuiMouseUp(MP);
          WM_MOUSEMOVE:
            DuiMouseMove(MP);
        end;
      end;
    WM_SIZE:
      DuiReSize;
  end;
end;

procedure TfrmDesignerTemplate.DuiMouseDown(APoint: TPoint);
var
  DPI: TPoint;
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

  DPI := GetDragPointIndex(APoint.X, APoint.Y);
  if (FSelectCtl <> nil) and (DPI.X > 0) and (DPI.Y > 0) then
  begin
    FDragPoint := DPI;
    FDragRect := FSelectCtl.GetPos;
    FDragStart := APoint;
    FDragActive := True;
  end else
  begin
    FSelectCtl := FPaintMgr.FindControl(APoint);
    if FSelectCtl <> nil then
      FPaintMgr.Invalidate;
    if Assigned(FOnSelectControl) then
      FOnSelectControl(Self, FSelectCtl);
  end;
end;

procedure TfrmDesignerTemplate.DuiMouseMove(APoint: TPoint);
var
  C: CControlUI;

 procedure SetBoundsOf(X, Y, W, H: Integer);
 begin
   C.SetFixedWidth(W);
   C.SetFixedHeight(H);
   C.SetFixedXY(TSize.Create(X, Y));
 end;

var
  X, Y: Integer;
begin
  if FSelectCtl <> nil then
    UpdateCurosr(GetDragPointIndex(APoint.X, APoint.Y));
  if (FSelectCtl <> nil) and FDragActive then
  begin
    C := FSelectCtl;
    X := APoint.X;
    Y := APoint.Y;
    case FDragPoint.Y of
      1:
        begin
          case FDragPoint.X of
            1: SetBoundsOf(FDragRect.Left + X - FDragStart.X,
              FDragRect.Top + Y - FDragStart.Y, FDragRect.Width + FDragStart.X - X + 1,
              FDragRect.Height + FDragStart.Y - Y + 1);
            2: SetBoundsOf(C.X, FDragRect.Top + Y - FDragStart.Y, C.Width,
              FDragRect.Height + FDragStart.Y - Y + 1);
            3: SetBoundsOf(C.X, FDragRect.Top + Y - FDragStart.Y,
              FDragRect.Width + X - FDragStart.X + 1, FDragRect.Height + FDragStart.Y - Y + 1);
          end;
        end;
      2:
        begin
          case FDragPoint.X of
            1: SetBoundsOf(FDragRect.Left + X - FDragStart.X, FDragRect.Top,
              FDragRect.Width + FDragStart.X - X + 1, C.Height);
            2: SetBoundsOf(FDragRect.Left + X - FDragStart.X,
              FDragRect.Top + Y - FDragStart.Y, C.Width, C.Height);
            3: SetBoundsOf(C.X, C.Y, FDragRect.Width + X - FDragStart.X + 1, C.Height);
          end;
        end;
      3:
        begin
          case FDragPoint.X of
            1: SetBoundsOf(FDragRect.Left + X - FDragStart.X, C.Y,
              FDragRect.Width + FDragStart.X - X + 1, FDragRect.Height + Y - FDragStart.Y + 1);
            2: SetBoundsOf(C.X, C.Y, C.Width, FDragRect.Height + Y - FDragStart.Y + 1);
            3: SetBoundsOf(C.X, C.Y, FDragRect.Width + X - FDragStart.X + 1,
              FDragRect.Height + Y - FDragStart.Y + 1);
          end;
        end;
    end;
  end;
end;

procedure TfrmDesignerTemplate.DuiMouseUp(APoint: TPoint);
begin
  if FDragActive then
  begin
    if Assigned(FOnControlChanged) then
     FOnControlChanged(Self);
  end;
  FDragActive := False;
  FPaintMgr.Invalidate;
end;

function TfrmDesignerTemplate.NewControlByName(AClass: string; APt: TPoint): CControlUI;
var
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
    Result.SetFloat;
    Result.SetFixedHeight(30);
    Result.SetFixedXY(TSize.Create(TSize.Create(APt.X, APt.Y)));
    // 是容器类
//    if (Result.GetInterface('IContainer') = nil) or
//        LClass.Equals('ActiveXUI') or
//       (LClass.Equals('ListUI')) or
//       (LClass.Equals('ComboUI')) then
//    begin
//
//    end;
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
begin
  R2 := Sender.GetPos;
  if FSelectCtl = Sender then
  begin
    CRenderEngine.DrawRect(DC, R2, 1, ColorToARGB(clRed), PS_SOLID);
    if Sender.IsFloat and CalculateDragPoints then
      PaintDragPoints(DC);
  end
  else
    CRenderEngine.DrawRect(DC, R2, 1, ColorToARGB(clBlue), PS_SOLID);
end;

procedure TfrmDesignerTemplate.PaintDragPoints(DC: HDC);
var
  X, Y: Integer;
  R: TRect;
begin
  for Y := 1 to 3 do
  begin
    for X := 1 to 3 do
    begin
      R.Left := FDragPoints[Y, X].X - SizeR;
      R.Top := FDragPoints[Y, X].Y - SizeR;
      R.Right :=FDragPoints[Y, X].X + SizeR;
      R.Bottom := FDragPoints[Y, X].Y + SizeR;
      CRenderEngine.DrawColor(DC, R, ColorToARGB(clWhite));
      CRenderEngine.DrawRect(DC, R, 1, ColorToARGB(clGray), PS_SOLID);
    end;
  end;
end;

procedure TfrmDesignerTemplate.UpdateCurosr(APoint: TPoint);
begin
  case APoint.Y of
    1:
      begin
        case APoint.X of
          1: Cursor := crSizeNWSE;
          2: Cursor := crSizeNS;
          3: Cursor := crSizeNESW;
        end;
      end;
    2:
      begin
        case APoint.X of
          1, 3: Cursor := crSizeWE;
          2: Cursor := crSizeAll;
        end;
      end;
    3:
      begin
        case APoint.X of
          1: Cursor := crSizeNESW;
          2: Cursor := crSizeNS;
          3: Cursor := crSizeNWSE;
        end;
      end;
  else
    Cursor := crDefault;
  end;
end;

procedure TfrmDesignerTemplate.DuiReSize;
begin
  if FSelectCtl <> nil then
    FPaintMgr.Invalidate;
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
