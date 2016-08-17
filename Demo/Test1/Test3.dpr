program Test3;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

{$R *.res}

uses
  Windows,
  Messages,
  MultiMon,
  Classes,
  Forms,
  SysUtils,
  Duilib;

const
  testUIXML = '';


procedure RectOffset(var ARect: TRect; const DX, DY: Integer);
begin
  Inc(ARect.Left, DX);
  Inc(ARect.Top, DY);
  Inc(ARect.Right, DX);
  Inc(ARect.Bottom, DY);
end;


type

  TDuiNotifyEvent = procedure(Sender: TObject; var Msg: TNotifyUI) of object;
  TDuiMessageEvent = procedure(Sender: TObject; var Msg: TMessage; var bHandled: Boolean) of object;
  TDuiCreateControlEvent = procedure(Sender: TObject; const AName: string) of object;

  TSkinKind = (skFile, skZip, skResource, skZipResource);

  TDDuiForm = class(TComponent)
  private
    FNotifyUI: INotifyUI;
	  FMessageFilterUI: IMessageFilterUI;
    FDialogBuilderCallback: IDialogBuilderCallback;
    FNotifyPump: CNotifyPump;

    FOldWndPro: TWndMethod;

    FPaintMgr: CPaintManagerUI;
    FForm: TForm;
    FSkinFolder: string;
    FIsNcDown: Boolean;
    FHandle: HWND;
    FOnNotify: TDuiNotifyEvent;
    FOnMessage: TDuiMessageEvent;
    FOnCreateControl: TDuiCreateControlEvent;
    FOnClick: TDuiNotifyEvent;
    FOnInitWindow: TNotifyEvent;
    FSkinZipFile: string;
    FSkinKind: TSkinKind;
    FSkinXml: TStrings;
    FSkinXmlFile: string;
    FSkinResName: string;


    procedure NewWndPro(var Msg: TMessage);
    procedure DoNcHitTest(var Msg: TMessage); //message WM_NCHITTEST;
    procedure DoNcActivate(var Msg: TMessage);// message WM_NCACTIVATE;
    procedure DoNcCalcSize(var Msg: TMessage);// message WM_NCCALCSIZE;
    procedure DoSize(var Msg: TMessage); //message WM_SIZE;
    procedure DoSysCommand(var Msg: TMessage); //message WM_SYSCOMMAND;
    procedure DoGetMinMaxInfo(var Msg: TMessage); //message WM_GETMINMAXINFO;
    procedure DoNcDestroy(var Msg: TMessage); // message WM_NCDESTROY;
    procedure DuiMessageHandler(uMsg: UINT; wParam: WPARAM; lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT);

    function IsDesigning: Boolean;
    procedure SetSkinXml(const Value: TStrings); {$IFDEF SupportInline}inline;{$ENDIF}
  protected
    procedure Click(var Msg: TNotifyUI); virtual;
    procedure Notify(var Msg: TNotifyUI); virtual;
    procedure CreateControl(pstrClass: string); virtual;
    procedure MessageHandler(var Msg: TMessage; var bHandled: Boolean); virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitUI;
    procedure Close;
    function Perform(uMsg: UINT; wParam: WPARAM = 0; lParam: LPARAM = 0): Boolean;
  public
    property PaintMgr: CPaintManagerUI read FPaintMgr;
    property Form: TForm read FForm;
    property Handle: HWND read FHandle;
  published
    property SkinFolder: string read FSkinFolder write FSkinFolder;
    property SkinXmlFile: string read FSkinXmlFile write FSkinXmlFile;
    property SkinZipFile: string read FSkinZipFile write FSkinZipFile;
    property SkinResName: string read FSkinResName write FSkinResName;
    property SkinKind: TSkinKind read FSkinKind write FSkinKind;
    property SkinXml: TStrings read FSkinXml write SetSkinXml;

    property OnInitWindow: TNotifyEvent read FOnInitWindow write FOnInitWindow;
    property OnNotify: TDuiNotifyEvent read FOnNotify write FOnNotify;
    property OnMessage: TDuiMessageEvent read FOnMessage write FOnMessage;
    property OnClick: TDuiNotifyEvent read FOnClick write FOnClick;
    property OnCreateControl: TDuiCreateControlEvent read FOnCreateControl write FOnCreateControl;
  end;

{ TWindowImplBase }

procedure TDDuiForm.Click(var Msg: TNotifyUI);
var
  sCtrlName: string;
begin
	sCtrlName := Msg.pSender.Name;
	if sCtrlName = 'closebtn' then
    Close
	else if sCtrlName = 'minbtn' then
    Perform(WM_SYSCOMMAND, SC_MINIMIZE)
	else if sCtrlName = 'maxbtn' then
	  Perform(WM_SYSCOMMAND, SC_MAXIMIZE)
	else if sCtrlName = 'restorebtn' then
    Perform(WM_SYSCOMMAND, SC_RESTORE);
  if Assigned(FOnClick) then
    FOnClick(Self, Msg);
