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

  kSearchedt = 'edt_Search';

  kbtnaddapp = 'btnaddapp';
  kbtnSearch = 'btn_Search';
  kbtnopenapp = 'btnopenapp';

  kSearchEditTextHint = '搜索应用';

  kRichMenuItemClick = 'RichMenuItemClick';
  kTrayMenuItemClick = 'TrayMenuItemClick';


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

  TNotifyEvent = procedure(var Msg: TNotifyUI) of object;

  TAppsWindow = class(TDuiWindowImplBase)
  private
    FDlgBuilder: CDialogBuilder;
    FEvents: TDictionary<string, TNotifyEvent>;
    FIcons: TList<TIconInfo>;
    FTrayData: TNotifyIconData;
    FIsMouseHover: Boolean;
    FIsNcMouseEnter: Boolean; // 没办法多加个判断
    FMouseTracking: Boolean;
    FSelectedRadioIndex: Integer;
    procedure ReInitRadios;
    procedure CreateRadioButton(const AName: string);
    procedure ShowPage(AIndex: Integer);
    procedure AddItemToLastPage;
    procedure AddIcon(AIcon: TIconInfo);
    procedure InitRadios;
    function CreateAddItemButton: CVerticalLayoutUI;
    procedure SelectRadioItem(AIndex: Integer);
    function GetRadionSelectedIndex(ATabDock: CHorizontalLayoutUI): Integer;
    procedure InitEvents;
    procedure ProcesNotifyEvent(var Msg: TNotifyUI);


    procedure openmycomputer(var Msg: TNotifyUI);
    procedure openbrowser(var Msg: TNotifyUI);
    procedure openyule(var Msg: TNotifyUI);
    procedure openappmarket(var Msg: TNotifyUI);
    procedure btnSearchClick(var Msg: TNotifyUI);
    procedure closebtnClick(var Msg: TNotifyUI);
    procedure minbtnClick(var Msg: TNotifyUI);
    procedure btnopenappClick(var Msg: TNotifyUI);
    procedure btnaddappClick(var Msg: TNotifyUI);

//    procedure menuCopyClick(var Msg: TNotifyUI);
//    procedure menuCutClick(var Msg: TNotifyUI);
//    procedure menuPasteClick(var Msg: TNotifyUI);
//    procedure menuSelAllClick(var Msg: TNotifyUI);
//    procedure menuExitAppClick(var Msg: TNotifyUI);
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

constructor TAppsWindow.Create;
var
  I: Integer;
begin
  inherited Create('MainWindow.xml', 'skin\Apps');
  FIsMouseHover := True;
  FEvents := TDictionary<string, TNotifyEvent>.Create;
  InitEvents;
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

destructor TAppsWindow.Destroy;
begin
  FDlgBuilder.CppDestroy;
  FIcons.Free;
  Shell_NotifyIcon(NIM_DELETE, @FTrayData);
  inherited;
end;

procedure TAppsWindow.AddIcon(AIcon: TIconInfo);
begin
  FIcons.Add(AIcon);
end;

procedure TAppsWindow.AddItemToLastPage;
var
  LTileLayout: CTileLayoutUI;
  LVerticalLayout: CVerticalLayoutUI;
  LTitle: CLabelUI;
  LItem: TIconInfo;
  LButton: CButtonUI;
  LLastIndex: Integer;
begin
  LTileLayout := CTileLayoutUI(FindControl(kIconsList));
  if LTileLayout <> nil then
  begin
    // 每页最大数
    if LTileLayout.GetCount >= PAGE_MAX_CHIND then Exit;
    LLastIndex := FIcons.Count - 1;
    LItem := FIcons[LLastIndex];
    if not FDlgBuilder.GetMarkup.IsValid then
      LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create('buttonitem.xml', '', nil, PaintManagerUI))
    else
      LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create(nil, PaintManagerUI));
    if LVerticalLayout = nil then Exit;
    LVerticalLayout.Tag := LLastIndex;
    LButton := CButtonUI(PaintManagerUI.FindSubControlByName(LVerticalLayout, kitemopenappbtn));
    if LButton <> nil then
    begin
      LButton.Tag := LLastIndex;
      LButton.NormalImage := LItem.IconPath;
      LButton.BkImage :=  LItem.IconPath;
    end;
    LTitle := CLabelUI(PaintManagerUI.FindSubControlByName(LVerticalLayout, kitemtitle));
    if LTitle <> nil then
      LTitle.Text := LItem.Text;
    LTileLayout.AddAt(LVerticalLayout, LTileLayout.GetCount - 1);
    // 当前页已经满了，移除掉添加按钮
    if LTileLayout.GetCount > PAGE_MAX_CHIND then
      LTileLayout.RemoveAt(LTileLayout.GetCount - 1);
  end;
