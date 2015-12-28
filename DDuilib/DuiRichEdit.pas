//***************************************************************************
//
//       名称：DuiRichEdit.pas
//       工具：RAD Studio XE6
//       日期：2015/12/3
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiRichEdit;

{$I DDuilib.inc}

interface

uses
  Windows,
  RichEdit,
  Duilib;

type

  CRichEditUI = class(CContainerUI)
  private
    function _GetText: string;
    procedure _SetText(const Value: string);
    function _GetTextLength: Integer;
    function _GetSelText: string;
    function _GetTextRange(nStart, nEnd: Integer): string;
    function _GetDefaultCharFormat: TCharFormat2;
    procedure _SetDefaultCharFormat(const Value: TCharFormat2);
    procedure _SetAutoURLDetect(const Value: Boolean);
    procedure _SetEventMask(const Value: DWORD);
  public
    class function CppCreate: CRichEditUI; deprecated {$IFNDEF UseLowVer}'use Create'{$ENDIF};
    procedure CppDestroy; deprecated {$IFNDEF UseLowVer}'use Free'{$ENDIF};
    class function Create: CRichEditUI;
    procedure Free;
    function GetClass: string;
    function GetInterface(pstrName: string): Pointer;
    function GetControlFlags: UINT;
    function IsWantTab: Boolean;
    procedure SetWantTab(bWantTab: Boolean = True);
    function IsWantReturn: Boolean;
    procedure SetWantReturn(bWantReturn: Boolean = True);
    function IsWantCtrlReturn: Boolean;
    procedure SetWantCtrlReturn(bWantCtrlReturn: Boolean = True);
    function IsTransparent: Boolean;
    procedure SetTransparent(bTransparent: Boolean = True);
    function IsRich: Boolean;
    procedure SetRich(bRich: Boolean = True);
    function IsReadOnly: Boolean;
    procedure SetReadOnly(bReadOnly: Boolean = True);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(bWordWrap: Boolean = True);
    function GetFont: Integer;
    procedure SetFont(index: Integer); overload;
    procedure SetFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean); overload;
    function GetWinStyle: LONG;
    procedure SetWinStyle(lStyle: LONG);
    function GetTextColor: DWORD;
    procedure SetTextColor(dwTextColor: DWORD);
    function GetLimitText: Integer;
    procedure SetLimitText(iChars: Integer);
    function GetTextLength(dwFlags: DWORD = GTL_DEFAULT): LongInt;
    function GetText: string;
    procedure SetText(pstrText: string);
    function GetModify: Boolean;
    procedure SetModify(bModified: Boolean = True);
    procedure GetSel(var cr: CHARRANGE); overload;
    procedure GetSel(var nStartChar: LongInt; var nEndChar: LongInt); overload;
    function SetSel(const cr: CHARRANGE): Integer; overload;
    function SetSel(nStartChar: LongInt; nEndChar: LongInt): Integer; overload;
    procedure ReplaceSel(lpszNewText: string; bCanUndo: Boolean);
    procedure ReplaceSelW(lpszNewText: WideString; bCanUndo: Boolean = False);
    function GetSelText: string;
    function SetSelAll: Integer;
    function SetSelNone: Integer;
    function GetSelectionType: WORD;
    function GetZoom(var nNum: Integer; var nDen: Integer): Boolean;
    function SetZoom(nNum: Integer; nDen: Integer): Boolean;
    function SetZoomOff: Boolean;
    function GetAutoURLDetect: Boolean;
    function SetAutoURLDetect(bAutoDetect: Boolean = True): Boolean;
    function GetEventMask: DWORD;
    function SetEventMask(dwEventMask: DWORD): DWORD;
    function GetTextRange(nStartChar: LongInt; nEndChar: LongInt): CDuiString;
    procedure HideSelection(bHide: Boolean = True; bChangeStyle: Boolean = False);
    procedure ScrollCaret;
    function InsertText(nInsertAfterChar: LongInt; lpstrText: string; bCanUndo: Boolean = False): Integer;
    function AppendText(lpstrText: string; bCanUndo: Boolean = False): Integer;
    function GetDefaultCharFormat(var cf: CHARFORMAT2): DWORD;
    function SetDefaultCharFormat(const cf: CHARFORMAT2): Boolean;
    function GetSelectionCharFormat(var cf: CHARFORMAT2): DWORD;
    function SetSelectionCharFormat(const cf: CHARFORMAT2): Boolean;
    function SetWordCharFormat(const cf: CHARFORMAT2): Boolean;
    function GetParaFormat(var pf: PARAFORMAT2): DWORD;
    function SetParaFormat(const pf: PARAFORMAT2): Boolean;
    procedure Clear;
    procedure Copy;
    procedure Cut;
    procedure Paste;
    function Redo: Boolean;
    function Undo: Boolean;
    function GetLineCount: Integer;
    function GetLine(nIndex: Integer; nMaxLength: Integer): string;
    function LineIndex(nLine: Integer = -1): Integer;
    function LineLength(nLine: Integer = -1): Integer;
    function LineScroll(nLines: Integer; nChars: Integer = 0): Boolean;
    function GetCharPos(lChar: LongInt): TPoint;
    function LineFromChar(nIndex: LongInt): LongInt;
    function PosFromChar(nChar: UINT): TPoint;
    function CharFromPos(pt: TPoint): Integer;
    procedure EmptyUndoBuffer;
    function SetUndoLimit(nLimit: UINT): UINT;
    function StreamIn(nFormat: Integer; var es: EDITSTREAM): LongInt;
    function StreamOut(nFormat: Integer; const es: EDITSTREAM): LongInt;
    procedure DoInit;
    function SetDropAcceptFile(bAccept: Boolean): Boolean;
    function TxSendMessage(msg: UINT; wparam: WPARAM; lparam: LPARAM; plresult: PLRESULT): HRESULT;
    function GetTxDropTarget: IDropTarget;
    function OnTxViewChanged: Boolean;
    procedure OnTxNotify(iNotify: DWORD; pv: PPointer);
    procedure SetScrollPos(szPos: TSize);
    procedure LineUp;
    procedure LineDown;
    procedure PageUp;
    procedure PageDown;
    procedure HomeUp;
    procedure EndDown;
    procedure LineLeft;
    procedure LineRight;
    procedure PageLeft;
    procedure PageRight;
    procedure HomeLeft;
    procedure EndRight;
    function EstimateSize(szAvailable: TSize): TSize;
    procedure SetPos(rc: TRect; bNeedInvalidate: Boolean = True);
    procedure Move(szOffset: TSize; bNeedInvalidate: Boolean = True);
    procedure DoEvent(var event: TEventUI);
    procedure DoPaint(hDC: HDC; var rcPaint: TRect);
    procedure SetAttribute(pstrName: string; pstrValue: string);
  public
    property DefaultCharFormat: TCharFormat2 read _GetDefaultCharFormat write _SetDefaultCharFormat;
    property Rich: Boolean read IsRich write SetRich;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap;
    property WinStyle: LONG read GetWinStyle write SetWinStyle;
    property TextColor: DWORD read GetTextColor write SetTextColor;
    property WantTab: Boolean read IsWantTab write SetWantTab;
    property WantReturn: Boolean read IsWantReturn write SetWantCtrlReturn;
    property WantCtrolReturn: Boolean read IsWantCtrlReturn write SetWantCtrlReturn;
    property ReadOnly: Boolean read IsReadOnly write SetReadOnly;
    property LimitText: Integer read GetLimitText write SetLimitText;
    property Text: string read _GetText write _SetText;
    property Transparent: Boolean read IsTransparent write SetTransparent;
    property Modify: Boolean read GetModify write SetModify;
    property Length: Integer read _GetTextLength;
    property SelText: string read _GetSelText;
    property AutoURLDetect: Boolean read GetAutoURLDetect write _SetAutoURLDetect;
    property EventMask: DWORD read GetEventMask write _SetEventMask;
    property TextRange[nStart, nEnd: Integer]: string read _GetTextRange;
  end;



