program DDuilibDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Winapi.ActiveX,
  Winapi.RichEdit,
  System.Generics.Collections,
  Duilib in 'Duilib.pas',
  DuiWindowImplBase in 'DuiWindowImplBase.pas',
  DuiBase in 'DuiBase.pas',
  DuiListUI in 'DuiListUI.pas',
  DuiApplication in 'DuiApplication.pas',
  UIListCommonDefine in 'UIListCommonDefine.pas',
  DuilibHelper in 'DuilibHelper.pas',
  DuiConst in 'DuiConst.pas';

const
  kFriendListItemNormalHeight = 32;
  kFriendListItemSelectedHeight = 50;
  kLogoButtonControlName = 'logo';
  kLogoContainerControlName = 'logo_container';
  kNickNameControlName = 'nickname';
  kDescriptionControlName = 'description';
  kOperatorPannelControlName = 'operation';
  kTabControlName = 'tabs';
  kFriendButtonControlName = 'friendbtn';
  kGroupButtonControlName = 'groupbtn';
  kMicroBlogButtonControlName = 'microblogbtn';
  kBackgroundControlName = 'bg';
  kTitleControlName = 'apptitle';
  kCloseButtonControlName = 'closebtn';
  kMinButtonControlName = 'minbtn';
  kMaxButtonControlName = 'maxbtn';
  kRestoreButtonControlName = 'restorebtn';
  kFontButtonControlName = 'fontbtn';
  kFontbarControlName = 'fontbar';
  kFontTypeControlName = 'font_type';
  kFontSizeControlName = 'font_size';
  kBoldButtonControlName = 'boldbtn';
  kItalicButtonControlName = 'italicbtn';
  KUnderlineButtonControlName = 'underlinebtn';
  kColorButtonControlName = 'colorbtn';
  kInputRichEditControlName = 'input_richedit';
  kViewRichEditControlName = 'view_richedit';
  kEmotionButtonControlName = 'emotionbtn';
  kSendButtonControlName = 'sendbtn';
  kChangeBkSkinControlName = 'bkskinbtn';
  kChangeColorSkinControlName = 'colorskinbtn';
  kEmotionRefreshTimerId = 1001;
  kEmotionRefreshInterval = 150;
  kBackgroundSkinImageCount = 3;
  kAdjustColorControlName = 'adjcolor';
  kAdjustBkControlName = 'adjbk';
  kAdjustColorSliderRControlName = 'AdjustColorSliderR';
  kAdjustColorSliderGControlName = 'AdjustColorSliderG';
  kAdjustColorSliderBControlName = 'AdjustColorSliderB';
  kHColorLayoutControlName = 'HColorLayout';
  kHBkLayoutControlName = 'HBkLayout';

type
  TFriendListItemInfo = packed record
    Folder: Boolean;
    Empty: Boolean;
    Id: string;
    Logo: string;
    NickName: string;
    Description: string;
  end;

  TSkinChangedParam = packed record
    BkColor: DWORD;
    BKImage: string;
  end;

  PSkinChangedParam = ^TSkinChangedParam;

var
  SkinChangedList: TList<TDuiWindowImplBase>;

procedure AddSkinChangedWindow(AWindow: TDuiWindowImplBase); forward;

procedure SendSkinChanged(p: TSkinChangedParam); forward;

type
  TFirendList = class;

  TXGuiFoundation = class(TDuiWindowImplBase)
  private
    FFirendList: TList<TFriendListItemInfo>;
    FFirned: TFirendList;
    FMySelfInfo: TFriendListItemInfo;
    FBKImageIndex: Integer;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    procedure UpdateFriendsList;
    procedure OnPrepare(var Msg: TNotifyUI);
    procedure SetBkColor(bkColor: DWORD);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TChatDialog = class(TDuiWindowImplBase)
  private
    FBGImage: string;
    FBKColor: DWORD;
    FMySelft: TFriendListItemInfo;
    FFriendInfo: TFriendListItemInfo;
    FEmotionTimerStart: Boolean;
    FTextColor: DWORD;
    FFontFaceName: string;
    function GetCurrentTimeString: string;
    procedure FontStyleChanged;
    procedure SendMsg;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(const bgimage: string; bkcolor: DWORD; myselft_info, friend_info: TFriendListItemInfo);
    procedure OnReceive(Param: Pointer); override;
    procedure OnPrepare(var Msg: TNotifyUI);
  end;

  TColorSkinWindow = class(TDuiWindowImplBase)
  private
    FMainFrame: TXGuiFoundation;
    FParentWindowRect: TRect;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoInitWindow; override;
    function DoHandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(main_frame: TXGuiFoundation; rcParentWindow: TRect);
  end;

  TFirendList = class(TDuiListUI)
  private
    FPaintManager: CPaintManagerUI;
    FDlgBuilder: CDialogBuilder;
    FRootNode: TNode;
    FTextPadding: TRect;
    FLevelTextStartPos: Integer;
    FLevelExpandImage: string;
    FLevelCollapseImage: string;
  protected
    procedure DoSelectItem; override;
  public
    constructor Create(APaintManager: CPaintManagerUI);
    destructor Destroy; override;
    function AddNode(AItem: TFriendListItemInfo; parent: TNode): TNode;
    procedure RemoveAll;
    function RemoveNode(node: TNode): Boolean;
    function CanExpand(node: TNode): Boolean;
    procedure SetChildVisible(node: TNode; AVisible: Boolean);
  end;