end;

procedure TDDuiForm.Close;
begin
  FForm.Close;
end;

constructor TDDuiForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSkinResName := 'DefaultSkin';
  FSkinKind := skFile;

  FNotifyPump := CNotifyPump.CppCreate;
  FNotifyUI := INotifyUI.Create(Notify);
  FMessageFilterUI := IMessageFilterUI.Create(DuiMessageHandler);
  FDialogBuilderCallback := IDialogBuilderCallback.Create(CreateControl);

  FSkinXml := TStringList.Create;

  FForm := TForm.Create(Application);
  FHandle := FForm.Handle;
  FOldWndPro := FForm.WindowProc;
  FForm.WindowProc := NewWndPro;

  FPaintMgr := CPaintManagerUI.CppCreate;
end;

destructor TDDuiForm.Destroy;
begin
  FPaintMgr.CppDestroy;
  FForm.Free;

  FSkinXml.Free;

  FDialogBuilderCallback.Free;
  FMessageFilterUI.Free;
  FNotifyUI.Free;
  FNotifyPump.CppDestroy;
  inherited;
end;

procedure TDDuiForm.DoGetMinMaxInfo(var Msg: TMessage);
var
  lpMMI: PMinMaxInfo;
  oMonitor: TMonitorInfo;
  rcWork, rcMonitor: TRect;
begin
	lpMMI := PMinMaxInfo(Msg.LParam);
  FillChar(oMonitor, SizeOf(oMonitor), #0);
  oMonitor.cbSize := SizeOf(oMonitor);

  GetMonitorInfo(MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST), @oMonitor);
	rcWork := oMonitor.rcWork;
	rcMonitor := oMonitor.rcMonitor;
  RectOffset(rcWork, -oMonitor.rcMonitor.Left, -oMonitor.rcMonitor.Top);
	// 计算最大化时，正确的原点坐标
	lpMMI^.ptMaxPosition.X	:= rcWork.Left;
	lpMMI^.ptMaxPosition.Y	:= rcWork.Top;

	lpMMI^.ptMaxTrackSize.X := rcWork.Right - rcWork.Left;
	lpMMI^.ptMaxTrackSize.Y := rcWork.Bottom - rcWork.Top;

	lpMMI^.ptMinTrackSize.X := FPaintMgr.GetMinInfo.cx;
	lpMMI^.ptMinTrackSize.Y := FPaintMgr.GetMinInfo.cy;

  Msg.Result := 0
end;

procedure TDDuiForm.DoNcActivate(var Msg: TMessage);
begin
  Msg.Result := LRESULT(Msg.WParam = 0);
end;

procedure TDDuiForm.DoNcCalcSize(var Msg: TMessage);
var
  LPRect: PRect;
  LPParam: PNCCalcSizeParams;
  oMonitor: TMonitorInfo;
  rcWork, rcMonitor: TRect;
begin
	if Msg.WParam <> 0 then
	begin
	  LPParam := PNCCalcSizeParams(Msg.LParam);
		LPRect := @LPParam^.rgrc[0];
	end	else
		LPRect := PRect(Msg.LParam);

  if IsZoomed(Handle) then
  begin
    FillChar(oMonitor, SizeOf(oMonitor), #0);
    oMonitor.cbSize := sizeof(oMonitor);
    GetMonitorInfo(MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST), @oMonitor);
    rcWork := oMonitor.rcWork;
    rcMonitor := oMonitor.rcMonitor;

    RectOffset(rcWork, -oMonitor.rcMonitor.Left, -oMonitor.rcMonitor.Top);

    LPRect^.Right := LPRect^.Left + (rcWork.Right - rcWork.Left);
    LPRect^.Bottom := LPRect^.Top + (rcWork.Bottom - rcWork.Top);
    Msg.Result := WVR_REDRAW;
    Exit;
  end;
	Msg.Result := 0;
end;

procedure TDDuiForm.DoNcDestroy(var Msg: TMessage);
begin
  if Assigned(FPaintMgr) then
  begin
    FPaintMgr.RemovePreMessageFilter(FMessageFilterUI);
    FPaintMgr.RemoveNotifier(FNotifyUI);
    FPaintMgr.ReapObjects(FPaintMgr.GetRoot);
  end;
end;

procedure TDDuiForm.DoNcHitTest(var Msg: TMessage);
var
  pt: TPoint;
  rcClient, rcSizeBox, rcCaption: TRect;
  pControl: CControlUI;
  LClassName: string;
