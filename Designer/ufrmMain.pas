//***************************************************************************
//
//       名称：ufrmMain.pas
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@qq.com
//       DDuilib设计器主窗口
//       版权所有 (C) 2015-2016 ying32 All Rights Reserved
//
//***************************************************************************
unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ComCtrls, Duilib,
  Vcl.ToolWin, Vcl.Buttons, Vcl.ImgList, Vcl.Menus,
  ufrmDesignerTemplate, System.Generics.Collections, System.Actions,
  Vcl.ActnList, cxGraphics, cxControls,
  cxEdit,
  cxInplaceContainer, cxVGrid, cxOI, cxButtonEdit, uPropertyClass,
  cxPC, cxScrollBox, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxTreeView, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxBarBuiltInMenu;

type

  TPageItemRec = record
    Designer: TfrmDesignerTemplate;
  end;

  TfrmMain = class(TForm)
    pnl_Top: TPanel;
    pnl_Left: TPanel;
    stat1: TStatusBar;
    pnl_Right: TPanel;
    pnl_Client: TPanel;
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
    mm1: TMainMenu;
    F1: TMenuItem;
    il_opertools: TImageList;
    il_formedits: TImageList;
    ctrlbr1: TControlBar;
    tlb3: TToolBar;
    btn19: TToolButton;
    btnfile_new: TToolButton;
    btn21: TToolButton;
    btnfile_save: TToolButton;
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
    pnl4: TPanel;
    spl3: TSplitter;
    pnl5: TPanel;
    actlst1: TActionList;
    act_file_new: TAction;
    cxRTTIInspector: TcxRTTIInspector;
    cxpgcntrl_Des: TcxPageControl;
    cxTreeView1: TcxTreeView;
    cxComboBox1: TcxComboBox;
    act_file_save: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure btn_ctl_pointerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_file_newExecute(Sender: TObject);
    procedure act_file_saveExecute(Sender: TObject);
  private
    FCurDesigner: TfrmDesignerTemplate;
    FCurCtl: TToolButton;
    FDesingers: TObjectList<TfrmDesignerTemplate>;
    FDuiControlRTTIs: TDictionary<string, TPersistent>;

    procedure InitDuiControlRTTI;
    procedure FreeDuiControlRTTI;

    function GetSelect: Boolean;
    procedure CreateNewPage;
    procedure OnScrollBoxClick(Sender: TObject);
    procedure OnSelectControl(Sender: TObject; AControl: CControlUI);
    procedure OnControlChanged(Sender: TObject);

    function GetControlRTTI(AClass: string): TPersistent;
  public
    procedure ClearSel;
    property CurCtl: TToolButton read FCurCtl write FCurCtl;
    property IsSelect: Boolean read GetSelect;
  end;

  TcxImageStringeProperty = class(TcxStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TcxPropertyAttributes; override;
  end;


var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses ufrmImageEditor;

procedure TfrmMain.act_file_newExecute(Sender: TObject);
begin
  // 这里还要新建一个Page页
//  FCurDesigner := NewDesignerTemplate(scrlbx_des);
//  FDesingers.Add(FCurDesigner);
  CreateNewPage;
end;

procedure TfrmMain.act_file_saveExecute(Sender: TObject);
begin
  if Assigned(FCurDesigner) then
    FCurDesigner.SaveXML('test.xml');
end;

procedure TfrmMain.aplctnvnts1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  CPaintManagerUI.TranslateMessage(@Msg);
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

procedure TfrmMain.CreateNewPage;
var
  LTab: TcxTabSheet;
  LScrollBox: TcxScrollBox;
begin
  LTab := TcxTabSheet.Create(Self);
  LScrollBox := TcxScrollBox.Create(Self);
  LScrollBox.Parent := LTab;
  LScrollBox.Align := alClient;
  LScrollBox.OnClick := OnScrollBoxClick;
  LTab.Caption := 'New 1';
  LTab.PageControl := cxpgcntrl_Des;
  FCurDesigner := NewDesignerTemplate(LScrollBox);
  FCurDesigner.OnSelectControl := OnSelectControl;
  FCurDesigner.OnControlChanged := OnControlChanged;
  FDesingers.Add(FCurDesigner);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // 注册新的类
  cxRegisterPropertyEditor(TypeInfo(TImageString), nil, '', TcxImageStringeProperty);
  cxRegisterEditPropertiesClass(TcxImageStringeProperty, TcxButtonEditProperties);

  FCurCtl := btn_ctl_pointer;
  FDesingers := TObjectList<TfrmDesignerTemplate>.Create;
  FDuiControlRTTIs := TDictionary<string, TPersistent>.Create;
  InitDuiControlRTTI;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeDuiControlRTTI;
  FDuiControlRTTIs.Free;
  FDesingers.Free;
end;

function TfrmMain.GetControlRTTI(AClass: string): TPersistent;
var
  LControl: TPersistent;
begin
  Result := nil;
  if FDuiControlRTTIs.TryGetValue(AClass, LControl) then
    Result := LControl;
end;

function TfrmMain.GetSelect: Boolean;
begin
  Result := (FCurCtl <> btn_ctl_pointer) and (FCurCtl <> nil);
end;

procedure TfrmMain.InitDuiControlRTTI;
begin
  FDuiControlRTTIs.Add('ControlUI', TDControl.Create);
end;

procedure TfrmMain.FreeDuiControlRTTI;
var
  LR: TPersistent;
begin
  for LR in FDuiControlRTTIs.Values.ToArray do
    LR.Free;
  FDuiControlRTTIs.Clear;
end;

procedure TfrmMain.OnControlChanged(Sender: TObject);
begin
  if cxRTTIInspector.InspectedObject <> nil then
    cxRTTIInspector.RefreshInspectedProperties;
end;

procedure TfrmMain.OnScrollBoxClick(Sender: TObject);
begin
  if Assigned(FCurDesigner) then
    cxRTTIInspector.InspectedObject := FCurDesigner.DuiWindow;
end;

procedure TfrmMain.OnSelectControl(Sender: TObject; AControl: CControlUI);
var
  LPer: TPersistent;
begin
  // 测试用
  if FDuiControlRTTIs.TryGetValue('ControlUI', LPer) then
  begin
    TDControl(LPer).SetControl(AControl);
    cxRTTIInspector.InspectedObject := LPer;
    cxRTTIInspector.RefreshInspectedProperties;
  end
  else
    cxRTTIInspector.InspectedObject := nil;
end;

{ TcxImageStringeProperty }

procedure TcxImageStringeProperty.Edit;
begin
  inherited;
  if frm_ImageEditor.ShowModal = mrOk then
  begin
    PostChangedNotification;
  end;
end;

function TcxImageStringeProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaDialog];
end;

end.
