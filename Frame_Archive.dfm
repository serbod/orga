object FrameArchive: TFrameArchive
  Left = 0
  Top = 0
  Width = 763
  Height = 431
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 290
    Top = 0
    Height = 431
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 431
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'ToolBar1'
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      Caption = 'ToolButton1'
      ImageIndex = 0
      Wrap = True
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 32
      Caption = 'ToolButton2'
      ImageIndex = 1
      Wrap = True
    end
    object ToolButton3: TToolButton
      Left = 0
      Top = 62
      Caption = 'ToolButton3'
      ImageIndex = 2
      Wrap = True
    end
  end
  object panLeft: TPanel
    Left = 33
    Top = 0
    Width = 257
    Height = 431
    Align = alLeft
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 290
      Width = 255
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object tvArchiveTree: TTreeView
      Left = 1
      Top = 1
      Width = 255
      Height = 289
      Align = alClient
      Indent = 19
      TabOrder = 0
      Items.Data = {
        080000002C0000000000000000000000FFFFFFFFFFFFFFFF0000000002000000
        13CFF0E8F5EEE4EDFBE520EDE0EAEBE0E4EDFBE51D0000000000000000000000
        FFFFFFFFFFFFFFFF000000000200000004323030361F00000000000000000000
        00FFFFFFFFFFFFFFFF000000000000000006DFEDE2E0F0FC2000000000000000
        00000000FFFFFFFFFFFFFFFF000000000000000007D4E5E2F0E0EBFC1D000000
        0000000000000000FFFFFFFFFFFFFFFF000000000000000004323030372F0000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000016CFEEEBF3F7E5
        EDFBE520F1F7E5F22DF4E0EAF2F3F0FB310000000000000000000000FFFFFFFF
        FFFFFFFF000000000000000018CFEEEBF3F7E5EDFBE520E7E0FFE2EAE820E820
        F1F7E5F2E0290000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0010CFEEEBF3F7E5EDFBE520EFF0E0E9F1FB2A0000000000000000000000FFFF
        FFFFFFFFFFFF000000000000000011CFEEEBF3F7E5EDFBE520E1F3EAEBE5F2FB
        2B0000000000000000000000FFFFFFFFFFFFFFFF000000000000000012C2FBE4
        E0EDEDFBE520EDE0EAEBE0E4EDFBE52F0000000000000000000000FFFFFFFFFF
        FFFFFF000000000000000016C2FBE4E0EDEDFBE520F1F7E5F2E02DF4E0EAF2F3
        F0FB280000000000000000000000FFFFFFFFFFFFFFFF00000000000000000FC2
        FBE4E0EDEDFBE520EFF0E0E9F1FB}
    end
    object gbInfo: TGroupBox
      Left = 1
      Top = 293
      Width = 255
      Height = 137
      Align = alBottom
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      TabOrder = 1
    end
  end
  object panRight: TPanel
    Left = 293
    Top = 0
    Width = 470
    Height = 431
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 468
      Height = 429
      Align = alClient
    end
  end
end
