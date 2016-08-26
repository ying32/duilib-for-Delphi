unit uPropertyClass;

interface

uses
  Winapi.Windows,
  System.Types,
  Vcl.Graphics,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  System.Rtti,
  Winapi.GDIPAPI,
  Vcl.Forms,
  Duilib;

type

  TImageString = type string;


  TSizeClass = class(TPersistent)
  private
    FCX: Integer;
    FCY: Integer;
    function GetS: TSize;
    procedure SetS(const Value: TSize);
    function GetIsEmpty: Boolean;
  public
    property S: TSize read GetS write SetS;
    property IsEmpty: Boolean read GetIsEmpty;
  published
    property CX: Integer read FCX write FCX;
    property CY: Integer read FCY write FCY;
  end;


  TRectClass = class(TPersistent)
  private
    FRight: Integer;
    FBottom: Integer;
    FTop: Integer;
    FLeft: Integer;
    function GetR: TRect;
    procedure SetR(const Value: TRect);
    function GetIsEmpty: Boolean;
  public
    property R: TRect read GetR write SetR;
    property IsEmpty: Boolean read GetIsEmpty;
  published
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Right: Integer read FRight write FRight;
    property Bottom: Integer read FBottom write FBottom;
  end;

  TRectFClass = class(TPersistent)
  private
    FRight: Single;
    FBottom: Single;
    FTop: Single;
    FLeft: Single;
    function GetR: TRectF;
    procedure SetR(const Value: TRectF);
    function GetIsEmpty: Boolean;
  public
    property R: TRectF read GetR write SetR;
    property IsEmpty: Boolean read GetIsEmpty;
  published
    property Left: Single read FLeft write FLeft;
    property Top: Single read FTop write FTop;
    property Right: Single read FRight write FRight;
    property Bottom: Single read FBottom write FBottom;
  end;


  TDWindow = class(TPersistent)
  private
    FForm: TForm;
    FPaintMgr: CPaintManagerUI;

    FSize: TSizeClass;
    FSizeBox: TRectClass;
    FCaption: TRectClass;
    FRoundCorner: TSizeClass;
    FMinInfo: TSizeClass;
    FMaxInfo: TSizeClass;

    function GetDefaultFontColor: TColor;
    function GetDisabledFontColor: TColor;
    function GetLinkFontColor: TColor;
    function GetLinkHoverFontColor: TColor;
    function GetSelectedColor: TColor;
    procedure SetDefaultFontColor(const Value: TColor);
    procedure SetDisabledFontColor(const Value: TColor);
    procedure SetLinkFontColor(const Value: TColor);
    procedure SetLinkHoverFontColor(const Value: TColor);
    procedure SetSelectedColor(const Value: TColor);
    function GetCaption: TRectClass;
    function GetLayeredImage: TImageString;
    function GetLayeredOpacity: Byte;
    function GetMaxInfo: TSizeClass;
    function GetMinInfo: TSizeClass;
    function GetOpacity: Byte;
    function GetRoundCorner: TSizeClass;
    function GetSize: TSizeClass;
    function GetSizeBox: TRectClass;
    procedure SetCaption(const Value: TRectClass);
    procedure SetLayeredImage(const Value: TImageString);
    procedure SetLayeredOpacity(const Value: Byte);
    procedure SetMaxInfo(const Value: TSizeClass);
    procedure SetMinInfo(const Value: TSizeClass);
    procedure SetOpacity(const Value: Byte);
    procedure SetRoundCorner(const Value: TSizeClass);
    procedure SetSize(const Value: TSizeClass);
    procedure SetSizeBox(const Value: TRectClass);
  public
    constructor Create(AForm: TForm);
    destructor Destroy; override;
    property PaintMgr: CPaintManagerUI read FPaintMgr write FPaintMgr;
  published
    property Size: TSizeClass read GetSize write SetSize;
    property SizeBox: TRectClass read GetSizeBox write SetSizeBox;
    property Caption: TRectClass read GetCaption write SetCaption;
    property RoundCorner: TSizeClass read GetRoundCorner write SetRoundCorner;
    property MinInfo: TSizeClass read GetMinInfo write SetMinInfo;
    property MaxInfo: TSizeClass read GetMaxInfo write SetMaxInfo;
    property Opacity: Byte read GetOpacity write SetOpacity;
    property LayeredOpacity: Byte read GetLayeredOpacity write SetLayeredOpacity;
    property LayeredImage: TImageString read GetLayeredImage write SetLayeredImage;
    property DisabledFontColor: TColor read GetDisabledFontColor write SetDisabledFontColor;
    property DefaultFontColor: TColor read GetDefaultFontColor write SetDefaultFontColor;
    property LinkFontColor: TColor read GetLinkFontColor write SetLinkFontColor;
    property LinkHoverFontColor: TColor read GetLinkHoverFontColor write SetLinkHoverFontColor;
    property SelectedColor: TColor read GetSelectedColor write SetSelectedColor;
  end;

  TDControl = class(TPersistent)
  private
    FBorderRound :TSizeClass;
    FPos :TRectClass;
    FPadding :TRectClass;
    FFixedXY :TSizeClass;
    FFloatPercent :TRectFClass;
    FBorderSize :TRectClass;
    function GetBkColor: TColor;
    function GetBkColor2: TColor;
    function GetBkColor3: TColor;
    function GetBkImage: TImageString;
    function GetBorderColor: TColor;
    function GetBorderStyle: Integer;
    function GetColorHSL: Boolean;
    function GetContextMenuUsed: Boolean;
    function GetEnabled: Boolean;
    function GetFixedHeight: Integer;
    function GetFixedWidth: Integer;
    function GetFloat: Boolean;
    function GetFocusBorderColor: TColor;
    function GetKeyboardEnabled: Boolean;
    function GetMaxHeight: Integer;
    function GetMaxWidth: Integer;
    function GetMinHeight: Integer;
    function GetMinWidth: Integer;
    function GetMouseEnabled: Boolean;
    function GetName: string;
    function GetShortcut: Char;
    function GetTag: Integer;
    function GetText: string;
    function GetToolTip: string;
    function GetToolTipWidth: Integer;
    function GetUserData: string;
    function GetVirtualWnd: string;
    function GetVisible: Boolean;
    procedure SetBkColor(const Value: TColor);
    procedure SetBkColor2(const Value: TColor);
    procedure SetBkColor3(const Value: TColor);
    procedure SetBkImage(const Value: TImageString);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: Integer);
    procedure SetColorHSL(const Value: Boolean);
    procedure SetContextMenuUsed(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFixedHeight(const Value: Integer);
    procedure SetFixedWidth(const Value: Integer);
    procedure SetFloat(const Value: Boolean);
    procedure SetFocusBorderColor(const Value: TColor);
    procedure SetKeyboardEnabled(const Value: Boolean);
    procedure SetMaxHeight(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
    procedure SetMinHeight(const Value: Integer);
    procedure SetMinWidth(const Value: Integer);
    procedure SetMouseEnabled(const Value: Boolean);
    procedure SetName(const Value: string);
    procedure SetShortcut(const Value: Char);
    procedure SetTag(const Value: Integer);
    procedure SetText(const Value: string);
    procedure SetToolTip(const Value: string);
    procedure SetToolTipWidth(const Value: Integer);
    procedure SetUserData(const Value: string);
    procedure SetVirtualWnd(const Value: string);
    procedure SetVisible(const Value: Boolean);
    function GetBorderRound: TSizeClass;
    function GetBorderSize: TRectClass;
    function GetFixedXY: TSizeClass;
    function GetPadding: TRectClass;
    function GetPos: TRectClass;
    procedure SetBorderRound(const Value: TSizeClass);
    procedure SetBorderSize(const Value: TRectClass);
    procedure SetFixedXY(const Value: TSizeClass);
    procedure SetPadding(const Value: TRectClass);
    procedure SetPos(const Value: TRectClass);
    function GetFloatPercent: TRectFClass;
    procedure SetFloatPercent(const Value: TRectFClass);
  protected
    FControl: CControlUI;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetControl(AControl: CControlUI);
  published
    property Name: string read GetName write SetName;
    property Text: string read GetText write SetText;
    property BkColor: TColor read GetBkColor write SetBkColor;
    property BkColor2: TColor read GetBkColor2 write SetBkColor2;
    property BkColor3: TColor read GetBkColor3 write SetBkColor3;
    property BkImage: TImageString read GetBkImage write SetBkImage;
    property FocusBorderColor: TColor read GetFocusBorderColor write SetFocusBorderColor;
    property ColorHSL: Boolean read GetColorHSL write SetColorHSL;
    property BorderRound: TSizeClass read GetBorderRound write SetBorderRound;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property BorderSize: TRectClass read GetBorderSize write SetBorderSize;
//    property BorderSize: Integer read FBorderSize write FBorderSize;
    property BorderStyle: Integer read GetBorderStyle write SetBorderStyle;
    property Pos: TRectClass read GetPos write SetPos;
    property Padding: TRectClass read GetPadding write SetPadding;
    property FixedXY: TSizeClass read GetFixedXY write SetFixedXY;
    property FixedWidth: Integer read GetFixedWidth write SetFixedWidth;
    property FixedHeight: Integer read GetFixedHeight write SetFixedHeight;
    property MinWidth: Integer read GetMinWidth write SetMinWidth;
    property MaxWidth: Integer read GetMaxWidth write SetMaxWidth;
    property MinHeight: Integer read GetMinHeight write SetMinHeight;
    property MaxHeight: Integer read GetMaxHeight write SetMaxHeight;
    property ToolTip: string read GetToolTip write SetToolTip;
    property ToolTipWidth: Integer read GetToolTipWidth write SetToolTipWidth;
    property Shortcut: Char read GetShortcut write SetShortcut;
    property ContextMenuUsed: Boolean read GetContextMenuUsed write SetContextMenuUsed;
    property UserData: string read GetUserData write SetUserData;
    property Tag: Integer read GetTag write SetTag;
    property Visible: Boolean read GetVisible write SetVisible;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property MouseEnabled: Boolean read GetMouseEnabled write SetMouseEnabled;
    property KeyboardEnabled: Boolean read GetKeyboardEnabled write SetKeyboardEnabled;
    property Float: Boolean read GetFloat write SetFloat;
    property FloatPercent: TRectFClass read GetFloatPercent write SetFloatPercent;
    property VirtualWnd: string read GetVirtualWnd write SetVirtualWnd;
  end;

  TDCContainer = class(TDControl)
  private
    FInset: TRectClass;
    FScrollPos: TSizeClass;
    function GetChildPadding: Integer;
    procedure SetChildPadding(const Value: Integer);
    function GetAutoDestroy: Boolean;
    function GetMouseChildEnabled: Boolean;
    function GetScrollPos: TSizeClass;
    procedure SetAutoDestroy(const Value: Boolean);

    procedure SetMouseChildEnabled(const Value: Boolean);
    procedure SetScrollPos(const Value: TSizeClass);
    function GetInset: TRectClass;
    procedure SetInset(const Value: TRectClass);
    function GetDelayedDestroy: Boolean;
    procedure SetDelayedDestroy(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ChildPadding: Integer read GetChildPadding write SetChildPadding;
    property Inset: TRectClass read GetInset write SetInset;
    property AutoDestroy: Boolean read GetAutoDestroy write SetAutoDestroy;
    property DelayedDestroy: Boolean read GetDelayedDestroy write SetDelayedDestroy;
    property MouseChildEnabled: Boolean read GetMouseChildEnabled write SetMouseChildEnabled;
    property ScrollPos: TSizeClass read GetScrollPos write SetScrollPos;
  end;

  TDVerticalLayout = class(TDCContainer)
  end;

  TDHorizontalLayout = class(TDCContainer)
  end;

  TDListHeader = class(TDHorizontalLayout)
  end;

  TDList = class(TDVerticalLayout)
  published

//    procedure EnsureVisible(iIndex: Integer);
//    procedure Scroll(dx: Integer; dy: Integer);
//    function GetChildPadding: Integer;
//    procedure SetChildPadding(iPadding: Integer);
//    procedure SetItemFont(index: Integer);
//    procedure SetItemTextStyle(uStyle: UINT);
//    procedure SetItemTextPadding(rc: TRect);
//    procedure SetItemTextColor(dwTextColor: DWORD);
//    procedure SetItemBkColor(dwBkColor: DWORD);
//    procedure SetItemBkImage(pStrImage: string);
//    function IsAlternateBk: Boolean;
//    procedure SetAlternateBk(bAlternateBk: Boolean);
//    procedure SetSelectedItemTextColor(dwTextColor: DWORD);
//    procedure SetSelectedItemBkColor(dwBkColor: DWORD);
//    procedure SetSelectedItemImage(pStrImage: string);
//    procedure SetHotItemTextColor(dwTextColor: DWORD);
//    procedure SetHotItemBkColor(dwBkColor: DWORD);
//    procedure SetHotItemImage(pStrImage: string);
//    procedure SetDisabledItemTextColor(dwTextColor: DWORD);
//    procedure SetDisabledItemBkColor(dwBkColor: DWORD);
//    procedure SetDisabledItemImage(pStrImage: string);
//    procedure SetItemLineColor(dwLineColor: DWORD);
//    function IsItemShowHtml: Boolean;
//    procedure SetItemShowHtml(bShowHtml: Boolean = True);
//    function GetItemTextPadding: TRect;
//    function GetItemTextColor: DWORD;
//    function GetItemBkColor: DWORD;
//    function GetItemBkImage: string;
//    function GetSelectedItemTextColor: DWORD;
//    function GetSelectedItemBkColor: DWORD;
//    function GetSelectedItemImage: string;
//    function GetHotItemTextColor: DWORD;
//    function GetHotItemBkColor: DWORD;
//    function GetHotItemImage: string;
//    function GetDisabledItemTextColor: DWORD;
//    function GetDisabledItemBkColor: DWORD;
//    function GetDisabledItemImage: string;
//    function GetItemLineColor: DWORD;
//    procedure SetMultiExpanding(bMultiExpandable: Boolean);
//    function GetExpandedItem: Integer;
//    function ExpandItem(iIndex: Integer; bExpand: Boolean = True): Boolean;
  end;


  function ColorToARGB(AColor: TColor): Cardinal;
  function ARGBToColor(AColor: Cardinal): TColor;
implementation

function ColorToARGB(AColor: TColor): Cardinal;
begin
  Result := Winapi.GDIPAPI.ColorRefToARGB(AColor);
end;

function ARGBToColor(AColor: Cardinal): TColor;
begin
  Result := Winapi.GDIPAPI.ARGBToColorRef(AColor);
end;

{ TDWindow }

constructor TDWindow.Create(AForm: TForm);
begin
  inherited Create;
  FForm := AForm;
  FSize       := TSizeClass.Create;
  FSizeBox    := TRectClass.Create;
  FCaption    := TRectClass.Create;
  FRoundCorner:= TSizeClass.Create;
  FMinInfo    := TSizeClass.Create;
  FMaxInfo    := TSizeClass.Create;
end;

destructor TDWindow.Destroy;
begin
  FMaxInfo.Free;
  FMinInfo.Free;
  FRoundCorner.Free;
  FCaption.Free;
  FSizeBox.Free;
  FSize.Free;
  inherited;
end;

function TDWindow.GetCaption: TRectClass;
begin
  FCaption.R := FPaintMgr.GetCaptionRect;
  Result := FCaption;
end;

function TDWindow.GetDefaultFontColor: TColor;
begin
  Result := ARGBToColor(FPaintMgr.GetDefaultFontColor);
end;

function TDWindow.GetDisabledFontColor: TColor;
begin
  Result := ARGBToColor(FPaintMgr.GetDefaultDisabledColor);
end;

function TDWindow.GetLayeredImage: TImageString;
begin
  Result := FPaintMgr.LayeredImage;
end;

function TDWindow.GetLayeredOpacity: Byte;
begin
  Result := FPaintMgr.GetLayeredOpacity;
end;

function TDWindow.GetLinkFontColor: TColor;
begin
  Result := ARGBToColor(FPaintMgr.GetDefaultLinkFontColor);
end;

function TDWindow.GetLinkHoverFontColor: TColor;
begin
  Result := ARGBToColor(FPaintMgr.GetDefaultLinkHoverFontColor);
end;

function TDWindow.GetMaxInfo: TSizeClass;
begin
  FMaxInfo.S := FPaintMgr.GetMaxInfo;
  Result := FMaxInfo;
end;

function TDWindow.GetMinInfo: TSizeClass;
begin
  FMinInfo.S := FPaintMgr.GetMinInfo;
  Result := FMinInfo;
end;

function TDWindow.GetOpacity: Byte;
begin
  Result := FPaintMgr.GetOpacity;
end;

function TDWindow.GetRoundCorner: TSizeClass;
begin
  FRoundCorner.S := FPaintMgr.GetRoundCorner;
  Result := FRoundCorner;
end;

function TDWindow.GetSelectedColor: TColor;
begin
  Result := ARGBToColor(FPaintMgr.GetDefaultSelectedBkColor);
end;

function TDWindow.GetSize: TSizeClass;
begin
  FSize.S := FPaintMgr.GetInitSize;
  Result := FSize;
end;

function TDWindow.GetSizeBox: TRectClass;
begin
  FSizeBox.R := FPaintMgr.GetSizeBox;
  Result := FSizeBox;
end;

procedure TDWindow.SetCaption(const Value: TRectClass);
begin
  FCaption.R := Value.R;
  FPaintMgr.SetCaptionRect(Value.R);
end;

procedure TDWindow.SetDefaultFontColor(const Value: TColor);
begin
  FPaintMgr.SetDefaultFontColor(ColorToARGB(Value));
end;

procedure TDWindow.SetDisabledFontColor(const Value: TColor);
begin
  FPaintMgr.SetDefaultDisabledColor(ColorToARGB(Value));
end;

procedure TDWindow.SetLayeredImage(const Value: TImageString);
begin
  FPaintMgr.SetLayeredImage(Value);
end;

procedure TDWindow.SetLayeredOpacity(const Value: Byte);
begin
  FPaintMgr.SetLayeredOpacity(Value);
end;

procedure TDWindow.SetLinkFontColor(const Value: TColor);
begin
  FPaintMgr.SetDefaultLinkFontColor(ColorToARGB(Value));
end;

procedure TDWindow.SetLinkHoverFontColor(const Value: TColor);
begin
  FPaintMgr.SetDefaultLinkHoverFontColor(ColorToARGB(Value));
end;

procedure TDWindow.SetMaxInfo(const Value: TSizeClass);
begin
  FMaxInfo.S := Value.S;
  FPaintMgr.SetMaxInfo(Value.CX, Value.CY);
end;

procedure TDWindow.SetMinInfo(const Value: TSizeClass);
begin
  FMinInfo.S := Value.S;
  FPaintMgr.SetMinInfo(Value.CX, Value.CY);
end;

procedure TDWindow.SetOpacity(const Value: Byte);
begin
  FPaintMgr.SetOpacity(Value);
end;

procedure TDWindow.SetRoundCorner(const Value: TSizeClass);
begin
  FRoundCorner.S := Value.S;
  FPaintMgr.SetRoundCorner(Value.CX, Value.CY);
end;

procedure TDWindow.SetSelectedColor(const Value: TColor);
begin
  FPaintMgr.SetDefaultSelectedBkColor(ColorToARGB(Value));
end;

procedure TDWindow.SetSize(const Value: TSizeClass);
begin
  FSize.S := Value.S;
  FPaintMgr.SetInitSize(Value.CX, Value.CY);
  FForm.Width := Value.CX;
  FForm.Height := Value.CY;
end;

procedure TDWindow.SetSizeBox(const Value: TRectClass);
begin
  FSizeBox.R := Value.R;
  FPaintMgr.SetSizeBox(Value.R);
end;

{ TDControlUI }

constructor TDControl.Create;
begin
  inherited;
  FBorderRound := TSizeClass.Create;
  FPos := TRectClass.Create;
  FPadding := TRectClass.Create;
  FFixedXY := TSizeClass.Create;
  FFloatPercent := TRectFClass.Create;
  FBorderSize := TRectClass.Create;
end;

destructor TDControl.Destroy;
begin
  FBorderSize.Free;
  FFloatPercent.Free;
  FFixedXY.Free;
  FPadding.Free;
  FPos.Free;
  FBorderRound.Free;
  inherited;
end;

function TDControl.GetBkColor: TColor;
begin
  Result := ARGBToColor(FControl.BkColor);
end;

function TDControl.GetBkColor2: TColor;
begin
  Result := ARGBToColor(FControl.BkColor2);
end;

function TDControl.GetBkColor3: TColor;
begin
  Result := ARGBToColor(FControl.BkColor3);
end;

function TDControl.GetBkImage: TImageString;
begin
  Result := FControl.BkImage;
end;

function TDControl.GetBorderColor: TColor;
begin
  Result := ARGBToColor(FControl.GetBorderColor);
end;

function TDControl.GetBorderRound: TSizeClass;
begin
  FBorderRound.S := FControl.GetBorderRound;
  Result := FBorderRound;
end;

function TDControl.GetBorderSize: TRectClass;
begin
  FBorderSize.R := FControl.GetBorderSize;
  Result := FBorderSize;
end;

function TDControl.GetBorderStyle: Integer;
begin
  Result := FControl.GetBorderStyle;
end;

function TDControl.GetColorHSL: Boolean;
begin
  Result := FControl.IsColorHSL;
end;

function TDControl.GetContextMenuUsed: Boolean;
begin
  Result := FControl.IsContextMenuUsed;
end;

function TDControl.GetEnabled: Boolean;
begin
  Result := FControl.IsEnabled;
end;

function TDControl.GetFixedHeight: Integer;
begin
  Result := FControl.GetFixedHeight;
end;

function TDControl.GetFixedWidth: Integer;
begin
  Result := FControl.GetFixedWidth;
end;

function TDControl.GetFixedXY: TSizeClass;
begin
  FFixedXY.S := FControl.GetFixedXY;
  Result := FFixedXY;
end;

function TDControl.GetFloat: Boolean;
begin
  Result := FControl.IsFloat;
end;

function TDControl.GetFloatPercent: TRectFClass;
var
  LFloatPercent: TPercentInfo;
begin
  LFloatPercent := FControl.GetFloatPercent;
  FFloatPercent.Left := LFloatPercent.left;
  FFloatPercent.Top := LFloatPercent.top;
  FFloatPercent.Right := LFloatPercent.right;
  FFloatPercent.Bottom := LFloatPercent.bottom;
  Result := FFloatPercent;
end;

function TDControl.GetFocusBorderColor: TColor;
begin
  Result := ARGBToColor(FControl.GetFocusBorderColor);
end;

function TDControl.GetKeyboardEnabled: Boolean;
begin
  Result := FControl.IsKeyboardEnabled;
end;

function TDControl.GetMaxHeight: Integer;
begin
  Result := FControl.GetMaxHeight;
end;

function TDControl.GetMaxWidth: Integer;
begin
  Result := FControl.GetMaxWidth;
end;

function TDControl.GetMinHeight: Integer;
begin
  Result := FControl.GetMinHeight;
end;

function TDControl.GetMinWidth: Integer;
begin
  Result := FControl.GetMinWidth;
end;

function TDControl.GetMouseEnabled: Boolean;
begin
  Result := FControl.IsMouseEnabled;
end;

function TDControl.GetName: string;
begin
  Result := FControl.GetName;
end;

function TDControl.GetPadding: TRectClass;
begin
  FPadding.R := FControl.GetPadding;
  Result := FPadding;
end;

function TDControl.GetPos: TRectClass;
begin
  FPos.R := FControl.GetPos;
  Result := FPos;
end;

function TDControl.GetShortcut: Char;
begin
  Result := FControl.GetShortcut;
end;

function TDControl.GetTag: Integer;
begin
  Result := FControl.GetTag;
end;

function TDControl.GetText: string;
begin
  Result := FControl.GetText;
end;

function TDControl.GetToolTip: string;
begin
  Result := FControl.GetToolTip;
end;

function TDControl.GetToolTipWidth: Integer;
begin
  Result := FControl.GetToolTipWidth;
end;

function TDControl.GetUserData: string;
begin
  Result := FControl.GetUserData;
end;

function TDControl.GetVirtualWnd: string;
begin
  Result := FControl.GetVirtualWnd;
end;

function TDControl.GetVisible: Boolean;
begin
  Result := FControl.IsVisible;
end;

procedure TDControl.SetBkColor(const Value: TColor);
begin
  FControl.SetBkColor(ColorToARGB(Value));
end;

procedure TDControl.SetBkColor2(const Value: TColor);
begin
  FControl.SetBkColor2(ColorToARGB(Value));
end;

procedure TDControl.SetBkColor3(const Value: TColor);
begin
  FControl.SetBkColor3(ColorToARGB(Value));
end;

procedure TDControl.SetBkImage(const Value: TImageString);
begin
  FControl.SetBkImage(Value);
end;

procedure TDControl.SetBorderColor(const Value: TColor);
begin
  FControl.SetBorderColor(ColorToARGB(Value));
end;

procedure TDControl.SetBorderRound(const Value: TSizeClass);
begin
  FBorderRound.S := Value.S;
  FControl.SetBorderRound(Value.S);
end;

procedure TDControl.SetBorderSize(const Value: TRectClass);
begin
  FBorderSize.R := Value.R;
  FControl.SetBorderSize(Value.R);
end;

procedure TDControl.SetBorderStyle(const Value: Integer);
begin
  FControl.SetBorderStyle(Value);
end;

procedure TDControl.SetColorHSL(const Value: Boolean);
begin
  FControl.SetColorHSL(Value);
end;

procedure TDControl.SetContextMenuUsed(const Value: Boolean);
begin
 FControl.SetContextMenuUsed(Value);
end;

procedure TDControl.SetControl(AControl: CControlUI);
begin
  FControl := AControl;
end;

procedure TDControl.SetEnabled(const Value: Boolean);
begin
  FControl.SetEnabled(Value);
end;

procedure TDControl.SetFixedHeight(const Value: Integer);
begin
  FControl.SetFixedHeight(Value);
end;

procedure TDControl.SetFixedWidth(const Value: Integer);
begin
  FControl.SetFixedWidth(Value);
end;

procedure TDControl.SetFixedXY(const Value: TSizeClass);
begin
  FFixedXY.S := Value.S;
  FControl.SetFixedXY(Value.S);
end;

procedure TDControl.SetFloat(const Value: Boolean);
begin
  FControl.SetFloat(Value);
end;

procedure TDControl.SetFloatPercent(const Value: TRectFClass);
var
  L: TPercentInfo;
begin
  L.left := Value.Left;
  L.top := Value.Top;
  L.right := Value.Right;
  L.bottom := Value.Bottom;
  FFloatPercent.Left := Value.Left;
  FFloatPercent.Top := Value.Top;
  FFloatPercent.Right := Value.Right;
  FFloatPercent.Bottom := Value.Bottom;
  FControl.SetFloatPercent(L);
end;

procedure TDControl.SetFocusBorderColor(const Value: TColor);
begin
  FControl.SetFocusBorderColor(ColorToARGB(Value));
end;

procedure TDControl.SetKeyboardEnabled(const Value: Boolean);
begin
  FControl.SetKeyboardEnabled(Value);
end;

procedure TDControl.SetMaxHeight(const Value: Integer);
begin
  FControl.SetMaxHeight(Value);
end;

procedure TDControl.SetMaxWidth(const Value: Integer);
begin
  FControl.SetMaxWidth(Value);
end;

procedure TDControl.SetMinHeight(const Value: Integer);
begin
  FControl.SetMinHeight(Value);
end;

procedure TDControl.SetMinWidth(const Value: Integer);
begin
  FControl.SetMinWidth(Value);
end;

procedure TDControl.SetMouseEnabled(const Value: Boolean);
begin
  FControl.SetMouseEnabled(Value);
end;

procedure TDControl.SetName(const Value: string);
begin
  FControl.SetName(Value);
end;

procedure TDControl.SetPadding(const Value: TRectClass);
begin
  FPadding.R := Value.R;
  FControl.SetPadding(Value.R);
end;

procedure TDControl.SetPos(const Value: TRectClass);
begin
  FPos.R := Value.R;
  FControl.SetPos(Value.R);
end;

procedure TDControl.SetShortcut(const Value: Char);
begin
  FControl.SetShortcut(Value);
end;

procedure TDControl.SetTag(const Value: Integer);
begin
  FControl.SetTag(Value);
end;

procedure TDControl.SetText(const Value: string);
begin
  FControl.SetText(Value);
end;

procedure TDControl.SetToolTip(const Value: string);
begin
  FControl.SetToolTip(Value);
end;

procedure TDControl.SetToolTipWidth(const Value: Integer);
begin
  FControl.SetToolTipWidth(Value);
end;

procedure TDControl.SetUserData(const Value: string);
begin
  FControl.SetUserData(Value);
end;

procedure TDControl.SetVirtualWnd(const Value: string);
begin
  FControl.SetVirtualWnd(Value);
end;

procedure TDControl.SetVisible(const Value: Boolean);
begin
  FControl.SetVisible(Value);
end;

{ TDCContainer }

constructor TDCContainer.Create;
begin
  inherited;
  FInset := TRectClass.Create;
  FScrollPos := TSizeClass.Create;
end;

destructor TDCContainer.Destroy;
begin
  FScrollPos.Free;
  FInset.Free;
  inherited;
end;

function TDCContainer.GetAutoDestroy: Boolean;
begin
  Result := CContainerUI(FControl).IsAutoDestroy;
end;

function TDCContainer.GetChildPadding: Integer;
begin
  Result := CContainerUI(FControl).GetChildPadding;
end;

function TDCContainer.GetDelayedDestroy: Boolean;
begin

end;

function TDCContainer.GetInset: TRectClass;
begin

end;

function TDCContainer.GetMouseChildEnabled: Boolean;
begin

end;

function TDCContainer.GetScrollPos: TSizeClass;
begin

end;

procedure TDCContainer.SetAutoDestroy(const Value: Boolean);
begin

end;

procedure TDCContainer.SetChildPadding(const Value: Integer);
begin

end;

procedure TDCContainer.SetDelayedDestroy(const Value: Boolean);
begin

end;

procedure TDCContainer.SetInset(const Value: TRectClass);
begin

end;

procedure TDCContainer.SetMouseChildEnabled(const Value: Boolean);
begin

end;

procedure TDCContainer.SetScrollPos(const Value: TSizeClass);
begin

end;

{ TRectClass }

function TRectClass.GetIsEmpty: Boolean;
begin
  Result := (FLeft = 0) and (FTop = 0) and (FRight = 0) and (FBottom = 0);
end;

function TRectClass.GetR: TRect;
begin
  Result := Rect(Self.Left, Self.Top, Self.Right, Self.Bottom);
end;

procedure TRectClass.SetR(const Value: TRect);
begin
  Left := Value.Left;
  Top := Value.Top;
  Right := Value.Right;
  Bottom := Value.Bottom;
end;

{ TSizeClass }

function TSizeClass.GetIsEmpty: Boolean;
begin
  Result := (FCX = 0) and (FCY = 0);
end;

function TSizeClass.GetS: TSize;
begin
  Result.cx := Self.CX;
  Result.cy := Self.Cy;
end;

procedure TSizeClass.SetS(const Value: TSize);
begin
  Cy := Value.cy;
  CX := Value.cx;
end;

{ TRectFClass }

function TRectFClass.GetIsEmpty: Boolean;
begin
  Result := (FLeft = 0.0) and (FTop = 0.0) and (FRight = 0.0) and (FBottom = 0);
end;

function TRectFClass.GetR: TRectF;
begin
  Result := RectF(Self.Left, Self.Top, Self.Right, Self.Bottom);
end;

procedure TRectFClass.SetR(const Value: TRectF);
begin
  Left := Value.Left;
  Top := Value.Top;
  Right := Value.Right;
  Bottom := Value.Bottom;
end;

end.