begin
  Msg.Result := HTCLIENT;
	pt.x := TWMMouse(Msg).XPos;
  pt.y := TWMMouse(Msg).YPos;
	ScreenToClient(Handle, pt);
	GetClientRect(Handle, rcClient);
	if not IsZoomed(Handle) then
	begin
		rcSizeBox := FPaintMgr.GetSizeBox;
		if pt.Y < rcClient.Top + rcSizeBox.Top then
		begin
			if pt.X < rcClient.Left + rcSizeBox.Left then
      begin
        Msg.Result := HTTOPLEFT;
        Exit;
      end;
			if pt.X > rcClient.Right - rcSizeBox.Right then
      begin
        Msg.Result := HTTOPRIGHT;
        Exit;
      end;
			Msg.Result := HTTOP;
      Exit;
		end
		else if pt.Y > rcClient.Bottom - rcSizeBox.Bottom then
		begin
			if pt.X < rcClient.Left + rcSizeBox.Left then
      begin
        Msg.Result := HTBOTTOMLEFT;
        Exit;
      end;
			if pt.X > rcClient.Right - rcSizeBox.Right then
      begin
        Msg.Result := HTBOTTOMRIGHT;
        Exit;
      end;
			Msg.Result := HTBOTTOM;
      Exit;
		end;
		if pt.X < rcClient.Left + rcSizeBox.Left then
    begin
      Msg.Result := HTLEFT;
      Exit;
    end;
		if pt.X > rcClient.Right - rcSizeBox.Right then
    begin
      Msg.Result := HTRIGHT;
      Exit;
    end;
	end;

  rcCaption := FPaintMgr.GetCaptionRect;
	if (pt.X >= rcClient.Left + rcCaption.Left) and (pt.X < rcClient.Right - rcCaption.Right) and
		 (pt.Y >= rcCaption.top) and (pt.Y < rcCaption.bottom) then
  begin
    pControl := FPaintMgr.FindControl(pt);
    LClassName := '';
    if pControl <> nil then
      LClassName := pControl.GetClass;
    if (LClassName <> 'ButtonUI') and
       (LClassName <> 'OptionUI') and
       (LClassName <> 'TextUI') then
    begin
      Msg.Result := HTCAPTION;
      Exit;
    end;
  end;
end;

procedure TDDuiForm.DoSize(var Msg: TMessage);
var
  szRoundCorner: TSize;
  rcWnd: TRect;
  LhRgn: HRGN;
begin
  szRoundCorner := FPaintMgr.GetRoundCorner;
	if IsIconic(Handle) and ((szRoundCorner.cx <> 0) or (szRoundCorner.cy <> 0)) then
  begin
		GetWindowRect(Handle, rcWnd);
    RectOffset(rcWnd, -rcWnd.Left, -rcWnd.Top);
    Inc(rcWnd.Right);
    Inc(rcWnd.Bottom);
		LhRgn := CreateRoundRectRgn(rcWnd.Left, rcWnd.Top, rcWnd.Right, rcWnd.Bottom, szRoundCorner.cx, szRoundCorner.cy);
		SetWindowRgn(Handle, LhRgn, True);
		DeleteObject(LhRgn);
	end;
	Msg.Result := 0;
end;

procedure TDDuiForm.DoSysCommand(var Msg: TMessage);
var
  bZoomed: Boolean;
  lRes: LRESULT;
  pbtnMax, pbtnRestore: CControlUI;
begin
  if Msg.WParam = SC_CLOSE then
  begin
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Msg.Result := 0;
    Exit;
  end;
  bZoomed := IsZoomed(Handle);
  lRes := 0;
  if Assigned(FOldWndPro) then
  begin
    FOldWndPro(Msg);
    lRes := Msg.Result;
  end;
  if IsZoomed(Handle) <> bZoomed then
  begin
    pbtnMax := PaintMgr.FindControl('maxbtn');         // max button
    pbtnRestore := PaintMgr.FindControl('restorebtn'); // restore button
    // toggle status of max and restore button
    if Assigned(pbtnMax) and Assigned(pbtnRestore) then
    begin
      pbtnMax.Visible := True = bZoomed;
      pbtnRestore.Visible := False = bZoomed;
    end;
  end;
  Msg.Result := lRes;
end;

procedure TDDuiForm.InitUI;
var
  builder: CDialogBuilder;
  LResourcePath: string;
  pRoot: CControlUI;
  LResStream: TResourceStream;
