unit ufrmWebbrowser;

interface

{$I 'DDuilib.inc'}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DDuilibComponent, Duilib, DuiWebBrowser, DuiActiveX, SHDocVw;

type
  TForm4 = class(TForm)
    DDuiForm1: TDDuiForm;
    procedure DDuiForm1InitWindow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.DDuiForm1InitWindow(Sender: TObject);
var
  pActiveXUI: CActiveXUI;
  pWebBrowser: IWebBrowser2;
  Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
  inherited;
{$IFNDEF SupportGeneric}
  pActiveXUI := CActiveXUI(DDuiForm1.DUI.FindControl('ie'));
{$ELSE}
  pActiveXUI := DDuiForm1.DUI.FindControl<CActiveXUI>('ie');
{$ENDIF}
  if pActiveXUI <> nil then
  begin
    pActiveXUI.GetControl(IID_IWebBrowser2, pWebBrowser);
    if pWebBrowser <> nil then
    begin
      Flags := NULL;
      TargetFrameName := NULL;
      PostData := NULL;
      Headers := NULL;
      pWebBrowser.Navigate('http://git.oschina.net/ying32/Duilib-for-Delphi', Flags, TargetFrameName, PostData, Headers);
    end;
  end;
end;

end.
