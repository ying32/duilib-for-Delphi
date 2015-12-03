program ListDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Generics.Collections,
  Duilib,
  DuiConst,
  DuiWindowImplBase,
  DuiListUI,
  DuilibHelper;

type

  TListItem = record
    Col1: string;
    Col2: string;
    Col3: string;
  end;

  TListMainForm = class(TDuiWindowImplBase)
  private
    FSearch: CButtonUI;
    FList: TList<TListItem>;
    procedure OnSearch;
    function DoGetItemText(pControl: CControlUI; iIndex, iSubItem: Integer): string; override;
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TListMainForm }

constructor TListMainForm.Create;
begin
  inherited Create('skin.xml', 'skin\ListRes');
  CreateWindow(0, 'ListDemo', UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE or WS_EX_APPWINDOW , 0, 0, 600, 320);
  FList := TList<TListItem>.Create;
end;

destructor TListMainForm.Destroy;
begin
  FList.Free;
  inherited;
end;

function TListMainForm.DoGetItemText(pControl: CControlUI; iIndex,
  iSubItem: Integer): string;
var
  Litem: TListItem;
begin
  if (pControl.Tag <> -1) and (pControl.Tag < FList.Count) then
  begin
    Litem := FList[pControl.Tag];
    case iSubItem of
      0 : Result := Litem.Col1;
      1 : Result := Litem.Col2;
      2 : Result := Litem.Col3;
    end;
  end else Result := '';
end;

procedure TListMainForm.DoHandleMessage(var Msg: TMessage);
begin
  inherited;

end;

procedure TListMainForm.DoInitWindow;
begin
  inherited;
  FSearch := CButtonUI(FindControl('btn'));
end;

procedure TListMainForm.DoNotify(var Msg: TNotifyUI);
var
  LType, LCtlName: string;
begin
  inherited;
  LType := Msg.sType;
  LCtlName := Msg.pSender.Name;
  if LType.Equals(DUI_EVENT_CLICK) then
  begin
    if LCtlName.Equals('closebtn') then
      DuiApplication.Terminate
    else if LCtlName.Equals('minbtn') then
      Minimize
    else if LCtlName.Equals('btn') then
      OnSearch;
  end;
end;

procedure TListMainForm.OnSearch;
var
  pList: CListUI;
  pEdit: CEditUI;
  LInputText: string;
  I: Integer;
  pListElement: CListTextElementUI;
  LItem: TListItem;
begin
  pList := CListUI(FindControl('domainlist'));
  pEdit := CEditUI(FindControl('input'));
  if pEdit <> nil then
  begin
    pEdit.Enabled := False;
    LInputText := pEdit.Text;
  end;
  FSearch.Enabled := False;
  if pList <> nil then
  begin
    pList.RemoveAll;
    pList.SetTextCallback(Pointer(this));
    for I := 0 to 10 do
    begin
      LItem.Col1 := I.ToString;
      LItem.Col2 := 'aaaaa' + I.ToString;
      LItem.Col3 := 'bbbbb' + I.ToString;
      FList.Add(LItem);
      pListElement := CListTextElementUI.CppCreate;
      pListElement.Tag := I;
      pList.Add(pListElement);
    end;
  end;
  FSearch.Enabled := True;
end;



var
  ListMainForm: TListMainForm;


begin
  try
    DuiApplication.Initialize;
    ListMainForm := TListMainForm.Create;
    ListMainForm.CenterWindow;
    ListMainForm.Show;
    DuiApplication.Run;
    ListMainForm.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
