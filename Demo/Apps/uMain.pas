unit uMain;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Math,
  Dialogs,
  Graphics,
  pngimage,
  ShellAPI,
  JSON,
  Generics.Collections,
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
  kButtonMenuItemClick = 'ButtonMenuItemClick';

  kResDir = 'skin\Apps';


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

  TAppsJSONObject = class
  private
    FItems: TList<TIconInfo>;
    function GetCount: Integer;
    function GetItemByIndex(Index: Integer): TIconInfo;
    procedure ParseJSON(const AStr: string);
    procedure SetItemByIndex(Index: Integer; const Value: TIconInfo);
  public
    constructor Create;
    destructor Destroy; override;
  public
    function Add(AItem: TIconInfo): Integer;
    procedure Remove(AItem: TIconInfo);
    procedure Delete(AIndex: Integer);
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromStream(const AStream: TStream);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(const AStream: TStream);
  public
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TIconInfo read GetItemByIndex write SetItemByIndex;
  end;

  TAppsWindow = class(TDuiWindowImplBase)
  private
    FDlgBuilder: CDialogBuilder;
    FEvents: TDictionary<string, TNotifyEvent>;
    FApps: TAppsJSONObject;
    FTrayData: TNotifyIconData;
    FIsMouseHover: Boolean;
    FIsNcMouseEnter: Boolean; // 没办法多加个判断
    FMouseTracking: Boolean;
    FSelectedRadioIndex: Integer;
    FTileLayout: CTileLayoutUI;
    FTabStyleDock: CHorizontalLayoutUI;

    FOpenDialog: TOpenDialog;
  
    procedure ReInitRadios;
    procedure CreateRadioButton(const AName: string);
    procedure ShowPage(AIndex: Integer);
    procedure AddItemToLastPage;
    procedure AddIcon(AIcon: TIconInfo);
    procedure InitRadios;
    function GetListMaxPage: Integer;
    function CreateAddItemButton: CVerticalLayoutUI;
    procedure SelectRadioItem(AIndex: Integer);
    function GetRadionSelectedIndex(ATabDock: CHorizontalLayoutUI): Integer;
    procedure InitEvents;
    procedure ProcesNotifyEvent(Sender: TObject);
    procedure AddAppToList(AItem: TIconInfo);

    function ExtractFileIconToPngAndReturnNewPath(const AFileName: string): string;

    procedure openmycomputer(Sender: TObject);
    procedure openbrowser(Sender: TObject);
    procedure openyule(Sender: TObject);
    procedure openappmarket(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure closebtnClick(Sender: TObject);
    procedure minbtnClick(Sender: TObject);
    procedure btnopenappClick(Sender: TObject);
    procedure btnaddappClick(Sender: TObject);
    procedure OpenAppByItemIndex(AIndex: Integer);
    procedure DeleteAppByItemIndex(AIndex: Integer);
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DuiWindowInit; // 这个是DoNotify中收到的 windowinit
    procedure DoInitWindow; override;
  public
    procedure ShowBalloonTips(ATitle, AInfo: string; ATimeout: Integer = 1000);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TRichEditMenu = class(TSimplePopupMenu)
  public
    constructor Create(APaintManger: CPaintManagerUI);
  end;

  TTrayMenu = class(TSimplePopupMenu)
  public
    constructor Create(APaintManger: CPaintManagerUI);
  end;

  TButtonItemMenu = class(TSimplePopupMenu)
  private
    FTitleControl: CControlUI;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
  public
    constructor Create(ATitleControl: CControlUI; APaintManger: CPaintManagerUI);
  end;

  TModifyInfoWindow = class(TDuiWindowImplBase)
  private
    FApps: TAppsJSONObject;
    FTitleControl: CControlUI;
    FEdtTitle: CEditUI;
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create(AParent: HWND; ATitleControl: CControlUI;  AApps: TAppsJSONObject);
  end;



var
  AppsWindow: TAppsWindow;


implementation

{
UINT WINAPI PrivateExtractIcons(
  _In_      LPCTSTR lpszFile,
  _In_      int     nIconIndex,
  _In_      int     cxIcon,
  _In_      int     cyIcon,
  _Out_opt_ HICON   *phicon,
  _Out_opt_ UINT    *piconid,
  _In_      UINT    nIcons,
  _In_      UINT    flags
);
}
function PrivateExtractIcons(lpszFile: LPCTSTR; nIconIndex, cxIcon, cyIcon: Integer;
   var phicon: HICON; var piconid: UINT; nIcons, flags: UINT): UINT; stdcall;
    external user32 name 'PrivateExtractIconsW';


function GetAppPath: string; inline;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function GetResFullDir: string; inline;
begin
  Result := GetAppPath + kResDir;
end;

function GetIconsPath: string; inline;
begin
  Result := GetAppPath + 'Icons\';
end;

function GetAppsConfigFileName: string; inline;
begin
  Result := GetAppPath + 'Apps.json';
end;

function ExtractFileWithoutExt(const AFileName: string): string;
begin
  Result := Copy(ExtractFileName(AFileName), 1, Length(ExtractFileName(AFileName)) - Length(ExtractFileExt(AFileName)));
end;

function GetSaveAbsIconFileName(const AFileName: string): string;
begin
  Result := GetIconsPath + ExtractFileWithoutExt(AFileName) + '.png';
end;

function GetIconRelIconFileName(const AFileName: string): string;
begin
   // 暂定的目录，测试用
   Result := '..\..\Icons\' + ExtractFileWithoutExt(AFileName) + '.png';
end;


{ TAppsWindow }

constructor TAppsWindow.Create;
begin
  inherited Create('MainWindow.xml', kResDir);
  FIsMouseHover := True;
  FEvents := TDictionary<string, TNotifyEvent>.Create;
  InitEvents;
  FDlgBuilder := CDialogBuilder.CppCreate;
  FApps := TAppsJSONObject.Create;

  if FileExists(GetAppsConfigFileName) then
    FApps.LoadFromFile(GetAppsConfigFileName);

  //for I := 0 to 15 do
  //  AddIcon(TIconInfo.Create('测试' + I.ToString, 'xiaoshuo.png'));

  // 初始化一些数据后再创建窗口
  CreateWindow(0, 'Apps', UI_WNDSTYLE_EX_DIALOG, WS_EX_WINDOWEDGE or WS_EX_ACCEPTFILES);

  FTrayData.Wnd := Handle;
  FTrayData.uID := FTrayData.Wnd;
  FTrayData.cbSize := Sizeof(TNotifyIconData);
  FTrayData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP or NIF_INFO;
  FTrayData.ucallbackmessage := WM_TRAYICON_MESSAGE;
  FTrayData.hIcon := LoadIcon(HInstance, 'MAINICON');
  StrPLCopy(FTrayData.szTip, '测试托盘显示', Length(FTrayData.szTip) - 1);
  Shell_NotifyIcon(NIM_ADD, @FTrayData);

  FOpenDialog := TOpenDialog.Create(nil);
  FOpenDialog.Filter := '应用程序(*.exe)|*.exe';

  if not DirectoryExists(GetIconsPath) then
    CreateDir(GetIconsPath);
end;

procedure TAppsWindow.DeleteAppByItemIndex(AIndex: Integer);
var
  LVerticalLayout: CVerticalLayoutUI;
  LItemIndex: Integer;
begin
  if (AIndex >= 0) and (AIndex < FApps.Count) then
  begin
    // 移除相应布局中的
    LItemIndex := (AIndex + 1) mod PAGE_MAX_CHIND - 1;
    if LItemIndex >= 0 then
    begin
      if FTileLayout.Count = 1 then
      begin
        // 最后一个不是添加按钮
        if FTileLayout.LastItem.Name <> 'addappLayout' then
          FTileLayout.RemoveAt(0);
      end else
        FTileLayout.RemoveAt(LItemIndex);
      // 如果少于 PAGE_MAX_CHIND 添加一个“添加“按钮
      if (FTileLayout.Count = 0) or ((FTileLayout.Count > 0) and
         (FTileLayout.LastItem.Name <> 'addappLayout')) then
      begin
        LVerticalLayout := CreateAddItemButton;
        if LVerticalLayout <> nil then
          FTileLayout.Add(LVerticalLayout);
      end;
      // 这里不要做删除所有的，只删除那个按钮
      // 删除应用列表中的
      FApps.Delete(AIndex);
    end;
    // 改变底部按钮
    ReInitRadios;
  end;
end;

destructor TAppsWindow.Destroy;
begin
  FApps.SaveToFile(GetAppsConfigFileName);
  FOpenDialog.Free;
  FDlgBuilder.CppDestroy;
  FApps.Free;
  Shell_NotifyIcon(NIM_DELETE, @FTrayData);
  inherited;
end;

procedure TAppsWindow.AddAppToList(AItem: TIconInfo);
begin
  AddIcon(AItem);
  ReInitRadios;
  AddItemToLastPage;
end;

procedure TAppsWindow.AddIcon(AIcon: TIconInfo);
begin
  FApps.Add(AIcon);
end;

procedure TAppsWindow.AddItemToLastPage;
var
  LVerticalLayout: CVerticalLayoutUI;
  LTitle: CLabelUI;
  LItem: TIconInfo;
  LButton: CButtonUI;
  LLastIndex: Integer;
  LIsLast: Boolean;
begin
  if FTileLayout <> nil then
  begin
    LIsLast := False;
    // 每页最大数
    if FTileLayout.GetCount >= PAGE_MAX_CHIND then
    begin
      // 当前页已经满了，移除掉添加按钮
      if FTileLayout.GetItemAt(FTileLayout.GetCount - 1).Name = 'addappLayout' then
      begin
        FTileLayout.RemoveAt(FTileLayout.GetCount - 1);
        LIsLast := True;
      end else Exit;
    end;
    LLastIndex := FApps.Count - 1;
    LItem := FApps.Items[LLastIndex];
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
    if LIsLast then
    begin
      FTileLayout.Add(LVerticalLayout);
      // 然后整除了，下一页要预算出来
    end else
      FTileLayout.AddAt(LVerticalLayout, FTileLayout.GetCount - 1);
  end;
end;

procedure TAppsWindow.btnaddappClick(Sender: TObject);
var
  LItem: TIconInfo;
begin
  if FOpenDialog.Execute(Handle) then
  begin
    LItem.AppFileName := FOpenDialog.FileName;
    LItem.Text := ExtractFileWithoutExt(LItem.AppFileName);
    LItem.IconPath := ExtractFileIconToPngAndReturnNewPath(LItem.AppFileName);
    AddAppToList(LItem);
  end;
end;

procedure TAppsWindow.btnopenappClick(Sender: TObject);
begin
  OpenAppByItemIndex(CControlUI(Sender).Tag);
end;

procedure TAppsWindow.btnSearchClick(Sender: TObject);
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

procedure TAppsWindow.closebtnClick(Sender: TObject);
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
const
  RadioSize = 18;
  OffsetSize = 6;
var
  LRadio: COptionUI;
  I: Integer;
  LWidth, LLeft: Integer;
begin
  if FTabStyleDock <> nil then
  begin
    if PaintManagerUI.FindSubControlByName(FTabStyleDock, AName) = nil then
    begin
      LRadio := COptionUI.CppCreate;
      LRadio.Tag := FTabStyleDock.GetCount;
      FTabStyleDock.Add(LRadio);
      LRadio.Name := AName;
      LRadio.SetFixedWidth(RadioSize);
      LRadio.SetFixedHeight(RadioSize);
      LRadio.NormalImage := 'file=''indicator2.png'' source=''0,0,18,18''';
      LRadio.HotImage := 'file=''indicator2.png'' source=''0,18,18,36''';
      LRadio.PushedImage := 'file=''indicator2.png'' source=''0,54,18,72''';
      LRadio.SelectedImage := 'file=''indicator2.png'' source=''0,54,18,72''';
      LRadio.Group := 'TabDotStyleGroup';
      LRadio.SetFloat(True);
      // 总宽度，包括偏移位置
      LWidth := FTabStyleDock.GetCount * RadioSize + (FTabStyleDock.GetCount - 1) * OffsetSize;
      LLeft := FTabStyleDock.GetWidth div 2 - LWidth div 2;

      for I := 0 to FTabStyleDock.GetCount - 1 do
        FTabStyleDock.GetItemAt(I).SetFixedXY(TSize.Create(LLeft + I * (RadioSize + OffsetSize), 0))
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
        else if R.Right > ScreenSize.cx then
          SetWindowPos(Handle, HWND_NOTOPMOST, ScreenSize.cx - R.Width, R.Top, 0, 0,  SWP_NOREDRAW or SWP_NOSIZE)
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
         else if R.Right = ScreenSize.cx then
           SetWindowPos(Handle, HWND_NOTOPMOST, ScreenSize.cx - 5, R.Top, 0, 0, SWP_NOREDRAW or SWP_NOSIZE)
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
var
  LSize, LScreenSize: TSize;
begin
  inherited;
  LSize := InitSize;
  LScreenSize := ScreenSize;
  MoveWindow(Handle, LScreenSize.cx - LSize.cx - 5,
                     LScreenSize.cy div 2 - LSize.cy div 2,
                     LSize.cx, LSize.cy, False);
end;

procedure TAppsWindow.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
  LEdit: CRichEditUI;
  LTitleCtl: CLabelUI;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_EVENT_WINDOWINIT) then
    DuiWindowInit
  else
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    if LCtlName.Contains('TabDotButton_') then
    begin
      if not COptionUI(Msg.pSender).IsSelected then
      begin
        FSelectedRadioIndex := Msg.pSender.Tag;
        ShowPage(FSelectedRadioIndex);
      end;
    end else ProcesNotifyEvent(Msg.pSender);
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
      TRichEditMenu.Create(PaintManagerUI)
    else if LCtlName.Equals(kbtnopenapp) then
    begin
      LTitleCtl := CLabelUI(PaintManagerUI.FindSubControlByName(FTileLayout.GetItemAt(Msg.pSender.Tag), 'title'));
      LTitleCtl.Tag := Msg.pSender.Tag;
      TButtonItemMenu.Create(LTitleCtl, PaintManagerUI);
    end;
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
  end else
  if LType.Equals(kButtonMenuItemClick) then
  begin
    if LCtlName.Equals('menu_open') then
      OpenAppByItemIndex(CLabelUI(Pointer(Msg.pSender.Tag)).Tag)
    else if LCtlName.Equals('menu_modify') then
    begin
      with TModifyInfoWindow.Create(Handle, CControlUI(Pointer(Msg.pSender.Tag)), FApps) do
      begin
        CenterWindow;
        ShowModal;
        Free;
      end;
    end else
    if LCtlName.Equals('menu_delete') then
    begin
      DeleteAppByItemIndex(CLabelUI(Pointer(Msg.pSender.Tag)).Tag);
    end;
  end;
