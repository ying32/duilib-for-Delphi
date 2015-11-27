///=======================================================
///
/// 日期：2015-11-25
/// 作者：ying32
///
///=======================================================
unit uOthers;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TOthers = class
  public
    class procedure AddDelphiDuiStringA(AFile: TStringList);
    class procedure AddDelphiDuiStringB(AFile: TStringList);
    class procedure AddTResourceType(AFile: TStringList);
    class procedure AddTNotifyUIStruct(AFile: TStringList);
    /// <summary>
    ///   其它类型，暂未翻译的
    /// </summary>
    class procedure AddOtherType(AFile: TStringList);
    class procedure AddDefualtConst(AFile: TStringList);
    class procedure AddDelphiCommentHeader(AFile: TStringList);
    class procedure AddCppHeaderCommentHeader(AFile: TStringList);
    class procedure AddCppSourceCommentHeader(AFile: TStringList);
  end;

implementation

{ TOthers }

{
  // 只需要的
  CStdStringPtrMap = class;
  CMarkup = class;
  CMarkupNode = class;
  CControlUI = class;
  CPaintManagerUI = class;
  CScrollBarUI = class;
  CTreeViewUI = class;
  CListHeaderUI = class;
}


class procedure TOthers.AddCppHeaderCommentHeader(AFile: TStringList);
begin
  AFile.Add('//*******************************************************************');
  AFile.Add('//');
  AFile.Add('//       作者：ying32');
  AFile.Add('//       QQ  ：1444386932');
  AFile.Add('//       E-mail：1444386932@qq.com');
  AFile.Add(Format('//       本单元由CppConvert工具自动生成于%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now)]));
  AFile.Add('//       版权所有 (C) 2015-2015 ying32 All Rights Reserved');
  AFile.Add('//');
  AFile.Add('//*******************************************************************');
end;

class procedure TOthers.AddCppSourceCommentHeader(AFile: TStringList);
begin
  AFile.Add('//*******************************************************************');
  AFile.Add('//');
  AFile.Add('//       作者：ying32');
  AFile.Add('//       QQ  ：1444386932');
  AFile.Add('//       E-mail：1444386932@qq.com');
  AFile.Add(Format('//       本单元由CppConvert工具自动生成于%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now)]));
  AFile.Add('//       版权所有 (C) 2015-2015 ying32 All Rights Reserved');
  AFile.Add('//');
  AFile.Add('//*******************************************************************');
end;

class procedure TOthers.AddDefualtConst(AFile: TStringList);
begin
  AFile.Add('  UI_WNDSTYLE_CONTAINER   = 0;');
  AFile.Add('  UI_WNDSTYLE_FRAME       = WS_VISIBLE or WS_OVERLAPPEDWINDOW;');
  AFile.Add('  UI_WNDSTYLE_CHILD       = WS_VISIBLE or WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN;');
  AFile.Add('  UI_WNDSTYLE_DIALOG      = WS_VISIBLE or WS_POPUPWINDOW or WS_CAPTION or WS_DLGFRAME or WS_CLIPSIBLINGS or WS_CLIPCHILDREN;');
  AFile.Add('');
  AFile.Add('  UI_WNDSTYLE_EX_FRAME    = WS_EX_WINDOWEDGE;');
  AFile.Add('  UI_WNDSTYLE_EX_DIALOG   = WS_EX_TOOLWINDOW or WS_EX_DLGMODALFRAME;');
  AFile.Add('');
  AFile.Add('  UI_CLASSSTYLE_CONTAINER  = 0;');
  AFile.Add('  UI_CLASSSTYLE_FRAME      = CS_VREDRAW or CS_HREDRAW;');
  AFile.Add('  UI_CLASSSTYLE_CHILD      = CS_VREDRAW or CS_HREDRAW or CS_DBLCLKS or CS_SAVEBITS;');
  AFile.Add('  UI_CLASSSTYLE_DIALOG     = CS_VREDRAW or CS_HREDRAW or CS_DBLCLKS or CS_SAVEBITS;');
  AFile.Add('');
  AFile.Add('  UILIST_MAX_COLUMNS = 32;');
  AFile.Add('');

  AFile.Add('  XMLFILE_ENCODING_UTF8    = 0;');
  AFile.Add('  XMLFILE_ENCODING_UNICODE = 1;');
  AFile.Add('  XMLFILE_ENCODING_ASNI    = 2;');
  AFile.Add('');


end;

class procedure TOthers.AddDelphiCommentHeader(AFile: TStringList);
begin
  AFile.Add('//***************************************************************************');
  AFile.Add('//');
  AFile.Add('//       名称：Duilib.pas');
  AFile.Add('//       作者：ying32');
  AFile.Add('//       QQ  ：1444386932');
  AFile.Add('//       E-mail：1444386932@qq.com');
  AFile.Add(Format('//       本单元由CppConvert工具自动生成于%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now)]));
  AFile.Add('//       版权所有 (C) 2015 ying32 All Rights Reserved');
  AFile.Add('//');
  AFile.Add('//       1、以C开头的都是用来桥接C++类的，理论上是不给继承，除非是c++的类');
  // AFile.Add('//       2、类中的方法及字段必须严格对照c++中类方法和字段的顺序');                               // 已经不走这条路了
  // AFile.Add('//       也只允许2种，一是变量，二是虚方法需要应，不包括以static标识，普通成员函数');            // 已经不走这条路了
  // AFile.Add('//       桥接类中的 public 字段不要乱用，本来定义为protected,因跨单元不能访问，则改为public');   // 已经不走这条路了
  AFile.Add('//       2、导出的方法原为__thiscall，Delphi中采用stdcall来调用，调用的时候将类指针地址放入ecx寄存器中');
  AFile.Add('//');
  // AFile.Add('//       虚函数__thiscall问题，到Delphi这里了没这一约定，只能老老实实干点其它的了'); // 已经不走这条路了
  AFile.Add('//');
  AFile.Add('//***************************************************************************');
end;

class procedure TOthers.AddDelphiDuiStringA(AFile: TStringList);
begin
  AFile.Add('  //CDuiString = array[0..65] of Char; // 132 byte');
  AFile.Add('  // MAX_LOCAL_STRING_LEN = 63 + 1 + 1 + #0 = 66byte');
  AFile.Add('  // 这里定义为一个记录， 因为他内部返回的并不是一个指针，so，字段大小不一样了，只能改record方式来做');
  AFile.Add('  PCDuiString = ^CDuiString; // 这个有点牵强吧');
  AFile.Add('  CDuiString = record');
  AFile.Add('  const');
  AFile.Add('    MAX_LOCAL_STRING_LEN = 63;');
  AFile.Add('  private // 这个方法不知道从哪个版本的Delphi支持');
  AFile.Add('    /// <summary>');
  AFile.Add('    ///   这个不要用，使用　ToString');
  AFile.Add('    /// </summary>');
  AFile.Add('    szStr:array[0..65] of Char;');
  AFile.Add('  public');
  AFile.Add('    class operator Equal(const Lhs, Rhs : CDuiString) : Boolean; overload;');
  AFile.Add('    class operator Equal(const Lhs: CDuiString; Rhs : string) : Boolean; overload;');
  AFile.Add('    class operator Equal(const Lhs: string; Rhs : CDuiString) : Boolean; overload;');
  AFile.Add('    class operator NotEqual(const Lhs, Rhs : CDuiString): Boolean; overload;');
  AFile.Add('    class operator NotEqual(const Lhs: CDuiString; Rhs : string): Boolean; overload;');
  AFile.Add('    class operator NotEqual(const Lhs: string; Rhs : CDuiString): Boolean; overload;');
  AFile.Add('');
  AFile.Add('    class operator Implicit(const AStr: string): CDuiString; overload;');
  AFile.Add('    class operator Implicit(ADuiStr: CDuiString): string; overload;');
  AFile.Add('    class operator Explicit(ADuiStr: CDuiString): string;');
  AFile.Add('');
  AFile.Add('    function ToString: string;');
  AFile.Add('    function Length: Integer;');
  AFile.Add('    function IsEmpty: Boolean;');
  AFile.Add('  end;');
end;

class procedure TOthers.AddDelphiDuiStringB(AFile: TStringList);
begin
  AFile.Add('{ CDuiString }');
  AFile.Add('');
  AFile.Add('class operator CDuiString.Equal(const Lhs, Rhs: CDuiString): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs.ToString = Rhs.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.Equal(const Lhs: CDuiString; Rhs: string): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs.ToString = Rhs;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.Equal(const Lhs: string; Rhs: CDuiString): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs = Rhs.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.Explicit(ADuiStr: CDuiString): string;');
  AFile.Add('begin');
  AFile.Add('  Result := ADuiStr.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('// 他这个貌似只是临时性的，所以没啥关系吧');
  AFile.Add('class operator CDuiString.Implicit(const AStr: string): CDuiString;');
  AFile.Add('var');
  AFile.Add('  LLen: Integer;');
  AFile.Add('  LBytes: TBytes;');
  AFile.Add('begin');
  AFile.Add('  LBytes := TEncoding.Unicode.GetBytes(AStr + #0);');
  AFile.Add('  LLen := System.Length(LBytes);');
  AFile.Add('  if LLen > MAX_LOCAL_STRING_LEN then');
  AFile.Add('    LLen := MAX_LOCAL_STRING_LEN;');
  AFile.Add('  Move(LBytes[0], Result.szStr[2], LLen);');
  AFile.Add('end;');

  AFile.Add('');
  AFile.Add('class operator CDuiString.Implicit(ADuiStr: CDuiString): string;');
  AFile.Add('begin');
  AFile.Add('  Result := ADuiStr.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('function CDuiString.IsEmpty: Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := ToString.IsEmpty;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('function CDuiString.Length: Integer;');
  AFile.Add('begin');
  AFile.Add('  Result := ToString.Length;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.NotEqual(const Lhs, Rhs: CDuiString): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs.ToString <> Rhs.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.NotEqual(const Lhs: CDuiString; Rhs: string): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs.ToString <> Rhs;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('class operator CDuiString.NotEqual(const Lhs: string; Rhs: CDuiString): Boolean;');
  AFile.Add('begin');
  AFile.Add('  Result := Lhs <> Rhs.ToString;');
  AFile.Add('end;');
  AFile.Add('');
  AFile.Add('function CDuiString.ToString: string;');
  AFile.Add('begin');
  AFile.Add('  Result := PChar(@szStr[2]);');
  AFile.Add('end;');
end;

class procedure TOthers.AddOtherType(AFile: TStringList);
begin
  // typedef CControlUI* (CALLBACK* FINDCONTROLPROC)(CControlUI*, LPVOID);
  AFile.Add('  FINDCONTROLPROC = function(AControl: CControlUI; P: LPVOID): CControlUI; cdecl;');
  AFile.Add('  TFindControlProc = FINDCONTROLPROC;');

  AFile.Add('  INotifyUI = Pointer;');
  AFile.Add('  IMessageFilterUI = Pointer;');
//  AFile.Add('  CNotifyPump = class(TObject) end;');
  AFile.Add('  IListCallbackUI = Pointer;');
//  AFile.Add('  CListHeaderUI = class(TObject) end;');
  AFile.Add('  CWebBrowserEventHandler = class(TObject) end;');
//  AFile.Add('  CScrollBarUI = class(TObject) end;');
  AFile.Add('  ITranslateAccelerator = Pointer;');
  AFile.Add('  IDialogBuilderCallback = Pointer;');
//  AFile.Add('  STRINGorID = class');
//  AFile.Add('  public');
//  AFile.Add('    m_lpstr: LPCTSTR;');
//  AFile.Add('  end;');
  AFile.Add('  IListOwnerUI = Pointer;');
  AFile.Add('  STRINGorID = PWideChar; // 暂改');
  AFile.Add('  IDropTarget = Pointer;');
  AFile.Add('  PLRESULT = ^LRESULT;');
  // typedef int (CALLBACK *PULVCompareFunc)(UINT_PTR, UINT_PTR, UINT_PTR);
  AFile.Add('  PULVCompareFunc = function(p1, p2, p3: UINT_PTR): Integer; cdecl;');
end;

class procedure TOthers.AddTNotifyUIStruct(AFile: TStringList);
begin
  AFile.Add('  TNotifyUI = packed record');
  AFile.Add('    sType: CDuiString;');
  AFile.Add('    sVirtualWnd: CDuiString;');
  AFile.Add('    pSender: CControlUI;');
  AFile.Add('    dwTimestamp: DWORD;');
  AFile.Add('    ptMouse: TPoint;');
  AFile.Add('    wParam: WPARAM;');
  AFile.Add('    lParam: LPARAM;');
  AFile.Add('  end;');
end;

class procedure TOthers.AddTResourceType(AFile: TStringList);
begin
  AFile.Add('  /// <summary>');
  AFile.Add('  ///  来自磁盘文件, 来自磁盘zip压缩包, 来自资源, 来自资源的zip压缩包 , 使用 {$Z4+} 指令对齐4字节');
  AFile.Add('  /// </summary>');
  AFile.Add('  {$Z4+}');
  AFile.Add('  UILIB_RESOURCETYPE  = (UILIB_FILE = 1, UILIB_ZIP, UILIB_RESOURCE, UILIB_ZIPRESOURCE);');
  AFile.Add('  TResourceType = UILIB_RESOURCETYPE;');
end;

end.
