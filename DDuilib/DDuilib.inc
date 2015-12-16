// FPC的定义
{$IFDEF FPC}
  {$mode delphi}
  {$DEFINE UseLowVer}
  // fcp中使用兼容delphi语法
  {$DEFINE SupportGeneric}
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
     {$DEFINE FPCGeneric}
  {$ELSE}
     {$DEFINE DelphiGeneric}
  {$ENDIF}
{$ENDIF}


