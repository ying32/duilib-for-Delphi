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
  private
    FDlgBuilder: CDialogBuilder;
    FInitOK: Boolean;
  protected
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
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

{
  if not FDlgBuilder.GetMarkup.IsValid then
    LListElement := CListContainerElementUI(FDlgBuilder.Create('iconslist.xml', '', nil, FPaintManager))
  else
    LListElement := CListContainerElementUI(FDlgBuilder.Create(nil, FPaintManager));
  if LListElement = nil then
    Exit;

}

constructor TAppsWindow.Create;
begin
  inherited Create('MainWindow.xml', 'skin\Apps');
  CreateWindow(0, 'Apps', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
  FDlgBuilder := CDialogBuilder.CppCreate;
end;

destructor TAppsWindow.Destroy;
var
  LTileLayout: CTileLayoutUI;
begin
  LTileLayout := CTileLayoutUI(FindControl('listctrl'));
  if LTileLayout <> nil then
    LTileLayout.RemoveAll;
  FDlgBuilder.CppDestroy;
  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
var
  LTileLayout: CTileLayoutUI;
  R: TRect;
begin
  inherited;
  if Msg.Msg = WM_SIZE then
  begin
    if FInitOK then
    begin
      LTileLayout := CTileLayoutUI(FindControl('listctrl'));
      if LTileLayout <> nil then
      begin
        GetClientRect(Handle, R);
        LTileLayout.SetColumns(R.Width div 90);
        // item的宽为80 + 20的
      end;
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
  LTileLayout: CTileLayoutUI;
  LVerticalLayout: CVerticalLayoutUI;
  I: Integer;
  LTitle: CLabelUI;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_EVENT_WINDOWINIT) then
  begin
    FInitOK := True;
    LTileLayout := CTileLayoutUI(FindControl('listctrl'));
    if LTileLayout <> nil then
    begin
      for I := 1 to 10 do
      begin
        if not FDlgBuilder.GetMarkup.IsValid then
          LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create('buttonitem.xml', '', nil, PaintManagerUI))
        else
          LVerticalLayout := CVerticalLayoutUI(FDlgBuilder.Create(nil, PaintManagerUI));
        if LVerticalLayout = nil then Continue;
        LTitle := CLabelUI(PaintManagerUI.FindSubControlByName(LVerticalLayout, 'title'));
        if LTitle <> nil then
          LTitle.Text := '文字' + I.ToString;
        LVerticalLayout.Visible := True;
        LTileLayout.Add(LVerticalLayout);
        OutputDebugString(PChar('+++++++++++++++++++++++++++++++'));
      end;
    end;
  end else
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
