unit TasksAllFrame;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ToolWin, TasksUnit, System.Actions,
  Vcl.ActnList, Vcl.Menus;

type
  TFrameTasksAll = class(TFrame)
    panelLeft: TPanel;
    panelRight: TPanel;
    Splitter1: TSplitter;
    lvAllTasks: TListView;
    gbTaskDetails: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    reTaskText: TRichEdit;
    lbAuthor: TLabel;
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    alTasks: TActionList;
    actTasksLoad: TAction;
    actTasksSave: TAction;
    actTasksRefresh: TAction;
    pmTasksList: TPopupMenu;
    N1: TMenuItem;
    Loadtasklist1: TMenuItem;
    Savetasklist1: TMenuItem;
    actTaskAdd: TAction;
    actTaskDel: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    cbbTaskStatus: TComboBoxEx;
    lbFiles: TLabel;
    procedure lvAllTasksChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure OnChangeHandler(Sender: TObject);
    procedure actTasksLoadExecute(Sender: TObject);
    procedure actTasksSaveExecute(Sender: TObject);
    procedure actTasksRefreshExecute(Sender: TObject);
    procedure actTaskAddExecute(Sender: TObject);
    procedure actTaskDelExecute(Sender: TObject);
  private
    { Private declarations }
    TaskList: TTaskList;
    // task data before edit
    SavedTaskData: string;
    SelectedTask: TTaskItem;
    IsChangeDisabled: Boolean;
    procedure LoadList();
    procedure SaveList();
    procedure NewItem(ASubItem: Boolean = False);
    procedure DeleteItem();
    procedure ReadSelectedTask();
    procedure WriteSelectedTask();
    procedure TaskToListItem(ATask: TTaskItem; li: TListItem);
    procedure RefreshTasksList(SelectedOnly: Boolean = False);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation

uses Main, MainFunc;

{$R *.dfm}

procedure TFrameTasksAll.actTaskAddExecute(Sender: TObject);
begin
  NewItem();
end;

procedure TFrameTasksAll.actTaskDelExecute(Sender: TObject);
begin
  DeleteItem();
end;

procedure TFrameTasksAll.actTasksLoadExecute(Sender: TObject);
begin
  LoadList();
end;

procedure TFrameTasksAll.actTasksRefreshExecute(Sender: TObject);
begin
  RefreshTasksList();
end;

procedure TFrameTasksAll.actTasksSaveExecute(Sender: TObject);
begin
  SaveList();
end;

constructor TFrameTasksAll.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(TaskList) then TaskList := TTaskList.Create();
  self.LoadList();
end;

destructor TFrameTasksAll.Destroy();
begin
  TaskList.Free();
  inherited Destroy();
end;

procedure TFrameTasksAll.OnChangeHandler(Sender: TObject);
begin
  WriteSelectedTask();
  RefreshTasksList(True);
end;

procedure TFrameTasksAll.RefreshTasksList(SelectedOnly: Boolean);
var
  Task: TTaskItem;
  li: TListItem;
  i: Integer;
begin
  if SelectedOnly then
  begin
    for i:=0 to TaskList.Count-1 do
    begin
      Task := TTaskItem(TaskList[i]);
      if Task = SelectedTask then
      begin
        li := lvAllTasks.Items[i];
        li.SubItems.Clear();
        TaskToListItem(Task, li);
        Exit;
      end;
    end;
    Exit;
  end;

  lvAllTasks.Clear();
  TaskList.Sort();
  for i := 0 to TaskList.Count-1 do
  begin
    Task := TTaskItem(TaskList[i]);
    li := lvAllTasks.Items.Add();
    TaskToListItem(Task, li);
    if Task = SelectedTask then
    begin
      li.Selected := True;
      li.Focused := True;
    end;
  end;
end;

procedure TFrameTasksAll.LoadList();
begin
  //
  SelectedTask := nil;
  SavedTaskData := '';
  TaskList.Clear();
  TaskList.LoadList();
  RefreshTasksList();
end;

procedure TFrameTasksAll.SaveList();
begin
  self.TaskList.SaveList();
end;

procedure TFrameTasksAll.TaskToListItem(ATask: TTaskItem; li: TListItem);
begin
  li.Data := ATask;
  li.StateIndex := TaskStateToIconIndex(ATask);
  li.Caption := ATask.Name;
  li.SubItems.Add(FormatDateTime('DD.MM.YY', ATask.BeginDate));
  li.SubItems.Add(ATask.Author);
end;

procedure TFrameTasksAll.NewItem(ASubItem: boolean = false);
var
  Task: TTaskItem;
  li: TListItem;
  i: integer;
begin
  Task := TTaskItem.Create();
  Task.Name := 'Новая задача';
  Task.Priority := 1;
  Task.Status := 0;
  Task.Author := 'Admin';
  Task.BeginDate := Now();
  Task.EndDate := Now();
  self.TaskList.Add(Task);

  li := lvAllTasks.Items.Add();
  TaskToListItem(Task, li);

  self.SelectedTask := Task;
  SavedTaskData := self.SelectedTask.ToString;
  ReadSelectedTask();
end;

procedure TFrameTasksAll.ReadSelectedTask();
var
  Task: TTaskItem;
begin
  if not Assigned(SelectedTask) then Exit;
  IsChangeDisabled := True;
  try
    Task := SelectedTask;
    cbbTaskStatus.ItemIndex := Task.Status;
    dtpBegin.DateTime := Task.BeginDate;
    dtpEnd.DateTime := Task.EndDate;
    lbAuthor.Caption := Task.Author;
    //lbPeriod.Caption := ''+DateTimeToStr(Task.BeginDate)+' - '+DateTimeToStr(Task.EndDate);
    reTaskText.Text := Task.Text;
  finally
    IsChangeDisabled := False;
  end;
end;

procedure TFrameTasksAll.WriteSelectedTask();
begin
  if not Assigned(SelectedTask) then Exit;
  if IsChangeDisabled then Exit;

  SelectedTask.Status := cbbTaskStatus.ItemIndex;
  SelectedTask.Priority := TaskStatusToPriority(SelectedTask.Status);
  SelectedTask.BeginDate := dtpBegin.DateTime;
  SelectedTask.EndDate := dtpEnd.DateTime;
  //SelectedTask.Author := lbAuthor.Caption;
  SelectedTask.Text := reTaskText.Text;
  SelectedTask.Name := '';
  if reTaskText.Lines.Count > 0 then
    SelectedTask.Name := reTaskText.Lines[0];
end;


procedure TFrameTasksAll.DeleteItem();
var
  i: Integer;
begin
  if not Assigned(SelectedTask) then Exit;
  i := lvAllTasks.ItemIndex;
  TaskList.Remove(SelectedTask);
  SelectedTask := nil;
  SavedTaskData := '';
  RefreshTasksList();
  while i >= lvAllTasks.Items.Count do Dec(i);
  if i < 0 then Exit;
  lvAllTasks.ItemIndex := i;
end;

procedure TFrameTasksAll.lvAllTasksChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  li: TListItem;
  Task: TTaskItem;
begin
  //if not AskApplyChanges then
  //  RestoreSelectedTask();
  RefreshTasksList(True);
  li := TListView(Sender).Selected;
  if not Assigned(li) then Exit;
  Task := li.Data;
  if not Assigned(Task) then Exit;
  SelectedTask := Task;
  SavedTaskData := SelectedTask.ToString;
  ReadSelectedTask();
end;

end.