begin
  FPaintMgr.Init(Handle);
  FPaintMgr.AddMessageFilter(FMessageFilterUI);
  builder := CDialogBuilder.CppCreate;
  try
    LResourcePath := FPaintMgr.GetResourcePath;
    if LResourcePath = '' then
      LResourcePath := ExtractFilePath(ParamStr(0)) + FSkinFolder;
    FPaintMgr.SetResourcePath(LResourcePath);
    case FSkinKind of
      skZip:
        FPaintMgr.SetResourceZip(SkinZipFile, True);
      skZipResource:
        begin
          LResStream := TResourceStream.Create(FPaintMgr.GetResourceDll, FSkinResName, 'ZIPRES');
          try
            if LResStream.Size <> 0 then
              FPaintMgr.SetResourceZip(LResStream.Memory, LResStream.Size)
            else Exit;
          finally
            LResStream.Free;
          end;
        end;
    end;
    if (FSkinXml.Text <> '') and (FSkinKind = skResource) then
      pRoot := builder.Create(FSkinXml.Text, 'xml', FDialogBuilderCallback, FPaintMgr)
    else
    begin
      if FSkinKind = skResource then
        pRoot := builder.Create(FSkinXmlFile, 'xml', FDialogBuilderCallback, FPaintMgr)
      else
        pRoot := builder.Create(FSkinXmlFile, '', FDialogBuilderCallback, FPaintMgr);
    end;
    if pRoot = nil then
    begin
      raise Exception.Create('加载资源文件失败');
      Exit;
    end;
    FPaintMgr.AttachDialog(pRoot);
    FPaintMgr.AddNotifier(FNotifyUI);
  finally
    builder.CppDestroy;
  end;
  if Assigned(FOnInitWindow) then
    FOnInitWindow(Self);
end;

function TDDuiForm.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

procedure TDDuiForm.Loaded;
begin
  inherited;
  if not IsDesigning then
    InitUI;
end;

procedure TDDuiForm.MessageHandler(var Msg: TMessage; var bHandled: Boolean);
begin
  if Assigned(FOnMessage) then
    FOnMessage(Self, Msg, bHandled);
end;

procedure TDDuiForm.NewWndPro(var Msg: TMessage);
begin
  case Msg.Msg of
    WM_NCACTIVATE:
      DoNcActivate(Msg);
    WM_NCCALCSIZE:
      DoNcCalcSize(Msg);
    WM_SIZE:
      DoSize(Msg);
    WM_SYSCOMMAND:
      DoSysCommand(Msg);
    WM_NCHITTEST:
      DoNcHitTest(Msg);
    WM_GETMINMAXINFO:
      DoGetMinMaxInfo(Msg);
    WM_NCDESTROY:
      DoNcDestroy(Msg);
  end;
  if FPaintMgr.MessageHandler(Msg.Msg, Msg.WParam, Msg.LParam, Msg.Result) then
	begin
    if Msg.Msg = WM_SETCURSOR then
      Exit;
  end;
  // 解决调整边框时无法收WM_NCLBUTTONUP消息
  if Msg.Msg = WM_NCLBUTTONDOWN then
    FIsNcDown := True
  else if Msg.Msg = WM_NCLBUTTONUP then
  begin
    FIsNcDown := False;
    ReleaseCapture;
  end;
  if (Msg.Msg = WM_EXITSIZEMOVE) and FIsNcDown then
    Perform(WM_NCLBUTTONUP, HTCAPTION);

  case Msg.Msg of
    WM_NCCALCSIZE,
    WM_NCHITTEST,
    WM_NCPAINT,
    WM_NCACTIVATE,
    WM_GETMINMAXINFO:
  else
    if Assigned(FOldWndPro) then
      FOldWndPro(Msg);
  end;
end;

procedure TDDuiForm.Notify(var Msg: TNotifyUI);
begin
  if Assigned(FOnNotify) then
    FOnNotify(Self, Msg);
  Click(Msg);
  FNotifyPump.NotifyPump(Msg);
end;

procedure TDDuiForm.CreateControl(pstrClass: string);
begin
  if Assigned(FOnCreateControl) then
    FOnCreateControl(Self, pstrClass);
end;

procedure TDDuiForm.DuiMessageHandler(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM; var bHandled: Boolean; var Result: LRESULT);
var
  LMsg: TMessage;
begin
  LMsg.Msg := uMsg;
  LMsg.WParam := wParam;
  LMsg.LParam := lParam;
  LMsg.Result := 0;
  MessageHandler(LMsg, bHandled);
  Result := LMsg.Result;
end;

function TDDuiForm.Perform(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): Boolean;
begin
  Result := PostMessage(Handle, uMsg, wParam, lParam);
end;

procedure TDDuiForm.SetSkinXml(const Value: TStrings);
begin
  FSkinXml.Assign(Value);
end;

var
  gTest: TDDuiForm;

begin
  try
    Application.MainFormOnTaskBar := True;
    CPaintManagerUI.SetInstance(HInstance);
    gTest := TDDuiForm.Create(nil);
    gTest.SkinFolder := 'skin\QQNewRes';
    gTest.SkinXmlFile := 'login.xml';
    gTest.InitUI;
    gTest.Form.Show;
    CPaintManagerUI.MessageLoop;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
