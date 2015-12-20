unit SuperBind;

interface

uses
  SysUtils, superobject;

type
  IJsonDataBinding = interface
  ['{AEBBFBC1-5753-41B6-B718-228FA3A9C809}']
    { Methods }
    function  Implementator: TObject;
    procedure Clear;
    procedure FromSO(const ASo: ISuperObject);
    procedure FromString(const AStr: SOString);
    procedure FromFile(const AFileName: SOString; AStrict: Boolean = False);
    function  ToString: SOString;
    function  ToJson(AIndent: Boolean = False; AEscape: Boolean = True): SOString;
    function  ToFile(const AFileName: SOString; AIndent: Boolean = False; AEscape: Boolean = True): Boolean;
    function  AsSO(): ISuperObject;
  end;

 IJsonDataBindingList = interface
 ['{5CBF7F08-3F9B-464E-A305-BF89FBD2A2EC}']
    { Property Accessors }
    function Get_Length: Integer;
    function Get_ItemAt(const Index: Integer): IJsonDataBinding;
    function Get_Item(const AKey, AValue: SOString): IJsonDataBinding;
    procedure Set_ItemAt(const Index: Integer; const Value: IJsonDataBinding);
    procedure Set_Item(const AKey, AValue: SOString; const Value: IJsonDataBinding);

    { Methods  }
    function  NewItem(const AImpl: ISuperObject): IJsonDataBinding; 
    function  First: IJsonDataBinding;
    function  Last: IJsonDataBinding;
    function  Add: IJsonDataBinding;
    function  Insert(const Index: Integer): IJsonDataBinding;
    procedure Delete(Index: Integer);
    function  IndexOf(const AItem: IJsonDataBinding): Integer; overload;
    function  IndexOf(const AItem: ISuperObject): Integer; overload;
    function  IndexOf(const AKey, AValue: SOString): Integer; overload;
    function  Remove(const AItem: IJsonDataBinding): Integer; overload;
    function  Remove(const AItem: ISuperObject): Integer; overload;
    function  Remove(const AKey, AValue: SOString): Integer; overload;

    { Properties }
    property Length: Integer read Get_Length;
    property Items[const AKey, AValue: SOString]: IJsonDataBinding read Get_Item write Set_Item;
    property ItemAt[const Index: Integer]: IJsonDataBinding read Get_ItemAt write Set_ItemAt; default;
  end;
  TJsonDataBindingClass = class of TJsonDataBinding;
  TJsonDataBinding = class(TInterfacedObject, IJsonDataBinding)
  private
    F_Impl: ISuperObject;
    function Get__Impl: ISuperObject;
  protected
    property _Impl: ISuperObject read Get__Impl;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
  public
    constructor Create(const AImpl: ISuperObject = nil); virtual;
    
    { Methods }
    function  Implementator: TObject;
    procedure Clear; virtual;
    procedure FromSO(const ASo: ISuperObject);
    procedure FromString(const AStr: SOString);
    procedure FromFile(const AFileName: SOString; AStrict: Boolean = False);
    function  ToString: SOString;
    function  ToJson(AIndent: Boolean = False; AEscape: Boolean = True): SOString;
    function  ToFile(const AFileName: SOString; AIndent: Boolean = False; AEscape: Boolean = True): Boolean;
    function  AsSO(): ISuperObject;
  end;

 TJsonDataBindingList = class(TJsonDataBinding, IJsonDataBindingList)
 private
   FItemClass: TJsonDataBindingClass;
 protected
    { Property Accessors }
    function Get_Length: Integer;
    function Get_ItemAt(const Index: Integer): IJsonDataBinding;
    function Get_Item(const AKey, AValue: SOString): IJsonDataBinding;
    procedure Set_ItemAt(const Index: Integer; const Value: IJsonDataBinding);
    procedure Set_Item(const AKey, AValue: SOString; const Value: IJsonDataBinding);
 public
    constructor Create(const AImpl: ISuperObject; const AItemClass: TJsonDataBindingClass); reintroduce; virtual; 
    { Methods  }
    function  NewItem(const AImpl: ISuperObject): IJsonDataBinding;
    function  First: IJsonDataBinding;
    function  Last: IJsonDataBinding;
    function  Add: IJsonDataBinding;
    function  Insert(const Index: Integer): IJsonDataBinding;
    procedure Delete(Index: Integer);
    function  IndexOf(const AItem: IJsonDataBinding): Integer; overload;
    function  IndexOf(const AItem: ISuperObject): Integer; overload;
    function  IndexOf(const AKey, AValue: SOString): Integer; overload;
    function  Remove(const AItem: IJsonDataBinding): Integer; overload;
    function  Remove(const AItem: ISuperObject): Integer; overload;
    function  Remove(const AKey, AValue: SOString): Integer; overload;

    { Properties }
    property Length: Integer read Get_Length;
    property Items[const AKey, AValue: SOString]: IJsonDataBinding read Get_Item write Set_Item;
    property ItemAt[const Index: Integer]: IJsonDataBinding read Get_ItemAt write Set_ItemAt; default;
  end;