end;

procedure TAppsWindow.DuiWindowInit;
begin
  FTileLayout := CTileLayoutUI(FindControl(kIconsList));
  FTabStyleDock := CHorizontalLayoutUI(FindControl('TabStyleDock'));
  ShowPage(0);
  InitRadios;
end;

function TAppsWindow.ExtractFileIconToPngAndReturnNewPath(
  const AFileName: string): string;
var
  LIcon: HICON;
  LIconId: UINT;
  LSaveIcon: TIcon;
  LBmp: TBitmap;
  LPng: TPngImage;

begin
  Result := '';
  if PrivateExtractIcons(PChar(AFileName), 0, 48, 48, LIcon, LIconId, 1, LR_LOADFROMFILE) <> 0 then
  begin
    LSaveIcon := TIcon.Create;
    try
      LSaveIcon.Handle := LIcon;
      LSaveIcon.Transparent := True;
      LBmp := TBitmap.Create;
      try
        // 关于透明问题以后再去解决
//        LSaveIcon.SaveToFile(GetSaveAbsIconFileName(AFileName).Replace('.png', '.ico'));
//        LBmp.Assign(LSaveIcon);
        LBmp.SetSize(LSaveIcon.Width, LSaveIcon.Height);
//        LBmp.Transparent := True;
        LBmp.Canvas.Draw(0, 0, LSaveIcon);
        LPng := TPngImage.Create;
        try
          LPng.Assign(LBmp);
          LPng.SaveToFile(GetSaveAbsIconFileName(AFileName));
          Result := GetIconRelIconFileName(AFileName);
        finally
          LPng.Free;
        end;
      finally
        LBmp.Free;
      end;
    finally
      LSaveIcon.Free;
      DestroyIcon(LIcon);
    end;
  end;
