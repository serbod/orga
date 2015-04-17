unit Frame_ArchiveSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ToolWin;

type
  TFrameArchiveSearch = class(TFrame)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    panLeft: TPanel;
    PanRight: TPanel;
    Splitter1: TSplitter;
    gbSearchParams: TGroupBox;
    gbSearchResults: TGroupBox;
    Splitter2: TSplitter;
    Image1: TImage;
    ListView1: TListView;
    edSearchName: TEdit;
    lbSearchName: TLabel;
    lbSearchDate: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edSearchAuthor: TEdit;
    dtpSearchBeginDate: TDateTimePicker;
    dtpSearchEndDate: TDateTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses Main;

{$R *.dfm}

end.
