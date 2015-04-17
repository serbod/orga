unit DrawBoardFrame;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ComCtrls, ToolWin, Types, ColorGrd;

type
  TFrameDrawBoard = class(TFrame)
    toolbarDBoardTools: TToolBar;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    panLeft: TPanel;
    panTop: TPanel;
    panImage: TPanel;
    btnSelect: TBitBtn;
    btnMove: TBitBtn;
    btnPen: TBitBtn;
    btnBrush: TBitBtn;
    btnLine: TBitBtn;
    btnFill: TBitBtn;
    clrbx1: TColorBox;
    btnRect: TBitBtn;
    btnPoly: TBitBtn;
    btnOval: TBitBtn;
    btnText: TBitBtn;
    btnErase: TBitBtn;
    btnPick: TBitBtn;
    lbCursorPos: TLabel;
    clrgrd1: TColorGrid;
    pbImage: TPaintBox;
    scrollBox: TScrollBox;
    procedure img1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    LastPos: TPoint;
    LastState: TShiftState;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses Main;

{$R *.dfm}

constructor TFrameDrawBoard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //panImage.DoubleBuffered:=True;
  //scrollBox.DoubleBuffered:=True;

  //pbImage.DoubleBuffered:=True;
  self.Align:=alClient;
  pbImage.Canvas.FloodFill(1, 1, clWhite, fsSurface);
end;


procedure TFrameDrawBoard.img1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbCursorPos.Caption:='Position: '+IntToStr(X)+' : '+IntToStr(Y);
  if (ssLeft in Shift) then
  begin
    pbImage.Canvas.Pen.Color:=clrbx1.Selected;
    pbImage.Canvas.LineTo(X, Y);
  end
  else
  begin
    pbImage.Canvas.MoveTo(X, Y);
  end;
end;

end.
