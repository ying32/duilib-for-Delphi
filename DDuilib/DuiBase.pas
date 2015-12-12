//***************************************************************************
//
//       名称：DuiBase.pas
//       工具：RAD Studio XE6
//       日期：2015/11/18 20:33:15
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：yuanfen3287@vip.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//
//***************************************************************************
unit DuiBase;

{$I DDuilib.inc}

interface

uses
  TypInfo,
{$IFNDEF UseLowVer}
  Rtti,
{$ENDIF}
  Duilib;



type
  {$IFNDEF UseLowVer}
    {$RTTI EXPLICIT METHODS([vcProtected])}
  {$ElSE}
    {$M+}
  {$ENDIF}
  {$IFDEF FPC}generic{$ENDIF}TDuiBase{$IFDEF SuppoertGeneric}<T>{$ENDIF} = class(TObject)
  private
    function GetThisControlUI: CControlUI;
  strict protected
    FThis: {$IFDEF SuppoertGeneric}T{$ELSE}Pointer{$ENDIF};
  public
    function GetMethodAddr(const AName: string): Pointer;
  public
    property this: {$IFDEF SuppoertGeneric}T{$ELSE}Pointer{$ENDIF} read FThis;
    property ControlUI: CControlUI read GetThisControlUI;
  end;

implementation

{ TDuiBase<T> }

function TDuiBase{$IF Defined(SuppoertGeneric) and not Defined(FPC)}<T>{$ENDIF}.GetThisControlUI: CControlUI;
begin
  Result := {$IFDEF SuppoertGeneric}PPointer(@FThis)^{$ELSE}FThis{$ENDIF};
end;

function TDuiBase{$IF Defined(SuppoertGeneric) and not Defined(FPC)}<T>{$ENDIF}.GetMethodAddr(const AName: string): Pointer;
{$IFNDEF UseLowVer}
var
  T: TRttiType;
begin
  T := TRttiContext.Create.GetType(ClassType);
  Result := T.GetMethod(AName).CodeAddress;
  T.Free;
end;
{$ELSE}
begin
  Result := MethodAddress(AName);
end;
{$ENDIF}

end.
