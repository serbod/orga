unit Frame_Archive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin;

type
  TFrameArchive = class(TFrame)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    panLeft: TPanel;
    panRight: TPanel;
    Splitter1: TSplitter;
    tvArchiveTree: TTreeView;
    gbInfo: TGroupBox;
    Splitter2: TSplitter;
    Image1: TImage;
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    ArchiveDir: string;
    { Public declarations }
  end;

implementation
uses Main, MainFunc, Config;

{$R *.dfm}

procedure TFrameArchive.ToolButton1Click(Sender: TObject);
begin
  tvArchiveTree.Items.Clear;
  ReadDirToTree(ArchiveDir, nil, tvArchiveTree);
end;

end.