end;

function TAppsWindow.GetListMaxPage: Integer;
begin
  Result := Math.Ceil(FApps.Count / PAGE_MAX_CHIND);
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
  I, LMaxPage: Integer;
begin
  if FTabStyleDock = nil then Exit;
  LMaxPage := GetListMaxPage;
  // 创建对应的TabDot样式按钮
  for I := 0 to IfThen(FApps.Count mod PAGE_MAX_CHIND = 0, LMaxPage + 1, LMaxPage) - 1 do
     CreateRadioButton(Format('TabDotButton_%d', [I]));
  SelectRadioItem(FSelectedRadioIndex);
end;

procedure TAppsWindow.minbtnClick(Sender: TObject);
begin
  Minimize;
end;

procedure TAppsWindow.OpenAppByItemIndex(AIndex: Integer);
begin
  if (AIndex <> -1) and (AIndex < FApps.Count) then
    ShellExecute(0, nil, PChar(FApps.Items[AIndex].AppFileName), nil,
      PChar(ExtractFileDir(FApps.Items[AIndex].AppFileName)), SW_HIDE);
end;

procedure TAppsWindow.openappmarket(Sender: TObject);
begin
  MessageBox(0, 'appmarket', nil, 0);
end;

procedure TAppsWindow.openbrowser(Sender: TObject);
begin
  MessageBox(0, 'browser', nil, 0);
