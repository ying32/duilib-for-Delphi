program ListDemo;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
{$IFNDEF UseLowVer}
  Generics.Collections,
{$ENDIF}
  Duilib,
  DuiConst,
  DuiWindowImplBase,
  DuiListUI;

type
  {$IFDEF UseLowVer}
  NaviveInt  = Integer;
  NativeUInt = Cardinal;
  {$ENDIF}
  
  PListItem = ^TListItem;
  TListItem = record
    Col1: string;
    Col2: string;
    Col3: string;
  end;

  TListMainForm = class(TDuiWindowImplBase)
  private
    FSearch: CButtonUI;
    FList: TList{$IFNDEF UseLowVer}<TListItem>{$ENDIF};
    procedure OnSearch;
    function DoGetItemText(pControl: CControlUI; iIndex, iSubItem: Integer): string; override;
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // 一个简单的菜单，可看duilib的listDemo里面有一个菜单
  TDuiPopupMenu = class(TDuiWindowImplBase)
  private
    FListUI: CListUI;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    procedure DoFinalMessage(hWd: HWND); override;
    procedure DoInitWindow; override;
  public
    constructor Create(AListUI: CListUI);
  end;


{ TListMainForm }

constructor TListMainForm.Create;
begin
  // 后面两参数置空了，交由入口函数设置值
  inherited Create('skin.xml', '', '');
  CreateWindow(0, 'ListDemo', UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE or WS_EX_APPWINDOW , 0, 0, 600, 320);
  FList := TList{$IFNDEF UseLowVer}<TListItem>{$ENDIF}.Create;
end;

destructor TListMainForm.Destroy;
{$IFDEF UseLowVer}
var
  I: Integer;
{$ENDIF}
begin
{$IFDEF UseLowVer}
  for I := 0 to FList.Count - 1 do
    Dispose(FList[I]);
{$ENDIF}
  FList.Free;
  inherited;
end;

function TListMainForm.DoGetItemText(pControl: CControlUI; iIndex,
  iSubItem: Integer): string;
var
  Litem: TListItem;
begin
  if (pControl.Tag <> NativeUInt(-1)) and (pControl.Tag < FList.Count) then
  begin
    Litem := {$IFNDEF UseLowVer}FList[pControl.Tag]{$ELSE}PListItem(FList[pControl.Tag])^{$ENDIF};
    case iSubItem of
      0 : Result := Litem.Col1;
      1 : Result := Litem.Col2;
      2 : Result := Litem.Col3;
    end;
  end else Result := '';
end;

procedure TListMainForm.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;

end;

procedure TListMainForm.DoInitWindow;
begin
  inherited;
  FSearch := CButtonUI(FindControl('btn'));
end;

procedure TListMainForm.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
  iIndex: Integer;
  pList: CListUI;
begin
  inherited;
{$IFNDEF UseLowVer}
  LType := Msg.sType;
{$ELSE}
  LType := DuiStringToString(Msg.sType);
{$ENDIF}
  LCtlName := Msg.pSender.Name;

  if LType = DUI_MSGTYPE_CLICK then
  begin
    if LCtlName = 'closebtn' then
      DuiApplication.Terminate
    else if LCtlName = 'minbtn' then
      Minimize
    else if LCtlName = 'btn' then
      OnSearch;
  end else
  if LType = DUI_MSGTYPE_ITEMACTIVATE then
  begin
    iIndex := Msg.pSender.Tag;
    if (iIndex <> -1) and (iIndex < FList.Count) then
    begin
    {$IFNDEF UseLowVer}
      MessageBox(0, PChar(Format('Col1=%s, Col2=%s, Col3=%s',
        [ FList[iIndex].Col1, FList[iIndex].Col2, FList[iIndex].Col3])), nil, MB_OK);
    {$ELSE}
      MessageBox(0, PChar(Format('Col1=%s, Col2=%s, Col3=%s',
        [ PListItem(FList[iIndex])^.Col1, PListItem(FList[iIndex])^.Col2, PListItem(FList[iIndex])^.Col3])), nil, MB_OK);
    {$ENDIF}
    end;
  end else
  if LType = DUI_MSGTYPE_MENU then
  begin
