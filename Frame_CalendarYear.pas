unit Frame_CalendarYear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, Grids, Calendar, ToolWin, ExtCtrls, StdCtrls;

type
  TFrameCalendarYear = class(TFrame)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    ToolBar1: TToolBar;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    Calendar1: TCalendar;
    Calendar2: TCalendar;
    Calendar3: TCalendar;
    Calendar4: TCalendar;
    Calendar5: TCalendar;
    Calendar6: TCalendar;
    Calendar7: TCalendar;
    Calendar8: TCalendar;
    Calendar9: TCalendar;
    Calendar10: TCalendar;
    Calendar11: TCalendar;
    Calendar12: TCalendar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CalendarInit();
    constructor Create(AOwner: TComponent);
  end;

implementation
uses Main;

{$R *.dfm}

procedure TFrameCalendarYear.FrameResize(Sender: TObject);
var
  iColWidth, iRowHeight: integer;
begin
  iColWidth:=(self.Width - Toolbar1.Width - 2) div 4;
  iRowHeight:=(self.Height - 2) div 3;

  Panel1.Width:=iColWidth;
  Panel2.Width:=iColWidth;
  Panel3.Width:=iColWidth;
  Panel4.Width:=iColWidth;

  GroupBox1.Height:=iRowHeight;
  GroupBox2.Height:=iRowHeight;
  GroupBox3.Height:=iRowHeight;
  GroupBox4.Height:=iRowHeight;
  GroupBox5.Height:=iRowHeight;
  GroupBox6.Height:=iRowHeight;
  GroupBox7.Height:=iRowHeight;
  GroupBox8.Height:=iRowHeight;
  GroupBox9.Height:=iRowHeight;
  GroupBox10.Height:=iRowHeight;
  GroupBox11.Height:=iRowHeight;
  GroupBox12.Height:=iRowHeight;
end;

procedure SetCalendar(Calendar: TCalendar; Month: integer);
begin
  if Calendar.Month = Month Then Exit;
  Calendar.Day:=1;
  Calendar.Month:=Month;
  Calendar.UpdateCalendar;
  Calendar.SelectNone;
end;

procedure TFrameCalendarYear.CalendarInit();
begin
  SetCalendar(Calendar1, 1);
  SetCalendar(Calendar2, 2);
  SetCalendar(Calendar3, 3);
  SetCalendar(Calendar4, 4);
  SetCalendar(Calendar5, 5);
  SetCalendar(Calendar6, 6);
  SetCalendar(Calendar7, 7);
  SetCalendar(Calendar8, 8);
  SetCalendar(Calendar9, 9);
  SetCalendar(Calendar10, 10);
  SetCalendar(Calendar11, 11);
  SetCalendar(Calendar12, 12);
end;

constructor TFrameCalendarYear.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CalendarInit();
end;

end.
