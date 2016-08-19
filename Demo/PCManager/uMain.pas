unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DuiVCLComponent, Duilib, DuiConst;

type
  TDDuiPCManager = class(TForm)
    DDuiForm: TDDuiForm;
    procedure DDuiFormInitWindow(Sender: TObject);
    procedure DDuiFormNotify(Sender: TObject; var Msg: TNotifyUI);
  private
    FTabs: CTabLayoutUI;
    procedure OnOptionSelectchanged(Sender: TObject; Msg: TNotifyUI);
  public
    { Public declarations }
  end;

var
  DDuiPCManager: TDDuiPCManager;

implementation

{$R *.dfm}

procedure TDDuiPCManager.DDuiFormInitWindow(Sender: TObject);
begin
  FTabs := DDuiForm.FindControl<CTabLayoutUI>('tabs');
end;

procedure TDDuiPCManager.DDuiFormNotify(Sender: TObject; var Msg: TNotifyUI);
begin
  if Msg.sType = DUI_MSGTYPE_SELECTCHANGED then
    OnOptionSelectchanged(Sender, Msg);
end;

procedure TDDuiPCManager.OnOptionSelectchanged(Sender: TObject; Msg: TNotifyUI);
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
  end;
end;

end.