end;

procedure TAppsWindow.btnaddappClick(var Msg: TNotifyUI);
begin
  AddIcon(TIconInfo.Create('测试' + (FIcons.Count - 1).ToString, 'xiaoshuo.png'));
  ReInitRadios;
  AddItemToLastPage;
end;

procedure TAppsWindow.btnopenappClick(var Msg: TNotifyUI);
begin

end;

procedure TAppsWindow.btnSearchClick(var Msg: TNotifyUI);
var
  LEdit: CRichEditUI;
begin
  LEdit := CRichEditUI(FindControl(kSearchedt));
  if LEdit <> nil then
  begin
    if LEdit.Text.Equals(kSearchEditTextHint) or LEdit.Text.IsEmpty then
      MessageBox(0, '请输入搜索的文字', '', 0)
    else
      MessageBox(0, PChar(LEdit.Text), nil, 0);
  end;
end;

procedure TAppsWindow.closebtnClick(var Msg: TNotifyUI);
begin
  DuiApplication.Terminate;
end;

function TAppsWindow.CreateAddItemButton: CVerticalLayoutUI;
var
  LDlgBuilder: CDialogBuilder;
begin
  LDlgBuilder := CDialogBuilder.CppCreate;
  try
    Result := CVerticalLayoutUI(LDlgBuilder.Create('buttonitemadd.xml', '', nil, PaintManagerUI));
  finally
    LDlgBuilder.CppDestroy;
  end;
end;

procedure TAppsWindow.CreateRadioButton(const AName: string);
var
  LRadio: COptionUI;
  LTabStyleDock: CHorizontalLayoutUI;
  I: Integer;
  LWidth, LLeft: Integer;
begin
  LTabStyleDock := CHorizontalLayoutUI(FindControl('TabStyleDock'));
  if LTabStyleDock <> nil then
  begin
    if PaintManagerUI.FindSubControlByName(LTabStyleDock, AName) = nil then
    begin
      LRadio := COptionUI.CppCreate;
      LRadio.Tag := LTabStyleDock.GetCount;
      LTabStyleDock.Add(LRadio);
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
      LWidth := LTabStyleDock.GetCount * 18 + (LTabStyleDock.GetCount - 1) * 12;
      LLeft := LTabStyleDock.GetWidth div 2 - LWidth div 2;
      // 30 = Radio.Width + 12 Offset
      for I := 0 to LTabStyleDock.GetCount - 1 do
        LTabStyleDock.GetItemAt(I).SetFixedXY(TSize.Create(LLeft + I * 30, 0))
    end;
  end;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
var
  R: TRect;
//  LTrackMouse: TTrackMouseEvent;
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

//    WM_MOUSEMOVE :
//      begin
//        if not FMouseTracking then
//        begin
//          LTrackMouse.cbSize := Sizeof(TTrackMouseEvent);
//          LTrackMouse.hwndTrack := Handle;
//          LTrackMouse.dwFlags := TME_LEAVE or TME_HOVER;
//          LTrackMouse.dwHoverTime := 1;
//          FMouseTracking := TrackMouseEvent(LTrackMouse);
//        end;
//      end;

    WM_NCMOUSELEAVE: FIsNcMouseEnter := False;
    WM_MOUSEHOVER, WM_NCMOUSEMOVE :
     begin

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
       FMouseTracking := False;
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
    ShowPage(0);
    InitRadios;
  end else
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    if LCtlName.Contains('TabDotButton_') then
    begin
      if not COptionUI(Msg.pSender).IsSelected then
      begin
        FSelectedRadioIndex := Msg.pSender.Tag;
        ShowPage(FSelectedRadioIndex);
      end;
    end else ProcesNotifyEvent(Msg);
  end else
  if LType.Equals(DUI_EVENT_KILLFOCUS) then
  begin
    if LCtlName.Equals(kSearchedt) then
    begin
      LEdit := CRichEditUI(Msg.pSender);
      if LEdit <> nil then
      begin
        if LEdit.Text = '' then
        begin
          LEdit.Text := kSearchEditTextHint;
          LEdit.TextColor := $FF94AAB5;
        end;
      end;
    end;
  end else
  if LType.Equals(DUI_EVENT_SETFOCUS) then
  begin
    if LCtlName.Equals(kSearchedt) then
    begin
      LEdit := CRichEditUI(Msg.pSender);
      if LEdit <> nil then
      begin
        if LEdit.Text = kSearchEditTextHint then
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
    if LCtlName.Equals(kSearchedt) then
      TRichEditMenu.Create(CRichEditUI(Msg.pSender));
  end else
  if LType.Equals(kRichMenuItemClick) then
  begin
    LEdit := CRichEditUI(FindControl(kSearchedt));
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
  if LType.Equals(kTrayMenuItemClick) then
  begin
    if LCtlName.Equals('menu_exit') then
      DuiApplication.Terminate;
  end;
