object FrameDbBrowser: TFrameDbBrowser
  Left = 0
  Top = 0
  Width = 577
  Height = 376
  TabOrder = 0
  object toolbarDbBrowser: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 376
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'toolbarDbBrowser'
    TabOrder = 0
    object btnRefresh: TToolButton
      Left = 0
      Top = 0
      Caption = 'btnRefresh'
      ImageIndex = 29
      Wrap = True
      OnClick = ToolButtonClick
    end
    object btnEditTable: TToolButton
      Left = 0
      Top = 30
      Caption = 'btnEditTable'
      ImageIndex = 11
      OnClick = ToolButtonClick
    end
  end
  object panCenter: TPanel
    Left = 33
    Top = 0
    Width = 544
    Height = 376
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object splH1: TSplitter
      Left = 0
      Top = 145
      Width = 544
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object tvDbTree: TTreeView
      Left = 0
      Top = 0
      Width = 544
      Height = 145
      Align = alTop
      HotTrack = True
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = tvDbTreeChange
    end
    object lvDbTable: TListView
      Left = 0
      Top = 148
      Width = 544
      Height = 228
      Align = alClient
      Columns = <>
      GridLines = True
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
end