end;

procedure TAppsWindow.openmycomputer(Sender: TObject);
begin
  MessageBox(0, 'computer', nil, 0);
end;

procedure TAppsWindow.openyule(Sender: TObject);
begin
  MessageBox(0, 'yule', nil, 0);
end;

procedure TAppsWindow.ProcesNotifyEvent(Sender: TObject);
var
  LEvent: TNotifyEvent;
begin
  if FEvents.TryGetValue(CControlUI(Sender).Name, LEvent) then
    LEvent(Sender);
end;

procedure TAppsWindow.ReInitRadios;
begin
  if FTabStyleDock <> nil then
  begin
    if (FTabStyleDock.GetCount <> GetListMaxPage) or (FApps.Count mod PAGE_MAX_CHIND = 0) then
    begin
      FTabStyleDock.RemoveAll;
      InitRadios;
    end;
  end;
end;

procedure TAppsWindow.SelectRadioItem(AIndex: Integer);
begin
  if AIndex <= -1 then Exit;
  if FTabStyleDock <> nil then
  begin
    if AIndex > FTabStyleDock.GetCount then Exit;
    COptionUI(FTabStyleDock.GetItemAt(AIndex)).Selected := True;
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
  I, LCurPageCount, LStartIndex, LEndIndex: Integer;
  LVerticalLayout: CVerticalLayoutUI;
  LTitle: CLabelUI;
  LItem: TIconInfo;
  LButton: CButtonUI;
