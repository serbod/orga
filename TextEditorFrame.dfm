object FrameTextEditor: TFrameTextEditor
  Left = 0
  Top = 0
  Width = 397
  Height = 342
  TabOrder = 0
  object pcEditorControls: TPageControl
    Left = 0
    Top = 0
    Width = 397
    Height = 62
    ActivePage = tsFile
    Align = alTop
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    object tsFile: TTabSheet
      Caption = 'File'
      object toolbarFile: TToolBar
        Left = 0
        Top = 0
        Width = 389
        Height = 34
        Align = alClient
        ButtonHeight = 30
        ButtonWidth = 31
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbOpenFile: TToolButton
          Left = 0
          Top = 2
          Action = FileOpen1
        end
        object tbSaveAs: TToolButton
          Left = 31
          Top = 2
          Action = FileSaveAs1
        end
        object tbSepFile1: TToolButton
          Left = 62
          Top = 2
          Width = 8
          Caption = 'tbSepFile1'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object tbPrint: TToolButton
          Left = 70
          Top = 2
          Action = PrintDlg1
        end
        object tbPrintPreview: TToolButton
          Left = 101
          Top = 2
          Caption = 'tbPrintPreview'
          ImageIndex = 4
        end
        object tbSepFile2: TToolButton
          Left = 132
          Top = 2
          Width = 8
          Caption = 'tbSepFile2'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object tbSendTo: TToolButton
          Left = 140
          Top = 2
          Action = SendMail1
        end
      end
    end
    object tsEdit: TTabSheet
      Caption = 'Edit'
      ImageIndex = 1
      object toolbarEdit: TToolBar
        Left = 0
        Top = 0
        Width = 389
        Height = 34
        Align = alClient
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'toolbarEdit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbUndo: TToolButton
          Left = 0
          Top = 2
          Action = EditUndo1
        end
        object tbRedo: TToolButton
          Left = 31
          Top = 2
          Caption = 'tbRedo'
          ImageIndex = 41
        end
        object tbSepEdit1: TToolButton
          Left = 62
          Top = 2
          Width = 8
          Caption = 'tbSepEdit1'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object tbCut: TToolButton
          Left = 70
          Top = 2
          Action = EditCut1
        end
        object tbCopy: TToolButton
          Left = 101
          Top = 2
          Action = EditCopy1
        end
        object tbPaste: TToolButton
          Left = 132
          Top = 2
          Action = EditPaste1
        end
        object tbDelete: TToolButton
          Left = 163
          Top = 2
          Action = EditDelete1
        end
        object tbSelectAll: TToolButton
          Left = 194
          Top = 2
          Action = EditSelectAll1
        end
        object ToolButton3: TToolButton
          Left = 225
          Top = 2
          Width = 8
          Caption = 'ToolButton3'
          ImageIndex = 7
          Style = tbsSeparator
        end
        object tbSearch: TToolButton
          Left = 233
          Top = 2
          Action = SearchFind1
        end
        object tbReplace: TToolButton
          Left = 264
          Top = 2
          Action = SearchReplace1
        end
      end
    end
    object tsInsert: TTabSheet
      Caption = 'Insert'
      ImageIndex = 2
      object toolbarInsert: TToolBar
        Left = 0
        Top = 0
        Width = 389
        Height = 34
        Align = alClient
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'toolbarInsert'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbInsDate: TToolButton
          Left = 0
          Top = 2
          Action = InsDate
        end
        object tbInsTime: TToolButton
          Left = 31
          Top = 2
          Action = InsTime
        end
        object tbInsAuthorSign: TToolButton
          Left = 62
          Top = 2
          Action = InsAuthorSign
        end
        object ToolButton1: TToolButton
          Left = 93
          Top = 2
          Width = 8
          Caption = 'ToolButton1'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object tbInsURL: TToolButton
          Left = 101
          Top = 2
          Action = InsURL
        end
        object tbInsNote: TToolButton
          Left = 132
          Top = 2
          Action = InsNote
        end
        object tbInsBookmark: TToolButton
          Left = 163
          Top = 2
          Action = InsBookmark
        end
        object tbInsHLine: TToolButton
          Left = 194
          Top = 2
          Action = InsHLine
        end
        object ToolButton2: TToolButton
          Left = 225
          Top = 2
          Width = 8
          Caption = 'ToolButton2'
          ImageIndex = 6
          Style = tbsSeparator
        end
        object tbInsPicture: TToolButton
          Left = 233
          Top = 2
          Action = InsPicture
        end
        object tbInsFile: TToolButton
          Left = 264
          Top = 2
          Action = InsFile
        end
      end
    end
    object tsFormat: TTabSheet
      Caption = 'Format'
      ImageIndex = 3
      object toolbarFormat: TToolBar
        Left = 0
        Top = 0
        Width = 389
        Height = 34
        Align = alClient
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'toolbarFormat'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbFont: TToolButton
          Left = 0
          Top = 2
          Action = FontEdit1
        end
        object tbFontColor: TToolButton
          Left = 31
          Top = 2
          Action = ColorSelect1
        end
        object tbSepFormat1: TToolButton
          Left = 62
          Top = 2
          Width = 8
          Caption = 'tbSepFormat1'
          ImageIndex = 2
          Style = tbsSeparator
        end
        object tbBold: TToolButton
          Left = 70
          Top = 2
          Action = RichEditBold1
        end
        object tbItalic: TToolButton
          Left = 101
          Top = 2
          Action = RichEditItalic1
        end
        object tbUnderline: TToolButton
          Left = 132
          Top = 2
          Action = RichEditUnderline1
        end
        object tbStrikeout: TToolButton
          Left = 163
          Top = 2
          Action = RichEditStrikeOut1
        end
        object tbSepFormat2: TToolButton
          Left = 194
          Top = 2
          Width = 8
          Caption = 'tbSepFormat2'
          ImageIndex = 6
          Style = tbsSeparator
        end
        object tbAlignLeft: TToolButton
          Left = 202
          Top = 2
          Action = RichEditAlignLeft1
        end
        object tbAlignCenter: TToolButton
          Left = 233
          Top = 2
          Action = RichEditAlignCenter1
        end
        object tbAlignRight: TToolButton
          Left = 264
          Top = 2
          Action = RichEditAlignRight1
        end
      end
    end
    object tsTable: TTabSheet
      Caption = 'Table'
      ImageIndex = 4
    end
    object tsRecent: TTabSheet
      Caption = 'Recent'
      ImageIndex = 5
      object toolbarRecent: TToolBar
        Left = 0
        Top = 0
        Width = 389
        Height = 34
        Align = alClient
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'toolbarRecent'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object tsCustom: TTabSheet
      Caption = 'Custom'
      ImageIndex = 6
    end
  end
  object reText: TRichEdit
    Left = 0
    Top = 62
    Width = 397
    Height = 280
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    Zoom = 100
  end
  object ActionList: TActionList
    Left = 32
    Top = 120
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 13
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 12
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 7
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ImageIndex = 6
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 40
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 14
      ShortCut = 46
    end
    object RichEditBold1: TRichEditBold
      Category = 'Format'
      AutoCheck = True
      Caption = '&Bold'
      Hint = 'Bold'
      ImageIndex = 30
      ShortCut = 16450
    end
    object RichEditItalic1: TRichEditItalic
      Category = 'Format'
      AutoCheck = True
      Caption = '&Italic'
      Hint = 'Italic'
      ImageIndex = 31
      ShortCut = 16457
    end
    object RichEditUnderline1: TRichEditUnderline
      Category = 'Format'
      AutoCheck = True
      Caption = '&Underline'
      Hint = 'Underline'
      ImageIndex = 32
      ShortCut = 16469
    end
    object RichEditStrikeOut1: TRichEditStrikeOut
      Category = 'Format'
      AutoCheck = True
      Caption = '&Strikeout'
      Hint = 'Strikeout'
      ImageIndex = 44
    end
    object RichEditBullets1: TRichEditBullets
      Category = 'Format'
      AutoCheck = True
      Caption = '&Bullets'
      Hint = 'Bullets|Inserts a bullet on the current line'
      ImageIndex = 38
    end
    object RichEditAlignLeft1: TRichEditAlignLeft
      Category = 'Format'
      AutoCheck = True
      Caption = 'Align &Left'
      Hint = 'Align Left|Aligns text at the left indent'
      ImageIndex = 38
    end
    object RichEditAlignRight1: TRichEditAlignRight
      Category = 'Format'
      AutoCheck = True
      Caption = 'Align &Right'
      Hint = 'Align Right|Aligns text at the right indent'
      ImageIndex = 35
    end
    object RichEditAlignCenter1: TRichEditAlignCenter
      Category = 'Format'
      AutoCheck = True
      Caption = '&Center'
      Hint = 'Center|Centers text between margins'
      ImageIndex = 36
    end
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 28
      ShortCut = 16463
      BeforeExecute = FileOpen1BeforeExecute
      OnAccept = FileOpen1Accept
    end
    object FileSaveAs1: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 27
      BeforeExecute = FileSaveAs1BeforeExecute
      OnAccept = FileSaveAs1Accept
    end
    object PrintDlg1: TPrintDlg
      Category = 'Dialog'
      Caption = '&Print...'
      ImageIndex = 39
      ShortCut = 16464
    end
    object SendMail1: TSendMail
      Category = 'Internet'
      Caption = '&Send Mail...'
      Hint = 'Send email'
      ImageIndex = 11
    end
    object FontEdit1: TFontEdit
      Category = 'Dialog'
      Caption = 'Select &Font...'
      Dialog.Font.Charset = DEFAULT_CHARSET
      Dialog.Font.Color = clWindowText
      Dialog.Font.Height = -11
      Dialog.Font.Name = 'Tahoma'
      Dialog.Font.Style = []
      Hint = 'Font Select'
      ImageIndex = 33
    end
    object ColorSelect1: TColorSelect
      Category = 'Dialog'
      Caption = 'Select &Color...'
      Hint = 'Color Select'
      ImageIndex = 34
    end
    object InsDate: TAction
      Category = 'Insert'
      Caption = 'Insert Date'
      Hint = 'Insert current date'
      ImageIndex = 43
    end
    object InsTime: TAction
      Category = 'Insert'
      Caption = 'InsTime'
      Hint = 'Insert current time'
      ImageIndex = 44
    end
    object InsAuthorSign: TAction
      Category = 'Insert'
      Caption = 'InsAuthorSign'
      Hint = 'Insert Author'#39's signature'
      ImageIndex = 11
    end
    object InsURL: TAction
      Category = 'Insert'
      Caption = 'InsURL'
      Hint = 'Insert hyperlink (URL)'
      ImageIndex = 46
    end
    object InsNote: TAction
      Category = 'Insert'
      Caption = 'InsNote'
      Hint = 'Insert note'
      ImageIndex = 48
    end
    object InsBookmark: TAction
      Category = 'Insert'
      Caption = 'InsBookmark'
      Hint = 'Insert bookmark'
      ImageIndex = 45
    end
    object InsHLine: TAction
      Category = 'Insert'
      Caption = 'InsHLine'
      Hint = 'Insert horyzontal line'
    end
    object InsPicture: TAction
      Category = 'Insert'
      Caption = 'InsPicture'
      Hint = 'Insert picture'
      ImageIndex = 47
    end
    object InsFile: TAction
      Category = 'Insert'
      Caption = 'InsFile'
      Hint = 'Insert file'
      ImageIndex = 17
    end
    object SearchFind1: TSearchFind
      Category = 'Search'
      Caption = '&Find...'
      Hint = 'Find|Finds the specified text'
      ImageIndex = 34
      ShortCut = 16454
    end
    object SearchReplace1: TSearchReplace
      Category = 'Search'
      Caption = '&Replace'
      Hint = 'Replace|Replaces specific text with different text'
      ImageIndex = 32
    end
  end
end