function SA(const AStr: SOString = '[]'): ISuperObject;

implementation

function SA(const AStr: SOString): ISuperObject;
begin
  Result := SO(AStr)
end;

{ TJsonDataBinding }

procedure TJsonDataBinding.Clear;
begin
  F_Impl := nil;
end;

constructor TJsonDataBinding.Create(const AImpl: ISuperObject);
begin
  F_Impl := AImpl;
end;

procedure TJsonDataBinding.FromFile(const AFileName: SOString;
  AStrict: Boolean);
begin
  Clear;
  F_Impl := TSuperObject.ParseFile(AFileName, AStrict)
end;

procedure TJsonDataBinding.FromSO(const ASo: ISuperObject);
begin
  Clear;
  F_Impl := ASo;
end;

procedure TJsonDataBinding.FromString(const AStr: SOString);
begin
  Clear;
  F_Impl := SO(AStr)
end;

function TJsonDataBinding.Get__Impl: ISuperObject;
begin
  if F_Impl = nil then
    F_Impl := SO();
  Result := F_Impl;
end;

function TJsonDataBinding.Implementator: TObject;
begin
  Result := Self;
end;

function TJsonDataBinding.ToFile(const AFileName: SOString; AIndent,
  AEscape: Boolean): Boolean;
begin
  Result := _Impl.SaveTo(AFileName, AIndent, AEscape) > 0;
end;

function TJsonDataBinding.ToJson(AIndent, AEscape: Boolean): SOString;
begin
  Result := _Impl.AsJSon(AIndent, AEscape);
end;

function TJsonDataBinding.AsSO: ISuperObject;
begin
  Result := _Impl;
end;

function TJsonDataBinding.ToString: SOString;
begin
  Result := _Impl.AsString;
end;

function TJsonDataBinding.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
  if Result = E_NOINTERFACE then
    Result := _Impl.QueryInterface(IID, Obj);
end;

{ TJsonDataBindingList }

function TJsonDataBindingList.Add: IJsonDataBinding;
var
  o: ISuperObject;
begin
  o := SO();
  _Impl.AsArray.Add(o);
  Result := NewItem(o);
end;

constructor TJsonDataBindingList.Create(const AImpl: ISuperObject;
  const AItemClass: TJsonDataBindingClass);
begin
  inherited Create(AImpl);
  if AItemClass = nil then
    FItemClass := TJsonDataBinding
  else
    FItemClass := AItemClass;
end;

procedure TJsonDataBindingList.Delete(Index: Integer);
begin
  _Impl.AsArray.Delete(Index)
end;

function TJsonDataBindingList.First: IJsonDataBinding;
begin
  if Get_Length > 0 then
    Result := Get_ItemAt(0)
  else
    Result := nil;
