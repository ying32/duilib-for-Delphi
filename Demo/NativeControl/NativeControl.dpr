program NativeControl;

{$APPTYPE CONSOLE}

{$I DDuilib.inc}

{$R *.res}

uses
  Windows,
  Messages,
  Classes,
  SysUtils,
  StdCtrls,
  Duilib,
  DuiConst,
  ComCtrls,
  Forms,
  DuiWindowImplBase;

type
  TDuiNativeControlTest = class(TDuiWindowImplBase)
  private
    FButton: TButton;
    FTabs: CTabLayoutUI;
    FTabTool: CTabLayoutUI;
    FVclPageCtl: CNativeControlUI;
    FVclListViewCtl: CNativeControlUI;
    FWCaption: CLabelUI;

    FListV: TListView;
    FPages: TPageControl;


    procedure ButtonClick(Sender: TObject);
    procedure OnOptionSelectchanged(Msg: TNotifyUI);
    procedure CreateVclControls;
    procedure CreateVclSubControls;
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TDuiNativeControlTest }

procedure TDuiNativeControlTest.ButtonClick(Sender: TObject);
begin
   MessageBox(0, '单击了按钮', '消息', 0);
end;

constructor TDuiNativeControlTest.Create;
begin
  CreateVclControls;
  //inherited Create('NativeControlTest.xml', 'skin');
  inherited Create('dlg_main2.xml', 'skin\PCManager\');
  CreateDuiWindow(0, 'NativeControl测试');
end;

procedure TDuiNativeControlTest.CreateVclControls;
var
  LCol: TListColumn;
begin
  // 有点奇怪，delphi7下放到create与CreateDuiWindow之间就报错，高版本则无此问题
  FButton := TButton.Create(nil);
  FButton.Caption := '按钮1';
  FButton.OnClick := ButtonClick;

  FPages := TPageControl.Create(nil);
  FPages.Left := 0 - (FPages.Width + 1);


  FListV := TListView.Create(nil);
  // 不使用visible属性
  FListV.Left := 0 - (FListV.Width + 1);

  FListV.GridLines := True;
  FListV.RowSelect := True;
  FListV.ViewStyle := vsReport;

  LCol := FListV.Columns.Add;
  LCol.Caption := '第一列';
  LCol.Width := 100;

  LCol := FListV.Columns.Add;
  LCol.Caption := '第二列';
  LCol.Width := 100;

  LCol := FListV.Columns.Add;
  LCol.Caption := '第三列';
  LCol.Width := 100;

end;

procedure TDuiNativeControlTest.CreateVclSubControls;
var
  LTabSheet: TTabSheet;
  LItem: TListItem;
  I: Integer;
  LButton: TButton;
begin
  // 添加了无法切换tab，不响应某些消息了。。。。估计是和vcl和冲突，某些消息需要转发
  LTabSheet := TTabSheet.Create(FPages);
  LTabSheet.Parent := FPages;
  LTabSheet.PageControl := FPages;
  LTabSheet.Caption := '第一页';

  LButton := TButton.Create(LTabSheet);
  LButton.Parent := LTabSheet;
  LButton.Caption := '按钮';

  LTabSheet := TTabSheet.Create(FPages);
  LTabSheet.Parent := FPages;
  LTabSheet.PageControl := FPages;
  LTabSheet.Caption := '第二页';
  // 添加了文字无法显示。。。。估计是和vcl和冲突，某些消息需要转发
  FListV.Items.BeginUpdate;
  try
    for I := 0 to 100 do
    begin
      LItem := FListV.Items.Add;
      LItem.Caption := IntToStr(I+1);
      LItem.SubItems.Add('1111');
    end;
  finally
    FListV.Items.EndUpdate;
  end;
end;

destructor TDuiNativeControlTest.Destroy;
begin
  FreeAndNil(FListV);
  FreeAndNil(FButton);
  inherited;
end;

procedure TDuiNativeControlTest.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;
  if Msg.Msg = WM_COMMAND then
  begin
    // 在WM_COMMAND中接收
    if Msg.LParam = FButton.Handle then
      FButton.WindowProc(Msg);
  end;
end;

procedure TDuiNativeControlTest.DoInitWindow;
var
  LNativeCtl: CNativeControlUI;
begin
  inherited;
{$IFDEF SupportGeneric}
  FTabs := FindControl<CTabLayoutUI>('tabs');
  FTabTool := FindControl<CTabLayoutUI>('tabtool');
  FVclPageCtl := FindControl<CNativeControlUI>('vclpagectl');
  FWCaption := FindControl<CLabelUI>('lblCaption');
  FVclListViewCtl := FindControl<CNativeControlUI>('vcllistviewctl');
{$ELSE}
  FTabs := CTabLayoutUI(FindControl('tabs'));
  FTabTool := CTabLayoutUI(FindControl('tabtool'));
  FVclPageCtl := CNativeControlUI(FindControl('vclpagectl'));
  FWCaption := CLabelUI(FindControl('lblCaption'));
  FVclListViewCtl := CNativeControlUI(FindControl('vcllistviewctl'));
{$ENDIF}
  FWCaption.Text := 'VCL控件测试';

  if FVclPageCtl <> nil then
  begin
    FPages.ParentWindow := Handle;
    FVclPageCtl.SetNativeHandle(FPages.Handle);
  end;
  if FVclListViewCtl <> nil then
  begin
    FListV.ParentWindow := Handle;
    FVclListViewCtl.SetNativeHandle(FListV.Handle);
  end;

  CreateVclSubControls;

//  LNativeCtl := CNativeControlUI(FindControl('test1'));
//  if LNativeCtl <> nil then
//  begin
//    // 这个只能使用delphi设置parent
//    FButton.ParentWindow := Handle;
//    LNativeCtl.SetNativeHandle(FButton.Handle);
//  end;
end;

procedure TDuiNativeControlTest.DoNotify(var Msg: TNotifyUI);
begin
  if Msg.sType.m_pStr = DUI_MSGTYPE_SELECTCHANGED then
    OnOptionSelectchanged(Msg);
  Writeln(string(Msg.sType.m_pstr));
  inherited;
end;


procedure TDuiNativeControlTest.OnOptionSelectchanged(Msg: TNotifyUI);
var
  LName: string;
  LIndex: Integer;
begin
  LName := Msg.pSender.Name;
  if Copy(LName, 1, 6) = 'tabsel' then
  begin
    LIndex := StrToIntDef(Copy(LName, 7, 1), -1) - 1;
    if LIndex >= 0 then
      FTabs.SelectIndex := LIndex;
  end else if Copy(LName, 1, 7) = 'toolsel' then
  begin
    LIndex := StrToIntDef(Copy(LName, 8, 1), -1) - 1;
    if LIndex >= 0 then
      FTabTool.SelectIndex := LIndex;
  end;
end;

var
  DuiNativeControlTest: TDuiNativeControlTest;

begin
  try
    DuiApplication.Initialize;
    DuiNativeControlTest := TDuiNativeControlTest.Create;
    DuiNativeControlTest.CenterWindow;
    DuiNativeControlTest.Show;
    DuiApplication.Run;
    DuiNativeControlTest.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
