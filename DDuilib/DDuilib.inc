{$IFDEF FPC}
  {$DEFINE UseLowVer}
  // fcp中使用兼容delphi语法
  {$mode delphi}
{$ENDIF}

{$IFNDEF UNICODE}
   {$DEFINE UseLowVer}
{$ENDIF}

// 泛型支持
//{$IF Defined(FPC) or not Defined(UseLowVer)}
{$IFNDEF UseLowVer}
   {$DEFINE SupportGeneric}
{$ENDIF}
