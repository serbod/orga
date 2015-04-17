unit TasksAllFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ToolWin, TasksUnit;

type
  TFrameTasksAll = class(TFrame)
    toolbarMain: TToolBar;
    tbRefresh: TToolButton;
    tbLoadTasks: TToolButton;
    tbSaveTasks: TToolButton;
    ToolButton4: TToolButton;
    panelLeft: TPanel;
    panelRight: TPanel;
    Splitter1: TSplitter;
    lvAllTasks: TListView;
    gbTaskDetails: TGroupBox;
    toolbarTaskEdit: TToolBar;
    tbAddTask: TToolButton;
    tbDeleteTask: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    trackbarPriority: TTrackBar;
    lbPriorityValue: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    trackbarStatus: TTrackBar;
    reTaskText: TRichEdit;
    lbAuthor: TLabel;
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    procedure trackbarPriorityChange(Sender: TObject);
    procedure tbClick(Sender: TObject);
    procedure lvAllTasksChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
    TaskList: TTaskList;
    SelectedTask: TTaskItem;
    procedure LoadList();
    procedure SaveList();
    procedure NewItem(ASubItem: boolean = false);
    procedure DeleteItem();
    procedure ReadSelectedTask();
    procedure WriteSelectedTask();
    procedure RefreshTasksList(SelectedOnly: boolean = false);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  end;

implementation
uses Main, MainFunc;

{$R *.dfm}

constructor TFrameTasksAll.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(TaskList) then TaskList:=TTaskList.Create();
  self.LoadList();
end;

destructor TFrameTasksAll.Destroy();
begin
  TaskList.Free();
  inherited Destroy();
end;

procedure TFrameTasksAll.trackbarPriorityChange(Sender: TObject);
begin
  lbPriorityValue.Caption := IntToStr((Sender as TTrackBar).Position);
end;

procedure TFrameTasksAll.RefreshTasksList(SelectedOnly: boolean = false);
var
  Task: TTaskItem;
  li: TListItem;
  i: integer;
begin
  if SelectedOnly then
  begin
    for i:=0 to TaskList.Count-1 do
    begin
      Task:=TTaskItem(TaskList[i]);
      if Task=SelectedTask then
      begin
        li:=lvAllTasks.Items[i];
        li.Caption:=IntToStr(Task.Priority);
        li.SubItems[0]:=Task.Author;
        li.SubItems[1]:=Task.Name;
        li.SubItems[2]:=DateTimeToStr(Task.BeginDate);
        Exit;
      end;
    end;
    Exit;
  end;

  lvAllTasks.Clear();
  TaskList.Sort();
  for i:=0 to TaskList.Count-1 do
  begin
    Task:=TTaskItem(TaskList[i]);
    li:=lvAllTasks.Items.Add();
    li.Data:=Task;
    li.Caption:=IntToStr(Task.Priority);
    li.SubItems.Add(Task.Author);
    li.SubItems.Add(Task.Name);
    li.SubItems.Add(DateTimeToStr(Task.BeginDate));
    if Task=SelectedTask then
    begin
      li.Selected:=true;
      li.Focused:=true;
    end;
  end;
end;

procedure TFrameTasksAll.tbClick(Sender: TObject);
begin
  if Sender=tbLoadTasks then
  begin
    LoadList();
  end
  else if Sender=tbSaveTasks then
  begin
    SaveList();
  end
  else if Sender=tbRefresh then
  begin
    RefreshTasksList();
  end
  else if Sender=tbAddTask then
  begin
    NewItem();
  end
  else if Sender=tbDeleteTask then
  begin
    DeleteItem();
  end;
end;

procedure TFrameTasksAll.LoadList();
begin
  //
  SelectedTask:=nil;
  TaskList.Clear();
  TaskList.LoadList();
  RefreshTasksList();
end;

procedure TFrameTasksAll.SaveList();
begin
  self.TaskList.SaveList();
end;

procedure TFrameTasksAll.NewItem(ASubItem: boolean = false);
var
  Task: TTaskItem;
  li: TListItem;
  i: integer;
begin
  Task:=TTaskItem.Create();
  Task.Name:='Новая задача';
  Task.Priority:=1;
  Task.Status:=0;
  Task.Author:='Admin';
  Task.BeginDate:=Now();
  Task.EndDate:=Now();
  self.TaskList.Add(Task);

  li:=lvAllTasks.Items.Add();
  li.Data:=Task;
  li.Caption:=IntToStr(Task.Priority);
  li.SubItems.Add(Task.Author);
  li.SubItems.Add(Task.Name);
  li.SubItems.Add(DateTimeToStr(Task.BeginDate));

  self.SelectedTask:=Task;
  ReadSelectedTask();
end;

procedure TFrameTasksAll.ReadSelectedTask();
var
  Task: TTaskItem;
begin
  if not Assigned(self.SelectedTask) then Exit;
  Task:=self.SelectedTask;
  trackbarPriority.Position:=Task.Priority;
  trackbarStatus.Position:=Task.Status;
  dtpBegin.DateTime:=Task.BeginDate;
  dtpEnd.DateTime:=Task.EndDate;
  lbAuthor.Caption:=Task.Author;
  //lbPeriod.Caption:=''+DateTimeToStr(Task.BeginDate)+' - '+DateTimeToStr(Task.EndDate);
  reTaskText.Text:=Task.Text;
end;

procedure TFrameTasksAll.WriteSelectedTask();
begin
  if not Assigned(self.SelectedTask) then Exit;
  self.SelectedTask.Priority:=trackbarPriority.Position;
  self.SelectedTask.Status:=trackbarStatus.Position;
  self.SelectedTask.BeginDate:=dtpBegin.DateTime;
  self.SelectedTask.EndDate:=dtpEnd.DateTime;
  //self.SelectedTask.Author:=lbAuthor.Caption;
  self.SelectedTask.Text:=reTaskText.Text;
  self.SelectedTask.Name:='';
  if reTaskText.Lines.Count>0 then self.SelectedTask.Name:=reTaskText.Lines[0];
end;


procedure TFrameTasksAll.DeleteItem();
var
  i: integer;
begin
  if not Assigned(self.SelectedTask) then Exit;
  i:=lvAllTasks.ItemIndex;
  TaskList.Remove(SelectedTask);
  SelectedTask:=nil;
  RefreshTasksList();
  while i >= lvAllTasks.Items.Count do Dec(i);
  if i < 0 then Exit;
  lvAllTasks.ItemIndex:=i;
end;

procedure TFrameTasksAll.lvAllTasksChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  li: TListItem;
  Task: TTaskItem;
begin
  self.WriteSelectedTask();
  self.RefreshTasksList(true);
  li:=TListView(Sender).Selected;
  if not Assigned(li) then Exit;
  Task:=li.Data;
  if not Assigned(Task) then Exit;
  self.SelectedTask:=Task;
  self.ReadSelectedTask();
end;

end.
