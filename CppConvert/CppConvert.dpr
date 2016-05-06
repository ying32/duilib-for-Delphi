program CppConvert;

{$APPTYPE CONSOLE}

{$R *.res}

uses
//  winapi.Windows,
  System.SysUtils,
  uConvert in 'uConvert.pas',
  uOthers in 'uOthers.pas';


var
  gFileName: string;

procedure Test1;
var
  Cpp: TCppConvert;
begin
  Writeln('开始处理');

  Cpp := TCppConvert.Create;
  try
    Writeln('处理文档：', gFileName);
    Cpp.LoadFromFile(gFileName);
    Cpp.SaveCppFile;
    Cpp.SaveDelphiFile;
  finally
    Cpp.Free;
  end;
  Writeln('完成。');
  Writeln('请按[Enter]键退出。');
end;

begin
  try
    Writeln('拖一个文件到窗口：');
    Readln(gFileName);
    if FileExists(gFileName) then
      Test1;
    readln;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
