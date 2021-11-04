unit Main;
// Created 2007.07.29

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, ExtCtrls, StdCtrls, XPMan,
  Frame_Archive, Frame_ArchiveSearch, Config,
  Frame_CalendarYear, ActnMan, ActnCtrls, XPStyleActnCtrls,
  ActnList, StdActns, ExtActns, Frame_EnterpriseStructure, PersonnelFrame,
  Frame_DayShedule, MsgBoardFrame, ContactsFrame,
  TasksAllFrame, MailboxFrame, LocalOrdersFrame, UserOptionsFrame,
  {VideoPhoneFrame,} DbBrowserFrame, DrawBoardFrame, System.Actions,
  System.ImageList, TasksUnit;

type
  TfrmMain = class(TForm)
    StatusBar: TStatusBar;
    pcMain: TPageControl;
    tsTasks: TTabSheet;
    tsMail: TTabSheet;
    tsMsgBoard: TTabSheet;
    tsNews: TTabSheet;
    tsCommunication: TTabSheet;
    tsCalendar: TTabSheet;
    tsArchivePersonal: TTabSheet;
    tsEnterprise: TTabSheet;
    ImageList48: TImageList;
    ImageList32: TImageList;
    ImageList24: TImageList;
    tsOther: TTabSheet;
    pcTasks: TPageControl;
    tsAllTasks: TTabSheet;
    tsTodayTasks: TTabSheet;
    tsWeekTasks: TTabSheet;
    tsMonthTasks: TTabSheet;
    tsOtherTasks: TTabSheet;
    pcMail: TPageControl;
    tsMailBox: TTabSheet;
    tsAttachments: TTabSheet;
    pcCommunication: TPageControl;
    tsChat: TTabSheet;
    tsContacts: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Splitter6: TSplitter;
    TreeView5: TTreeView;
    ToolBar5: TToolBar;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Panel7: TPanel;
    Splitter7: TSplitter;
    RichEdit4: TRichEdit;
    pcOther: TPageControl;
    tsVisual: TTabSheet;
    tsConnection: TTabSheet;
    tsAbout: TTabSheet;
    tsArchive: TTabSheet;
    pcArchive: TPageControl;
    tsArchiveSearch: TTabSheet;
    tsArchiveGlobal: TTabSheet;
    panLeft: TPanel;
    Memo1: TMemo;
    XPManifest: TXPManifest;
    FrameArchivePublic: TFrameArchive;
    FrameArchiveSearch: TFrameArchiveSearch;
    FrameArchivePrivate: TFrameArchive;
    FrameMailboxGeneral: TFrameMailbox;
    FrameMailboxNews: TFrameMailbox;
    FrameCalendarYear: TFrameCalendarYear;
    gbVersion: TGroupBox;
    gbAuthors: TGroupBox;
    tsDrawing: TTabSheet;
    tsVideoPhone: TTabSheet;
    pcEnterprise: TPageControl;
    tsStructure: TTabSheet;
    tsPersonnel: TTabSheet;
    tsBudget: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    ActionList1: TActionList;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    WindowUndock: TAction;
    WindowDock: TAction;
    FrameEnterpiseStructure: TFrameEnterpiseStructure;
    FramePersonnel: TFramePersonnel;
    pcCalendar: TPageControl;
    tsYearCalendar: TTabSheet;
    tsTodayCalendar: TTabSheet;
    FrameDayShedule: TFrameDayShedule;
    FrameTasksAll: TFrameTasksAll;
    FrameMsgBoard: TFrameMsgBoard;
    FrameContacts: TFrameContacts;
    tsUser: TTabSheet;
    tsWeekCalendar: TTabSheet;
    tsLocalOrders: TTabSheet;
    tsFaxes: TTabSheet;
    FrameLocalOrders: TFrameLocalOrders;
    FrameUserOptions: TFrameUserOptions;
    tsDebug: TTabSheet;
    gbDebugMsg: TGroupBox;
    gbDebugSQL: TGroupBox;
    Splitter1: TSplitter;
    memoDebugMsg: TMemo;
    memoDebugSQL: TMemo;
    tsDbBrowser: TTabSheet;
    FrameDbBrowser: TFrameDbBrowser;
    FrameDrawBoard: TFrameDrawBoard;
    ilIcons16: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FrameArchivePrivateToolButton1Click(Sender: TObject);
    procedure FrameArchivePublicToolButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function TaskStateToIconIndex(ATask: TTaskItem): Integer;

var
  frmMain: TfrmMain;

implementation

uses MainFunc;

{$R *.dfm}

function TaskStateToIconIndex(ATask: TTaskItem): Integer;
begin
  // 0-none, 1-normal, 2-urgent, 3-critical, 4-completed, 5-paused
  case ATask.Status of
    1: Result := 7;
    2: Result := 8;
    3: Result := 9;
    4: Result := 10;
    5: Result := 11;
  else
    Result := -1;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  // Set images lists to templates
  // Local orders
  //FrameLocalOrders.ActionList1.Images:=self.ImageList24;
  FrameLocalOrders.toolbarLocOrders.Images:=self.ImageList24;
  FrameLocalOrders.pmLocOrdersList.Images:=self.ImageList24;
  // Mail
  FrameMailboxGeneral.ToolBarMailbox.Images:=self.ImageList24;
  FrameMailboxGeneral.ToolBarMsg.Images:=self.ImageList24;
  FrameMailboxNews.ToolBarMailbox.Images:=self.ImageList24;
  FrameMailboxNews.ToolBarMsg.Images:=self.ImageList24;
  // MsgBoard
  FrameMsgBoard.toolbarMsgBoard.Images:=self.ImageList24;
  FrameMsgBoard.TextEditor.Init();
  // Contacts
  FrameContacts.toolbarContacts.Images:=self.ImageList24;
  // Archive
  FrameArchivePrivate.ToolBar1.Images:=self.ImageList24;
  FrameArchivePublic.ToolBar1.Images:=self.ImageList24;
  // Enterprise
  //FrameEnterpiseStructure.ToolBar1.Images:=self.ImageList24;
  // Calendar
  FrameCalendarYear.ToolBar1.Images:=self.ImageList24;
  FrameCalendarYear.CalendarInit();

  // DrawBoard
  FrameDrawBoard.toolbarDBoardTools.Images:=self.ImageList24;
  // VideoPhone
  //FrameVideoPhone.toolbarVideoPhone.Images:=self.ImageList24;

  // User options
  FrameUserOptions.toolbarUserOptions.Images:=self.ImageList24;

  // DbBrowser
  FrameDbBrowser.toolbarDbBrowser.Images:=self.ImageList24;

  FrameDayShedule.RefreshShedule();
end;

procedure TfrmMain.FrameArchivePrivateToolButton1Click(Sender: TObject);
begin
  FrameArchivePrivate.ArchiveDir:=conf['DataDir']+'/Archive/Private';
  FrameArchivePrivate.ToolButton1Click(Sender);

end;

procedure TfrmMain.FrameArchivePublicToolButton1Click(Sender: TObject);
begin
  FrameArchivePublic.ArchiveDir:=conf['DataDir']+'/Archive/Public';
  FrameArchivePublic.ToolButton1Click(Sender);

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  OnProgramStop();
end;

end.
