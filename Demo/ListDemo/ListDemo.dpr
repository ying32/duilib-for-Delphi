program ListDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Generics.Collections,
  Duilib,
  DuiConst,
  DuiWindowImplBase,
  DuiListUI;

type

  TListItem = record
    Col1: string;
    Col2: string;
    Col3: string;
  end;

  TListMainForm = class(TDuiWindowImplBase)
  private
    FSearch: CButtonUI;
    FList: TList<TListItem>;
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
  inherited Create('skin.xml', 'skin\ListRes');
  CreateWindow(0, 'ListDemo', UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE or WS_EX_APPWINDOW , 0, 0, 600, 320);
  FList := TList<TListItem>.Create;
end;

destructor TListMainForm.Destroy;
begin
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
    Litem := FList[pControl.Tag];
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
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;

  Writeln(Format('Msg.pSender=%p', [Pointer(Msg.pSender)]));
  Writeln(Format('Msg.pSender.OnInit=%p', [Pointer(Msg.pSender.OnInit.Delegates)]));
  Writeln(Format('Msg.pSender.OnDestroy=%p', [Pointer(@Msg.pSender.OnDestroy)]));
  Writeln(Format('Msg.pSender.OnSize=%p', [Pointer(@Msg.pSender.OnSize)]));
  Writeln(Format('Msg.pSender.OnEvent=%p', [Pointer(@Msg.pSender.OnEvent)]));
  Writeln(Format('Msg.pSender.OnNotify=%p', [Pointer(@Msg.pSender.OnNotify)]));
  Writeln(Format('Msg.pSender.OnPaint=%p', [Pointer(@Msg.pSender.OnPaint)]));
  Writeln(Format('Msg.pSender.OnPostPaint=%p', [Pointer(@Msg.pSender.OnPostPaint)]));
  Writeln('');
  if LType.Equals(DUI_MSGTYPE_CLICK) then
  begin
    if LCtlName.Equals('closebtn') then
      DuiApplication.Terminate
    else if LCtlName.Equals('minbtn') then
      Minimize
    else if LCtlName.Equals('btn') then
      OnSearch;
  end else
  if LType.Equals(DUI_MSGTYPE_ITEMACTIVATE) then
  begin
    iIndex := Msg.pSender.Tag;
    if (iIndex <> -1) and (iIndex < FList.Count) then
    begin
      MessageBox(0, PChar(Format('Col1=%s, Col2=%s, Col3=%s',
        [FList[iIndex].Col1, FList[iIndex].Col2, FList[iIndex].Col3])), nil, MB_OK);
    end;
  end else
  if LType.Equals(DUI_MSGTYPE_MENU) then
  begin
//    MessageBox(0, nil, nil, 0);
    if LCtlName.Equals('domainlist') then
    begin
      TDuiPopupMenu.Create(CListUI(msg.pSender));
    end;
  end else
  if LType.Equals('menu_Delete') then
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
  LItem: TListItem;
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
      LItem.Col1 := I.ToString;
      LItem.Col2 := 'aaaaa' + I.ToString;
      LItem.Col3 := 'bbbbb' + I.ToString;
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
  inherited Create('menu.xml', ExtractFilePath(ParamStr(0)) + 'skin\ListRes');
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
  if Msg.sType = 'itemselect' then
    Close
  else if Msg.sType = 'itemclick' then
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