begin
  if FTileLayout <> nil then
  begin
    // 清除之前的控件
    FTileLayout.RemoveAll;
    if FTileLayout.GetColumns <> 4 then
      FTileLayout.SetColumns(4);

    LStartIndex := AIndex * PAGE_MAX_CHIND;
    LEndIndex := Min((AIndex + 1) * PAGE_MAX_CHIND, FApps.Count);
    LCurPageCount := LEndIndex - LStartIndex;
    OutputDebugString(PChar(Format('++++++++++++++++++++++++LCurPageCount=%d', [LCurPageCount])));
    for I := LStartIndex to LEndIndex - 1 do
    begin
      LItem := FApps.Items[I];
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
      FTileLayout.Add(LVerticalLayout);
    end;
    // 这里应该是哪个页少就出现添加按钮，当满了就移除添加按钮
    if LCurPageCount < PAGE_MAX_CHIND then
    begin
      LVerticalLayout := CreateAddItemButton;
      if LVerticalLayout <> nil then
        FTileLayout.Add(LVerticalLayout);
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

constructor TRichEditMenu.Create(APaintManger: CPaintManagerUI);
begin
  inherited Create('richeditmenu.xml', GetResFullDir,
    '', UILIB_FILE, APaintManger, 'RichMenuItemClick');
