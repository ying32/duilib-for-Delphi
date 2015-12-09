unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Math,
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

  /// <summary>
  ///   4行，5列 (LTileLayout.GetWidth div 80 * (LTitleLayout.GetHeight div 80)
  /// </summary>
  PAGE_MAX_CHIND = 20;

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
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DoInitWindow; override;
    procedure CreateRadioButton(const AName: string);
    procedure ShowPage(AIndex: Integer);
    procedure AddIcon(AIcon: TIconInfo);
    procedure InitRadios;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  AppsWindow: TAppsWindow;

implementation

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
  CreateWindow(0, 'Apps', UI_WNDSTYLE_EX_DIALOG, WS_EX_WINDOWEDGE or WS_EX_ACCEPTFILES);
  FDlgBuilder := CDialogBuilder.CppCreate;
  FIcons := TList<TIconInfo>.Create;
  for I := 0 to 34 do
    FIcons.Add(TIconInfo.Create('测试' + I.ToString, 'xiaoshuo.png'))
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
  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  inherited;
  case Msg.Msg of
    WM_DROPFILES:
     begin
       //TDropStruct
       // 文件拖放
     end;
  end;
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
      LEdit := CRichEditUI(FindControl('edt_Search'));
      if LEdit <> nil then
      begin
        MessageBox(0, PChar(LEdit.Text), nil, 0);
      end;
    end else
    if LCtlName.Equals('btnopenapp') then
    begin
      OutputDebugString(PChar(Format('XXX=%s, Tag=%d', [LCtlName, Msg.pSender.Tag])));
    end;

  end else
  if LType.Equals(DUI_EVENT_KILLFOCUS) then
  begin
    if LCtlName.Equals('edt_Search') then
    begin
      LEdit := CRichEditUI(FindControl('edt_Search'));
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
    if LCtlName.Equals('edt_Search') then
    begin
      LEdit := CRichEditUI(FindControl('edt_Search'));
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

// 从0开始的索引
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
    for I := (AIndex * PAGE_MAX_CHIND) to  Min((AIndex + 1) * PAGE_MAX_CHIND, FIcons.Count) - 1 do
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

  end;
end;

{ TIconInfo }

constructor TIconInfo.Create(AText, AIconPath: string);
begin
  Self.Text := AText;
  Self.IconPath := AIconPath;
  Self.AppFileName := '';
end;

end.
