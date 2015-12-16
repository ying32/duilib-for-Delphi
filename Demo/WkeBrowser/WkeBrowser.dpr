program WkeBrowser;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Classes,
  Duilib,
  DuiWkeBrowser;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
