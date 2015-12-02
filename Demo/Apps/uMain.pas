unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  Duilib,
  DuiWindowImplBase,
  DuiListUI,
  DuiConst,
  DuilibHelper;

const
  kclosebtn = 'closebtn';
  krestorebtn = 'restorebtn';
  kmaxbtn = 'maxbtn';
  kminbtn = 'minbtn';

type

  TAppsWindow = class(TDuiWindowImplBase)
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
    procedure DoInitWindow; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  AppsWindow: TAppsWindow;

implementation

{ TAppsWindow }

constructor TAppsWindow.Create;
begin
  inherited Create('MainWindow.xml', 'skin\Apps');
  CreateWindow(0, 'Apps', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
end;

destructor TAppsWindow.Destroy;
begin

  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage);
begin
  inherited;

end;

procedure TAppsWindow.DoInitWindow;
var
  LSize: TSize;
begin
  inherited;
  LSize := InitSize;
//  MoveWindow(Handle, )
end;

procedure TAppsWindow.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    if LCtlName.Equals(kclosebtn) then
      DuiApplication.Terminate
    else if LCtlName.Equals(krestorebtn) then
      Restore
    else if LCtlName.Equals(kmaxbtn) then
      Maximize
    else if LCtlName.Equals(kminbtn) then
      Minimize;
  end;
end;

end.
