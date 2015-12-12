{$IFDEF FPC}
  {$IFNDEF UseLowVer}
    {$DEFINE UseLowVer}
  {$ENDIF}
{$ENDIF}

{$IFNDEF UNICODE}
   {$DEFINE UseLowVer}
{$ENDIF}

// 泛型支持
{$IF Defined(FPC) or not Defined(UseLowVer)}
   {$DEFINE SuppoertGeneric}
{$ENDIF}
