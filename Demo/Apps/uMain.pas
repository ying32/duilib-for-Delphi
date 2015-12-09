unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Math,
  Winapi.ShellAPI,
  System.Generics.Collections,
  Duilib,
  DuiWindowImplBase,
  DuiListUI,
  DuiRichEdit,
  DuiConst,
  DuilibHelper;

const
  kclosebtn = 'closebtn';
  krestorebtn = 'restorebtn';
  kmaxbtn = 'maxbtn';
  kminbtn = 'minbtn';

  kitemopenappbtn = 'btnopenapp';
  kitemtitle = 'title';
  kIconsList = 'IconsList';

  kedt_Search = 'edt_Search';

  kbtnaddapp = 'btnaddapp';

  /// <summary>
  ///   4行，5列 (LTileLayout.GetWidth div 80 * (LTitleLayout.GetHeight div 80)
  /// </summary>
  PAGE_MAX_CHIND = 20;

  WM_TRAYICON_MESSAGE = WM_USER + $128;

type
  TIconInfo = record
    Text: string;
    IconPath: string;
    AppFileName: string;
  public
    constructor Create(AText, AIconPath: string);
  end;

  TAppsWindow = class(TDuiWindowImplBase)
  private
    FDlgBuilder: CDialogBuilder;
    FInitOK: Boolean;
    FIcons: TList<TIconInfo>;
    FTrayData: TNotifyIconData;
    FIsMouseHover: Boolean;
    FIsNcMouseEnter: Boolean; // 没办法多加个判断
    procedure CreateRadioButton(const AName: string);
    procedure ShowPage(AIndex: Integer);
    procedure AddIcon(AIcon: TIconInfo);
    procedure InitRadios;
    function CreateAddItemButton: CVerticalLayoutUI;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DoInitWindow; override;
  public
    procedure ShowBalloonTips(ATitle, AInfo: string; ATimeout: Integer = 1000);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TRichEditMenu = class(TDuiWindowImplBase)
  private
    FRichEdit: CRichEditUI;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    procedure DoInitWindow; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(ARichEdit: CRichEditUI);
  end;

  TTrayMenu = class(TDuiWindowImplBase)
  private
    FPaintManager: CPaintManagerUI;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    procedure DoInitWindow; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(APaintManager: CPaintManagerUI);
  end;



var
  AppsWindow: TAppsWindow;

implementation

function GetScreenSize: TSize;
begin
  Result.cx := GetSystemMetrics(SM_CXSCREEN);
  Result.cy := GetSystemMetrics(SM_CYSCREEN);
end;

{ TAppsWindow }

procedure TAppsWindow.AddIcon(AIcon: TIconInfo);
begin
  FIcons.Add(AIcon);
end;

constructor TAppsWindow.Create;
var
  I: Integer;
begin
  inherited Create('MainWindow.xml', 'skin\Apps');
  FIsMouseHover := True;

  CreateWindow(0, 'Apps', UI_WNDSTYLE_EX_DIALOG, WS_EX_WINDOWEDGE or WS_EX_ACCEPTFILES);
  FDlgBuilder := CDialogBuilder.CppCreate;
  FIcons := TList<TIconInfo>.Create;
  for I := 0 to 34 do
    AddIcon(TIconInfo.Create('测试' + I.ToString, 'xiaoshuo.png'));
  FTrayData.Wnd := Handle;
  FTrayData.uID := FTrayData.Wnd;
  FTrayData.cbSize := Sizeof(TNotifyIconData);
  FTrayData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP or NIF_INFO;
  FTrayData.ucallbackmessage := WM_TRAYICON_MESSAGE;
  FTrayData.hIcon := LoadIcon(HInstance, 'MAINICON');
  StrPLCopy(FTrayData.szTip, '测试托盘显示', Length(FTrayData.szTip) - 1);
  Shell_NotifyIcon(NIM_ADD, @FTrayData);

end;

function TAppsWindow.CreateAddItemButton: CVerticalLayoutUI;
var
  LButton: CButtonUI;
  LDlgBuilder: CDialogBuilder;
begin
  LDlgBuilder := CDialogBuilder.CppCreate;
  try
    if not LDlgBuilder.GetMarkup.IsValid then
      Result := CVerticalLayoutUI(LDlgBuilder.Create('buttonitemadd.xml', '', nil, PaintManagerUI))
    else Result := CVerticalLayoutUI(LDlgBuilder.Create(nil, PaintManagerUI));
    if Result <> nil then
      LButton := CButtonUI(PaintManagerUI.FindSubControlByName(Result, kbtnaddapp));
  finally
    LDlgBuilder.CppDestroy;
  end;
end;

