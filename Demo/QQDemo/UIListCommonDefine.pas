//***************************************************************************
//
//       名称：UIListCommonDefine.pas
//       工具：RAD Studio XE6
//       作者：ying32
//       改自duilib qq demo下的UIListCommonDefine.cpp
//
//***************************************************************************
unit UIListCommonDefine;

{$I DDuilib.inc}

interface

uses
  Math,
  Classes,
  SysUtils,
{$IFNDEF UseLowVer}
  System.Generics.Collections,
{$ENDIF}
  Duilib;

type
  TNodeData = packed record
    Level: Integer;
    Folder: Boolean;
    ChildVisible: Boolean;
    HasChild: Boolean;
    Text: string;
    Value: string;
    ListElment: CListContainerElementUI;
  end;

  PNodeData = ^TNodeData;

  TNode = class
  private
   {$IFNDEF UseLowVer}
    FChildrens: TObjectList<TNode>;
   {$ELSE}
    FChildrens: TList;
   {$ENDIF}
    FParent: TNode;
    FNodeData: TNodeData;
    procedure SetParent(AParent: TNode);
    function GetLastChild: TNode;
   // 这个绝对是偷懒行为
    function GetNodeData: PNodeData;
    function GetCount: Integer;
    function GetChild(index: Integer): TNode;
    function GetFolder: Boolean;
    function GetHasChildren: Boolean;
  public
    constructor Create; overload;
    constructor Create(ANodeData: TNodeData; AParent: TNode); overload;
    constructor Create(ANodeData: TNodeData); overload;
    destructor Destroy; override;
    procedure Add(AChild: TNode);
    procedure Remove(AChild: TNode);
  public
    property HasChildren: Boolean read GetHasChildren;
    property Folder: Boolean read GetFolder;
    property Parent: TNode read FParent;
    property NodeData: PNodeData read GetNodeData;
    property LastChild: TNode read GetLastChild;
    property Count: Integer read GetCount;
    property Childs[Index: Integer]: TNode read GetChild;
  end;

function CalculateDelay(state: double): Double;

implementation

function CalculateDelay(state: double): Double;
begin
  Result := Power(state, 2);
end;

{ TNode }

constructor TNode.Create;
begin
  inherited;
  {$IFNDEF UseLowVer}
    FChildrens := TObjectList<TNode>.Create;
  {$ELSE}
    FChildrens := TList.Create;
  {$ENDIF}
end;

constructor TNode.Create(ANodeData: TNodeData; AParent: TNode);
begin
  FNodeData := ANodeData;
  FParent := AParent;
  Create;
end;

constructor TNode.Create(ANodeData: TNodeData);
begin
  Create(ANodeData, nil);
end;

destructor TNode.Destroy;
{$IFDEF UseLowVer}
var
  I: Integer;
{$ENDIF}
begin
{$IFDEF UseLowVer}
  for I := 0 to FChildrens.Count - 1 do
    TNode(FChildrens[I]).Free;
{$ENDIF}
  FChildrens.Free;
  inherited;
end;

procedure TNode.Add(AChild: TNode);
begin
  AChild.SetParent(Self);
  FChildrens.Add(AChild);
end;

function TNode.GetChild(index: Integer): TNode;
begin
  Result := FChildrens[index];
end;

function TNode.GetNodeData: PNodeData;
begin
  Result := @FNodeData;
end;

function TNode.GetFolder: Boolean;
begin
  Result := FNodeData.Folder;
end;

function TNode.GetLastChild: TNode;
begin
  if HasChildren then
    Result := Childs[GetCount - 1].GetLastChild
  else
    Result := Self;
end;

function TNode.GetHasChildren: Boolean;
begin
  Result := GetCount > 0;
end;

function TNode.GetCount: Integer;
begin
  Result := FChildrens.Count;
end;

procedure TNode.Remove(AChild: TNode);
begin
  FChildrens.Remove(AChild);
end;

procedure TNode.SetParent(AParent: TNode);
begin
  FParent := AParent;
end;

end.

