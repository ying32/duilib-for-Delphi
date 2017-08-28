program Cef3Browser;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Duilib,
  DuiConst,
  DuiWindowImplBase,
  ceflib;

type

  TCustomClient = class(TCefClientOwn)
  private
    FLifeSpan: ICefLifeSpanHandler;
    FOnBrwCreate: TNotifyEvent;
  protected
    function GetLifeSpanHandler: ICefLifeSpanHandler; override;
    procedure FXOnBrwCreate(Sender: TObject);
  public
    constructor Create; override;
  public
    property OnBrwCreate: TNotifyEvent read FOnBrwCreate write FOnBrwCreate;
  end;

  TCustomLifeSpan = class(TCefLifeSpanHandlerOwn)
  private
    FOnBrwCreate: TNotifyEvent;
  protected
    procedure OnAfterCreated(const browser: ICefBrowser); override;
    procedure OnBeforeClose(const browser: ICefBrowser); override;
  public
    property OnBrwCreate: TNotifyEvent read FOnBrwCreate write FOnBrwCreate;
  end;

  TCef3BrowserWindow = class(TDuiWindowImplBase)
  private
    FEdtURL: CEditUI;
    FBtnGo: CButtonUI;
    FTitle: CLabelUI;
    FInfo: TCefWindowInfo;
  private
    FCef3Webbrowser: ICefClient;
    procedure FXOnBrwCreate(Sender: TObject);
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
    procedure CreateCef3;

  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  brows: ICefBrowser = nil;
  browserId: Integer = 0;


{ TCustomClient }

constructor TCustomClient.Create;
begin
  inherited;
  FLifeSpan := TCustomLifeSpan.Create;
  TCustomLifeSpan(FLifeSpan).OnBrwCreate := FXOnBrwCreate;
end;

function TCustomClient.GetLifeSpanHandler: ICefLifeSpanHandler;
begin
  Result := FLifeSpan;
end;

procedure TCustomClient.FXOnBrwCreate(Sender: TObject);
begin
  if Assigned(FOnBrwCreate) then
    FOnBrwCreate(Self);
end;

{ TCustomLifeSpan }

procedure TCustomLifeSpan.OnAfterCreated(const browser: ICefBrowser);
begin
  if not browser.IsPopup then
  begin
    // get the first browser
    brows := browser;
    browserId := brows.Identifier;
    if Assigned(FOnBrwCreate) then
      FOnBrwCreate(Self);
  end;
end;

procedure TCustomLifeSpan.OnBeforeClose(const browser: ICefBrowser);
begin
  if browser.Identifier = browserId then
    brows := nil;
end;

{ TCef3BrowserWindow }

constructor TCef3BrowserWindow.Create;
begin
  inherited Create('Cef3browserWindow.xml', 'skin');
  CreateWindow(0, 'Cef3ä¯ÀÀÆ÷', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
  FCef3Webbrowser := TCustomClient.Create;
  TCustomClient(FCef3Webbrowser).OnBrwCreate := FXOnBrwCreate;
  CreateCef3;
  SetTimer(Handle, 1, 100, nil);
end;

procedure TCef3BrowserWindow.CreateCef3;
var
  rect: TRect;
  hdwp: THandle;
  setting: TCefBrowserSettings;
begin
  GetClientRect(Handle, rect);
  FillChar(FInfo, SizeOf(FInfo), 0);
  FInfo.Style := WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_TABSTOP;
  FInfo.parent_window := Handle;
  FInfo.x := 0;
  FInfo.y := 0;
  FInfo.Width := 1;
  FInfo.Height := 1;
  FillChar(setting, sizeof(setting), 0);
  setting.size := SizeOf(setting);
  CefBrowserHostCreateSync(@FInfo, FCef3Webbrowser, '', @setting);
end;

destructor TCef3BrowserWindow.Destroy;
begin
  FCef3Webbrowser := nil;
  inherited;
end;

procedure TCef3BrowserWindow.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
end;

procedure TCef3BrowserWindow.DoInitWindow;
begin
  inherited;
  FEdtURL := CEditUI(FindControl('edturl'));
  FBtnGo := CButtonUI(FindControl('btngo'));
  FTitle := CLabelUI(FindControl('title'));
end;

procedure TCef3BrowserWindow.DoNotify(var Msg: TNotifyUI);
begin
  inherited;
  if Msg.sType.m_pstr = DUI_MSGTYPE_CLICK then
  begin
    if Msg.pSender.Name = 'closebtn' then
      DuiApplication.Terminate
    else if Msg.pSender = FBtnGo then
    begin
      Writeln(FEdtURL.Text);
      if (FEdtURL.Text <> '') and (brows <> nil) then
        brows.MainFrame.LoadUrl(FEdtURL.Text);
    end;
  end else if Msg.sType.m_pstr = DUI_MSGTYPE_RETURN then
  begin
    if (FEdtURL.Text <> '') and (brows <> nil)  then
      brows.MainFrame.LoadUrl(FEdtURL.Text);
  end;
end;



procedure TCef3BrowserWindow.FXOnBrwCreate(Sender: TObject);
var
  LCtl: CNativeControlUI;
begin
  LCtl := CNativeControlUI(FindControl('webbrowser'));
  if LCtl <> nil then
  begin
    FInfo.window := brows.Host.WindowHandle;
    Writeln('FXOnBrwCreate');
    Writeln('ok');
    LCtl.SetNativeHandle(FInfo.window);
    LCtl.Show;
  end;
end;

var
  Cef3BrowserWindow: TCef3BrowserWindow;

begin
  try

    DuiApplication.Initialize;
    Cef3BrowserWindow := TCef3BrowserWindow.Create;
    Cef3BrowserWindow.CenterWindow;
    Cef3BrowserWindow.Show;
    CefRunMessageLoop;
    DuiApplication.Run;
    Cef3BrowserWindow.Free;

  except
    on E: Exception do
      Writeln(E.Message);
  end;
end.
