object FrameVideoPhone: TFrameVideoPhone
  Left = 0
  Top = 0
  Width = 744
  Height = 484
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 257
    Top = 0
    Height = 484
  end
  object toolbarVideoPhone: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 484
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    TabOrder = 0
    object tbtnSelectCamera: TToolButton
      Left = 0
      Top = 0
      Caption = 'tbtnSelectCamera'
      DropdownMenu = pmCameraSelect
      ImageIndex = 47
      PopupMenu = pmCameraSelect
      Wrap = True
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 30
      Caption = 'ToolButton2'
      ImageIndex = 1
      Wrap = True
    end
    object ToolButton3: TToolButton
      Left = 0
      Top = 60
      Caption = 'ToolButton3'
      ImageIndex = 2
      Wrap = True
    end
  end
  object Panel1: TPanel
    Left = 33
    Top = 0
    Width = 224
    Height = 484
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object TreeView1: TTreeView
      Left = 0
      Top = 0
      Width = 224
      Height = 281
      Align = alTop
      Indent = 19
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 260
    Top = 0
    Width = 484
    Height = 484
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 0
      Top = 313
      Width = 484
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object gbVideo: TGroupBox
      Left = 0
      Top = 0
      Width = 484
      Height = 313
      Align = alTop
      Caption = #1054#1082#1085#1086' '#1074#1080#1076#1077#1086
      TabOrder = 0
    end
    object gbInfo: TGroupBox
      Left = 0
      Top = 316
      Width = 484
      Height = 168
      Align = alClient
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      TabOrder = 1
    end
  end
  object pmCameraSelect: TPopupMenu
    Left = 56
    Top = 48
  end
end
