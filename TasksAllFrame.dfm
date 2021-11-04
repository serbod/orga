object FrameTasksAll: TFrameTasksAll
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
    Left = 447
    Top = 0
    Height = 431
    ExplicitLeft = 446
  end
  object panelLeft: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 431
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object lvAllTasks: TListView
      Left = 0
      Top = 0
      Width = 447
      Height = 431
      Align = alClient
      Columns = <
        item
          Caption = #1047#1072#1076#1072#1095#1072
          Width = 300
        end
        item
          Caption = #1055#1077#1088#1080#1086#1076
          Width = 70
        end
        item
          Caption = #1040#1074#1090#1086#1088
        end>
      GridLines = True
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = pmTasksList
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = lvAllTasksChange
      ExplicitLeft = -6
      ExplicitTop = -8
      ExplicitWidth = 413
    end
  end
  object panelRight: TPanel
    Left = 450
    Top = 0
    Width = 313
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 449
    ExplicitWidth = 314
    object gbTaskDetails: TGroupBox
      Left = 0
      Top = 0
      Width = 313
      Height = 431
      Align = alClient
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1079#1072#1076#1072#1095#1080
      TabOrder = 0
      ExplicitTop = 36
      ExplicitWidth = 314
      ExplicitHeight = 395
      DesignSize = (
        313
        431)
      object Label2: TLabel
        Left = 12
        Top = 56
        Width = 43
        Height = 16
        Caption = #1055#1077#1088#1080#1086#1076
      end
      object Label3: TLabel
        Left = 12
        Top = 82
        Width = 35
        Height = 16
        Caption = #1040#1074#1090#1086#1088
      end
      object Label4: TLabel
        Left = 12
        Top = 29
        Width = 62
        Height = 16
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
      end
      object lbAuthor: TLabel
        Left = 104
        Top = 86
        Width = 193
        Height = 16
        AutoSize = False
      end
      object lbFiles: TLabel
        Left = 16
        Top = 384
        Width = 40
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = #1060#1072#1081#1083#1099
      end
      object reTaskText: TRichEdit
        Left = 8
        Top = 108
        Width = 298
        Height = 269
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          #1058#1077#1082#1089#1090' '#1079#1072#1076#1072#1095#1080)
        ParentFont = False
        TabOrder = 0
        Zoom = 100
        OnChange = OnChangeHandler
      end
      object dtpBegin: TDateTimePicker
        Left = 104
        Top = 56
        Width = 89
        Height = 24
        Date = 39861.000000000000000000
        Time = 0.678234768522088400
        Enabled = False
        TabOrder = 1
        OnChange = OnChangeHandler
      end
      object dtpEnd: TDateTimePicker
        Left = 208
        Top = 56
        Width = 90
        Height = 24
        Date = 39861.000000000000000000
        Time = 0.678434062501764900
        TabOrder = 2
        OnChange = OnChangeHandler
      end
      object cbbTaskStatus: TComboBoxEx
        Left = 104
        Top = 25
        Width = 193
        Height = 25
        ItemsEx = <
          item
            Caption = #1053#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086
          end
          item
            Caption = #1054#1073#1099#1095#1085#1072#1103' '#1079#1072#1076#1072#1095#1072
            ImageIndex = 7
            SelectedImageIndex = 7
          end
          item
            Caption = #1057#1088#1086#1095#1085#1072#1103' '#1079#1072#1076#1072#1095#1072
            ImageIndex = 8
            SelectedImageIndex = 8
          end
          item
            Caption = #1050#1088#1080#1090#1080#1095#1085#1072#1103' '#1079#1072#1076#1072#1095#1072
            ImageIndex = 9
            SelectedImageIndex = 9
          end
          item
            Caption = #1047#1072#1076#1072#1095#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1072
            ImageIndex = 10
            SelectedImageIndex = 10
          end
          item
            Caption = #1054#1090#1083#1086#1078#1077#1085#1086' '#1085#1072' '#1087#1086#1090#1086#1084
            ImageIndex = 11
            SelectedImageIndex = 11
          end>
        Style = csExDropDownList
        TabOrder = 3
        OnChange = OnChangeHandler
        Images = frmMain.ilIcons16
      end
    end
  end
  object alTasks: TActionList
    Left = 129
    Top = 72
    object actTasksLoad: TAction
      Caption = 'Load task list'
      OnExecute = actTasksLoadExecute
    end
    object actTasksSave: TAction
      Caption = 'Save task list'
      OnExecute = actTasksSaveExecute
    end
    object actTasksRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1079#1072#1076#1072#1095
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1079#1072#1076#1072#1095
      OnExecute = actTasksRefreshExecute
    end
    object actTaskAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1076#1072#1095#1091
      OnExecute = actTaskAddExecute
    end
    object actTaskDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1076#1072#1095#1091
      OnExecute = actTaskDelExecute
    end
  end
  object pmTasksList: TPopupMenu
    Left = 201
    Top = 72
    object N1: TMenuItem
      Action = actTasksRefresh
    end
    object Loadtasklist1: TMenuItem
      Action = actTasksLoad
    end
    object Savetasklist1: TMenuItem
      Action = actTasksSave
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Action = actTaskAdd
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = actTaskDel
    end
  end
end
