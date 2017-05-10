// FPC的定义
{$IFDEF FPC}   // fpc需要最低2.4.4支持
  {$mode delphi}
  {$DEFINE UseLowVer}
  // fcp中使用兼容delphi语法
  {'$DEFINE SupportGeneric}
  {$DEFINE SupportInline}
{$ENDIF}

// 非Unicode模式下全部使用Ansi版本
{$IFNDEF UNICODE}
  {$IFNDEF UseLowVer}
    {$DEFINE UseLowVer}
  {$ENDIF}
{$ENDIF}

// 泛型支持
{$IFNDEF UseLowVer}
   {$IFNDEF SupportGeneric}
     {$DEFINE SupportGeneric}
   {$ENDIF}
   {$IFNDEF SupportInline}
     {$DEFINE SupportInline}
   {$ENDIF}
{$ENDIF}

// 是Delphi还是FPC的泛型，当mode使用delphi时好像能兼容Delphi的泛型
{$IFDEF SupportGeneric}
  {$IFDEF FPC}
     {$DEFINE FPCGeneric}  // fpc 2.4.4后支持
  {$ELSE}
     {$DEFINE DelphiGeneric}
  {$ENDIF}
{$ENDIF}

// 因vc中fastcall与delphi中register有不同处，大至为
// delphi使用  eax, edx, ecx　作为前三个参数
// vc使用 ecx edx作为前两个参数
// fpc中又有不一样，所以才用通用方式吧
{$IFNDEF FPC}
  {$DEFINE UseVcFastCall}
{$ENDIF}

