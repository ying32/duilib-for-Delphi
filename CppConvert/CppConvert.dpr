program CppConvert;

{$APPTYPE CONSOLE}

{$R *.res}

uses
//  winapi.Windows,
  System.SysUtils,
  uConvert in 'uConvert.pas',
  uOthers in 'uOthers.pas';


procedure Test1;
var
  Cpp: TCppConvert;
begin
  Writeln('开始处理');
  Cpp := TCppConvert.Create;
  try
    Writeln('处理文档：', ExtractFilePath(ParamStr(0)) + 'MakeList.txt');
    Cpp.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'MakeList.txt');
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
    Test1;
    readln;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