//================================CRichEditUI============================

function Delphi_RichEditUI_CppCreate: CRichEditUI; cdecl;
procedure Delphi_RichEditUI_CppDestroy(Handle: CRichEditUI); cdecl;
function Delphi_RichEditUI_GetClass(Handle: CRichEditUI): LPCTSTR; cdecl;
function Delphi_RichEditUI_GetInterface(Handle: CRichEditUI; pstrName: LPCTSTR): Pointer; cdecl;
function Delphi_RichEditUI_GetControlFlags(Handle: CRichEditUI): UINT; cdecl;
function Delphi_RichEditUI_IsWantTab(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetWantTab(Handle: CRichEditUI; bWantTab: Boolean); cdecl;
function Delphi_RichEditUI_IsWantReturn(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetWantReturn(Handle: CRichEditUI; bWantReturn: Boolean); cdecl;
function Delphi_RichEditUI_IsWantCtrlReturn(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetWantCtrlReturn(Handle: CRichEditUI; bWantCtrlReturn: Boolean); cdecl;
function Delphi_RichEditUI_IsTransparent(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetTransparent(Handle: CRichEditUI; bTransparent: Boolean); cdecl;
function Delphi_RichEditUI_IsRich(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetRich(Handle: CRichEditUI; bRich: Boolean); cdecl;
function Delphi_RichEditUI_IsReadOnly(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetReadOnly(Handle: CRichEditUI; bReadOnly: Boolean); cdecl;
function Delphi_RichEditUI_GetWordWrap(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetWordWrap(Handle: CRichEditUI; bWordWrap: Boolean); cdecl;
function Delphi_RichEditUI_GetFont(Handle: CRichEditUI): Integer; cdecl;
procedure Delphi_RichEditUI_SetFont_01(Handle: CRichEditUI; index: Integer); cdecl;
procedure Delphi_RichEditUI_SetFont_02(Handle: CRichEditUI; pStrFontName: LPCTSTR; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean); cdecl;
function Delphi_RichEditUI_GetWinStyle(Handle: CRichEditUI): LONG; cdecl;
procedure Delphi_RichEditUI_SetWinStyle(Handle: CRichEditUI; lStyle: LONG); cdecl;
function Delphi_RichEditUI_GetTextColor(Handle: CRichEditUI): DWORD; cdecl;
procedure Delphi_RichEditUI_SetTextColor(Handle: CRichEditUI; dwTextColor: DWORD); cdecl;
function Delphi_RichEditUI_GetLimitText(Handle: CRichEditUI): Integer; cdecl;
procedure Delphi_RichEditUI_SetLimitText(Handle: CRichEditUI; iChars: Integer); cdecl;
function Delphi_RichEditUI_GetTextLength(Handle: CRichEditUI; dwFlags: DWORD): LongInt; cdecl;
function Delphi_RichEditUI_GetText(Handle: CRichEditUI): CDuiString; cdecl;
procedure Delphi_RichEditUI_SetText(Handle: CRichEditUI; pstrText: LPCTSTR); cdecl;
function Delphi_RichEditUI_GetModify(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_SetModify(Handle: CRichEditUI; bModified: Boolean); cdecl;
procedure Delphi_RichEditUI_GetSel_01(Handle: CRichEditUI; var cr: CHARRANGE); cdecl;
procedure Delphi_RichEditUI_GetSel_02(Handle: CRichEditUI; var nStartChar: LongInt; var nEndChar: LongInt); cdecl;
function Delphi_RichEditUI_SetSel_01(Handle: CRichEditUI; const cr: CHARRANGE): Integer; cdecl;
function Delphi_RichEditUI_SetSel_02(Handle: CRichEditUI; nStartChar: LongInt; nEndChar: LongInt): Integer; cdecl;
procedure Delphi_RichEditUI_ReplaceSel(Handle: CRichEditUI; lpszNewText: LPCTSTR; bCanUndo: Boolean); cdecl;
procedure Delphi_RichEditUI_ReplaceSelW(Handle: CRichEditUI; lpszNewText: LPCWSTR; bCanUndo: Boolean); cdecl;
function Delphi_RichEditUI_GetSelText(Handle: CRichEditUI): CDuiString; cdecl;
function Delphi_RichEditUI_SetSelAll(Handle: CRichEditUI): Integer; cdecl;
function Delphi_RichEditUI_SetSelNone(Handle: CRichEditUI): Integer; cdecl;
function Delphi_RichEditUI_GetSelectionType(Handle: CRichEditUI): WORD; cdecl;
function Delphi_RichEditUI_GetZoom(Handle: CRichEditUI; var nNum: Integer; var nDen: Integer): Boolean; cdecl;
function Delphi_RichEditUI_SetZoom(Handle: CRichEditUI; nNum: Integer; nDen: Integer): Boolean; cdecl;
function Delphi_RichEditUI_SetZoomOff(Handle: CRichEditUI): Boolean; cdecl;
function Delphi_RichEditUI_GetAutoURLDetect(Handle: CRichEditUI): Boolean; cdecl;
function Delphi_RichEditUI_SetAutoURLDetect(Handle: CRichEditUI; bAutoDetect: Boolean): Boolean; cdecl;
function Delphi_RichEditUI_GetEventMask(Handle: CRichEditUI): DWORD; cdecl;
function Delphi_RichEditUI_SetEventMask(Handle: CRichEditUI; dwEventMask: DWORD): DWORD; cdecl;
function Delphi_RichEditUI_GetTextRange(Handle: CRichEditUI; nStartChar: LongInt; nEndChar: LongInt): CDuiString; cdecl;
procedure Delphi_RichEditUI_HideSelection(Handle: CRichEditUI; bHide: Boolean; bChangeStyle: Boolean); cdecl;
procedure Delphi_RichEditUI_ScrollCaret(Handle: CRichEditUI); cdecl;
function Delphi_RichEditUI_InsertText(Handle: CRichEditUI; nInsertAfterChar: LongInt; lpstrText: LPCTSTR; bCanUndo: Boolean): Integer; cdecl;
function Delphi_RichEditUI_AppendText(Handle: CRichEditUI; lpstrText: LPCTSTR; bCanUndo: Boolean): Integer; cdecl;
function Delphi_RichEditUI_GetDefaultCharFormat(Handle: CRichEditUI; var cf: CHARFORMAT2): DWORD; cdecl;
function Delphi_RichEditUI_SetDefaultCharFormat(Handle: CRichEditUI; const cf: CHARFORMAT2): Boolean; cdecl;
function Delphi_RichEditUI_GetSelectionCharFormat(Handle: CRichEditUI; var cf: CHARFORMAT2): DWORD; cdecl;
function Delphi_RichEditUI_SetSelectionCharFormat(Handle: CRichEditUI; const cf: CHARFORMAT2): Boolean; cdecl;
function Delphi_RichEditUI_SetWordCharFormat(Handle: CRichEditUI; const cf: CHARFORMAT2): Boolean; cdecl;
function Delphi_RichEditUI_GetParaFormat(Handle: CRichEditUI; var pf: PARAFORMAT2): DWORD; cdecl;
function Delphi_RichEditUI_SetParaFormat(Handle: CRichEditUI; const pf: PARAFORMAT2): Boolean; cdecl;
function Delphi_RichEditUI_Redo(Handle: CRichEditUI): Boolean; cdecl;
function Delphi_RichEditUI_Undo(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_Clear(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_Copy(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_Cut(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_Paste(Handle: CRichEditUI); cdecl;
function Delphi_RichEditUI_GetLineCount(Handle: CRichEditUI): Integer; cdecl;
function Delphi_RichEditUI_GetLine(Handle: CRichEditUI; nIndex: Integer; nMaxLength: Integer): CDuiString; cdecl;
function Delphi_RichEditUI_LineIndex(Handle: CRichEditUI; nLine: Integer): Integer; cdecl;
function Delphi_RichEditUI_LineLength(Handle: CRichEditUI; nLine: Integer): Integer; cdecl;
function Delphi_RichEditUI_LineScroll(Handle: CRichEditUI; nLines: Integer; nChars: Integer): Boolean; cdecl;
function Delphi_RichEditUI_GetCharPos(Handle: CRichEditUI; lChar: LongInt): TPoint; cdecl;
function Delphi_RichEditUI_LineFromChar(Handle: CRichEditUI; nIndex: LongInt): LongInt; cdecl;
function Delphi_RichEditUI_PosFromChar(Handle: CRichEditUI; nChar: UINT): TPoint; cdecl;
function Delphi_RichEditUI_CharFromPos(Handle: CRichEditUI; pt: TPoint): Integer; cdecl;
procedure Delphi_RichEditUI_EmptyUndoBuffer(Handle: CRichEditUI); cdecl;
function Delphi_RichEditUI_SetUndoLimit(Handle: CRichEditUI; nLimit: UINT): UINT; cdecl;
function Delphi_RichEditUI_StreamIn(Handle: CRichEditUI; nFormat: Integer; var es: EDITSTREAM): LongInt; cdecl;
function Delphi_RichEditUI_StreamOut(Handle: CRichEditUI; nFormat: Integer; const es: EDITSTREAM): LongInt; cdecl;
procedure Delphi_RichEditUI_DoInit(Handle: CRichEditUI); cdecl;
function Delphi_RichEditUI_SetDropAcceptFile(Handle: CRichEditUI; bAccept: Boolean): Boolean; cdecl;
function Delphi_RichEditUI_TxSendMessage(Handle: CRichEditUI; msg: UINT; wparam: WPARAM; lparam: LPARAM; plresult: PLRESULT): HRESULT; cdecl;
function Delphi_RichEditUI_GetTxDropTarget(Handle: CRichEditUI): IDropTarget; cdecl;
function Delphi_RichEditUI_OnTxViewChanged(Handle: CRichEditUI): Boolean; cdecl;
procedure Delphi_RichEditUI_OnTxNotify(Handle: CRichEditUI; iNotify: DWORD; pv: PPointer); cdecl;
procedure Delphi_RichEditUI_SetScrollPos(Handle: CRichEditUI; szPos: TSize); cdecl;
procedure Delphi_RichEditUI_LineUp(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_LineDown(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_PageUp(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_PageDown(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_HomeUp(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_EndDown(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_LineLeft(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_LineRight(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_PageLeft(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_PageRight(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_HomeLeft(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_EndRight(Handle: CRichEditUI); cdecl;
procedure Delphi_RichEditUI_EstimateSize(Handle: CRichEditUI; szAvailable: TSize; var Result: TSize); cdecl;
procedure Delphi_RichEditUI_SetPos(Handle: CRichEditUI; rc: TRect; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_RichEditUI_Move(Handle: CRichEditUI; szOffset: TSize; bNeedInvalidate: Boolean); cdecl;
procedure Delphi_RichEditUI_DoEvent(Handle: CRichEditUI; var event: TEventUI); cdecl;
procedure Delphi_RichEditUI_DoPaint(Handle: CRichEditUI; hDC: HDC; var rcPaint: TRect); cdecl;
procedure Delphi_RichEditUI_SetAttribute(Handle: CRichEditUI; pstrName: LPCTSTR; pstrValue: LPCTSTR); cdecl;


implementation

{ CRichEditUI }

class function CRichEditUI.CppCreate: CRichEditUI;
begin
  Result := Delphi_RichEditUI_CppCreate;
end;

procedure CRichEditUI.CppDestroy;
begin
  Delphi_RichEditUI_CppDestroy(Self);
end;

class function CRichEditUI.Create: CRichEditUI;
begin
  Result := Delphi_RichEditUI_CppCreate;
end;

procedure CRichEditUI.Free;
begin
  Delphi_RichEditUI_CppDestroy(Self);
end;

function CRichEditUI.GetClass: string;
begin
  Result := Delphi_RichEditUI_GetClass(Self);
end;

function CRichEditUI.GetInterface(pstrName: string): Pointer;
begin
  Result := Delphi_RichEditUI_GetInterface(Self, PChar(pstrName));
end;

function CRichEditUI.GetControlFlags: UINT;
begin
  Result := Delphi_RichEditUI_GetControlFlags(Self);
end;

function CRichEditUI.IsWantTab: Boolean;
begin
  Result := Delphi_RichEditUI_IsWantTab(Self);
end;

procedure CRichEditUI.SetWantTab(bWantTab: Boolean);
begin
  Delphi_RichEditUI_SetWantTab(Self, bWantTab);
end;

function CRichEditUI.IsWantReturn: Boolean;
begin
  Result := Delphi_RichEditUI_IsWantReturn(Self);
end;

procedure CRichEditUI.SetWantReturn(bWantReturn: Boolean);
begin
  Delphi_RichEditUI_SetWantReturn(Self, bWantReturn);
end;

function CRichEditUI.IsWantCtrlReturn: Boolean;
begin
  Result := Delphi_RichEditUI_IsWantCtrlReturn(Self);
end;

procedure CRichEditUI.SetWantCtrlReturn(bWantCtrlReturn: Boolean);
begin
  Delphi_RichEditUI_SetWantCtrlReturn(Self, bWantCtrlReturn);
end;

function CRichEditUI.IsTransparent: Boolean;
begin
  Result := Delphi_RichEditUI_IsTransparent(Self);
end;

procedure CRichEditUI.SetTransparent(bTransparent: Boolean);
begin
  Delphi_RichEditUI_SetTransparent(Self, bTransparent);
end;

function CRichEditUI.IsRich: Boolean;
begin
  Result := Delphi_RichEditUI_IsRich(Self);
end;

procedure CRichEditUI.SetRich(bRich: Boolean);
begin
  Delphi_RichEditUI_SetRich(Self, bRich);
end;

function CRichEditUI.IsReadOnly: Boolean;
begin
  Result := Delphi_RichEditUI_IsReadOnly(Self);
end;

procedure CRichEditUI.SetReadOnly(bReadOnly: Boolean);
begin
  Delphi_RichEditUI_SetReadOnly(Self, bReadOnly);
end;

function CRichEditUI.GetWordWrap: Boolean;
begin
  Result := Delphi_RichEditUI_GetWordWrap(Self);
end;

procedure CRichEditUI.SetWordWrap(bWordWrap: Boolean);
begin
  Delphi_RichEditUI_SetWordWrap(Self, bWordWrap);
end;

function CRichEditUI.GetFont: Integer;
begin
  Result := Delphi_RichEditUI_GetFont(Self);
end;

procedure CRichEditUI.SetFont(index: Integer);
begin
  Delphi_RichEditUI_SetFont_01(Self, index);
end;

procedure CRichEditUI.SetFont(pStrFontName: string; nSize: Integer; bBold: Boolean; bUnderline: Boolean; bItalic: Boolean);
begin
  Delphi_RichEditUI_SetFont_02(Self, PChar(pStrFontName), nSize, bBold, bUnderline, bItalic);
end;

function CRichEditUI.GetWinStyle: LONG;
begin
  Result := Delphi_RichEditUI_GetWinStyle(Self);
end;

procedure CRichEditUI.SetWinStyle(lStyle: LONG);
begin
  Delphi_RichEditUI_SetWinStyle(Self, lStyle);
end;

function CRichEditUI.GetTextColor: DWORD;
begin
  Result := Delphi_RichEditUI_GetTextColor(Self);
end;

procedure CRichEditUI.SetTextColor(dwTextColor: DWORD);
begin
  Delphi_RichEditUI_SetTextColor(Self, dwTextColor);
end;

function CRichEditUI.GetLimitText: Integer;
begin
  Result := Delphi_RichEditUI_GetLimitText(Self);
end;

procedure CRichEditUI.SetLimitText(iChars: Integer);
begin
  Delphi_RichEditUI_SetLimitText(Self, iChars);
end;

function CRichEditUI.GetTextLength(dwFlags: DWORD): LongInt;
begin
  Result := Delphi_RichEditUI_GetTextLength(Self, dwFlags);
end;

function CRichEditUI.GetText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_RichEditUI_GetText(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_RichEditUI_GetText(Self));
{$ENDIF}
end;

procedure CRichEditUI.SetText(pstrText: string);
begin
  Delphi_RichEditUI_SetText(Self, PChar(pstrText));
end;

function CRichEditUI.GetModify: Boolean;
begin
  Result := Delphi_RichEditUI_GetModify(Self);
end;

procedure CRichEditUI.SetModify(bModified: Boolean);
begin
  Delphi_RichEditUI_SetModify(Self, bModified);
end;

procedure CRichEditUI.GetSel(var cr: CHARRANGE);
begin
  Delphi_RichEditUI_GetSel_01(Self, cr);
end;

procedure CRichEditUI.GetSel(var nStartChar: LongInt; var nEndChar: LongInt);
begin
  Delphi_RichEditUI_GetSel_02(Self, nStartChar, nEndChar);
end;

function CRichEditUI.SetSel(const cr: CHARRANGE): Integer;
begin
  Result := Delphi_RichEditUI_SetSel_01(Self, cr);
end;

function CRichEditUI.SetSel(nStartChar: LongInt; nEndChar: LongInt): Integer;
begin
  Result := Delphi_RichEditUI_SetSel_02(Self, nStartChar, nEndChar);
end;

procedure CRichEditUI.ReplaceSel(lpszNewText: string; bCanUndo: Boolean);
begin
  Delphi_RichEditUI_ReplaceSel(Self, PChar(lpszNewText), bCanUndo);
end;

procedure CRichEditUI.ReplaceSelW(lpszNewText: WideString; bCanUndo: Boolean);
begin
  Delphi_RichEditUI_ReplaceSelW(Self, PWideChar(lpszNewText), bCanUndo);
end;

function CRichEditUI.GetSelText: string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_RichEditUI_GetSelText(Self);
{$ELSE}
  Result := DuiStringToString(Delphi_RichEditUI_GetSelText(Self));
{$ENDIF}
end;

function CRichEditUI.SetSelAll: Integer;
begin
  Result := Delphi_RichEditUI_SetSelAll(Self);
end;

function CRichEditUI.SetSelNone: Integer;
begin
  Result := Delphi_RichEditUI_SetSelNone(Self);
end;

function CRichEditUI.GetSelectionType: WORD;
begin
  Result := Delphi_RichEditUI_GetSelectionType(Self);
end;

function CRichEditUI.GetZoom(var nNum: Integer; var nDen: Integer): Boolean;
begin
  Result := Delphi_RichEditUI_GetZoom(Self, nNum, nDen);
end;

function CRichEditUI.SetZoom(nNum: Integer; nDen: Integer): Boolean;
begin
  Result := Delphi_RichEditUI_SetZoom(Self, nNum, nDen);
end;

function CRichEditUI.SetZoomOff: Boolean;
begin
  Result := Delphi_RichEditUI_SetZoomOff(Self);
end;

function CRichEditUI.GetAutoURLDetect: Boolean;
begin
  Result := Delphi_RichEditUI_GetAutoURLDetect(Self);
end;

function CRichEditUI.SetAutoURLDetect(bAutoDetect: Boolean): Boolean;
begin
  Result := Delphi_RichEditUI_SetAutoURLDetect(Self, bAutoDetect);
end;

function CRichEditUI.GetEventMask: DWORD;
begin
  Result := Delphi_RichEditUI_GetEventMask(Self);
end;

function CRichEditUI.SetEventMask(dwEventMask: DWORD): DWORD;
begin
  Result := Delphi_RichEditUI_SetEventMask(Self, dwEventMask);
end;

function CRichEditUI.GetTextRange(nStartChar: LongInt; nEndChar: LongInt): CDuiString;
begin
  Result := Delphi_RichEditUI_GetTextRange(Self, nStartChar, nEndChar);
end;

procedure CRichEditUI.HideSelection(bHide: Boolean; bChangeStyle: Boolean);
begin
  Delphi_RichEditUI_HideSelection(Self, bHide, bChangeStyle);
end;

procedure CRichEditUI.ScrollCaret;
begin
  Delphi_RichEditUI_ScrollCaret(Self);
end;

function CRichEditUI.InsertText(nInsertAfterChar: LongInt; lpstrText: string; bCanUndo: Boolean): Integer;
begin
  Result := Delphi_RichEditUI_InsertText(Self, nInsertAfterChar, PChar(lpstrText), bCanUndo);
end;

function CRichEditUI.AppendText(lpstrText: string; bCanUndo: Boolean): Integer;
begin
  Result := Delphi_RichEditUI_AppendText(Self, PChar(lpstrText), bCanUndo);
end;

function CRichEditUI.GetDefaultCharFormat(var cf: CHARFORMAT2): DWORD;
begin
  Result := Delphi_RichEditUI_GetDefaultCharFormat(Self, cf);
end;

function CRichEditUI.SetDefaultCharFormat(const cf: CHARFORMAT2): Boolean;
begin
  Result := Delphi_RichEditUI_SetDefaultCharFormat(Self, cf);
end;

function CRichEditUI.GetSelectionCharFormat(var cf: CHARFORMAT2): DWORD;
begin
  Result := Delphi_RichEditUI_GetSelectionCharFormat(Self, cf);
end;

function CRichEditUI.SetSelectionCharFormat(const cf: CHARFORMAT2): Boolean;
begin
  Result := Delphi_RichEditUI_SetSelectionCharFormat(Self, cf);
end;

function CRichEditUI.SetWordCharFormat(const cf: CHARFORMAT2): Boolean;
begin
  Result := Delphi_RichEditUI_SetWordCharFormat(Self, cf);
end;

function CRichEditUI.GetParaFormat(var pf: PARAFORMAT2): DWORD;
begin
  Result := Delphi_RichEditUI_GetParaFormat(Self, pf);
end;

function CRichEditUI.SetParaFormat(const pf: PARAFORMAT2): Boolean;
begin
  Result := Delphi_RichEditUI_SetParaFormat(Self, pf);
end;

function CRichEditUI._GetDefaultCharFormat: TCharFormat2;
begin
  GetDefaultCharFormat(Result);
end;

function CRichEditUI._GetSelText: string;
begin
  Result := GetSelText;
end;

function CRichEditUI._GetText: string;
begin
  Result := GetText;
end;

function CRichEditUI._GetTextLength: Integer;
begin
  Result := GetTextLength;
end;

function CRichEditUI._GetTextRange(nStart, nEnd: Integer): string;
begin
{$IFNDEF UseLowVer}
  Result := GetTextRange(nStart, nEnd);
{$ELSE}
  Result := DuiStringToString(GetTextRange(nStart, nEnd));
{$ENDIF}
end;

function CRichEditUI.Redo: Boolean;
begin
  Result := Delphi_RichEditUI_Redo(Self);
end;

procedure CRichEditUI._SetAutoURLDetect(const Value: Boolean);
begin
  SetAutoURLDetect(Value);
end;

procedure CRichEditUI._SetDefaultCharFormat(const Value: TCharFormat2);
var
  LFmt: TCharFormat2;
begin
  LFmt := Value;
  SetDefaultCharFormat(LFmt);
end;

procedure CRichEditUI._SetEventMask(const Value: DWORD);
begin
  SetEventMask(Value);
end;

procedure CRichEditUI._SetText(const Value: string);
begin
  SetText(PChar(Value));
end;

function CRichEditUI.Undo: Boolean;
begin
  Result := Delphi_RichEditUI_Undo(Self);
end;

procedure CRichEditUI.Clear;
begin
  Delphi_RichEditUI_Clear(Self);
end;

procedure CRichEditUI.Copy;
begin
  Delphi_RichEditUI_Copy(Self);
end;

procedure CRichEditUI.Cut;
begin
  Delphi_RichEditUI_Cut(Self);
end;

procedure CRichEditUI.Paste;
begin
  Delphi_RichEditUI_Paste(Self);
end;

function CRichEditUI.GetLineCount: Integer;
begin
  Result := Delphi_RichEditUI_GetLineCount(Self);
end;

function CRichEditUI.GetLine(nIndex: Integer; nMaxLength: Integer): string;
begin
{$IFNDEF UseLowVer}
  Result := Delphi_RichEditUI_GetLine(Self, nIndex, nMaxLength);
{$ELSE}
  Result := DuiStringToString(Delphi_RichEditUI_GetLine(Self, nIndex, nMaxLength));
{$ENDIF}
end;

function CRichEditUI.LineIndex(nLine: Integer): Integer;
begin
  Result := Delphi_RichEditUI_LineIndex(Self, nLine);
end;

function CRichEditUI.LineLength(nLine: Integer): Integer;
begin
  Result := Delphi_RichEditUI_LineLength(Self, nLine);
end;

function CRichEditUI.LineScroll(nLines: Integer; nChars: Integer): Boolean;
begin
  Result := Delphi_RichEditUI_LineScroll(Self, nLines, nChars);
end;

function CRichEditUI.GetCharPos(lChar: LongInt): TPoint;
begin
  Result := Delphi_RichEditUI_GetCharPos(Self, lChar);
end;

function CRichEditUI.LineFromChar(nIndex: LongInt): LongInt;
begin
  Result := Delphi_RichEditUI_LineFromChar(Self, nIndex);
end;

function CRichEditUI.PosFromChar(nChar: UINT): TPoint;
begin
  Result := Delphi_RichEditUI_PosFromChar(Self, nChar);
end;

function CRichEditUI.CharFromPos(pt: TPoint): Integer;
begin
  Result := Delphi_RichEditUI_CharFromPos(Self, pt);
end;

procedure CRichEditUI.EmptyUndoBuffer;
begin
  Delphi_RichEditUI_EmptyUndoBuffer(Self);
end;

function CRichEditUI.SetUndoLimit(nLimit: UINT): UINT;
begin
  Result := Delphi_RichEditUI_SetUndoLimit(Self, nLimit);
end;

function CRichEditUI.StreamIn(nFormat: Integer; var es: EDITSTREAM): LongInt;
begin
  Result := Delphi_RichEditUI_StreamIn(Self, nFormat, es);
end;

function CRichEditUI.StreamOut(nFormat: Integer; const es: EDITSTREAM): LongInt;
begin
  Result := Delphi_RichEditUI_StreamOut(Self, nFormat, es);
end;

procedure CRichEditUI.DoInit;
begin
  Delphi_RichEditUI_DoInit(Self);
end;

function CRichEditUI.SetDropAcceptFile(bAccept: Boolean): Boolean;
begin
  Result := Delphi_RichEditUI_SetDropAcceptFile(Self, bAccept);
end;

function CRichEditUI.TxSendMessage(msg: UINT; wparam: WPARAM; lparam: LPARAM; plresult: PLRESULT): HRESULT;
begin
  Result := Delphi_RichEditUI_TxSendMessage(Self, msg, wparam, lparam, plresult);
end;

function CRichEditUI.GetTxDropTarget: IDropTarget;
begin
  Result := Delphi_RichEditUI_GetTxDropTarget(Self);
end;

function CRichEditUI.OnTxViewChanged: Boolean;
begin
  Result := Delphi_RichEditUI_OnTxViewChanged(Self);
end;

procedure CRichEditUI.OnTxNotify(iNotify: DWORD; pv: PPointer);
begin
  Delphi_RichEditUI_OnTxNotify(Self, iNotify, pv);
end;

procedure CRichEditUI.SetScrollPos(szPos: TSize);
begin
  Delphi_RichEditUI_SetScrollPos(Self, szPos);
end;

procedure CRichEditUI.LineUp;
begin
  Delphi_RichEditUI_LineUp(Self);
end;

procedure CRichEditUI.LineDown;
begin
  Delphi_RichEditUI_LineDown(Self);
end;

procedure CRichEditUI.PageUp;
begin
  Delphi_RichEditUI_PageUp(Self);
end;

procedure CRichEditUI.PageDown;
begin
  Delphi_RichEditUI_PageDown(Self);
end;

procedure CRichEditUI.HomeUp;
begin
  Delphi_RichEditUI_HomeUp(Self);
end;

procedure CRichEditUI.EndDown;
begin
  Delphi_RichEditUI_EndDown(Self);
end;

procedure CRichEditUI.LineLeft;
begin
  Delphi_RichEditUI_LineLeft(Self);
end;

procedure CRichEditUI.LineRight;
begin
  Delphi_RichEditUI_LineRight(Self);
end;

procedure CRichEditUI.PageLeft;
begin
  Delphi_RichEditUI_PageLeft(Self);
end;

procedure CRichEditUI.PageRight;
begin
  Delphi_RichEditUI_PageRight(Self);
end;

procedure CRichEditUI.HomeLeft;
begin
  Delphi_RichEditUI_HomeLeft(Self);
end;

procedure CRichEditUI.EndRight;
begin
  Delphi_RichEditUI_EndRight(Self);
end;

function CRichEditUI.EstimateSize(szAvailable: TSize): TSize;
begin
  Delphi_RichEditUI_EstimateSize(Self, szAvailable, Result);
end;

procedure CRichEditUI.SetPos(rc: TRect; bNeedInvalidate: Boolean);
begin
  Delphi_RichEditUI_SetPos(Self, rc, bNeedInvalidate);
end;

procedure CRichEditUI.Move(szOffset: TSize; bNeedInvalidate: Boolean);
begin
  Delphi_RichEditUI_Move(Self, szOffset, bNeedInvalidate);
end;

procedure CRichEditUI.DoEvent(var event: TEventUI);
begin
  Delphi_RichEditUI_DoEvent(Self, event);
end;

procedure CRichEditUI.DoPaint(hDC: HDC; var rcPaint: TRect);
begin
  Delphi_RichEditUI_DoPaint(Self, hDC, rcPaint);
end;

procedure CRichEditUI.SetAttribute(pstrName: string; pstrValue: string);
begin
  Delphi_RichEditUI_SetAttribute(Self, PChar(pstrName), PChar(pstrValue));
end;

//================================CRichEditUI============================

function Delphi_RichEditUI_CppCreate; external DuiLibdll name 'Delphi_RichEditUI_CppCreate';
procedure Delphi_RichEditUI_CppDestroy; external DuiLibdll name 'Delphi_RichEditUI_CppDestroy';
function Delphi_RichEditUI_GetClass; external DuiLibdll name 'Delphi_RichEditUI_GetClass';
function Delphi_RichEditUI_GetInterface; external DuiLibdll name 'Delphi_RichEditUI_GetInterface';
function Delphi_RichEditUI_GetControlFlags; external DuiLibdll name 'Delphi_RichEditUI_GetControlFlags';
function Delphi_RichEditUI_IsWantTab; external DuiLibdll name 'Delphi_RichEditUI_IsWantTab';
procedure Delphi_RichEditUI_SetWantTab; external DuiLibdll name 'Delphi_RichEditUI_SetWantTab';
function Delphi_RichEditUI_IsWantReturn; external DuiLibdll name 'Delphi_RichEditUI_IsWantReturn';
procedure Delphi_RichEditUI_SetWantReturn; external DuiLibdll name 'Delphi_RichEditUI_SetWantReturn';
function Delphi_RichEditUI_IsWantCtrlReturn; external DuiLibdll name 'Delphi_RichEditUI_IsWantCtrlReturn';
procedure Delphi_RichEditUI_SetWantCtrlReturn; external DuiLibdll name 'Delphi_RichEditUI_SetWantCtrlReturn';
function Delphi_RichEditUI_IsTransparent; external DuiLibdll name 'Delphi_RichEditUI_IsTransparent';
procedure Delphi_RichEditUI_SetTransparent; external DuiLibdll name 'Delphi_RichEditUI_SetTransparent';
function Delphi_RichEditUI_IsRich; external DuiLibdll name 'Delphi_RichEditUI_IsRich';
procedure Delphi_RichEditUI_SetRich; external DuiLibdll name 'Delphi_RichEditUI_SetRich';
function Delphi_RichEditUI_IsReadOnly; external DuiLibdll name 'Delphi_RichEditUI_IsReadOnly';
procedure Delphi_RichEditUI_SetReadOnly; external DuiLibdll name 'Delphi_RichEditUI_SetReadOnly';
function Delphi_RichEditUI_GetWordWrap; external DuiLibdll name 'Delphi_RichEditUI_GetWordWrap';
procedure Delphi_RichEditUI_SetWordWrap; external DuiLibdll name 'Delphi_RichEditUI_SetWordWrap';
function Delphi_RichEditUI_GetFont; external DuiLibdll name 'Delphi_RichEditUI_GetFont';
procedure Delphi_RichEditUI_SetFont_01; external DuiLibdll name 'Delphi_RichEditUI_SetFont_01';
procedure Delphi_RichEditUI_SetFont_02; external DuiLibdll name 'Delphi_RichEditUI_SetFont_02';
function Delphi_RichEditUI_GetWinStyle; external DuiLibdll name 'Delphi_RichEditUI_GetWinStyle';
procedure Delphi_RichEditUI_SetWinStyle; external DuiLibdll name 'Delphi_RichEditUI_SetWinStyle';
function Delphi_RichEditUI_GetTextColor; external DuiLibdll name 'Delphi_RichEditUI_GetTextColor';
procedure Delphi_RichEditUI_SetTextColor; external DuiLibdll name 'Delphi_RichEditUI_SetTextColor';
function Delphi_RichEditUI_GetLimitText; external DuiLibdll name 'Delphi_RichEditUI_GetLimitText';
procedure Delphi_RichEditUI_SetLimitText; external DuiLibdll name 'Delphi_RichEditUI_SetLimitText';
function Delphi_RichEditUI_GetTextLength; external DuiLibdll name 'Delphi_RichEditUI_GetTextLength';
function Delphi_RichEditUI_GetText; external DuiLibdll name 'Delphi_RichEditUI_GetText';
procedure Delphi_RichEditUI_SetText; external DuiLibdll name 'Delphi_RichEditUI_SetText';
function Delphi_RichEditUI_GetModify; external DuiLibdll name 'Delphi_RichEditUI_GetModify';
procedure Delphi_RichEditUI_SetModify; external DuiLibdll name 'Delphi_RichEditUI_SetModify';
procedure Delphi_RichEditUI_GetSel_01; external DuiLibdll name 'Delphi_RichEditUI_GetSel_01';
procedure Delphi_RichEditUI_GetSel_02; external DuiLibdll name 'Delphi_RichEditUI_GetSel_02';
function Delphi_RichEditUI_SetSel_01; external DuiLibdll name 'Delphi_RichEditUI_SetSel_01';
function Delphi_RichEditUI_SetSel_02; external DuiLibdll name 'Delphi_RichEditUI_SetSel_02';
procedure Delphi_RichEditUI_ReplaceSel; external DuiLibdll name 'Delphi_RichEditUI_ReplaceSel';
procedure Delphi_RichEditUI_ReplaceSelW; external DuiLibdll name 'Delphi_RichEditUI_ReplaceSelW';
function Delphi_RichEditUI_GetSelText; external DuiLibdll name 'Delphi_RichEditUI_GetSelText';
function Delphi_RichEditUI_SetSelAll; external DuiLibdll name 'Delphi_RichEditUI_SetSelAll';
function Delphi_RichEditUI_SetSelNone; external DuiLibdll name 'Delphi_RichEditUI_SetSelNone';
function Delphi_RichEditUI_GetSelectionType; external DuiLibdll name 'Delphi_RichEditUI_GetSelectionType';
function Delphi_RichEditUI_GetZoom; external DuiLibdll name 'Delphi_RichEditUI_GetZoom';
function Delphi_RichEditUI_SetZoom; external DuiLibdll name 'Delphi_RichEditUI_SetZoom';
function Delphi_RichEditUI_SetZoomOff; external DuiLibdll name 'Delphi_RichEditUI_SetZoomOff';
function Delphi_RichEditUI_GetAutoURLDetect; external DuiLibdll name 'Delphi_RichEditUI_GetAutoURLDetect';
function Delphi_RichEditUI_SetAutoURLDetect; external DuiLibdll name 'Delphi_RichEditUI_SetAutoURLDetect';
function Delphi_RichEditUI_GetEventMask; external DuiLibdll name 'Delphi_RichEditUI_GetEventMask';
function Delphi_RichEditUI_SetEventMask; external DuiLibdll name 'Delphi_RichEditUI_SetEventMask';
function Delphi_RichEditUI_GetTextRange; external DuiLibdll name 'Delphi_RichEditUI_GetTextRange';
procedure Delphi_RichEditUI_HideSelection; external DuiLibdll name 'Delphi_RichEditUI_HideSelection';
procedure Delphi_RichEditUI_ScrollCaret; external DuiLibdll name 'Delphi_RichEditUI_ScrollCaret';
function Delphi_RichEditUI_InsertText; external DuiLibdll name 'Delphi_RichEditUI_InsertText';
function Delphi_RichEditUI_AppendText; external DuiLibdll name 'Delphi_RichEditUI_AppendText';
function Delphi_RichEditUI_GetDefaultCharFormat; external DuiLibdll name 'Delphi_RichEditUI_GetDefaultCharFormat';
function Delphi_RichEditUI_SetDefaultCharFormat; external DuiLibdll name 'Delphi_RichEditUI_SetDefaultCharFormat';
function Delphi_RichEditUI_GetSelectionCharFormat; external DuiLibdll name 'Delphi_RichEditUI_GetSelectionCharFormat';
function Delphi_RichEditUI_SetSelectionCharFormat; external DuiLibdll name 'Delphi_RichEditUI_SetSelectionCharFormat';
function Delphi_RichEditUI_SetWordCharFormat; external DuiLibdll name 'Delphi_RichEditUI_SetWordCharFormat';
function Delphi_RichEditUI_GetParaFormat; external DuiLibdll name 'Delphi_RichEditUI_GetParaFormat';
function Delphi_RichEditUI_SetParaFormat; external DuiLibdll name 'Delphi_RichEditUI_SetParaFormat';
function Delphi_RichEditUI_Redo; external DuiLibdll name 'Delphi_RichEditUI_Redo';
function Delphi_RichEditUI_Undo; external DuiLibdll name 'Delphi_RichEditUI_Undo';
procedure Delphi_RichEditUI_Clear; external DuiLibdll name 'Delphi_RichEditUI_Clear';
procedure Delphi_RichEditUI_Copy; external DuiLibdll name 'Delphi_RichEditUI_Copy';
procedure Delphi_RichEditUI_Cut; external DuiLibdll name 'Delphi_RichEditUI_Cut';
procedure Delphi_RichEditUI_Paste; external DuiLibdll name 'Delphi_RichEditUI_Paste';
function Delphi_RichEditUI_GetLineCount; external DuiLibdll name 'Delphi_RichEditUI_GetLineCount';
function Delphi_RichEditUI_GetLine; external DuiLibdll name 'Delphi_RichEditUI_GetLine';
function Delphi_RichEditUI_LineIndex; external DuiLibdll name 'Delphi_RichEditUI_LineIndex';
function Delphi_RichEditUI_LineLength; external DuiLibdll name 'Delphi_RichEditUI_LineLength';
function Delphi_RichEditUI_LineScroll; external DuiLibdll name 'Delphi_RichEditUI_LineScroll';
function Delphi_RichEditUI_GetCharPos; external DuiLibdll name 'Delphi_RichEditUI_GetCharPos';
function Delphi_RichEditUI_LineFromChar; external DuiLibdll name 'Delphi_RichEditUI_LineFromChar';
function Delphi_RichEditUI_PosFromChar; external DuiLibdll name 'Delphi_RichEditUI_PosFromChar';
function Delphi_RichEditUI_CharFromPos; external DuiLibdll name 'Delphi_RichEditUI_CharFromPos';
procedure Delphi_RichEditUI_EmptyUndoBuffer; external DuiLibdll name 'Delphi_RichEditUI_EmptyUndoBuffer';
function Delphi_RichEditUI_SetUndoLimit; external DuiLibdll name 'Delphi_RichEditUI_SetUndoLimit';
function Delphi_RichEditUI_StreamIn; external DuiLibdll name 'Delphi_RichEditUI_StreamIn';
function Delphi_RichEditUI_StreamOut; external DuiLibdll name 'Delphi_RichEditUI_StreamOut';
procedure Delphi_RichEditUI_DoInit; external DuiLibdll name 'Delphi_RichEditUI_DoInit';
function Delphi_RichEditUI_SetDropAcceptFile; external DuiLibdll name 'Delphi_RichEditUI_SetDropAcceptFile';
function Delphi_RichEditUI_TxSendMessage; external DuiLibdll name 'Delphi_RichEditUI_TxSendMessage';
function Delphi_RichEditUI_GetTxDropTarget; external DuiLibdll name 'Delphi_RichEditUI_GetTxDropTarget';
function Delphi_RichEditUI_OnTxViewChanged; external DuiLibdll name 'Delphi_RichEditUI_OnTxViewChanged';
procedure Delphi_RichEditUI_OnTxNotify; external DuiLibdll name 'Delphi_RichEditUI_OnTxNotify';
procedure Delphi_RichEditUI_SetScrollPos; external DuiLibdll name 'Delphi_RichEditUI_SetScrollPos';
procedure Delphi_RichEditUI_LineUp; external DuiLibdll name 'Delphi_RichEditUI_LineUp';
procedure Delphi_RichEditUI_LineDown; external DuiLibdll name 'Delphi_RichEditUI_LineDown';
procedure Delphi_RichEditUI_PageUp; external DuiLibdll name 'Delphi_RichEditUI_PageUp';
procedure Delphi_RichEditUI_PageDown; external DuiLibdll name 'Delphi_RichEditUI_PageDown';
procedure Delphi_RichEditUI_HomeUp; external DuiLibdll name 'Delphi_RichEditUI_HomeUp';
procedure Delphi_RichEditUI_EndDown; external DuiLibdll name 'Delphi_RichEditUI_EndDown';
procedure Delphi_RichEditUI_LineLeft; external DuiLibdll name 'Delphi_RichEditUI_LineLeft';
procedure Delphi_RichEditUI_LineRight; external DuiLibdll name 'Delphi_RichEditUI_LineRight';
procedure Delphi_RichEditUI_PageLeft; external DuiLibdll name 'Delphi_RichEditUI_PageLeft';
procedure Delphi_RichEditUI_PageRight; external DuiLibdll name 'Delphi_RichEditUI_PageRight';
procedure Delphi_RichEditUI_HomeLeft; external DuiLibdll name 'Delphi_RichEditUI_HomeLeft';
procedure Delphi_RichEditUI_EndRight; external DuiLibdll name 'Delphi_RichEditUI_EndRight';
procedure Delphi_RichEditUI_EstimateSize; external DuiLibdll name 'Delphi_RichEditUI_EstimateSize';
procedure Delphi_RichEditUI_SetPos; external DuiLibdll name 'Delphi_RichEditUI_SetPos';
procedure Delphi_RichEditUI_Move; external DuiLibdll name 'Delphi_RichEditUI_Move';
procedure Delphi_RichEditUI_DoEvent; external DuiLibdll name 'Delphi_RichEditUI_DoEvent';
procedure Delphi_RichEditUI_DoPaint; external DuiLibdll name 'Delphi_RichEditUI_DoPaint';
procedure Delphi_RichEditUI_SetAttribute; external DuiLibdll name 'Delphi_RichEditUI_SetAttribute';



end.
