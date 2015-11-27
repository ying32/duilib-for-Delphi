unit DuiApplication;

interface

uses
  Duilib,
  DuiWindowImplBase;

type
  TDuiApplication = class
  public
    procedure Initialize;
    procedure Run;
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

initialization
   Application := TDuiApplication.Create;

finalization
   Application.Free;


end.
