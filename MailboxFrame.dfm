object FrameMailbox: TFrameMailbox
  Left = 0
  Top = 0
  Width = 763
  Height = 431
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 346
    Top = 0
    Height = 431
  end
  object toolbarMailbox: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 431
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'toolbarMailbox'
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButton1'
      ImageIndex = 0
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
    object ToolButton4: TToolButton
      Left = 0
      Top = 90
      Caption = 'ToolButton4'
      ImageIndex = 3
      Wrap = True
    end
  end
  object panLeft: TPanel
    Left = 33
    Top = 0
    Width = 313
    Height = 431
    Align = alLeft
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 182
      Width = 311
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object tvMsgGroups: TTreeView
      Left = 1
      Top = 1
      Width = 311
      Height = 181
      Align = alTop
      HotTrack = True
      Indent = 19
      TabOrder = 0
      OnChange = tvMsgGroupsChange
      Items.Data = {
        05000000210000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        08C2F5EEE4FFF9E8E5220000000000000000000000FFFFFFFFFFFFFFFF000000
        000000000009C8F1F5EEE4FFF9E8E5250000000000000000000000FFFFFFFFFF
        FFFFFF00000000000000000CCEF2EFF0E0E2EBE5EDEDFBE52200000000000000
        00000000FFFFFFFFFFFFFFFF000000000000000009D7E5F0EDEEE2E8EAE82200
        00000000000000000000FFFFFFFFFFFFFFFF000000000000000009D3E4E0EBE5
        EDEDFBE5}
    end
    object lvMessages: TListView
      Left = 1
      Top = 185
      Width = 311
      Height = 245
      Align = alClient
      Columns = <
        item
          Caption = #1054#1090' '#1082#1086#1075#1086
          MinWidth = 100
          Width = 100
        end
        item
          Caption = #1058#1077#1084#1072
          MinWidth = 150
          Width = 150
        end
        item
          Caption = #1044#1072#1090#1072
          MinWidth = 50
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnChange = lvMessagesChange
    end
  end
  object panRight: TPanel
    Left = 349
    Top = 0
    Width = 414
    Height = 431
    Align = alClient
    TabOrder = 2
    object toolbarMsg: TToolBar
      Left = 1
      Top = 1
      Width = 412
      Height = 36
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'toolbarMsg'
      TabOrder = 0
      object tbNewMsg: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbNewMsg'
        ImageIndex = 0
      end
      object ToolButton6: TToolButton
        Left = 31
        Top = 0
        Caption = 'ToolButton6'
        ImageIndex = 1
      end
      object ToolButton7: TToolButton
        Left = 62
        Top = 0
        Caption = 'ToolButton7'
        ImageIndex = 2
      end
      object ToolButton8: TToolButton
        Left = 93
        Top = 0
        Caption = 'ToolButton8'
        ImageIndex = 3
      end
      object ToolButton9: TToolButton
        Left = 124
        Top = 0
        Caption = 'ToolButton9'
        ImageIndex = 4
      end
    end
    object richedMsgText: TRichEdit
      Left = 1
      Top = 92
      Width = 412
      Height = 338
      Align = alClient
      TabOrder = 1
    end
    object panMailHeader: TPanel
      Left = 1
      Top = 37
      Width = 412
      Height = 55
      Align = alTop
      TabOrder = 2
      DesignSize = (
        412
        55)
      object lbFromLabel: TLabel
        Left = 4
        Top = 8
        Width = 51
        Height = 13
        Caption = #1054#1090' '#1082#1086#1075#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbTopicLabel: TLabel
        Left = 4
        Top = 32
        Width = 36
        Height = 13
        Caption = #1058#1077#1084#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbFromText: TLabel
        Left = 64
        Top = 8
        Width = 3
        Height = 13
      end
      object lbTopicText: TLabel
        Left = 64
        Top = 32
        Width = 337
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
      end
    end
  end
end
