unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ComCtrls, Duilib,
  Vcl.ToolWin, Vcl.ButtonGroup, Vcl.Buttons, Vcl.ImgList, Vcl.StdCtrls, ufrmDesignerTemplate,
  Vcl.Menus;

type
  TfrmMain = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    stat1: TStatusBar;
    pnl3: TPanel;
    pnl_des: TPanel;
    spl1: TSplitter;
    spl2: TSplitter;
    aplctnvnts1: TApplicationEvents;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    il_controlicons: TImageList;
    tlb1: TToolBar;
    btn_ctl_pointer: TToolButton;
    btn_ctl_ControlUI: TToolButton;
    btn_ctl_CLableUI: TToolButton;
    btn_ctl_CTextUI: TToolButton;
    btn_ctl_CEditUI: TToolButton;
    btn_ctl_COptionUI: TToolButton;
    btn_ctl_CComboUI: TToolButton;
    btn_ctl_CButtonUI: TToolButton;
    btn_ctl_CProgressUI: TToolButton;
    btn_ctl_CSliderUI: TToolButton;
    btn_ctl_CActiveXUI: TToolButton;
    btn_ctl_CListUI: TToolButton;
    tlb2: TToolBar;
    btn_ctl_CContainerUI: TToolButton;
    btn_ctl_CVerticalLayoutUI: TToolButton;
    btn_ctl_CHorizontalLayoutUI: TToolButton;
    btn_ctl_CTileLayoutUI: TToolButton;
    btn_ctl_CTabLayoutUI: TToolButton;
    scrlbx_des: TScrollBox;
    mm1: TMainMenu;
    F1: TMenuItem;
    il_opertools: TImageList;
    il_formedits: TImageList;
    ctrlbr1: TControlBar;
    tlb3: TToolBar;
    btn19: TToolButton;
    btn20: TToolButton;
    btn21: TToolButton;
    btn22: TToolButton;
    btn23: TToolButton;
    btn29: TToolButton;
    btn24: TToolButton;
    btn25: TToolButton;
    btn26: TToolButton;
    btn30: TToolButton;
    btn27: TToolButton;
    btn28: TToolButton;
    tlb5: TToolBar;
    btn68: TToolButton;
    btn69: TToolButton;
    btn70: TToolButton;
    btn71: TToolButton;
    btn72: TToolButton;
    btn74: TToolButton;
    btn75: TToolButton;
    btn76: TToolButton;
    btn77: TToolButton;
    btn78: TToolButton;
    tlb4: TToolBar;
    btn32: TToolButton;
    btn33: TToolButton;
    btn34: TToolButton;
    btn35: TToolButton;
    btn36: TToolButton;
    btn37: TToolButton;
    btn38: TToolButton;
    btn39: TToolButton;
    btn40: TToolButton;
    btn41: TToolButton;
    btn42: TToolButton;
    btn43: TToolButton;
    btn44: TToolButton;
    btn13: TBitBtn;
    pnl4: TPanel;
    cbb1: TComboBox;
    tv1: TTreeView;
    spl3: TSplitter;
    pnl5: TPanel;
    procedure aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure btn13Click(Sender: TObject);
    procedure btn_ctl_pointerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTestDesigner: TfrmDesignerTemplate;
    FCurCtl: TToolButton;
    function GetSelect: Boolean;
  public
    procedure ClearSel;
    property CurCtl: TToolButton read FCurCtl write FCurCtl;
    property IsSelect: Boolean read GetSelect;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  CPaintManagerUI.TranslateMessage(@Msg);
end;

procedure TfrmMain.btn13Click(Sender: TObject);
begin
  FTestDesigner := NewDesignerTemplate(scrlbx_des);
end;

procedure TfrmMain.btn_ctl_pointerClick(Sender: TObject);
var
  Btn: TToolButton;
begin
  if Sender is TToolButton then
  begin
    if FCurCtl <> nil then
      FCurCtl.Down := False;
    Btn := Sender as TToolButton;
    Btn.Down := True;
    FCurCtl := Btn;
  end;
end;

procedure TfrmMain.ClearSel;
begin
  if FCurCtl <> nil then
    FCurCtl.Down := False;
  FCurCtl := btn_ctl_pointer;
  btn_ctl_pointer.Down := True;
  FCurCtl := nil;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurCtl := btn_ctl_pointer;
end;

function TfrmMain.GetSelect: Boolean;
begin
  Result := (FCurCtl <> btn_ctl_pointer) and (FCurCtl <> nil);
end;

end.