end;


function TAppsWindow.GetRadionSelectedIndex(ATabDock: CHorizontalLayoutUI): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ATabDock.GetCount - 1 do
    if COptionUI(ATabDock.GetItemAt(I)).Selected then
    begin
      Result := I;
      Break;
    end;
end;

procedure TAppsWindow.InitEvents;
begin
  FEvents.Add('openmycomputer', openmycomputer);
  FEvents.Add('openbrowser', openbrowser);
  FEvents.Add('openyule', openyule);
  FEvents.Add('openappmarket', openappmarket);
  FEvents.Add(kbtnSearch, btnSearchClick);
  FEvents.Add(kclosebtn, closebtnClick);
  FEvents.Add(kminbtn, minbtnClick);
  FEvents.Add(kbtnopenapp, btnopenappClick);
  FEvents.Add(kbtnaddapp, btnaddappClick);
end;

procedure TAppsWindow.InitRadios;
var
  I: Integer;
begin
  // 创建对应的TabDot样式按钮
  for I := 0 to System.Math.Ceil(FIcons.Count / PAGE_MAX_CHIND) - 1 do
     CreateRadioButton(Format('TabDotButton_%d', [I]));
  SelectRadioItem(FSelectedRadioIndex);
end;

procedure TAppsWindow.minbtnClick(var Msg: TNotifyUI);
begin
  Minimize;
end;

procedure TAppsWindow.openappmarket(var Msg: TNotifyUI);
begin
  MessageBox(0, 'appmarket', nil, 0);
end;

procedure TAppsWindow.openbrowser(var Msg: TNotifyUI);
begin
  MessageBox(0, 'browser', nil, 0);
end;

procedure TAppsWindow.openmycomputer(var Msg: TNotifyUI);
begin
  MessageBox(0, 'computer', nil, 0);
end;

procedure TAppsWindow.openyule(var Msg: TNotifyUI);
begin
  MessageBox(0, 'yule', nil, 0);
end;

procedure TAppsWindow.ProcesNotifyEvent(var Msg: TNotifyUI);
var
  LEvent: TNotifyEvent;
begin
  if FEvents.TryGetValue(Msg.pSender.Name, LEvent) then
    LEvent(Msg);
end;

procedure TAppsWindow.ReInitRadios;
var
  LTabStyleDock: CHorizontalLayoutUI;
begin
  LTabStyleDock := CHorizontalLayoutUI(FindControl('TabStyleDock'));
  if LTabStyleDock <> nil then
  begin
    LTabStyleDock.RemoveAll;
    InitRadios;
  end;
end;

procedure TAppsWindow.SelectRadioItem(AIndex: Integer);
var
  LTabStyleDock: CHorizontalLayoutUI;
begin
  if AIndex <= -1 then Exit;
  LTabStyleDock := CHorizontalLayoutUI(FindControl('TabStyleDock'));
  if LTabStyleDock <> nil then
  begin
    if AIndex > LTabStyleDock.GetCount then Exit;
    COptionUI(LTabStyleDock.GetItemAt(AIndex)).Selected := True;
  end;
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
  I, LCurPageCount, LStartIndex, LEndIndex: Integer;
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

    LStartIndex := AIndex * PAGE_MAX_CHIND;
    LEndIndex := Min((AIndex + 1) * PAGE_MAX_CHIND, FIcons.Count);
    LCurPageCount := LEndIndex - LStartIndex;
    OutputDebugString(PChar(Format('++++++++++++++++++++++++LCurPageCount=%d', [LCurPageCount])));
    for I := LStartIndex to LEndIndex - 1 do
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
    // 这里应该是哪个页少就出现添加按钮，当满了就移除添加按钮
    if LCurPageCount < PAGE_MAX_CHIND then
    begin
      LVerticalLayout := CreateAddItemButton;
      if LVerticalLayout <> nil then
        LTileLayout.Add(LVerticalLayout);
    end;
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
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
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
  end else if Msg.Msg = WM_MOUSEACTIVATE then
    Msg.Result := MA_NOACTIVATE;
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
