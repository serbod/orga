unit Frame_EnterpriseStructure;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ToolWin,
  PersonnelUnit, TasksUnit, LocalOrdersUnit;

type
  TFrameEnterpiseStructure = class(TFrame)
    panLeft: TPanel;
    panRight: TPanel;
    Splitter1: TSplitter;
    panLeftBottom: TPanel;
    tvDepartments: TTreeView;
    Splitter2: TSplitter;
    gbDeptInfo: TGroupBox;
    gbPersonnel: TGroupBox;
    gbTasks: TGroupBox;
    gbDeptExtraInfo: TGroupBox;
    lvDeptPersonnel: TListView;
    lvDeptTasks: TListView;
    MemoDeptExtraInfo: TMemo;
    procedure tvDepartmentsChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    ItemsList: TPersList;
    SelectedItem: TPersItem;
    SelItemTasks: TTaskList;
    SelItemLocalOrders: TLocOrderList;
    SelectedGroup: TPersItem;
    SelectedTask: TTaskItem;
    procedure LoadList();
    procedure SaveList();
    procedure ReadSelectedGroup();
  public
    { Public declarations }
    procedure AfterConstruction(); override;
  end;

implementation

{$R *.dfm}

uses
  Main, MainFunc, EnterpiseControls;

{ TFrameEnterpiseStructure }

procedure TFrameEnterpiseStructure.AfterConstruction;
begin
  inherited;
  self.Align := alClient;
  if not Assigned(ItemsList) then
    ItemsList := TPersList.Create();
  LoadList();
end;

procedure TFrameEnterpiseStructure.LoadList();
begin
  tvDepartments.Items.Clear();
  tvDepartments.Items.Clear();
  SelectedItem := nil;
  SelectedGroup := nil;
  ItemsList.Clear();
  ItemsList.LoadList();
  RefreshPersGroupsTree(tvDepartments, ItemsList, SelectedGroup, False);
end;

procedure TFrameEnterpiseStructure.SaveList();
begin
  ItemsList.SaveList();
end;

procedure TFrameEnterpiseStructure.ReadSelectedGroup();
var
  Item: TPersItem;
begin
  if not Assigned(self.SelectedGroup) then
    Exit;
  Item := self.SelectedGroup;
  if Item.ItemType <> TPersItemType.Group then
    Exit;

  MemoDeptExtraInfo.Clear();
  SelectedItem := nil;
  RefreshPersonItemsList(lvDeptPersonnel, ItemsList, SelectedGroup.ID, SelectedItem, False);

  // Tasks for selected department
  if not Assigned(SelItemTasks) then
    SelItemTasks := TTaskList.Create();

  SelItemTasks.Clear();
  SelItemTasks.SetFilter(TTaskFilterType.Department, SelectedGroup.ID);
  SelItemTasks.Sort();
  RefreshTasksList(lvDeptTasks, SelItemTasks, SelectedGroup.ID, SelectedTask, False);
  //ReadSelectedItem();
end;

procedure TFrameEnterpiseStructure.tvDepartmentsChange(Sender: TObject;
  Node: TTreeNode);
begin
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
    Exit;
  if SelectedGroup = TPersItem(Node.Data) then
    Exit;
  //WriteSelectedItem();
  SelectedGroup := TPersItem(Node.Data);
  ReadSelectedGroup();
end;

end.