end;

{ TTrayMenu }

constructor TTrayMenu.Create(APaintManger: CPaintManagerUI);
begin
  inherited Create('traymenu.xml', GetResFullDir,
    '', UILIB_FILE, APaintManger, 'TrayMenuItemClick');
end;

{ TButtonItemMenu }

constructor TButtonItemMenu.Create(ATitleControl: CControlUI; APaintManger: CPaintManagerUI);
begin
  FTitleControl := ATitleControl;
  inherited Create('buttonitemmenu.xml', GetResFullDir,
    '', UILIB_FILE, APaintManger, 'ButtonMenuItemClick', False);
end;

procedure TButtonItemMenu.DoNotify(var Msg: TNotifyUI);
begin
  // 重写这个方法，以便自定义，不要继续的
  if Msg.sType = DUI_EVENT_ITEMSELECT then
    Close
  else if Msg.sType = DUI_EVENT_ITEMCLICK then
  begin
    // 将打开的索引再进一步传递回去
    Msg.pSender.Tag := UIntPtr(FTitleControl);
    FParentPaintManager.SendNotify(Msg.pSender, FMsg);
  end;
end;

{ TAppsJSONObject }

constructor TAppsJSONObject.Create;
begin
  inherited Create;
  FItems := TList<TIconInfo>.Create;
end;

destructor TAppsJSONObject.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TAppsJSONObject.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);;
end;

function TAppsJSONObject.Add(AItem: TIconInfo): Integer;
begin
  Result := FItems.Add(AItem);
end;

function TAppsJSONObject.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TAppsJSONObject.GetItemByIndex(Index: Integer): TIconInfo;
begin
  Result := FItems[Index];
end;

procedure TAppsJSONObject.LoadFromFile(const AFileName: string);
var
  LFileStream: TFileStream;
begin
  LFileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(LFileStream);
  finally
    LFileStream.Free;
  end;
end;

procedure TAppsJSONObject.LoadFromStream(const AStream: TStream);
var
  LStrStream: TStringStream;
begin
  LStrStream := TStringStream.Create('', TEncoding.UTF8);
  try
    LStrStream.LoadFromStream(AStream);
    ParseJSON(LStrStream.DataString);
  finally
    LStrStream.Free;
  end;
end;

procedure TAppsJSONObject.ParseJSON(const AStr: string);
var
  LJV: TJSONValue;
  LJA: TJSONArray;
  I: Integer;
  LItem: TIconInfo;
