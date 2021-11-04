unit TextEditorFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtActns, StdActns, ActnList,
  System.Actions;

type
  TFrameTextEditor = class(TFrame)
    pcEditorControls: TPageControl;
    tsFile: TTabSheet;
    tsEdit: TTabSheet;
    tsInsert: TTabSheet;
    tsFormat: TTabSheet;
    tsTable: TTabSheet;
    tsRecent: TTabSheet;
    tsCustom: TTabSheet;
    toolbarFile: TToolBar;
    tbOpenFile: TToolButton;
    tbSaveAs: TToolButton;
    toolbarEdit: TToolBar;
    tbUndo: TToolButton;
    tbRedo: TToolButton;
    tbCut: TToolButton;
    tbCopy: TToolButton;
    reText: TRichEdit;
    tbPrint: TToolButton;
    tbSepFile1: TToolButton;
    tbPrintPreview: TToolButton;
    tbSepFile2: TToolButton;
    tbSendTo: TToolButton;
    tbSepEdit1: TToolButton;
    tbPaste: TToolButton;
    tbDelete: TToolButton;
    tbSelectAll: TToolButton;
    ActionList: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    PrintDlg1: TPrintDlg;
    SendMail1: TSendMail;
    toolbarFormat: TToolBar;
    tbFont: TToolButton;
    tbFontColor: TToolButton;
    tbSepFormat1: TToolButton;
    tbBold: TToolButton;
    tbItalic: TToolButton;
    tbUnderline: TToolButton;
    tbStrikeout: TToolButton;
    tbSepFormat2: TToolButton;
    tbAlignLeft: TToolButton;
    tbAlignCenter: TToolButton;
    tbAlignRight: TToolButton;
    FontEdit1: TFontEdit;
    ColorSelect1: TColorSelect;
    toolbarInsert: TToolBar;
    tbInsDate: TToolButton;
    tbInsTime: TToolButton;
    tbInsAuthorSign: TToolButton;
    tbInsURL: TToolButton;
    ToolButton1: TToolButton;
    tbInsNote: TToolButton;
    tbInsBookmark: TToolButton;
    ToolButton2: TToolButton;
    tbInsHLine: TToolButton;
    InsDate: TAction;
    InsTime: TAction;
    InsAuthorSign: TAction;
    InsURL: TAction;
    InsNote: TAction;
    InsBookmark: TAction;
    InsHLine: TAction;
    InsPicture: TAction;
    InsFile: TAction;
    tbInsPicture: TToolButton;
    tbInsFile: TToolButton;
    toolbarRecent: TToolBar;
    ToolButton3: TToolButton;
    tbSearch: TToolButton;
    tbReplace: TToolButton;
    SearchFind1: TSearchFind;
    SearchReplace1: TSearchReplace;
    procedure FileOpen1BeforeExecute(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure FileSaveAs1BeforeExecute(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
  private
    { Private declarations }
    function FReadRawText(): string;
    procedure FWriteRawText(const Value: string);
    function FReadLines(): TStrings;
    procedure FWriteLines(const Value: TStrings);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    property RawText: string read FReadRawText write FWriteRawText;
    property Lines: TStrings read FReadLines write FWriteLines;
    procedure Init();
    procedure SaveToFile(FileName: string);
    procedure LoadFromFile(FileName: string);
  end;

implementation

uses Main;

{$R *.dfm}

//===========================================
constructor TFrameTextEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TFrameTextEditor.Destroy();
begin
  inherited Destroy();
end;

procedure TFrameTextEditor.Init();
begin
  toolbarFile.Images:=frmMain.ImageList24;
  toolbarEdit.Images:=frmMain.ImageList24;
  toolbarInsert.Images:=frmMain.ImageList24;
  toolbarFormat.Images:=frmMain.ImageList24;
  toolbarRecent.Images:=frmMain.ImageList24;
end;

procedure TFrameTextEditor.SaveToFile(FileName: string);
begin
  reText.Lines.SaveToFile(FileName);
end;

procedure TFrameTextEditor.LoadFromFile(FileName: string);
begin
  reText.Clear();
  if not FileExists(FileName) then Exit;
  reText.Lines.LoadFromFile(FileName);
end;

//===========================================
function TFrameTextEditor.FReadRawText(): string;
var
  ss: TStringStream;
  s: string;
begin
  ss:=TStringStream.Create('');
  reText.Lines.SaveToStream(ss);
  s:=ss.DataString;
  s:=StringReplace(s, #0, '', [rfReplaceAll]);
  result:=Copy(ss.DataString, 1, Length(s)-1);
  ss.Free();
end;

procedure TFrameTextEditor.FWriteRawText(const Value: string);
var
  ss: TStringStream;
begin
  if Copy(Value, 1, 5)='{\rtf' then
  begin
    ss:=TStringStream.Create('');
    ss.WriteString(Value+#0);
    reText.Lines.LoadFromStream(ss);
    ss.Free();
  end
  else
  begin
    reText.Text:=Value;
  end;
end;

function TFrameTextEditor.FReadLines(): TStrings;
begin
  result:=reText.Lines;
end;

procedure TFrameTextEditor.FWriteLines(const Value: TStrings);
begin
  reText.Lines.Text:=Value.Text;
end;

//===========================================
// Action handlers
//===========================================
procedure TFrameTextEditor.FileOpen1BeforeExecute(Sender: TObject);
begin
  with (Sender as TFileOpen).Dialog do
  begin
    Filter:='RichText files (*.rtf)|*.rtf|Text files (*.txt)|*.txt';
    DefaultExt:='rtf';
    Title:='Open file';
  end;
end;

procedure TFrameTextEditor.FileOpen1Accept(Sender: TObject);
var
  s, s2: string;
begin
  s:=(Sender as TFileOpen).Dialog.FileName;
  s2:=ExtractFileExt(s);
  reText.Lines.LoadFromFile(s);
end;

procedure TFrameTextEditor.FileSaveAs1BeforeExecute(Sender: TObject);
begin
  with (Sender as TFileSaveAs).Dialog do
  begin
    Filter:='RichText files (*.rtf)|*.rtf|Text files (*.txt)|*.txt';
    DefaultExt:='rtf';
    Title:='Save file';
  end;
end;

procedure TFrameTextEditor.FileSaveAs1Accept(Sender: TObject);
var
  s, s2: string;
begin
  s:=(Sender as TFileSaveAs).Dialog.FileName;
  s2:=ExtractFileExt(s);
  reText.Lines.SaveToFile(s);
end;

end.
