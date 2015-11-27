unit UIListCommonDefine;

interface

uses
  System.Math,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Duilib;

type
 TNodeData = packed record
	 level_: Integer;
   folder_: Boolean;
   child_visible_: Boolean;
   has_child_: Boolean;
	 text_: CDuiString;
	 value: CDuiString;
	 list_elment_: CListContainerElementUI;
 end;
 PNodeData = ^TNodeData;

 TNode = class;

 TChildren = TObjectList<TNode>;

 TNode = class
 private
	 children_: TChildren;
   parent_: TNode;
	 data_: TNodeData;
   procedure set_parent(parent: TNode);
 public
   constructor Create; overload;
   constructor Create(t: TNodeData; parent: TNode); overload;
   constructor Create(t: TNodeData); overload;
   destructor Destroy; override;
   function num_children: Integer;
   function child(i: Integer): TNode;
   function parent: TNode;
   function folder: Boolean;
   function has_children: Boolean;
   procedure add_child(child: TNode);
   procedure remove_child(child: TNode);
   function get_last_child: TNode;
   function data: PNodeData;
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
  children_ := TChildren.Create;
end;

constructor TNode.Create(t: TNodeData; parent: TNode);
begin
  data_ := t;
  parent_ := parent;
  Create;
end;

constructor TNode.Create(t: TNodeData);
begin
  Create(t, nil);
end;

destructor TNode.Destroy;
begin
  children_.Free;
  inherited;
end;

procedure TNode.add_child(child: TNode);
begin
  child.set_parent(Self);
	children_.Add(child);
end;

function TNode.child(i: Integer): TNode;
begin
 Result := children_[i];
end;

function TNode.data: PNodeData;
begin
  Result := @data_;
end;


function TNode.folder: Boolean;
begin
  Result := data_.folder_;
end;

function TNode.get_last_child: TNode;
begin
  if has_children then
	  Result := child(num_children - 1).get_last_child
  else
	  Result := Self;
end;

function TNode.has_children: Boolean;
begin
  Result := num_children > 0;
end;

function TNode.num_children: Integer;
begin
  Result := children_.Count;
end;

function TNode.parent: TNode;
begin
  Result := parent_;
end;

procedure TNode.remove_child(child: TNode);
begin
  children_.Remove(child);
end;

procedure TNode.set_parent(parent: TNode);
begin
 parent_ := parent;
end;

end.