begin
  LJV := TJSONObject.ParseJSONValue(AStr);
  if Assigned(LJV) then
  begin
    try
      if LJV.TryGetValue<TJSONArray>(LJA) then
      begin
        for I := 0 to LJA.Count - 1 do
        begin
          LJA.Items[I].TryGetValue<string>('text', LItem.Text);
          LJA.Items[I].TryGetValue<string>('iconpath', LItem.IconPath);
          LJA.Items[I].TryGetValue<string>('appfilename', LItem.AppFileName);
          FItems.Add(LItem);
        end;
      end;
    finally
      LJV.Free;
    end;
  end;
end;

procedure TAppsJSONObject.Remove(AItem: TIconInfo);
begin
  FItems.Remove(AItem);
end;

procedure TAppsJSONObject.SaveToFile(const AFileName: string);
var
  LFileStream: TFileStream;
begin
  LFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(LFileStream);
  finally
    LFileStream.Free;
  end;
end;

procedure TAppsJSONObject.SaveToStream(const AStream: TStream);
var
  I: Integer;
  LItem: TIconInfo;
  LData: TStringStream;
  LJA: TJSONArray;
  LJO: TJSONObject;
begin
  LData := TStringStream.Create('', TEncoding.UTF8);
  try
    LJA := TJSONArray.Create;
    try
      for I := 0 to FItems.Count - 1 do
      begin
        LItem := FItems[I];
        LJO := TJSONObject.Create;
        // .Replace('\', '\\')　要这样，TJSONString竟然不起作用了？　
        LJO.AddPair('text', TJSONString.Create(LItem.Text.Replace('\', '\\')));
        LJO.AddPair('iconpath', TJSONString.Create(LItem.IconPath.Replace('\', '\\')));
        LJO.AddPair('appfilename', TJSONString.Create(LItem.AppFileName.Replace('\', '\\')));
        LJA.Add(LJO);
      end;
      LData.WriteString(LJA.ToString);
    finally
      LJA.Free;
    end;
    LData.SaveToStream(AStream);
  finally
    LData.Free;
  end;
end;

procedure TAppsJSONObject.SetItemByIndex(Index: Integer;
  const Value: TIconInfo);
begin
  FItems[Index] := Value;
end;

{ TModifyInfoWindow }

constructor TModifyInfoWindow.Create(AParent: HWND; ATitleControl: CControlUI; AApps: TAppsJSONObject);
begin
  FApps := AApps;
  FTitleControl := ATitleControl;
  inherited Create('modifyinfo.xml', GetResFullDir);
  CreateWindow(AParent, '修改信息', WS_POPUP, WS_EX_TOOLWINDOW);
end;

procedure TModifyInfoWindow.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
end;

procedure TModifyInfoWindow.DoInitWindow;
var
  LblTitle: CLabelUI;
begin
  inherited;
  FEdtTitle := CEditUI(FindControl('edtTitle'));
  if FEdtTitle <> nil then
  begin
    LblTitle := CLabelUI(Pointer(FTitleControl));
    if LblTitle <> nil then
      FEdtTitle.Text := FApps.Items[LblTitle.Tag].Text;
    FEdtTitle.SetFocus;
  end;
end;

procedure TModifyInfoWindow.DoNotify(var Msg: TNotifyUI);
var
  LblTitle: CLabelUI;
  LItem: TIconInfo;
begin
  inherited;
  if Msg.sType = DUI_EVENT_CLICK then
  begin
    if Msg.pSender.Name = kclosebtn then
      Close
    else if Msg.pSender.Name = 'btnOK' then
    begin
      if FEdtTitle.Text = '' then
      begin
        ShowMessage('请输入一个名称！');
        Exit;
      end;
      LblTitle := CLabelUI(Pointer(FTitleControl));
      if LblTitle <> nil then
      begin
        LItem := FApps.Items[LblTitle.Tag];
        LItem.Text := FEdtTitle.Text;
        LblTitle.Text := LItem.Text;
        FApps.Items[LblTitle.Tag] := LItem;
      end;
      Close;
    end;
  end
end;



end.
