unit Frame_DayShedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids;

type
  TFrameDayShedule = class(TFrame)
    sgDayShedule: TStringGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AParent: TControl);
    procedure RefreshShedule();
  end;

implementation

{$R *.dfm}

procedure TFrameDayShedule.RefreshShedule();
var
  i, n: integer;
begin
  with sgDayShedule do
  begin
    // Установка ширины колонок
    ColWidths[0]:=25;
    n:=(self.Width-ColWidths[0]-25) div (ColCount-1);
    for i:=1 to ColCount-1 do ColWidths[i]:=n;

    // Установка названий колонок
    n:=0;
    for i:=1 to ColCount-1 do
    begin
      Cells[i,0]:=IntToStr(n);
      Inc(n, 10);
    end;

    // Установка названий рядов
    n:=6;
    for i:=1 to RowCount-1 do
    begin
      Cells[0,i]:=IntToStr(n);
      Inc(n);
    end;

    // Установка текста
    Cells[1, 3]:='Начало рабочего дня';
    Cells[1, 9]:='Обед';
    Cells[4, 7]:='Встреча с Григорьевым';
    Cells[1, 11]:='Позвонить в Горгаз';
    Cells[6, 13]:='Конец рабочего дня';
    Cells[2, 15]:='Едем в сауну';
  end;
end;

constructor TFrameDayShedule.Create(AParent: TControl);
begin
  inherited Create(AParent);
  RefreshShedule();
end;

end.
