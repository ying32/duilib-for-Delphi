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
  DuilibHelper in 'DuilibHelper.pas';

const
  kFriendListItemNormalHeight = 32;
  kFriendListItemSelectedHeight = 50;
  kLogoButtonControlName: PChar = 'logo';
  kLogoContainerControlName: PChar = 'logo_container';
  kNickNameControlName: PChar = 'nickname';
  kDescriptionControlName: PChar = 'description';
  kOperatorPannelControlName: PChar = 'operation';

  kTabControlName: PChar = 'tabs';

  kFriendButtonControlName: PChar = 'friendbtn';
  kGroupButtonControlName: PChar = 'groupbtn';
  kMicroBlogButtonControlName: PChar = 'microblogbtn';

  kBackgroundControlName: PChar = 'bg';


  kTitleControlName: PChar = 'apptitle';
  kCloseButtonControlName: PChar = 'closebtn';
  kMinButtonControlName: PChar = 'minbtn';
  kMaxButtonControlName: PChar = 'maxbtn';
  kRestoreButtonControlName: PChar = 'restorebtn';

  kFontButtonControlName: PChar = 'fontbtn';
  kFontbarControlName: PChar = 'fontbar';
  kFontTypeControlName: PChar = 'font_type';
  kFontSizeControlName: PChar = 'font_size';
  kBoldButtonControlName: PChar = 'boldbtn';
  kItalicButtonControlName: PChar = 'italicbtn';
  KUnderlineButtonControlName: PChar = 'underlinebtn';
  kColorButtonControlName: PChar = 'colorbtn';

  kInputRichEditControlName: PChar = 'input_richedit';
  kViewRichEditControlName: PChar = 'view_richedit';

  kEmotionButtonControlName: PChar = 'emotionbtn';

  kSendButtonControlName: PChar = 'sendbtn';


  kChangeBkSkinControlName = 'bkskinbtn';
  kChangeColorSkinControlName = 'colorskinbtn';

  kEmotionRefreshTimerId = 1001;
  kEmotionRefreshInterval = 150;

