unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Duilib,
  DuiWindowImplBase,
  DuiListUI,
  DuiConst,
  DuilibHelper;

type
  TAppsWindow = class(TDuiWindowImplBase)
  protected
    procedure DoNotify(var Msg: TMessage); override;
    procedure DoHandleMessage(var Msg: TMessage); override;
    function DoCreateControl(pstrStr: string): CControlUI; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAppsWindow }

constructor TAppsWindow.Create;
begin
  inherited Create('');
end;

destructor TAppsWindow.Destroy;
begin

  inherited;
end;

function TAppsWindow.DoCreateControl(pstrStr: string): CControlUI;
begin
  Result := nil;
end;

procedure TAppsWindow.DoHandleMessage(var Msg: TMessage);
begin
  inherited;

end;

procedure TAppsWindow.DoNotify(var Msg: TMessage);
begin
  inherited;

end;

end.
