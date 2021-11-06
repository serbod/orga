object FrameLocalOrders: TFrameLocalOrders
  Left = 0
  Top = 0
  Width = 767
  Height = 425
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 240
    Top = 0
    Height = 425
    ExplicitLeft = 273
  end
  object panRight: TPanel
    Left = 243
    Top = 0
    Width = 524
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 276
    ExplicitWidth = 491
    object gbInfo: TGroupBox
      Left = 0
      Top = 0
      Width = 524
      Height = 73
      Align = alTop
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      TabOrder = 0
      ExplicitWidth = 491
      object lbFromText: TLabel
        Left = 8
        Top = 16
        Width = 65
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1054#1090' '#1082#1086#1075#1086':'
      end
      object lbToText: TLabel
        Left = 8
        Top = 40
        Width = 65
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1050#1086#1084#1091':'
        Visible = False
      end
      object lbFrom: TLabel
        Left = 80
        Top = 16
        Width = 40
        Height = 16
        Caption = 'lbFrom'
      end
      object lbTo: TLabel
        Left = 79
        Top = 46
        Width = 25
        Height = 16
        Caption = 'lbTo'
      end
      object btnToPerson: TButton
        Left = 6
        Top = 42
        Width = 67
        Height = 25
        Caption = #1050#1086#1084#1091
        TabOrder = 0
        OnClick = btnToPersonClick
      end
    end
    object gbReply: TGroupBox
      Left = 0
      Top = 320
      Width = 524
      Height = 105
      Align = alBottom
      Caption = #1056#1077#1079#1086#1083#1102#1094#1080#1103
      TabOrder = 1
      ExplicitWidth = 491
      DesignSize = (
        524
        105)
      object memoReply: TMemo
        Left = 8
        Top = 15
        Width = 378
        Height = 82
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitWidth = 345
      end
      object btnSelectReply: TButton
        Left = 393
        Top = 16
        Width = 121
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1086#1090#1074#1077#1090
        TabOrder = 1
        ExplicitLeft = 360
      end
      object bbtnSignOn: TBitBtn
        Left = 393
        Top = 72
        Width = 121
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1055#1086#1076#1087#1080#1089#1072#1090#1100
        Images = frmMain.ilIcons16
        TabOrder = 2
        OnClick = btnSignOnClick
        ExplicitLeft = 360
      end
    end
    object gbText: TGroupBox
      Left = 0
      Top = 73
      Width = 524
      Height = 247
      Align = alClient
      Caption = #1058#1077#1082#1089#1090' '#1089#1083#1091#1078#1077#1073#1085#1086#1081' '#1079#1072#1087#1080#1089#1082#1080
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 2
      ExplicitWidth = 491
      object memoText: TMemo
        Left = 7
        Top = 23
        Width = 510
        Height = 217
        Align = alClient
        PopupMenu = pmNoteText
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 8
        ExplicitTop = 15
        ExplicitWidth = 473
        ExplicitHeight = 226
      end
    end
  end
  object gbList: TGroupBox
    Left = 0
    Top = 0
    Width = 240
    Height = 425
    Align = alLeft
    Caption = #1057#1083#1091#1078#1077#1073#1085#1099#1077' '#1079#1072#1087#1080#1089#1082#1080
    TabOrder = 1
    ExplicitLeft = 33
    object lvOrdersList: TListView
      Left = 2
      Top = 18
      Width = 236
      Height = 405
      Align = alClient
      Columns = <
        item
          Caption = #1055
          MinWidth = 20
          Width = 30
        end
        item
          Caption = #1044#1072#1090#1072
        end
        item
          Caption = #1054#1090' '#1082#1086#1075#1086
          Width = 80
        end
        item
          AutoSize = True
          Caption = #1058#1077#1082#1089#1090
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = pmLocOrdersList
      SmallImages = frmMain.ilIcons16
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = lvOrdersListChange
    end
  end
  object alLocalOrders: TActionList
    Images = frmMain.ilIcons16
    Left = 80
    Top = 152
    object actNew: TAction
      Category = 'Local orders'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1080#1089#1082#1091
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1080#1089#1082#1091
      ImageIndex = 0
      OnExecute = actNewExecute
    end
    object actApply: TAction
      Category = 'Local orders'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Hint = 'Apply'
      ImageIndex = 6
      OnExecute = actNewExecute
    end
    object actListLoad: TAction
      Category = 'Local orders'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 28
      OnExecute = actNewExecute
    end
    object actListSave: TAction
      Category = 'Local orders'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 27
      OnExecute = actNewExecute
    end
    object actSignOn: TAction
      Caption = #1055#1086#1076#1087#1080#1089#1072#1090#1100
    end
    object actSelectAnswer: TAction
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1086#1090#1074#1077#1090
    end
  end
  object pmLocOrdersList: TPopupMenu
    Images = frmMain.ilIcons16
    Left = 48
    Top = 88
    object mNewItem: TMenuItem
      Action = actNew
    end
    object mApply: TMenuItem
      Action = actApply
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Action = actListLoad
    end
    object N3: TMenuItem
      Action = actListSave
    end
  end
  object pmNoteText: TPopupMenu
    Left = 497
    Top = 184
  end
end
