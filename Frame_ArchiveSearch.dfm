object FrameArchiveSearch: TFrameArchiveSearch
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
    Left = 330
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
  end
  object panLeft: TPanel
    Left = 33
    Top = 0
    Width = 297
    Height = 431
    Align = alLeft
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 158
      Width = 295
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object gbSearchParams: TGroupBox
      Left = 1
      Top = 1
      Width = 295
      Height = 157
      Align = alTop
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1072#1088#1093#1080#1074#1091
      TabOrder = 0
      object lbSearchName: TLabel
        Left = 8
        Top = 16
        Width = 61
        Height = 16
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      end
      object lbSearchDate: TLabel
        Left = 8
        Top = 60
        Width = 81
        Height = 16
        Caption = #1055#1077#1088#1080#1086#1076' '#1076#1072#1090#1099':'
      end
      object Label3: TLabel
        Left = 20
        Top = 80
        Width = 15
        Height = 16
        Caption = #1054#1090
      end
      object Label4: TLabel
        Left = 152
        Top = 80
        Width = 14
        Height = 16
        Caption = #1076#1086
      end
      object Label5: TLabel
        Left = 8
        Top = 108
        Width = 40
        Height = 16
        Caption = #1040#1074#1090#1086#1088':'
      end
      object edSearchName: TEdit
        Left = 8
        Top = 32
        Width = 277
        Height = 24
        TabOrder = 0
      end
      object edSearchAuthor: TEdit
        Left = 8
        Top = 124
        Width = 277
        Height = 24
        TabOrder = 1
      end
      object dtpSearchBeginDate: TDateTimePicker
        Left = 44
        Top = 76
        Width = 101
        Height = 24
        Date = 39448.000000000000000000
        Time = 0.664968206023331700
        TabOrder = 2
      end
      object dtpSearchEndDate: TDateTimePicker
        Left = 172
        Top = 76
        Width = 114
        Height = 24
        Date = 39539.000000000000000000
        Time = 0.665554259263444700
        TabOrder = 3
      end
    end
    object gbSearchResults: TGroupBox
      Left = 1
      Top = 161
      Width = 295
      Height = 269
      Align = alClient
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086#1080#1089#1082#1072
      TabOrder = 1
      object ListView1: TListView
        Left = 2
        Top = 18
        Width = 291
        Height = 249
        Align = alClient
        Columns = <
          item
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            Width = 150
          end
          item
            Caption = #1044#1072#1090#1072
          end
          item
            Caption = #1040#1074#1090#1086#1088
          end
          item
            Caption = #1058#1080#1087
          end>
        GridLines = True
        HotTrack = True
        HotTrackStyles = [htUnderlineHot]
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitTop = 15
        ExplicitHeight = 252
      end
    end
  end
  object PanRight: TPanel
    Left = 333
    Top = 0
    Width = 430
    Height = 431
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 428
      Height = 429
      Align = alClient
    end
  end
end
