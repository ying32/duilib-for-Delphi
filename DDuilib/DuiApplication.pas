unit DuiApplication;

interface

uses
  Winapi.Windows,
  Duilib;

type
  TDuiApplication = class
  public
    procedure Initialize;
    procedure Run;
    procedure Terminate;
    //procedure CreateForm();
  end;

var
  Application: TDuiApplication;

implementation

{ TDuiApplication }

procedure TDuiApplication.Initialize;
begin
  CPaintManagerUI.SetInstance(HInstance);
end;

procedure TDuiApplication.Run;
begin
  CPaintManagerUI.MessageLoop;
end;

procedure TDuiApplication.Terminate;
begin
  CPaintManagerUI.Term;
  //PostQuitMessage(0);
end;

initialization
   Application := TDuiApplication.Create;

finalization
   Application.Free;


end.