end;

function TJsonDataBindingList.Get_Item(const AKey,
  AValue: WideString): IJsonDataBinding;
var
  o: ISuperObject;
  i: Integer;
begin
  Result := nil;
  for i := 0 to _Impl.AsArray.Length - 1 do
  begin
    o := _Impl.AsArray[i];
    if WideSameText(o.S[AKey], AValue) then
    begin
      Result := NewItem(o);
      break;
    end;
  end;
end;

function TJsonDataBindingList.Get_ItemAt(
  const Index: Integer): IJsonDataBinding;
var
  o: ISuperObject;
begin
  o := _Impl.AsArray[Index];
  if o = nil then
    Result := nil
  else
    Result := NewItem(o);
end;

function TJsonDataBindingList.Get_Length: Integer;
begin
  Result := _Impl.AsArray.Length;
end;

function TJsonDataBindingList.IndexOf(const AKey,
  AValue: SOString): Integer;
var
  o: ISuperObject;
begin
  for Result := 0 to Get_Length - 1 do
  begin
    o := _Impl.AsArray[Result];
    if o = nil then
      Exit;

   if WideSameText(AValue, o.S[AKey]) then
     Exit;
  end;
  Result := -1;
end;

function TJsonDataBindingList.IndexOf(
  const AItem: IJsonDataBinding): Integer;
var
  LItemSO: ISuperObject;
begin
  LItemSO := AItem.AsSO;
  for Result := 0 to Get_Length - 1 do
  begin
   if LItemSO = _Impl.AsArray[Result] then
     Exit;
  end;
  Result := -1;
end;

function TJsonDataBindingList.IndexOf(const AItem: ISuperObject): Integer;
begin
  for Result := 0 to Get_Length - 1 do
  begin
   if AItem = _Impl.AsArray[Result] then
     Exit;
  end;
  Result := -1;
end;

function TJsonDataBindingList.Insert(
  const Index: Integer): IJsonDataBinding;
var
  o: ISuperObject;
begin
  o := SO();
  _Impl.AsArray.Insert(Index, o);
  Result := NewItem(o);
end;

function TJsonDataBindingList.Last: IJsonDataBinding;
begin
  if Get_Length > 0 then
    Result := Get_ItemAt(Get_Length-1)
  else
    Result := nil;
end;

function TJsonDataBindingList.NewItem(
  const AImpl: ISuperObject): IJsonDataBinding;
begin
  Result := FItemClass.Create(AImpl);
end;

function TJsonDataBindingList.Remove(const AKey,
  AValue: SOString): Integer;
begin
  Result := IndexOf(AKey, AValue);
  if Result >= 0 then
    _Impl.AsArray.Delete(Result);
end;

function TJsonDataBindingList.Remove(
  const AItem: IJsonDataBinding): Integer;
begin
  Result := IndexOf(AItem);
  if Result >= 0 then
    _Impl.AsArray.Delete(Result);
end;

function TJsonDataBindingList.Remove(const AItem: ISuperObject): Integer;
begin
  Result := IndexOf(AItem);
  if Result >= 0 then
    _Impl.AsArray.Delete(Result);
end;

procedure TJsonDataBindingList.Set_Item(const AKey, AValue: WideString;
  const Value: IJsonDataBinding);
var
  o: ISuperObject;
  i: Integer;
begin
  for i := 0 to _Impl.AsArray.Length - 1 do
  begin
    o := _Impl.AsArray[i];
    if o = nil then
      continue;
      
    if WideSameText(o.S[AKey], AValue) then
    begin
      Set_ItemAt(i, Value);
      break;
    end;
  end;
end;

procedure TJsonDataBindingList.Set_ItemAt(const Index: Integer;
  const Value: IJsonDataBinding);
begin
  if Value = nil then
    _Impl.AsArray[Index] := nil
  else
    _Impl.AsArray[Index] := Value.AsSO;
end;


end.
