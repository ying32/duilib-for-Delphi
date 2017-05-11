unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DuiVCLComponent, Duilib, DuiMenu, DuiConst;

type
  TfrmQQXF = class(TForm)
    DDuiForm1: TDDuiForm;
    procedure DDuiForm1InitWindow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DDuiForm1Click(Sender: TObject; var Msg: TNotifyUI);
  private
    FList: CListUI;
    FDlgBuilder: CDialogBuilder;
    procedure AddListTestItem;
  public
    { Public declarations }
  end;

var
  frmQQXF: TfrmQQXF;

implementation

{$R *.dfm}

procedure TfrmQQXF.AddListTestItem;
  procedure SetTaskIcon(AItem: CListContainerElementUI; I: Integer);
  begin
    AItem.FindSubControl('taskCompleted').Visible := (I = 0);
    AItem.FindSubControl('taskPause').Visible := (I = 1);
    AItem.FindSubControl('taskFailed').Visible := (I = 2);
  end;

var
  LItem: CListContainerElementUI;
  Lbl: CLabelUI;
  LProgress: CProgressUI;
  I: Integer;
begin
  if FList <> nil then
  begin
    if FList.GetHeader <> nil then
    begin
      FList.GetHeader.SetFixedWidth(0);
      FList.GetHeader.Hide;
    end;

    for I := 0 to 20 do
    begin
      if not FDlgBuilder.Markup.IsValid then
        LItem := FDlgBuilder.Create<CListContainerElementUI>('dllistitem.xml', '', nil, DDuiForm1.PaintMgr)
      else
        LItem := FDlgBuilder.Create<CListContainerElementUI>(nil, DDuiForm1.PaintMgr);
      if LItem <> nil then
      begin
        LItem.SetFixedHeight(75);
        Lbl := DDuiForm1.FindSubControl<CLabelUI>(LItem, 'filesize');
        if Lbl <> nil then
          Lbl.Text := Format('%dM', [Random(5000)]);
        Lbl := DDuiForm1.FindSubControl<CLabelUI>(LItem, 'filename');
        if Lbl <> nil then
          Lbl.Text := Format('file%d', [I]);
        LProgress := DDuiForm1.FindSubControl<CProgressUI>(LItem, 'progress');
        if LProgress <> nil then
          LProgress.Value := Random(100);
        SetTaskIcon(LItem, I mod 3);
        FList.Add(LItem);
      end;
    end;
  end;
end;

procedure TfrmQQXF.DDuiForm1Click(Sender: TObject; var Msg: TNotifyUI);
var
  LMenu: CMenuWnd;
  LPoint: TPoint;
begin
  if Msg.pSender.Name = 'btnTaskSort' then
  begin
    LMenu := CMenuWnd.CppCreate(Handle, DDuiForm1.PaintMgr);
    LPoint := Msg.ptMouse;
    Winapi.Windows.ClientToScreen(Handle, LPoint);
    LMenu.Init(nil, 'sortmenu.xml', '', LPoint);
  end else if Msg.pSender.Name = 'btnMore' then
  begin
    LMenu := CMenuWnd.CppCreate(Handle, DDuiForm1.PaintMgr);
    LPoint := Msg.ptMouse;
    Winapi.Windows.ClientToScreen(Handle, LPoint);
    LMenu.Init(nil, 'moremenu.xml', '', LPoint);
  end;
end;

procedure TfrmQQXF.DDuiForm1InitWindow(Sender: TObject);
begin
  FDlgBuilder := CDialogBuilder.CppCreate;
  FList := DDuiForm1.FindControl<CListUI>('DlList');
  AddListTestItem;
end;

procedure TfrmQQXF.FormDestroy(Sender: TObject);
begin
  if FDlgBuilder <> nil then
    FDlgBuilder.CppDestroy;
end;

end.
