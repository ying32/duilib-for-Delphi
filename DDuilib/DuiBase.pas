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

interface

uses
  System.TypInfo,
  System.Rtti,
  Duilib;

type

   TDuiNotify = procedure(Sender: TObject;  var Msg: TNotifyUI) of object;

  {$RTTI EXPLICIT METHODS([vcProtected])}
  TDuiBase<T> = class(TObject)
  private
    function GetThisControlUI: CControlUI;
  protected
    FThis: T;
  public
    function GetMethodAddr(const AName: string): Pointer;
  public
    property This: T read FThis;
    property ThisControlUI: CControlUI read GetThisControlUI;
  end;

implementation

{ TDuiBase<T> }

function TDuiBase<T>.GetThisControlUI: CControlUI;
begin
  Result := PPointer(@FThis)^;
end;

function TDuiBase<T>.GetMethodAddr(const AName: string): Pointer;
var
  T: TRttiType;
begin
  T := TRttiContext.Create.GetType(ClassType);
  Result := T.GetMethod(AName).CodeAddress;
  T.Free;
end;

end.
