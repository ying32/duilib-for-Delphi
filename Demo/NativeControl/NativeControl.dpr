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
  DuiVclControl,
  Forms,
  DuiWindowImplBase,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

type
  TDuiNativeControlTest = class(TDuiWindowImplBase)
  private
    FTabs: CTabLayoutUI;
    FTabTool: CTabLayoutUI;
    FVclForm: CVCLControlUI;
    FVclForm2: CVCLControlUI;
    FWCaption: CLabelUI;
    procedure OnOptionSelectchanged(Msg: TNotifyUI);

  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TDuiNativeControlTest }



constructor TDuiNativeControlTest.Create;
begin
  inherited Create('dlg_main2.xml', 'skin\PCManager\');
  CreateDuiWindow(0, 'NativeControl≤‚ ‘');

  Caption := 'test';
end;

destructor TDuiNativeControlTest.Destroy;
begin

  inherited;
end;

procedure TDuiNativeControlTest.DoHandleMessage(var Msg: TMessage;
  var bHandled: BOOL);
begin
  inherited;

end;

procedure TDuiNativeControlTest.DoInitWindow;
var
  LNativeCtl: CNativeControlUI;
begin
  inherited;
{$IFDEF SupportGeneric}
  FTabs := FindControl<CTabLayoutUI>('tabs');
  FTabTool := FindControl<CTabLayoutUI>('tabtool');
  FVclForm := FindControl<CVCLControlUI>('vclForm');
  FWCaption := FindControl<CLabelUI>('lblCaption');
  FVclForm2 := FindControl<CVCLControlUI>('vclForm2');
{$ELSE}
  FTabs := CTabLayoutUI(FindControl('tabs'));
  FTabTool := CTabLayoutUI(FindControl('tabtool'));
  FVclForm := CVCLControlUI(FindControl('vclForm'));
  FWCaption := CLabelUI(FindControl('lblCaption'));
  FVclForm2 := CVCLControlUI(FindControl('vclForm2));
{$ENDIF}
  FWCaption.Text := 'VCLøÿº˛≤‚ ‘';

   if FVclForm <> nil then
   begin
     Form1 := TForm1.Create(nil);
     FVclForm.VclObject := Form1;
   end;
   if FVclForm2 <> nil then
   begin
     Form2 := TForm2.Create(nil);
     FVclForm2.VclObject := Form2;
   end;
end;

procedure TDuiNativeControlTest.DoNotify(var Msg: TNotifyUI);
begin
  if Msg.sType.m_pStr = DUI_MSGTYPE_SELECTCHANGED then
    OnOptionSelectchanged(Msg)
  else if Msg.sType.m_pstr = DUI_MSGTYPE_CLICK then
  begin
    if Msg.pSender.Name = 'closebtn' then
      DuiApplication.Terminate;
  end;
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
//    DuiNativeControlTest.Left := 100;
//    DuiNativeControlTest.Top := 100;
    DuiNativeControlTest.Show;
    DuiApplication.Run;
    DuiNativeControlTest.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