type

  TFriendListItemInfo = packed record
    folder: Boolean;
    empty: Boolean;
    id: CDuiString;
    logo: CDuiString;
    nick_name: CDuiString;
    description: CDuiString;
  end;

  TSkinChangedParam = packed record
	  bkcolor: DWORD;
	  bgimage: string;
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
    myself_info_: TFriendListItemInfo;
    bk_image_index_: Integer;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    function  DoCreateControl(pstrStr: string): CControlUI; override;
  public
    procedure UpdateFriendsList;
    procedure OnPrepare(var Msg: TNotifyUI);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TChatDialog = class(TDuiWindowImplBase)
  private
    bgimage_: string;
    bkcolor_: DWORD;
    myselft_: TFriendListItemInfo;
    friend_: TFriendListItemInfo;
    emotion_timer_start_: Boolean;
    text_color_: DWORD;
    font_face_name_: string;
    function GetCurrentTimeString: string;
    procedure FontStyleChanged;
    procedure SendMsg;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(const bgimage: string; bkcolor: DWORD; myselft_info, friend_info: TFriendListItemInfo);
    destructor Destroy; override;
    procedure OnReceive(Param: Pointer); override;
    procedure OnPrepare(var Msg: TNotifyUI);
  end;

  TColorSkinWindow = class(TDuiWindowImplBase)
  private
    main_frame_: TXGuiFoundation;
    parent_window_rect_: TRect;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoInitWindow; override;
    function  DoHandleMessage(uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; override;
    procedure DoFinalMessage(hWd: HWND); override;
  public
    constructor Create(main_frame: TXGuiFoundation; rcParentWindow: TRect);
    destructor Destroy; override;
  end;

  TFirendList = class(TDuiListUI)
  private
    FPaintManager: CPaintManagerUI;
    FDlgBuilder: CDialogBuilder;
    root_node_: TNode;
    text_padding_: TRect;
    level_text_start_pos_: Integer;
    level_expand_image_: string;
    level_collapse_image_: string;
  protected
    procedure DoSelectItem; override;
  public
    constructor Create(APaintManager: CPaintManagerUI);
    destructor Destroy; override;
    function AddNode(var AItem: TFriendListItemInfo; parent: TNode): TNode;
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
    Exit(FFirned.ThisControlUI);
  end;
  Result := nil;
end;

{$REGION 'DoNotify'}
procedure TXGuiFoundation.DoNotify(var msg: TNotifyUI);
var
  left_main_pannel, hide_left_main_pannel, show_left_main_pannel: CControlUI;
  LCtlName, LType, bkimage: string;
  signature, signature_tip, search_tip, search_edit, background: CControlUI;
  pTabControl: CTabLayoutUI;
  node: TNode;
  friend_info, citer : TFriendListItemInfo;
  chatDlg: TChatDialog;
  skinparam: TSkinChangedParam;
  pControl: CControlUI;
  pFriendListItem: CListContainerElementUI;
  pOperatorPannel: CContainerUI;
  rcWindow: TRect;
begin
  inherited;
  //Writeln('DoNotify++++++++++++++++', string(Msg.sType));

  LCtlName := msg.pSender.Name;
  LType := Msg.sType;
  if LType.Equals('windowinit') then
  begin
    OnPrepare(msg);
  end else
  if SameStr(LType, 'killfocus') then
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
    end else
    if SameStr(LCtlName, 'search_edit') then
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
  end else
  if SameStr(LType, 'click') then
  begin
    if SameStr(LCtlName, 'closebtn') then
    begin
      Close;
    end else
    if SameStr(LCtlName, 'minbtn') then
    begin
      Perform(WM_SYSCOMMAND, SC_MINIMIZE);
    end else
    if SameStr(LCtlName, 'maxbtn') then
    begin
      Perform(WM_SYSCOMMAND, SC_MAXIMIZE);
    end else
    if SameStr(LCtlName, 'restorebtn') then
    begin
      Perform(WM_SYSCOMMAND, SC_RESTORE);
    end else
    if SameStr(LCtlName, 'btnleft') then
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
    end else
    if SameStr(LCtlName, 'btnright') then
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
    end else
    if SameStr(LCtlName, 'signaturetip') then
    begin
      msg.pSender.Hide;
      signature := FindControl('signature');
      if signature <> nil then
      begin
        signature.Text := msg.pSender.Text;
        signature.Show;
      end;
    end else
    if SameStr(LCtlName, 'search_tip') then
    begin
      msg.pSender.Hide;
      search_edit := FindControl('search_edit');
      if search_edit <> nil then
      begin
        search_edit.Text := msg.pSender.Text;
        search_edit.Show;
      end;
    end else
    if LCtlName.Equals(kChangeBkSkinControlName) then
    begin
      background := FindControl(kBackgroundControlName);
    end else
    if LCtlName.Equals(kChangeColorSkinControlName) then
    begin
			GetWindowRect(Handle, rcWindow);
			rcWindow.top := rcWindow.top + msg.pSender.GetPos.bottom;
      TColorSkinWindow.Create(Self, rcWindow);
    end;
  end else
  if SameStr(LType, 'selectchanged') then
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
  end else
  if SameStr(LType, 'itemactivate') then
  begin

    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
		if pTabControl <> nil then
		begin
			if pTabControl.SelectIndex = 0 then
			begin
				if (FFirned.This <> nil) and (FFirned.This.GetItemIndex(msg.pSender) <> -1) then
				begin
					if msg.pSender.ClassName = 'ListContainerElementUI' then
					begin
						node := TNode(Pointer(msg.pSender.Tag));
						background := FindControl(kBackgroundControlName);
						if (not FFirned.CanExpand(node)) and (background <> nil) then
						begin
              FillChar(friend_info, SizeOf(friend_info), #0);
              for citer in FFirendList do
							begin
								 if citer.id = node.data().value then
                 begin
                   friend_info := citer;
									 break;
								 end;
							end;
              bkimage := '';
							if background.BkImage <> '' then
							  bkimage := Format('bg%d.png', [bk_image_index_]);

              chatDlg := TChatDialog.Create(bkimage, background.BkColor,  myself_info_, friend_info);
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
  end else
  if SameStr(LType, 'itemclick') then
  begin
    pTabControl := CTabLayoutUI(FindControl(kTabControlName));
		if pTabControl <> nil then
		begin
			if pTabControl.GetCurSel() = 0 then
			begin
				if (FFirned.This <> nil) and (FFirned.This.GetItemIndex(msg.pSender) <> -1) then
			  begin
					if msg.pSender.GetClass() = 'ListContainerElementUI' then
				  begin
						node := TNode(Pointer(msg.pSender.GetTag()));
						if FFirned.CanExpand(node) then
							FFirned.SetChildVisible(node, not node.data().child_visible_);
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


  end else
  if SameStr(LType, 'itemselect') then
  begin
    // firend list
    if msg.pSender = FFirned.This then
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
    background.BkImage := Format('file=''bg%d.png'' corner=''600,200,1,1''', [bk_image_index_]);
  UpdateFriendsList;
end;

procedure TXGuiFoundation.UpdateFriendsList;
var
  item: TFriendListItemInfo;
  root_parent, root_parent2, root_parent3, root_parent4: TNode;
  I: Integer;
begin
  if FindControl('friends') <> nil then
  begin
    if FFirendList.Count > 0 then
      FFirendList.Clear;
    if FFirned.Count > 0 then
     FFirned.RemoveAll;

 		item.id := '0';
		item.folder := True;
		item.empty := False;
		item.nick_name := '我的好友';
    root_parent := FFirned.AddNode(item, nil);
    FFirendList.Add(item);

    item.id := '1';
		item.folder := false;
		item.logo := 'man.png';
		item.nick_name := 'ying32';
		item.description := '1444386932@qq.com';

    myself_info_ := item;
    FFirned.AddNode(item, root_parent);
		FFirendList.Add(item);

    item.id := '2';
		item.folder := false;
		item.logo := 'default.png';
		item.nick_name := 'achellies';
		item.description := 'achellies@hotmail.com';
		FFirned.AddNode(item, root_parent);
		FFirendList.Add(item);

    item.id := '2';
    item.folder := false;
    item.logo := 'default.png';
    item.nick_name := 'wangchyz';
    item.description := 'wangchyz@gmail.com';
    FFirned.AddNode(item, root_parent);
    FFirendList.Add(item);

    for I := 1 to 5 do
    begin
      item.id := '2';
      item.folder := false;
      item.logo := 'default.png';
      item.nick_name := 'duilib';
      item.description := 'www.duilib.com';
      FFirned.AddNode(item, root_parent);
      FFirendList.Add(item);
    end;

	  item.id := '3';
		item.folder := true;
		item.empty := false;
		item.nick_name := '企业好友';
		root_parent2 := FFirned.AddNode(item, nil);
		FFirendList.Add(item);


    item.id := '4';
    item.folder := false;
    item.logo := 'icon_home.png';
    item.nick_name := '腾讯企业QQ的官方展示号';
    item.description := '';
    FFirned.AddNode(item, root_parent2);
    FFirendList.Add(item);


		item.id := '5';
		item.folder := true;
		item.empty := false;
		item.nick_name := '陌生人';
		root_parent3 := FFirned.AddNode(item, nil);
		FFirendList.Add(item);

		item.id := '6';
		item.folder := true;
		item.empty := false;
		item.nick_name := '黑名单';
		root_parent4 := FFirned.AddNode(item, nil);
		FFirendList.Add(item);


  end;
end;


{ TChatDialog }

constructor TChatDialog.Create(const bgimage: string; bkcolor: DWORD;
  myselft_info, friend_info: TFriendListItemInfo);
begin
  inherited Create('chatbox.xml', ExtractFilePath(ParamStr(0)) + 'skin\QQRes\', UILIB_FILE);
  bgimage_ := bgimage;
  bkcolor_ := bkcolor;
  myselft_ := myselft_info;
  friend_ := friend_info;
  text_color_ := $FF000000;
  font_face_name_ := '微软雅黑';
  CreateWindow(0, 'ChatDialog', UI_WNDSTYLE_FRAME or WS_POPUP, 0, 0, 0, 0, 0, 0);
end;

destructor TChatDialog.Destroy;
begin

  inherited;
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
  if LType.Equals('windowinit') then
		OnPrepare(msg)
  else
  if SameStr(LType, 'click') then
  begin
    if SameStr(LCtlName, kCloseButtonControlName) then
      Close
    else
    if SameStr(LCtlName, kMinButtonControlName) then
      Perform(WM_SYSCOMMAND, SC_MINIMIZE)
    else
    if SameStr(LCtlName, kMaxButtonControlName) then
      Perform(WM_SYSCOMMAND, SC_MAXIMIZE)
    else
    if SameStr(LCtlName, kRestoreButtonControlName) then
      Perform(WM_SYSCOMMAND, SC_RESTORE)
    else if LCtlName.Equals(kSendButtonControlName) then
      SendMsg
    else if LCtlName.Equals(kFontButtonControlName) then
    begin
      pFontbar := CContainerUI(FindControl(kFontbarControlName));
			if pFontbar <> nil then
				pFontbar.Visible := not pFontbar.Visible;
    end else
    if LCtlName.Equals(kEmotionButtonControlName) then
    begin

    end;
  end else
  if LType.Equals('return') then
  begin
    if LCtlName.Equals(kInputRichEditControlName) then
       SendMsg;
  end else
  if LType.Equals('itemselect') then
  begin
    if LCtlName.Equals(kFontTypeControlName) then
    begin
      font_type := CComboUI(msg.pSender);
			if font_type <> nil then
      begin
				font_face_name_ := font_type.Text;
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
    background.BkImage := Format('file=''%s'' corner=''600,200,1,1''', [bgimage_]);
    background.BkColor := bkcolor_;
  end;
  log_button := CButtonUI(FindControl(kLogoButtonControlName));
  if log_button <> nil then
		log_button.BkImage := friend_.logo;

	nick_name := FindControl(kNickNameControlName);
	if nick_name <> nil then
		nick_name.Text := friend_.nick_name;

	desciption := FindControl(kDescriptionControlName);
	if desciption <> nil then
		desciption.Text := friend_.description;

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
    bgimage_ := L^.bgimage;
    bkcolor_ := L^.bkcolor;
    background := FindControl(kBackgroundControlName);
    if background <> nil then
    begin
      if not bgimage_.IsEmpty() then
        background.BkImage := Format('"file=''%s'' corner=''600,200,1,1''"', [bgimage_])
      else
        background.BkImage := '';
      background.BkColor := bkcolor_;
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
  if pRichEdit = nil then Exit;
  pRichEdit.SetFocus();
  sText := pRichEdit.GetTextRange(0, pRichEdit.GetTextLength);
  if sText.IsEmpty then Exit;
  pRichEdit.Text := '';

  pRichEdit := CRichEditUI(FindControl(kViewRichEditControlName));
  if pRichEdit = nil then Exit;

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

function TFirendList.AddNode(var AItem: TFriendListItemInfo;
  parent: TNode): TNode;
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
		parent := root_node_;

  if not FDlgBuilder.GetMarkup.IsValid then
    pListElement := Pointer(FDlgBuilder.Create('friend_list_item.xml', nil, nil, FPaintManager))
  else
    pListElement := Pointer(FDlgBuilder.Create(nil, FPaintManager));
  if pListElement = nil then Exit;

  node := TNode.Create;

  node.data().level_ := parent.data().level_ + 1;

	if AItem.folder then
		node.data().has_child_ := not AItem.empty
	else
		node.data().has_child_ := false;
	node.data().folder_ := AItem.folder;

	node.data().child_visible_ := node.data().level_ = 0;
	node.data().child_visible_ := false;

	node.data().text_ := AItem.nick_name;
	node.data().value := AItem.id;
	node.data().list_elment_ := pListElement;

	if not parent.data().child_visible_ then
		pListElement.SetVisible(false);

	if (parent <> root_node_) and (not parent.data().list_elment_.IsVisible()) then
		pListElement.SetVisible(false);

  rcPadding := text_padding_;
	for i := 0 to node.data().level_ - 1 do
		rcPadding.left := rcPadding.left + level_text_start_pos_;

  pListElement.SetPadding(rcPadding);


	log_button := CButtonUI(FPaintManager.FindSubControlByName(pListElement, kLogoButtonControlName));
	if log_button <> nil then
	begin
		if (not AItem.folder) and  (not AItem.logo.IsEmpty()) then
		begin
			log_button.SetNormalImage(PChar(string(AItem.logo)));
		end	else
		begin
			logo_container := CContainerUI(FPaintManager.FindSubControlByName(pListElement, kLogoContainerControlName));
			if logo_container <> nil then
				logo_container.SetVisible(False);
		end;
    CControlUI(log_button).SetTag(UINT_PTR(pListElement));
    //log_button.OnEvent += MakeDelegate(&OnLogoButtonEvent);
	end;

  html_text := '';
	if node.data().has_child_ then
	begin
		if node.data().child_visible_ then
			html_text := html_text + level_expand_image_
		else
			html_text := html_text + level_collapse_image_;
    html_text := html_text + Format('<x %d>', [level_text_start_pos_]);
  end;

  if AItem.folder then
		html_text := html_text + node.data().text_
  else
    html_text := html_text + AItem.nick_name;


  nick_name := CLabelUI(FPaintManager.FindSubControlByName(pListElement, kNickNameControlName));
  if nick_name <> nil then
  begin
    if AItem.folder then
			CControlUI(nick_name).SetFixedWidth(0);

		nick_name.SetShowHtml(True);
		nick_name.SetText(PChar(html_text));
  end;

  if (not AItem.folder) and (not AItem.description.IsEmpty()) then
  begin
    description := CLabelUI(FPaintManager.FindSubControlByName(pListElement, kDescriptionControlName));
    if description <> nil then
    begin
      description.SetShowHtml(True);
			description.SetText(PChar(Format('<x 20><c #808080>%s</c>', [string(AItem.description)])));
    end;
  end;
  pListElement.SetFixedHeight(kFriendListItemNormalHeight);
	pListElement.SetTag(UINT_PTR(node));
  if parent.has_children then
	begin
		prev := parent.get_last_child();
		index := prev.data().list_elment_.GetIndex() + 1;
	end
	else
	begin
		if parent = root_node_ then
			index := 0
		else
			index := parent.data().list_elment_.GetIndex() + 1;
	end;
  if not AddAt(Pointer(pListElement), index) then
	begin
		pListElement.CppDestroy;
		node.Free;
		node := nil;
	end;
	parent.add_child(node);
	Result := node;
end;

function TFirendList.CanExpand(node: TNode): Boolean;
begin
  if (node = nil) or (node = root_node_) then
		Result := False
  else
	  Result := node.data().has_child_;
end;

constructor TFirendList.Create(APaintManager: CPaintManagerUI);
begin
  inherited Create;

  text_padding_ := Rect(10, 0, 0, 0);
  level_text_start_pos_ := 10;
  level_expand_image_ := '<i list_icon_b.png>';
	level_collapse_image_ := '<i list_icon_a.png>';

  FPaintManager := APaintManager;
  ItemShowHtml := True;
  FDlgBuilder := CDialogBuilder.CppCreate;
  root_node_ := TNode.Create;

	root_node_.data().level_ := -1;
	root_node_.data().child_visible_ := true;
	root_node_.data().has_child_ := true;
	root_node_.data().list_elment_ := nil;
end;

destructor TFirendList.Destroy;
begin
  FDlgBuilder.CppDestroy;
  root_node_.Free;
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
    pControl := This.GetItemAt(LastSelectIndex);
    if pControl <> nil then
    begin
      pFriendListItem := CListContainerElementUI(pControl);
      node := TNode(Pointer(pControl.Tag));
      if (pFriendListItem <> nil) and (node <> nil) and (not node.folder()) then
      begin
        pFriendListItem.FixedHeight := kFriendListItemNormalHeight;
        pOperatorPannel := CContainerUI(FPaintManager.FindSubControlByName(pFriendListItem, kOperatorPannelControlName));
        if pOperatorPannel <> nil then
          pOperatorPannel.Hide;
      end;
    end;
  end;
  if CurSel < 0 then Exit;
  pControl := This.GetItemAt(CurSel);
  if pControl <> nil then
  begin
    pFriendListItem := CListContainerElementUI(pControl);
    node := TNode(Pointer(pControl.GetTag()));
    if (pFriendListItem <> nil) and (node <> nil) and (not node.folder()) then
    begin
      pFriendListItem.SetFixedHeight(kFriendListItemSelectedHeight);
      pOperatorPannel := CContainerUI(FPaintManager.FindSubControlByName(pFriendListItem, kOperatorPannelControlName));
      if pOperatorPannel <> nil then
        pOperatorPannel.SetVisible(true);
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
	for I := 0 to root_node_.num_children() - 1 do
		RemoveNode(root_node_.child(I));
  // 依靠 TObjectList可以达到父节类释放全线子类释放
	root_node_.Free;
	root_node_ := TNode.Create;
	root_node_.data().level_ := -1;
	root_node_.data().child_visible_ := true;
	root_node_.data().has_child_ := true;
	root_node_.data().list_elment_ := nil;
end;

function TFirendList.RemoveNode(node: TNode): Boolean;
var
  I: Integer;
begin
  if (node = nil) or (node = root_node_) then Exit(False);
	for I := 0 to node.num_children() - 1 do
		RemoveNode(node.child(I));
	Remove(Pointer(node.data().list_elment_));
//	node.parent().remove_child(node);
//	node.Free;
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
  if (node = nil) or (node = root_node_) then
    Exit;

	if node.data().child_visible_ = AVisible then
		Exit;

	node.data().child_visible_ := AVisible;
  html_text := '';
	if node.data().has_child_ then
	begin
		if node.data().child_visible_ then
			html_text := html_text + level_expand_image_
		else
			html_text := html_text + level_collapse_image_;
		html_text := html_text + Format('<x %d>', [level_text_start_pos_]);

		html_text := html_text + node.data().text_;

		nick_name := CLabelUI(FPaintManager.FindSubControlByName(Pointer(node.data().list_elment_), kNickNameControlName));
		if nick_name <> nil then
		begin
			nick_name.ShowHtml := True;
			nick_name.Text := html_text;
		end;
	end;

	if not node.data().list_elment_.IsVisible then
		Exit;

	if not node.has_children() then
		Exit;

	LBegin := node.child(0);
	LEnd := node.get_last_child();
	for I := LBegin.data.list_elment_.GetIndex to LEnd.data.list_elment_.GetIndex - 1 do
	begin
		control := Self.This.GetItemAt(i);
		if  control.ClassName = 'ListContainerElementUI' then
		begin
			if AVisible then
			begin
				local_parent := TNode(Pointer(control.Tag)).parent();
				if (local_parent.data().child_visible_) and local_parent.data().list_elment_.Visible then
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

constructor TColorSkinWindow.Create(main_frame: TXGuiFoundation;
  rcParentWindow: TRect);
begin
  inherited Create('ColorWnd.xml', ExtractFilePath(ParamStr(0)) + 'skin\QQRes\', UILIB_FILE);
  main_frame_ := main_frame;
  parent_window_rect_ := rcParentWindow;
  CreateWindow(0, 'colorskin', WS_POPUP, WS_EX_TOOLWINDOW, 0, 0, 0, 0, 0);
  Show;
end;

destructor TColorSkinWindow.Destroy;
begin
  Writeln('Free....');
end;

procedure TColorSkinWindow.DoFinalMessage(hWd: HWND);
begin
  inherited;
  Free;
end;

function TColorSkinWindow.DoHandleMessage(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
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
  Lsize := TSize.Create(140, 165); //PaintManagerUI.GetInitSize;
  MoveWindow(Handle, parent_window_rect_.right - Lsize.cx, parent_window_rect_.top, Lsize.cx, Lsize.cy, False);
end;

procedure TColorSkinWindow.DoNotify(var Msg: TNotifyUI);
begin
  Writeln(msg.sType.ToString);

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
    readln;
  except
    on E: Exception do
     // Writeln(E.ClassName, ': ', E.Message);
  end;
end.
