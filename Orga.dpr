program Orga;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  MainFunc in 'MainFunc.pas',
  Config in 'Config.pas',
  Frame_Archive in 'Frame_Archive.pas' {FrameArchive: TFrame},
  Frame_ArchiveSearch in 'Frame_ArchiveSearch.pas' {FrameArchiveSearch: TFrame},
  MailboxFrame in 'MailboxFrame.pas' {FrameMailbox: TFrame},
  MailUnit in 'MailUnit.pas',
  TasksAllFrame in 'TasksAllFrame.pas' {FrameTasksAll: TFrame},
  TasksUnit in 'TasksUnit.pas',
  ContactsFrame in 'ContactsFrame.pas' {FrameContacts: TFrame},
  ContactsUnit in 'ContactsUnit.pas',
  MsgBoardFrame in 'MsgBoardFrame.pas' {FrameMsgBoard: TFrame},
  MsgBoardUnit in 'MsgBoardUnit.pas',
  TextEditorFrame in 'TextEditorFrame.pas' {FrameTextEditor: TFrame},
  Frame_CalendarYear in 'Frame_CalendarYear.pas' {FrameCalendarYear: TFrame},
  Frame_EnterpriseStructure in 'Frame_EnterpriseStructure.pas' {FrameEnterpiseStructure: TFrame},
  PersonnelFrame in 'PersonnelFrame.pas' {FramePersonnel: TFrame},
  Frame_DayShedule in 'Frame_DayShedule.pas' {FrameDayShedule: TFrame},
  MiscFunc in 'MiscFunc.pas',
  LocalOrdersFrame in 'LocalOrdersFrame.pas' {FrameLocalOrders: TFrame},
  LocalOrdersUnit in 'LocalOrdersUnit.pas',
  PersonnelUnit in 'PersonnelUnit.pas',
  DbUnit in 'DbUnit.pas',
  TableEditForm in 'TableEditForm.pas' {frmTableEdit},
  SocketLinkUnit in 'SocketLinkUnit.pas',
  UserOptionsFrame in 'UserOptionsFrame.pas' {FrameUserOptions: TFrame},
  VideoPhoneFrame in 'VideoPhoneFrame.pas' {FrameVideoPhone: TFrame},
  DbBrowserFrame in 'DbBrowserFrame.pas' {FrameDbBrowser: TFrame},
  DrawBoardFrame in 'DrawBoardFrame.pas' {FrameDrawBoard: TFrame};

{$R *.res}

begin
  Application.Initialize;
  MainFunc.OnProgramStart();
  Application.CreateForm(TfrmMain, frmMain);
  //Application.CreateForm(TfrmTableEdit, frmTableEdit);
  Application.Run;
end.
