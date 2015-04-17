object FrameTasksAll: TFrameTasksAll
  Left = 0
  Top = 0
  Width = 763
  Height = 431
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 446
    Top = 0
    Height = 431
  end
  object toolbarMain: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 431
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object tbRefresh: TToolButton
      Left = 0
      Top = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1079#1072#1076#1072#1095
      Caption = 'tbRefresh'
      ImageIndex = 29
      Wrap = True
      OnClick = tbClick
    end
    object tbLoadTasks: TToolButton
      Left = 0
      Top = 30
      Hint = 'Load task list'
      Caption = 'tbLoadTasks'
      ImageIndex = 28
      Wrap = True
      OnClick = tbClick
    end
    object tbSaveTasks: TToolButton
      Left = 0
      Top = 60
      Hint = 'Save task list'
      Caption = 'tbSaveTasks'
      ImageIndex = 27
      Wrap = True
      OnClick = tbClick
    end
    object ToolButton4: TToolButton
      Left = 0
      Top = 90
      Caption = 'ToolButton4'
      Wrap = True
      OnClick = tbClick
    end
  end
  object panelLeft: TPanel
    Left = 33
    Top = 0
    Width = 413
    Height = 431
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object lvAllTasks: TListView
      Left = 0
      Top = 0
      Width = 413
      Height = 431
      Align = alClient
      Columns = <
        item
          Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
        end
        item
          Caption = #1040#1074#1090#1086#1088
        end
        item
          Caption = #1047#1072#1076#1072#1095#1072
          Width = 250
        end
        item
          Caption = #1055#1077#1088#1080#1086#1076
        end>
      GridLines = True
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = lvAllTasksChange
    end
  end
  object panelRight: TPanel
    Left = 449
    Top = 0
    Width = 314
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object gbTaskDetails: TGroupBox
      Left = 0
      Top = 36
      Width = 314
      Height = 395
      Align = alClient
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1079#1072#1076#1072#1095#1080
      TabOrder = 0
      DesignSize = (
        314
        395)
      object Label1: TLabel
        Left = 8
        Top = 20
        Width = 57
        Height = 13
        Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090':'
      end
      object Label2: TLabel
        Left = 12
        Top = 56
        Width = 38
        Height = 13
        Caption = #1055#1077#1088#1080#1086#1076
      end
      object lbPriorityValue: TLabel
        Left = 80
        Top = 16
        Width = 21
        Height = 25
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 12
        Top = 80
        Width = 30
        Height = 13
        Caption = #1040#1074#1090#1086#1088
      end
      object Label4: TLabel
        Left = 12
        Top = 104
        Width = 54
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
      end
      object lbAuthor: TLabel
        Left = 104
        Top = 80
        Width = 193
        Height = 13
        AutoSize = False
      end
      object trackbarPriority: TTrackBar
        Left = 100
        Top = 16
        Width = 200
        Height = 33
        Max = 6
        TabOrder = 0
        ThumbLength = 18
        OnChange = trackbarPriorityChange
      end
      object trackbarStatus: TTrackBar
        Left = 100
        Top = 96
        Width = 200
        Height = 33
        TabOrder = 1
        ThumbLength = 18
      end
      object reTaskText: TRichEdit
        Left = 8
        Top = 140
        Width = 299
        Height = 247
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          #1058#1077#1082#1089#1090' '#1079#1072#1076#1072#1095#1080)
        TabOrder = 2
      end
      object dtpBegin: TDateTimePicker
        Left = 104
        Top = 56
        Width = 89
        Height = 21
        Date = 39861.678234768520000000
        Time = 39861.678234768520000000
        Enabled = False
        TabOrder = 3
      end
      object dtpEnd: TDateTimePicker
        Left = 208
        Top = 56
        Width = 90
        Height = 21
        Date = 39861.678434062500000000
        Time = 39861.678434062500000000
        TabOrder = 4
      end
    end
    object toolbarTaskEdit: TToolBar
      Left = 0
      Top = 0
      Width = 314
      Height = 36
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'toolbarTaskEdit'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object tbAddTask: TToolButton
        Left = 0
        Top = 0
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
        ImageIndex = 0
        OnClick = tbClick
      end
      object tbDeleteTask: TToolButton
        Left = 31
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1076#1072#1085#1080#1077
        Caption = 'tbDeleteTask'
        ImageIndex = 26
        OnClick = tbClick
      end
      object ToolButton7: TToolButton
        Left = 62
        Top = 0
        Caption = 'ToolButton7'
        OnClick = tbClick
      end
      object ToolButton8: TToolButton
        Left = 93
        Top = 0
        Caption = 'ToolButton8'
        OnClick = tbClick
      end
    end
  end
end