procedure TAppsWindow.CreateRadioButton(const AName: string);
var
  LRadio: COptionUI;
  LVer: CHorizontalLayoutUI;
  I: Integer;
  LWidth, LLeft: Integer;
begin
  LVer := CHorizontalLayoutUI(FindControl('TabStyleDock'));
  if LVer <> nil then
  begin
    if PaintManagerUI.FindSubControlByName(LVer, AName) = nil then
    begin
      LRadio := COptionUI.CppCreate;
      LRadio.Tag := LVer.GetCount;
      LVer.Add(LRadio);
      if LVer.GetCount = 1 then
        LRadio.Selected := True;
      LRadio.Name := AName;
      LRadio.SetFixedWidth(18);
      LRadio.SetFixedHeight(18);
      LRadio.NormalImage := 'file=''indicator2.png'' source=''0,0,18,18''';
      LRadio.HotImage := 'file=''indicator2.png'' source=''0,18,18,36''';
      LRadio.PushedImage := 'file=''indicator2.png'' source=''0,54,18,72''';
      LRadio.SelectedImage := 'file=''indicator2.png'' source=''0,54,18,72''';
      LRadio.Group := 'TabDotStyleGroup';
      LRadio.SetFloat(True);
      // 总宽度，包括偏移位置
      LWidth := LVer.GetCount * 18 + (LVer.GetCount - 1) * 12;
      LLeft := LVer.GetWidth div 2 - LWidth div 2;
      // 30 = Radio.Width + 12 Offset
      for I := 0 to LVer.GetCount - 1 do
        LVer.GetItemAt(I).SetFixedXY(TSize.Create(LLeft + I * 30, 0))
    end;
  end;
end;

destructor TAppsWindow.Destroy;
var
  LTileLayout: CTileLayoutUI;
begin
  LTileLayout := CTileLayoutUI(FindControl(kIconsList));
  if LTileLayout <> nil then
    LTileLayout.RemoveAll;
  FDlgBuilder.CppDestroy;
  FIcons.Free;
  Shell_NotifyIcon(NIM_DELETE, @FTrayData);
  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
var
  R: TRect;
begin
  case Msg.Msg of
    WM_DROPFILES:
     begin
       //TDropStruct
       // 文件拖放
     end;

    WM_TRAYICON_MESSAGE:
     begin
       case Msg.LParam of
         WM_LBUTTONDOWN: ;
         WM_RBUTTONDOWN: TTrayMenu.Create(PaintManagerUI);
         WM_LBUTTONDBLCLK:;
       end;
     end;

    WM_EXITSIZEMOVE:
      begin
        GetWindowRect(Handle, R);
        if R.Top < 0 then
          SetWindowPos(Handle, HWND_NOTOPMOST, R.Left, 0, 0, 0,  SWP_NOREDRAW or SWP_NOSIZE)
        else if R.Right > GetScreenSize.cx then
          SetWindowPos(Handle, HWND_NOTOPMOST, GetScreenSize.cx - R.Width, R.Top, 0, 0,  SWP_NOREDRAW or SWP_NOSIZE)
        else if R.Left < 0 then
          SetWindowPos(Handle, HWND_NOTOPMOST, 0, R.Top, 0, 0,  SWP_NOREDRAW or SWP_NOSIZE);
      end;

    WM_NCMOUSELEAVE: FIsNcMouseEnter := False;
    WM_MOUSEHOVER, WM_NCMOUSEMOVE :
     begin
       // 消息收到有点慢啊，奇怪了
       if Msg.Msg = WM_NCMOUSEMOVE then
         FIsNcMouseEnter := True;
       if not FIsMouseHover then
       begin
         FIsMouseHover := True;
         Perform(WM_EXITSIZEMOVE);
       end;
     end;

    WM_MOUSELEAVE :
     begin
       if FIsMouseHover and not FIsNcMouseEnter then
       begin
         GetWindowRect(Handle, R);
         if R.Top = 0 then
           SetWindowPos(Handle, HWND_TOPMOST, R.Left, -(R.Height - 5), 0, 0, SWP_NOREDRAW or SWP_NOSIZE)
         else if R.Right = GetScreenSize.cx then
           SetWindowPos(Handle, HWND_NOTOPMOST, GetScreenSize.cx - 5, R.Top, 0, 0, SWP_NOREDRAW or SWP_NOSIZE)
         else if R.Left = 0 then
          SetWindowPos(Handle, HWND_NOTOPMOST, -(R.Width - 5), R.Top, 0, 0,  SWP_NOREDRAW or SWP_NOSIZE);
         FIsMouseHover := False;
       end;
       if FIsNcMouseEnter then
         FIsNcMouseEnter := False;
     end;
  end;
  inherited;