{ TXGuiFoundation }

constructor TXGuiFoundation.Create;
begin
  inherited Create('main_frame.xml', '\skin\QQRes\', UILIB_FILE);
  FFirendList := TList<TFriendListItemInfo>.Create;
  CreateDuiWindow(GetDesktopWindow, 'QQ2010');
end;

destructor TXGuiFoundation.Destroy;
begin
  if FFirned <> nil then
    FFirned.Free;
  FFirendList.Free;
  inherited;
end;

function TXGuiFoundation.DoCreateControl(pstrStr: string): CControlUI;
begin
  if pstrStr.Equals('FriendList') then
  begin
    if FFirned = nil then
      FFirned := TFirendList.Create(PaintManagerUI);
    Exit(FFirned.ControlUI);
  end;
  Result := nil;
end;

procedure TXGuiFoundation.DoFinalMessage(hWd: HWND);
begin
  inherited;
end;

{$REGION 'DoNotify'}
procedure TXGuiFoundation.DoNotify(var msg: TNotifyUI);
var
  left_main_pannel, hide_left_main_pannel, show_left_main_pannel: CControlUI;
  LCtlName, LType, bkimage: string;
  signature, signature_tip, search_tip, search_edit, background: CControlUI;
  pTabControl: CTabLayoutUI;
  node: TNode;
  friend_info, citer: TFriendListItemInfo;
  chatDlg: TChatDialog;
  skinparam: TSkinChangedParam;
//  pFriendListItem: CListContainerElementUI;
//  pOperatorPannel: CContainerUI;
  rcWindow: TRect;
begin
  inherited;
  //Writeln('DoNotify++++++++++++++++', string(Msg.sType));

  LCtlName := msg.pSender.Name;
  LType := Msg.sType;
  if LType.Equals(DUI_EVENT_WINDOWINIT) then
  begin
    OnPrepare(msg);
  end
  else if SameStr(LType, DUI_EVENT_KILLFOCUS) then
  begin
    if SameStr(LCtlName, 'signature') then
    begin
      msg.pSender.Hide;
      signature_tip := FindControl('signaturetip');
      if signature_tip <> nil then
      begin
        signature := msg.pSender;
        if signature <> nil then
          signature_tip.Text := signature.Text;
        signature_tip.Show;
      end;
    end
    else if SameStr(LCtlName, 'search_edit') then
    begin
      msg.pSender.Hide;
      search_tip := FindControl('search_tip');
      if search_tip <> nil then
      begin
        search_edit := msg.pSender;
        if search_edit <> nil then
          search_tip.Text := search_edit.Text;
        search_tip.Show;
      end;
    end;
  end
  else if SameStr(LType, DUI_EVENT_CLICK) then
  begin
    if SameStr(LCtlName, kCloseButtonControlName) then
      Close
    else if SameStr(LCtlName, kMinButtonControlName) then
      Minimize
    else if SameStr(LCtlName, kMaxButtonControlName) then
      Maximize
    else if SameStr(LCtlName, kRestoreButtonControlName) then
      Restore
    else if SameStr(LCtlName, 'btnleft') then
    begin
      left_main_pannel := FindControl('LeftMainPanel');
      hide_left_main_pannel := FindControl('btnleft');
      show_left_main_pannel := FindControl('btnright');
      if ((left_main_pannel <> nil) and (show_left_main_pannel <> nil) and (hide_left_main_pannel <> nil)) then
      begin
        hide_left_main_pannel.Hide;
        left_main_pannel.Hide;
        show_left_main_pannel.Show;
      end;
    end
    else if SameStr(LCtlName, 'btnright') then
    begin
      left_main_pannel := FindControl('LeftMainPanel');
      hide_left_main_pannel := FindControl('btnleft');
      show_left_main_pannel := FindControl('btnright');
      if ((left_main_pannel <> nil) and (show_left_main_pannel <> nil) and (hide_left_main_pannel <> nil)) then
      begin
        hide_left_main_pannel.Show;
        left_main_pannel.Show;
        show_left_main_pannel.Hide;
      end;
    end
    else if SameStr(LCtlName, 'signaturetip') then
    begin
      msg.pSender.Hide;
      signature := FindControl('signature');
      if signature <> nil then
      begin
        signature.Text := msg.pSender.Text;
        signature.Show;
      end;
    end
    else if LCtlName.Equals('search_tip') then
    begin
      msg.pSender.Hide;
      search_edit := FindControl('search_edit');
      if search_edit <> nil then
      begin
        search_edit.Text := msg.pSender.Text;
        search_edit.Show;
      end;
    end
    else if LCtlName.Equals(kChangeBkSkinControlName) then
    begin
      background := FindControl(kBackgroundControlName);
      if background <> nil then
      begin
        Inc(FBKImageIndex);
        if kBackgroundSkinImageCount < FBKImageIndex then
          FBKImageIndex := 0;
      end;
      background.BkImage := Format('file=''bg%d.png'' corner=''600,200,1,1''', [FBKImageIndex]);

      background := FindControl(kBackgroundControlName);
      if background <> nil then
      begin

        skinparam.bkcolor := background.BkColor;
        skinparam.BKImage := '';
        if background.BkImage <> '' then
          skinparam.BKImage := Format('bg%d.png', [FBKImageIndex]);
      end;
      SendSkinChanged(skinparam);
    end
    else if LCtlName.Equals(kChangeColorSkinControlName) then
    begin
      GetWindowRect(Handle, rcWindow);
      rcWindow.top := rcWindow.top + msg.pSender.GetPos.bottom;
      TColorSkinWindow.Create(Self, rcWindow);
    end;
  end
  else if SameStr(LType, DUI_EVENT_SELECTCHANGED) then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if LCtlName.Equals(kFriendButtonControlName) then
    begin
      if (pTabControl <> nil) and (pTabControl.SelectIndex <> 0) then
      begin
        pTabControl.SelectIndex := 0;
        UpdateFriendsList();
      end;
    end
    else if LCtlName.Equals(kGroupButtonControlName) then
    begin
      if (pTabControl <> nil) and (pTabControl.SelectIndex <> 1) then
      begin
        pTabControl.SelectIndex := 1;

				//UpdateGroupsList();
      end;
    end
    else if LCtlName.Equals(kMicroBlogButtonControlName) then
    begin
      if (pTabControl <> nil) and (pTabControl.SelectIndex <> 2) then
      begin
        pTabControl.SelectIndex := 2;
				//UpdateMicroBlogList();
      end;
    end;
  end
  else if SameStr(LType, DUI_EVENT_ITEMACTIVATE) then
  begin

    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if pTabControl <> nil then
    begin
      if pTabControl.SelectIndex = 0 then
      begin
        if (FFirned.this <> nil) and (FFirned.this.GetItemIndex(msg.pSender) <> -1) then
        begin
          if msg.pSender.ClassName.Equals(DUI_CLASS_ListContainerElementUI) then
          begin
            node := TNode(Pointer(msg.pSender.Tag));
            background := FindControl(kBackgroundControlName);
            if (not FFirned.CanExpand(node)) and (background <> nil) then
            begin
              FillChar(friend_info, SizeOf(friend_info), #0);
              for citer in FFirendList do
              begin
                if citer.id = node.NodeData.Value then
                begin
                  friend_info := citer;
                  break;
                end;
              end;
              bkimage := '';
              if background.BkImage <> '' then
                bkimage := Format('bg%d.png', [FBKImageIndex]);

              chatDlg := TChatDialog.Create(bkimage, background.BkColor, FMySelfInfo, friend_info);
              if chatDlg <> nil then
              begin
                chatDlg.CenterWindow;
                chatDlg.Show;
                AddSkinChangedWindow(chatDlg);
              end;
            end;
          end;
        end;
      end;
    end;
  end
  else if SameStr(LType, DUI_EVENT_ITEMCLICK) then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if pTabControl <> nil then
    begin
      if pTabControl.GetCurSel() = 0 then
      begin
        if (FFirned.this <> nil) and (FFirned.this.GetItemIndex(msg.pSender) <> -1) then
        begin
          if msg.pSender.ClassName.Equals(DUI_CLASS_ListContainerElementUI) then
          begin
            node := TNode(Pointer(msg.pSender.Tag));
            if FFirned.CanExpand(node) then
              FFirned.SetChildVisible(node, not node.NodeData.ChildVisible);
          end;
        end;
      end
      else if pTabControl.GetCurSel() = 1 then
      begin
//				CGroupsUI* pGroupsList = static_cast<CGroupsUI*>(m_PaintManager.FindControl(kGroupsListControlName));
//				if ((pGroupsList != NULL) &&  pGroupsList->GetItemIndex(msg.pSender) != -1) then
//				begin
//					if (_tcsicmp(msg.pSender->GetClass(), _T("ListContainerElementUI")) == 0) then
//					begin
//						node := TNode(Pointer(msg.pSender.GetTag()));
//						if (pGroupsList->CanExpand(node)) then
//							pGroupsList->SetChildVisible(node, !node->data().child_visible_);
//					end;
//				end;
      end;
    end;

  end
  else if SameStr(LType, DUI_EVENT_ITEMSELECT) then
  begin
    // firend list
    if msg.pSender = FFirned.this then
      FFirned.DoSelectItem;
  end;
end;
{$ENDREGION 'DoNotify'}

procedure TXGuiFoundation.OnPrepare(var Msg: TNotifyUI);
var
  background: CControlUI;
begin
  background := FindControl(kBackgroundControlName);
  if background <> nil then
    background.BkImage := Format('file=''bg%d.png'' corner=''600,200,1,1''', [FBKImageIndex]);
  UpdateFriendsList;
end;

procedure TXGuiFoundation.SetBkColor(bkColor: DWORD);
var
  background: CControlUI;
  param: TSkinChangedParam;
begin
  background := FindControl(kBackgroundControlName);
  if background <> nil then
  begin
    background.BkImage := '';
    background.BkColor := bkColor;
    background.NeedUpdate();
    param.bkcolor := background.BkColor;
    param.BKImage := background.BkImage;
    SendSkinChanged(param);
  end;
end;

procedure TXGuiFoundation.UpdateFriendsList;
var
  item: TFriendListItemInfo;
  root_parent, new2: TNode;
  I: Integer;
begin
  if FindControl('friends') <> nil then
  begin
    if FFirendList.Count > 0 then
      FFirendList.Clear;
    if FFirned.Count > 0 then
      FFirned.RemoveAll;

    FillChar(item, SizeOf(item), #0);

    item.Id := '0';
    item.Folder := True;
    item.Empty := False;
    item.NickName := '我的好友';
    root_parent := FFirned.AddNode(item, nil);
    FFirendList.Add(item);
    Writeln('parent=', DWORD(root_parent));

    item.Id := '1';
    item.Folder := False;
    item.Logo := 'man.png';
    item.NickName := 'ying32';
    item.Description := '1444386932@qq.com';
    FFirned.AddNode(item, root_parent);
    Writeln('root_parent.chinds=', root_parent.Count);
    FFirendList.Add(item);

    FMySelfInfo := item;

    item.Id := '2';
    item.Folder := False;
    item.Logo := 'default.png';
    item.NickName := 'achellies';
    item.Description := 'achellies@hotmail.com';
    FFirned.AddNode(item, root_parent);
    FFirendList.Add(item);

    item.Id := '2';
    item.Folder := False;
    item.Logo := 'default.png';
    item.NickName := 'wangchyz';
    item.Description := 'wangchyz@gmail.com';
    FFirned.AddNode(item, root_parent);
    FFirendList.Add(item);

    for I := 1 to 5 do
    begin
      item.Id := '2';
      item.Folder := False;
      item.Logo := 'default.png';
      item.NickName := 'duilib';
      item.Description := 'www.duilib.com';
      FFirned.AddNode(item, root_parent);
      FFirendList.Add(item);
    end;

    item.Id := '3';
    item.Folder := True;
    item.Empty := False;
    item.NickName := '企业好友';
    root_parent := FFirned.AddNode(item, nil);
    FFirendList.Add(item);

    item.Id := '4';
    item.Folder := False;
    item.Logo := 'icon_home.png';
    item.NickName := '腾讯企业QQ的官方展示号';
    item.Description := '';
    FFirned.AddNode(item, root_parent);
    FFirendList.Add(item);

    item.Id := '5';
    item.Folder := True;
    item.Empty := False;
    item.NickName := '陌生人';
    root_parent := FFirned.AddNode(item, nil);
    FFirendList.Add(item);

    item.Id := '6';
    item.Folder := False;
    item.Logo := 'default.png';
    item.NickName := '某人1';
    item.Description := '恨恨恨...';
    FFirned.AddNode(item, root_parent);
    FFirendList.Add(item);

    item.Id := '7';
    item.Folder := True;
    item.Empty := False;
    item.NickName := '黑名单';
    FFirned.AddNode(item, nil);
    FFirendList.Add(item);
  end;
end;


{ TChatDialog }

constructor TChatDialog.Create(const bgimage: string; bkcolor: DWORD; myselft_info, friend_info: TFriendListItemInfo);
begin
  inherited Create('chatbox.xml', ExtractFilePath(ParamStr(0)) + 'skin\QQRes\', UILIB_FILE);
  FBGImage := bgimage;
  FBKColor := bkcolor;
  FMySelft := myselft_info;
  FFriendInfo := friend_info;
  FTextColor := $FF000000;
  FFontFaceName := '微软雅黑';
  FEmotionTimerStart := False;
  CreateWindow(0, 'ChatDialog', UI_WNDSTYLE_FRAME or WS_POPUP, 0, 0, 0, 0, 0, 0);
end;

procedure TChatDialog.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

procedure TChatDialog.DoNotify(var Msg: TNotifyUI);
var
  LCtlName, LType: string;
  pFontbar: CContainerUI;
  font_type: CComboUI;
begin
  inherited;
  LCtlName := msg.pSender.Name;
  LType := Msg.sType;
  if LType.Equals(DUI_EVENT_WINDOWINIT) then
    OnPrepare(msg)
  else if SameStr(LType, DUI_EVENT_CLICK) then
  begin
    if SameStr(LCtlName, kCloseButtonControlName) then
      Close
    else if SameStr(LCtlName, kMinButtonControlName) then
      Minimize
    else if SameStr(LCtlName, kMaxButtonControlName) then
      Maximize
    else if SameStr(LCtlName, kRestoreButtonControlName) then
      Restore
    else if LCtlName.Equals(kSendButtonControlName) then
      SendMsg
    else if LCtlName.Equals(kFontButtonControlName) then
    begin
      pFontbar := CContainerUI(FindControl(kFontbarControlName));
      if pFontbar <> nil then
        pFontbar.Visible := not pFontbar.Visible;
    end
    else if LCtlName.Equals(kEmotionButtonControlName) then
    begin

    end;
  end
  else if LType.Equals(DUI_EVENT_RETURN) then
  begin
    if LCtlName.Equals(kInputRichEditControlName) then
      SendMsg;
  end
  else if LType.Equals(DUI_EVENT_ITEMSELECT) then
  begin
    if LCtlName.Equals(kFontTypeControlName) then
    begin
      font_type := CComboUI(msg.pSender);
      if font_type <> nil then
      begin
        FFontFaceName := font_type.Text;
        FontStyleChanged();
      end;
    end;
  end;
end;

procedure TChatDialog.FontStyleChanged;
begin

end;

function TChatDialog.GetCurrentTimeString: string;
begin
  Result := FormatDateTime('YYYY年MM月DD日 hh:mm:ss', Now);
end;

procedure TChatDialog.OnPrepare(var Msg: TNotifyUI);
var
  background, nick_name, desciption: CControlUI;
  log_button: CButtonUI;
  pFontbar: CContainerUI;
begin
  background := FindControl(kBackgroundControlName);
  if background <> nil then
  begin
    background.BkImage := Format('file=''%s'' corner=''600,200,1,1''', [FBGImage]);
    background.BkColor := FBKColor;
  end;
  log_button := CButtonUI(FindControl(kLogoButtonControlName));
  if log_button <> nil then
    log_button.BkImage := FFriendInfo.logo;

  nick_name := FindControl(kNickNameControlName);
  if nick_name <> nil then
    nick_name.Text := FFriendInfo.NickName;

  desciption := FindControl(kDescriptionControlName);
  if desciption <> nil then
    desciption.Text := FFriendInfo.description;

  pFontbar := CContainerUI(FindControl(kFontbarControlName));
  if pFontbar <> nil then
    pFontbar.Visible := not pFontbar.IsVisible;
end;

procedure TChatDialog.OnReceive(Param: Pointer);
var
  L: PSkinChangedParam;
  background: CControlUI;
begin
  L := Param;
  if L <> nil then
  begin

    FBGImage := L^.BKImage;
    FBKColor := L^.BkColor;
    background := FindControl(kBackgroundControlName);
    if background <> nil then
    begin
      if not FBGImage.IsEmpty() then
        background.BkImage := Format('file=''%s'' corner=''600,200,1,1''', [FBGImage])
      else
        background.BkImage := '';
      background.BkColor := FBKColor;
    end;
  end;
end;

procedure TChatDialog.SendMsg;
var
  pRichEdit: CRichEditUI;
  sText: string;
  lSelBegin, lSelEnd: Integer;
  cf: TCharFormat2;
  pf: TParaFormat2;
begin
  pRichEdit := CRichEditUI(FindControl(kInputRichEditControlName));
  if pRichEdit = nil then
    Exit;
  pRichEdit.SetFocus();
  sText := pRichEdit.GetTextRange(0, pRichEdit.GetTextLength);
  if sText.IsEmpty then
    Exit;
  pRichEdit.Text := '';

  pRichEdit := CRichEditUI(FindControl(kViewRichEditControlName));
  if pRichEdit = nil then
    Exit;

  ZeroMemory(@cf, sizeof(TCharFormat2));
  cf.cbSize := sizeof(cf);
  cf.dwReserved := 0;
  cf.dwMask := CFM_COLOR or CFM_LINK or CFM_UNDERLINE or CFM_UNDERLINETYPE;
  cf.dwEffects := CFE_LINK;
  cf.bUnderlineType := CFU_UNDERLINE;
  cf.crTextColor := RGB(220, 0, 0);

  lSelBegin := pRichEdit.GetTextLength;
  lSelEnd := lSelBegin;
  pRichEdit.SetSel(lSelEnd, lSelEnd);
  pRichEdit.ReplaceSel('某人', False);

  lSelEnd := pRichEdit.GetTextLength;
  pRichEdit.SetSel(lSelBegin, lSelEnd);
  pRichEdit.SetSelectionCharFormat(cf);

  lSelBegin := pRichEdit.GetTextLength;
  lSelEnd := lSelBegin;
  pRichEdit.SetSel(lSelEnd, lSelEnd);
  pRichEdit.ReplaceSel(PChar('说:'#9 + GetCurrentTimeString + #10), False);

  cf.dwMask := CFM_COLOR;
  cf.crTextColor := RGB(0, 0, 0);
  cf.dwEffects := 0;
  lSelEnd := pRichEdit.GetTextLength;
  pRichEdit.SetSel(lSelBegin, lSelEnd);
  pRichEdit.SetSelectionCharFormat(cf);

  ZeroMemory(@pf, sizeof(TParaFormat2));
  pf.cbSize := sizeof(pf);
  pf.dwMask := PFM_STARTINDENT;
  pf.dxStartIndent := 0;
  pRichEdit.SetParaFormat(pf);

  lSelBegin := pRichEdit.GetTextLength;

  pRichEdit.SetSel(-1, -1);
  pRichEdit.ReplaceSel(PChar(sText), False);

  pRichEdit.SetSel(-1, -1);
  pRichEdit.ReplaceSel(#10, False);

  cf.crTextColor := RGB(0, 0, 0);
  lSelEnd := pRichEdit.GetTextLength;
  pRichEdit.SetSel(lSelBegin, lSelEnd);
  pRichEdit.SetSelectionCharFormat(cf);

  ZeroMemory(@pf, sizeof(TParaFormat2));
  pf.cbSize := sizeof(pf);
  pf.dwMask := PFM_STARTINDENT;
  pf.dxStartIndent := 220;
  pRichEdit.SetParaFormat(pf);

  pRichEdit.EndDown();
end;

{ TFirendList }

function TFirendList.AddNode(AItem: TFriendListItemInfo; parent: TNode): TNode;
var
  pListElement: CListContainerElementUI;
  log_button: CButtonUI;
  logo_container: CContainerUI;
  nick_name, description: CLabelUI;
  node, prev: TNode;
  rcPadding: TRect;
  i, index: Integer;
  html_text: string;
begin
  Result := nil;
  if parent = nil then
    parent := FRootNode;

  if not FDlgBuilder.GetMarkup.IsValid then
    pListElement := CListContainerElementUI(FDlgBuilder.Create('friend_list_item.xml', nil, nil, FPaintManager))
  else
    pListElement := CListContainerElementUI(FDlgBuilder.Create(nil, FPaintManager));
  if pListElement = nil then
    Exit;

  node := TNode.Create;

  Writeln('parent.NodeData.Level=', parent.NodeData.Level);

  node.NodeData.Level := parent.NodeData.Level + 1;

  if AItem.Folder then
    node.NodeData.HasChild := not AItem.Empty
  else
    node.NodeData.HasChild := False;

  node.NodeData.Folder := AItem.Folder;

  node.NodeData.ChildVisible := node.NodeData.Level = 0;
  node.NodeData.ChildVisible := False;

  node.NodeData.Text := AItem.NickName;
  node.NodeData.Value := AItem.Id;
  node.NodeData.ListElment := pListElement;

  if not parent.NodeData.ChildVisible then
    pListElement.Hide;

  if (parent <> FRootNode) and (not parent.NodeData.ListElment.Visible) then
    pListElement.Hide;

  rcPadding := FTextPadding;
  for i := 0 to node.NodeData.Level - 1 do
    rcPadding.left := rcPadding.left + FLevelTextStartPos;

  pListElement.SetPadding(rcPadding);

  log_button := CButtonUI(FPaintManager.FindSubControlByName(pListElement, kLogoButtonControlName));
  if log_button <> nil then
  begin
    if (not AItem.Folder) and (not AItem.Logo.IsEmpty) then
    begin
      log_button.SetNormalImage(PChar(AItem.Logo));
    end
    else
    begin
      logo_container := CContainerUI(FPaintManager.FindSubControlByName(pListElement, kLogoContainerControlName));
      if logo_container <> nil then
        logo_container.Hide;
    end;
    log_button.Tag := UINT_PTR(pListElement);
    //log_button.OnEvent += MakeDelegate(&OnLogoButtonEvent);
  end;

  html_text := '';
  if node.NodeData.HasChild then
  begin
    if node.NodeData.ChildVisible then
      html_text := html_text + FLevelExpandImage
    else
      html_text := html_text + FLevelCollapseImage;
    html_text := html_text + Format('<x %d>', [FLevelTextStartPos]);
  end;

  if AItem.Folder then
    html_text := html_text + node.NodeData.Text
  else
    html_text := html_text + AItem.NickName;

  nick_name := CLabelUI(FPaintManager.FindSubControlByName(pListElement, kNickNameControlName));
  if nick_name <> nil then
  begin
    if AItem.Folder then
      nick_name.SetFixedWidth(0);

    nick_name.ShowHtml := True;
    nick_name.Text := html_text;
  end;

  if (not AItem.Folder) and (not AItem.Description.IsEmpty) then
  begin
    description := CLabelUI(FPaintManager.FindSubControlByName(pListElement, kDescriptionControlName));
    if description <> nil then
    begin
      description.ShowHtml := True;
      description.Text := Format('<x 20><c #808080>%s</c>', [AItem.Description]);
    end;
  end;
  pListElement.FixedHeight := kFriendListItemNormalHeight;
  pListElement.Tag := UINT_PTR(node);

  if parent.HasChildren then
  begin
    prev := parent.LastChild;
    index := prev.NodeData.ListElment.GetIndex + 1;
  end
  else
  begin
    if parent = FRootNode then
      index := 0
    else
      index := parent.NodeData.ListElment.GetIndex + 1;
  end;
  if not AddAt(pListElement, index) then
  begin
    pListElement.CppDestroy;
    node.Free;
    node := nil;
  end;
  parent.Add(node);
  Result := node;
end;

function TFirendList.CanExpand(node: TNode): Boolean;
begin
  if (node = nil) or (node = FRootNode) then
    Result := False
  else
    Result := node.NodeData.HasChild;
end;

constructor TFirendList.Create(APaintManager: CPaintManagerUI);
begin
  inherited Create;

  FTextPadding := Rect(10, 0, 0, 0);
  FLevelTextStartPos := 10;
  FLevelExpandImage := '<i list_icon_b.png>';
  FLevelCollapseImage := '<i list_icon_a.png>';

  FPaintManager := APaintManager;
  ItemShowHtml := True;
  FDlgBuilder := CDialogBuilder.CppCreate;
  FRootNode := TNode.Create;

  FRootNode.NodeData.Level := -1;
  FRootNode.NodeData.ChildVisible := True;
  FRootNode.NodeData.HasChild := True;
  FRootNode.NodeData.ListElment := nil;
end;

destructor TFirendList.Destroy;
begin
  FDlgBuilder.CppDestroy;
  FRootNode.Free;
  inherited;
end;

procedure TFirendList.DoSelectItem;
var
  pControl: CControlUI;
  pFriendListItem: CListContainerElementUI;
  node: TNode;
  pOperatorPannel: CContainerUI;
begin
  if LastSelectIndex <> -1 then
  begin
    pControl := this.GetItemAt(LastSelectIndex);
    if pControl <> nil then
    begin
      pFriendListItem := CListContainerElementUI(pControl);
      node := TNode(Pointer(pControl.Tag));
      if (pFriendListItem <> nil) and (node <> nil) and (not node.Folder) then
      begin
        pFriendListItem.FixedHeight := kFriendListItemNormalHeight;
        pOperatorPannel := CContainerUI(FPaintManager.FindSubControlByName(pFriendListItem, kOperatorPannelControlName));
        if pOperatorPannel <> nil then
          pOperatorPannel.Hide;
      end;
    end;
  end;
  if CurSel < 0 then
    Exit;
  pControl := this.GetItemAt(CurSel);
  if pControl <> nil then
  begin
    pFriendListItem := CListContainerElementUI(pControl);
    node := TNode(Pointer(pControl.Tag));
    if (pFriendListItem <> nil) and (node <> nil) and (not node.Folder) then
    begin
      pFriendListItem.SetFixedHeight(kFriendListItemSelectedHeight);
      pOperatorPannel := CContainerUI(FPaintManager.FindSubControlByName(pFriendListItem, kOperatorPannelControlName));
      if pOperatorPannel <> nil then
        pOperatorPannel.Show;
    end;
  end;
  // 放在后面，要确定最后选择的
  inherited;
end;

procedure TFirendList.RemoveAll;
var
  I: Integer;
begin
  inherited RemoveAll;
  for I := 0 to FRootNode.Count - 1 do
    RemoveNode(FRootNode.Childs[I]);
  // 依靠 TObjectList可以达到父节类释放全线子类释放
  FRootNode.Free;
  FRootNode := TNode.Create;
  FRootNode.NodeData.Level := -1;
  FRootNode.NodeData.ChildVisible := True;
  FRootNode.NodeData.HasChild := True;
  FRootNode.NodeData.ListElment := nil;
end;

function TFirendList.RemoveNode(node: TNode): Boolean;
var
  I: Integer;
begin
  if (node = nil) or (node = FRootNode) then
    Exit(False);
  for I := 0 to node.Count - 1 do
    RemoveNode(node.Childs[I]);
  Remove(node.NodeData.ListElment);
  Result := True;
end;

procedure TFirendList.SetChildVisible(node: TNode; AVisible: Boolean);
var
  html_text: string;
  nick_name: CLabelUI;
  LBegin, LEnd, local_parent: TNode;
  I: Integer;
  control: CControlUI;
begin
  if (node = nil) or (node = FRootNode) then
    Exit;
  if node.NodeData.ChildVisible = AVisible then
    Exit;
  node.NodeData.ChildVisible := AVisible;
  html_text := '';

  if node.NodeData.HasChild then
  begin
    if node.NodeData.ChildVisible then
      html_text := html_text + FLevelExpandImage
    else
      html_text := html_text + FLevelCollapseImage;
    html_text := html_text + Format('<x %d>', [FLevelTextStartPos]);

    html_text := html_text + node.NodeData.Text;

    nick_name := CLabelUI(FPaintManager.FindSubControlByName(node.NodeData.ListElment, kNickNameControlName));
    if nick_name <> nil then
    begin
      nick_name.ShowHtml := True;
      nick_name.Text := html_text;
    end;
  end;

  if not node.NodeData.ListElment.IsVisible then
    Exit;

  if not node.HasChildren then
    Exit;
  LBegin := node.Childs[0];
  LEnd := node.LastChild;
  for I := LBegin.NodeData.ListElment.GetIndex to LEnd.NodeData.ListElment.GetIndex do
  begin
    control := this.GetItemAt(i);
    if control.ClassName.Equals(DUI_CLASS_ListContainerElementUI) then
    begin
      if AVisible then
      begin
        local_parent := TNode(Pointer(control.Tag)).Parent;
        if (local_parent.NodeData.ChildVisible) and local_parent.NodeData.ListElment.Visible then
          control.Show;
      end
      else
        control.Hide;
    end;
  end;
end;

procedure AddSkinChangedWindow;
begin
  if SkinChangedList.IndexOf(AWindow) = -1 then
    SkinChangedList.Add(AWindow);
end;

procedure SendSkinChanged;
var
  LWindow: TDuiWindowImplBase;
begin
  for LWindow in SkinChangedList do
    LWindow.OnReceive(@p);
end;


{ TColorSkinWindow }

constructor TColorSkinWindow.Create(main_frame: TXGuiFoundation; rcParentWindow: TRect);
begin
  inherited Create('ColorWnd.xml', ExtractFilePath(ParamStr(0)) + 'skin\QQRes\', UILIB_FILE);
  FMainFrame := main_frame;
  FParentWindowRect := rcParentWindow;
  CreateWindow(0, 'colorskin', WS_POPUP, WS_EX_TOOLWINDOW, 0, 0);
  Show;
end;

procedure TColorSkinWindow.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

function TColorSkinWindow.DoHandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  if uMsg = WM_KILLFOCUS then
  begin
    Close;
    Exit(1);
  end;
  Result := 0;
end;

procedure TColorSkinWindow.DoInitWindow;
var
  LSize: TSize;
begin
  inherited;
  LSize := InitSize;
  MoveWindow(Handle, FParentWindowRect.right - Lsize.cx, FParentWindowRect.top, Lsize.cx, Lsize.cy, False);
end;

procedure TColorSkinWindow.DoNotify(var Msg: TNotifyUI);
var
  pTabControl: CTabLayoutUI;
  LType, LCtlName: string;
  AdjustColorSliderR, AdjustColorSliderG, AdjustColorSliderB: CSliderUI;
  dwColor: DWORD;
  r, g, b: Byte;
  crColor: COLORREF;
begin
  LType := msg.sType;
  LCtlName := msg.pSender.Name;
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if pTabControl <> nil then
    begin
      if pTabControl.SelectIndex = 0 then
      begin
        if LCtlName.contains('colour_') then
        begin
          AdjustColorSliderR := CSliderUI(FindControl(kAdjustColorSliderRControlName));
          AdjustColorSliderG := CSliderUI(FindControl(kAdjustColorSliderGControlName));
          AdjustColorSliderB := CSliderUI(FindControl(kAdjustColorSliderBControlName));
          if (AdjustColorSliderR <> nil) and (AdjustColorSliderG <> nil) and (AdjustColorSliderB <> nil) then
          begin
            dwColor := msg.pSender.BkColor;
            AdjustColorSliderR.SetValue(GetRValue(dwColor));
            AdjustColorSliderG.SetValue(GetGValue(dwColor));
            AdjustColorSliderB.SetValue(GetBValue(dwColor));
            FMainFrame.SetBkColor(dwColor);
          end;
        end;
      end
      else if pTabControl.SelectIndex = 1 then
      begin
        Writeln(LCtlName);
      end;
    end;
  end
  else if LType.Equals(DUI_EVENT_VALUECHANGED) then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if pTabControl <> nil then
    begin
      if pTabControl.SelectIndex = 0 then
      begin
        AdjustColorSliderR := CSliderUI(FindControl(kAdjustColorSliderRControlName));
        AdjustColorSliderG := CSliderUI(FindControl(kAdjustColorSliderGControlName));
        AdjustColorSliderB := CSliderUI(FindControl(kAdjustColorSliderBControlName));
        if (AdjustColorSliderR <> nil) and (AdjustColorSliderG <> nil) and (AdjustColorSliderB <> nil) then
        begin
          if LCtlName.Equals(kAdjustColorSliderRControlName) or LCtlName.Equals(kAdjustColorSliderGControlName) or LCtlName.Equals(kAdjustColorSliderBControlName) then
          begin
            r := AdjustColorSliderR.GetValue();
            g := AdjustColorSliderG.GetValue();
            b := AdjustColorSliderB.GetValue();
            crColor := RGB(r, g, b);
            FMainFrame.SetBkColor(StrToIntDef('$FF' + IntToHex(crColor, 6), 0));
          end;
        end;
      end
      else if pTabControl.SelectIndex = 1 then
      begin
      end;
    end;
  end
  else if LType.Equals(DUI_EVENT_SELECTCHANGED) then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
    if pTabControl <> nil then
    begin
      if LCtlName.Equals(kAdjustColorControlName) then
      begin
        if pTabControl.SelectIndex <> 0 then
          pTabControl.SelectIndex := 0;
      end
      else if LCtlName.Equals(kAdjustBkControlName) then
      begin
        if pTabControl.SelectIndex <> 1 then
          pTabControl.SelectIndex := 1;
      end;
    end;
  end;
end;

var
  XGuiFoundation: TXGuiFoundation;
  hInstRich: THandle;

begin
  try
    ReportMemoryLeaksOnShutdown := True;

    hInstRich := LoadLibrary('Riched20.dll');
    CoInitialize(nil);
    OleInitialize(nil);

    SkinChangedList := TList<TDuiWindowImplBase>.Create;

    Application.Initialize;
    XGuiFoundation := TXGuiFoundation.Create;
    XGuiFoundation.CenterWindow;
    XGuiFoundation.Show;
    Application.Run;
    XGuiFoundation.Free;

    SkinChangedList.Free;

    OleUninitialize();
    CoUninitialize();
    FreeLibrary(hInstRich);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

