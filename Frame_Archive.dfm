object FrameArchive: TFrameArchive
  Left = 0
  Top = 0
  Width = 763
  Height = 431
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
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
      Top = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      Caption = 'ToolButton1'
      ImageIndex = 0
      Wrap = True
      OnClick = ToolButton1Click
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
      Items.NodeData = {
        0308000000440000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        000200000001131F044004380445043E0434043D044B04350420003D0430043A
        043B04300434043D044B043504260000000000000000000000FFFFFFFFFFFFFF
        FF000000000000000002000000010432003000300036002A0000000000000000
        000000FFFFFFFFFFFFFFFF00000000000000000000000001062F043D04320430
        0440044C042C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        00000000000107240435043204400430043B044C042600000000000000000000
        00FFFFFFFFFFFFFFFF000000000000000000000000010432003000300037004A
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
        161F043E043B044304470435043D044B043504200041044704350442042D0044
        0430043A044204430440044B044E0000000000000000000000FFFFFFFFFFFFFF
        FF00000000000000000000000001181F043E043B044304470435043D044B0435
        042000370430044F0432043A043804200038042000410447043504420430043E
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
        101F043E043B044304470435043D044B04350420003F0440043004390441044B
        04400000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
        0001111F043E043B044304470435043D044B0435042000310443043A043B0435
        0442044B04420000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0000000000011212044B04340430043D043D044B04350420003D0430043A043B
        04300434043D044B0435044A0000000000000000000000FFFFFFFFFFFFFFFF00
        0000000000000000000000011612044B04340430043D043D044B043504200041
        0447043504420430042D00440430043A044204430440044B043C000000000000
        0000000000FFFFFFFFFFFFFFFF000000000000000000000000010F12044B0434
        0430043D043D044B04350420003F0440043004390441044B04}
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