end;

procedure TAppsWindow.DoInitWindow;
begin
  inherited;
end;


procedure TAppsWindow.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
  LEdit: CRichEditUI;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_EVENT_WINDOWINIT) then
  begin
    FInitOK := True;
    ShowPage(0);
    InitRadios;
  end else
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    if LCtlName.Equals(kclosebtn) then
      DuiApplication.Terminate
    else if LCtlName.Equals(kminbtn) then
      Minimize
    else if LCtlName.Contains('TabDotButton_') then
    begin
      if not COptionUI(Msg.pSender).IsSelected then
        ShowPage(Msg.pSender.Tag);
    end else
    if LCtlName.Equals('openmycomputer') then
    begin
      MessageBox(0, 'computer', nil, 0);
    end else
    if LCtlName.Equals('openbrowser') then
    begin
      MessageBox(0, 'browser', nil, 0);
    end else
    if LCtlName.Equals('openyule') then
    begin
      MessageBox(0, 'yule', nil, 0);
    end else
    if LCtlName.Equals('openappmarket') then
    begin
      MessageBox(0, 'appmarket', nil, 0);
    end else
    if LCtlName.Equals('btn_Search') then
    begin
      LEdit := CRichEditUI(FindControl(kedt_Search));
      if LEdit <> nil then
      begin
        MessageBox(0, PChar(LEdit.Text), nil, 0);
      end;
    end else
    if LCtlName.Equals('btnopenapp') then
    begin
      if Msg.pSender.Tag > 0 then
      begin

      end;
    end else
    if LCtlName.Equals(kbtnaddapp) then
    begin
       MessageBox(0, '添加app', nil, 0);
    end;
  end else
  if LType.Equals(DUI_EVENT_KILLFOCUS) then
  begin
    if LCtlName.Equals('edt_Search') then
    begin
      LEdit := CRichEditUI(Msg.pSender);
      if LEdit <> nil then
      begin
        if LEdit.Text = '' then
        begin
          LEdit.Text := '搜索应用';
          LEdit.TextColor := $FF94AAB5;
        end;
      end;
    end;
  end else
  if LType.Equals(DUI_EVENT_SETFOCUS) then
  begin
    if LCtlName.Equals(kedt_Search) then
    begin
      LEdit := CRichEditUI(Msg.pSender);
      if LEdit <> nil then
      begin
        if LEdit.Text = '搜索应用' then
        begin
          LEdit.Text := '';
          LEdit.TextColor := $FFFFFFFF;
        end;
      end;
    end;
  end else
  if LType.Equals(DUI_EVENT_DROPDOWN) then
  begin
    MessageBox(0, 'dropdown', 'drop', 0);
  end else
  if LType.Equals(DUI_EVENT_MENU) then
  begin
    if LCtlName.Equals(kedt_Search) then
      TRichEditMenu.Create(CRichEditUI(Msg.pSender));
  end else
  if LType.Equals('RichMenuItemClick') then
  begin
    LEdit := CRichEditUI(FindControl(kedt_Search));
    if LEdit <> nil then
    begin
      if LCtlName.Equals('menu_copy') then
        LEdit.Copy
      else if LCtlName.Equals('menu_cut') then
        LEdit.Cut
      else if LCtlName.Equals('menu_paste') then
        LEdit.Paste
      else if LCtlName.Equals('menu_selall') then
        LEdit.SetSelAll;
    end;
  end else
  if LType.Equals('TrayMenuItemClick') then
  begin
    if LCtlName.Equals('menu_exit') then
      DuiApplication.Terminate;
  end;
end;


procedure TAppsWindow.InitRadios;
var
  I: Integer;
begin
  // 创建对应的TabDot样式按钮
  for I := 0 to System.Math.Ceil(FIcons.Count / PAGE_MAX_CHIND) - 1 do
     CreateRadioButton(Format('TabDotButton_%d', [I]));
end;

procedure TAppsWindow.ShowBalloonTips(ATitle, AInfo: string; ATimeout: Integer);
begin
  FTrayData.uTimeout := ATimeout;
  FTrayData.dwInfoFlags := NIIF_INFO;
  StrPLCopy(FTrayData.szInfoTitle, ATitle, Length(FTrayData.szInfoTitle) - 1);
  StrPLCopy(FTrayData.szInfo, AInfo, Length(FTrayData.szInfo) - 1);
  Shell_NotifyIcon(NIM_MODIFY, @FTrayData);
end;

procedure TAppsWindow.ShowPage(AIndex: Integer);
var
  LTileLayout: CTileLayoutUI;
  I: Integer;
  LVerticalLayout: CVerticalLayoutUI;
  LTitle: CLabelUI;
  LItem: TIconInfo;
  LButton: CButtonUI;