//    MessageBox(0, nil, nil, 0);
    if LCtlName = 'domainlist' then
    begin
      TDuiPopupMenu.Create(CListUI(msg.pSender));
    end;
  end else
  if LType = 'menu_Delete' then
  begin
    pList := CListUI(Msg.pSender);
    if pList <> nil then
    begin
       iIndex := pList.GetCurSel;
       if (iIndex <> -1) and (iIndex < FList.Count) then
         pList.RemoveAt(iIndex);
    end;
  end;
end;

procedure TListMainForm.OnSearch;
var
  pList: CListUI;
  pEdit: CEditUI;
  LInputText: string;
  I: Integer;
  pListElement: CListTextElementUI;
{$IFNDEF UseLowVer}
  LItem: TListItem;
{$ELSE}
  LItem: PListItem;
{$ENDIF}
begin
  pList := CListUI(FindControl('domainlist'));
  pEdit := CEditUI(FindControl('input'));
  if pEdit <> nil then
  begin
    pEdit.Enabled := False;
    LInputText := pEdit.Text;
  end;
  FSearch.Enabled := False;
  if pList <> nil then
  begin
    pList.RemoveAll;
    pList.SetTextCallback(Pointer(this));
    for I := 0 to 10 do
    begin
      {$IFDEF UseLowVer}
         New(LItem);
      {$ENDIF}
      LItem.Col1 := IntToStr(I);
      LItem.Col2 := 'aaaaa' + IntToStr(I);
      LItem.Col3 := 'bbbbb' + IntToStr(I);
      FList.Add(LItem);
      pListElement := CListTextElementUI.CppCreate;
      pListElement.Tag := I;
      pList.Add(pListElement);
    end;
  end;
  FSearch.Enabled := True;
end;


{ TDuiPopupMenu }

constructor TDuiPopupMenu.Create(AListUI: CListUI);
begin
  inherited Create('menu.xml', '', '');
  FListUI := AListUI;
  CreateWindow(AListUI.GetManager.GetPaintWindow, '', WS_POPUP, WS_EX_TOOLWINDOW);
  Show;
end;

procedure TDuiPopupMenu.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

procedure TDuiPopupMenu.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_KILLFOCUS then
  begin
    Msg.Result := 1;
    Close;
  end;
end;

procedure TDuiPopupMenu.DoInitWindow;
var
  P: TPoint;
  LSize: TSize;
  pList: CListUI;
  nSel: Integer;
  pControl: CControlUI;
begin
  inherited;
  pList := CListUI(FListUI);
  if pList <> nil then
  begin
    nSel := pList.GetCurSel;
    if nSel < 0 then
    begin
      pControl := FindControl('menu_Delete');
      if pControl <> nil then
        pControl.Enabled := False;
    end;
  end;
  GetCursorPos(P);
  LSize := InitSize;
  MoveWindow(Handle, P.X, P.Y, LSize.cx, LSize.cy, False);
end;

procedure TDuiPopupMenu.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType{$IFDEF UseLowVer}.m_pstr{$ENDIF} = 'itemselect' then
    Close
  else if Msg.sType{$IFDEF UseLowVer}.m_pstr{$ENDIF} = 'itemclick' then
  begin
    if Assigned(FListUI) and (Msg.pSender.Name = 'menu_Delete') then
      FListUI.GetManager.SendNotify(FListUI, 'menu_Delete', 0, 0, True);
  end;
end;


var
  ListMainForm: TListMainForm;

begin
  try

    DuiApplication.Initialize;
    DuiApplication.SetResourcePath(ExtractFilePath(ParamStr(0)) + 'skin\');
    DuiApplication.SetResourceZip('ListRes.zip');
    ListMainForm := TListMainForm.Create;
    ListMainForm.CenterWindow;
    ListMainForm.Show;
    DuiApplication.Run;
    ListMainForm.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