begin
  LTileLayout := CTileLayoutUI(FindControl(kIconsList));
  if LTileLayout <> nil then
  begin
    // 清除之前的控件
    LTileLayout.RemoveAll;
    if LTileLayout.GetColumns <> 4 then
      LTileLayout.SetColumns(4);
    // 减2个，最后个作为添加的按钮
    for I := (AIndex * PAGE_MAX_CHIND) to  Min((AIndex + 1) * PAGE_MAX_CHIND, FIcons.Count) - 2 do
    begin
      LItem := FIcons[I];
      if not FDlgBuilder.GetMarkup.IsValid then
        LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create('buttonitem.xml', '', nil, PaintManagerUI))
      else
        LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create(nil, PaintManagerUI));
      if LVerticalLayout = nil then Continue;
      LVerticalLayout.Tag := I;
      LButton := CButtonUI(PaintManagerUI.FindSubControlByName(LVerticalLayout, kitemopenappbtn));
      if LButton <> nil then
      begin
        LButton.Tag := I;
        LButton.NormalImage := LItem.IconPath;
        LButton.BkImage :=  LItem.IconPath;
      end;
      LTitle := CLabelUI(PaintManagerUI.FindSubControlByName(LVerticalLayout, kitemtitle));
      if LTitle <> nil then
        LTitle.Text := LItem.Text;
      LTileLayout.Add(LVerticalLayout);
    end;
    LVerticalLayout := CreateAddItemButton;
    if LVerticalLayout <> nil then
      LTileLayout.Add(LVerticalLayout);
  end;
end;

{ TIconInfo }

constructor TIconInfo.Create(AText, AIconPath: string);
begin
  Self.Text := AText;
  Self.IconPath := AIconPath;
  Self.AppFileName := '';
end;

{ TRichEditMenu }

constructor TRichEditMenu.Create(ARichEdit: CRichEditUI);
begin
  inherited Create('richeditmenu.xml', ExtractFilePath(ParamStr(0)) + 'skin\Apps');
  FRichEdit := ARichEdit;
  CreateWindow(0, '', WS_POPUP, WS_EX_TOOLWINDOW);
  Show;
end;

procedure TRichEditMenu.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

procedure TRichEditMenu.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_KILLFOCUS then
  begin
    Msg.Result := 1;
    Close;
  end;
end;

procedure TRichEditMenu.DoInitWindow;
var
  LSize, LScreenSize: TSize;
  LP: TPoint;
begin
  inherited;
  LSize := InitSize;
  GetCursorPos(LP);
  LScreenSize := GetScreenSize;
  if LP.X + LSize.cx >= LScreenSize.cx then
    LP.X := LP.X - LSize.cx;
  if LP.Y + LSize.cy >= LScreenSize.cy then
    LP.Y := LP.Y - LSize.cy;
  MoveWindow(Handle, LP.X, LP.Y, LSize.cx, LSize.cy, False);
end;

procedure TRichEditMenu.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType = DUI_EVENT_ITEMSELECT then
    Close
  else if Msg.sType = DUI_EVENT_ITEMCLICK then
    FRichEdit.GetManager.SendNotify(Msg.pSender, 'RichMenuItemClick');
end;

{ TTrayMenu }

constructor TTrayMenu.Create(APaintManager: CPaintManagerUI);
begin
  inherited Create('traymenu.xml', ExtractFilePath(ParamStr(0)) + 'skin\Apps');
  FPaintManager := APaintManager;
  CreateWindow(0, '', WS_POPUP, WS_EX_TOOLWINDOW or WS_EX_TOPMOST);
  Show;
end;

procedure TTrayMenu.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

procedure TTrayMenu.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_KILLFOCUS then
  begin
    Msg.Result := 1;
    Close;
  end;
end;

procedure TTrayMenu.DoInitWindow;
var
  LSize, LScreenSize: TSize;
  LP: TPoint;
begin
  inherited;
  LSize := InitSize;
  GetCursorPos(LP);
  LScreenSize := GetScreenSize;
  if LP.X + LSize.cx >= LScreenSize.cx then
    LP.X := LP.X - LSize.cx;
  if LP.Y + LSize.cy >= LScreenSize.cy then
    LP.Y := LP.Y - LSize.cy;
  MoveWindow(Handle, LP.X, LP.Y, LSize.cx, LSize.cy, False);
end;

procedure TTrayMenu.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType = DUI_EVENT_ITEMSELECT then
    Close
  else if Msg.sType = DUI_EVENT_ITEMCLICK then
    FPaintManager.SendNotify(Msg.pSender, 'TrayMenuItemClick');
end;



end.
