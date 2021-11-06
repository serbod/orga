object FramePersonnel: TFramePersonnel
  Left = 0
  Top = 0
  Width = 744
  Height = 486
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object panCentral: TPanel
    Left = 0
    Top = 0
    Width = 744
    Height = 486
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 226
      Width = 742
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 709
    end
    object panTop: TPanel
      Left = 1
      Top = 1
      Width = 742
      Height = 225
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 188
        Top = 0
        Height = 225
      end
      object tvPersonnel: TTreeView
        Left = 0
        Top = 0
        Width = 188
        Height = 225
        Align = alLeft
        Indent = 19
        PopupMenu = pmPersTree
        TabOrder = 0
        OnChange = tvPersonnelChange
        OnEdited = tvPersonnelEdited
        Items.NodeData = {
          03020000003E0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
          00000000000110260435043D044204400430043B044C043D044B04390420003E
          044404380441043A0000000000000000000000FFFFFFFFFFFFFFFF0000000000
          00000000000000010E240438043B04380430043B04200012043E0440043E043D
          0435043604}
      end
      object lvPersonnel: TListView
        Left = 191
        Top = 0
        Width = 551
        Height = 225
        Align = alClient
        Columns = <
          item
            Caption = #1048#1084#1103
            Width = 250
          end
          item
            Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            Width = 100
          end
          item
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            Width = 150
          end>
        GridLines = True
        Items.ItemData = {
          05500000000100000000000000FFFFFFFFFFFFFFFF02000000FFFFFFFF000000
          00000C210435043C0435043D043E043204200012042E0012042E000000000008
          14043804400435043A0442043E04400400000000FFFFFFFF}
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmPersList
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvPersonnelChange
        OnDblClick = lvPersonnelDblClick
      end
    end
    object panBottom: TPanel
      Left = 1
      Top = 229
      Width = 742
      Height = 256
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pcPersInfo: TPageControl
        Left = 0
        Top = 0
        Width = 742
        Height = 256
        ActivePage = tsPersOrders
        Align = alClient
        Images = frmMain.ilIcons16
        TabOrder = 0
        object tsEmpInfo: TTabSheet
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
          ImageIndex = 12
          object Splitter3: TSplitter
            Left = 193
            Top = 0
            Height = 225
            ExplicitLeft = 233
            ExplicitHeight = 228
          end
          object gbEmployeeInfo: TGroupBox
            Left = 196
            Top = 0
            Width = 538
            Height = 225
            Align = alClient
            Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1077
            TabOrder = 0
            object vledPersInfo: TValueListEditor
              Left = 2
              Top = 18
              Width = 534
              Height = 205
              Align = alClient
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
              PopupMenu = pmPersInfo
              TabOrder = 0
              TitleCaptions.Strings = (
                #1057#1074#1086#1081#1089#1090#1074#1086
                #1047#1085#1072#1095#1077#1085#1080#1077)
              ColWidths = (
                150
                378)
            end
          end
          object gbEmployeePhoto: TGroupBox
            Left = 0
            Top = 0
            Width = 193
            Height = 225
            Align = alLeft
            Caption = #1060#1086#1090#1086#1075#1088#1072#1092#1080#1103' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
            TabOrder = 1
            object imgPersPhoto: TImage
              Left = 2
              Top = 18
              Width = 189
              Height = 205
              Align = alClient
              PopupMenu = pmPersInfo
              Stretch = True
              ExplicitTop = 15
              ExplicitWidth = 229
              ExplicitHeight = 211
            end
          end
        end
        object tsPersTasks: TTabSheet
          Caption = #1047#1072#1076#1072#1095#1080' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
          object Splitter4: TSplitter
            Left = 382
            Top = 0
            Height = 225
            ExplicitLeft = 391
            ExplicitTop = -3
          end
          object gbPersTaskInfo: TGroupBox
            Left = 385
            Top = 0
            Width = 349
            Height = 225
            Align = alClient
            Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1079#1072#1076#1072#1095#1080
            TabOrder = 0
            object memoPersTaskText: TMemo
              Left = 8
              Top = 56
              Width = 297
              Height = 161
              ReadOnly = True
              TabOrder = 0
            end
          end
          object lvPersTasks: TListView
            Left = 0
            Top = 0
            Width = 382
            Height = 225
            Align = alLeft
            Columns = <
              item
                AutoSize = True
                Caption = #1054#1087#1080#1089#1072#1085#1080#1077
                MinWidth = 100
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            StateImages = frmMain.ilIcons16
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvPersTasksChange
          end
        end
        object tsPersOrders: TTabSheet
          Caption = #1057#1083#1091#1078#1077#1073#1085#1099#1077' '#1079#1072#1087#1080#1089#1082#1080
          ImageIndex = 14
          object Splitter5: TSplitter
            Left = 337
            Top = 0
            Height = 225
            ExplicitHeight = 228
          end
          object lvPersLocalOrders: TListView
            Left = 0
            Top = 0
            Width = 337
            Height = 225
            Align = alLeft
            Columns = <
              item
                Caption = #1055
                MinWidth = 20
                Width = 20
              end
              item
                Caption = #1044#1072#1090#1072
                MinWidth = 50
              end
              item
                Caption = #1050#1086#1084#1091
                MinWidth = 100
                Width = 100
              end
              item
                Caption = #1058#1077#1082#1089#1090
                Width = 250
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            SmallImages = frmMain.ilIcons16
            TabOrder = 0
            ViewStyle = vsReport
            OnSelectItem = lvPersLocalOrdersSelectItem
          end
          object gbPersLocalOrdersInfo: TGroupBox
            Left = 340
            Top = 0
            Width = 394
            Height = 225
            Align = alClient
            Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1089#1083#1091#1078#1077#1073#1085#1086#1081' '#1079#1072#1087#1080#1089#1082#1080
            TabOrder = 1
            object memoPersLocalOrderText: TMemo
              Left = 8
              Top = 24
              Width = 337
              Height = 137
              TabOrder = 0
            end
          end
        end
        object tsPersChat: TTabSheet
          Caption = #1063#1072#1090
          ImageIndex = 13
        end
      end
    end
  end
  object pmPersTree: TPopupMenu
    Left = 88
    Top = 56
    object N3: TMenuItem
      Action = actRefresh
    end
    object N5: TMenuItem
      Action = actLoad
    end
    object N7: TMenuItem
      Action = actSave
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mAddGroup: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      OnClick = PersTreePopupClick
    end
    object mAddSubGroup: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1075#1088#1091#1087#1087#1091
      OnClick = PersTreePopupClick
    end
    object mDelGroup: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      OnClick = PersTreePopupClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mExpandSel: TMenuItem
      Caption = #1056#1072#1089#1082#1088#1099#1090#1100
      OnClick = PersTreePopupClick
    end
    object mExpandAll: TMenuItem
      Caption = #1056#1072#1089#1082#1088#1099#1090#1100' '#1074#1089#1077
      OnClick = PersTreePopupClick
    end
    object mCollapseAll: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      OnClick = PersTreePopupClick
    end
  end
  object pmPersList: TPopupMenu
    Left = 272
    Top = 64
    object mAddItem: TMenuItem
      Action = actPersAdd
    end
    object mDelItem: TMenuItem
      Action = actPersDel
    end
    object mSaveItem: TMenuItem
      Action = actPersSave
    end
  end
  object pmPersInfo: TPopupMenu
    Left = 432
    Top = 368
    object mPersInfoWrite: TMenuItem
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      OnClick = PersInfoPopupClick
    end
    object mPersInfoPropsList: TMenuItem
      Caption = #1057#1087#1080#1089#1086#1082' '#1089#1074#1086#1081#1089#1090#1074
      OnClick = PersInfoPopupClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mPersInfoSetPhoto: TMenuItem
      Caption = #1047#1072#1076#1072#1090#1100' '#1092#1086#1090#1086#1075#1088#1072#1092#1080#1102
      OnClick = PersInfoPopupClick
    end
    object mPersInfoDelPhoto: TMenuItem
      Caption = #1059#1073#1088#1072#1090#1100' '#1092#1086#1090#1086#1075#1088#1072#1092#1080#1102
      OnClick = PersInfoPopupClick
    end
  end
  object pmTableSelector: TPopupMenu
    Left = 72
    Top = 160
    object mTablePers: TMenuItem
      Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080
      OnClick = mTableSelectorClick
    end
    object mTablePersDataTypes: TMenuItem
      Caption = #1042#1080#1076#1099' '#1089#1074#1086#1081#1089#1090#1074
      OnClick = mTableSelectorClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object mTablePersData: TMenuItem
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      OnClick = mTableSelectorClick
    end
    object mTablePersTasks: TMenuItem
      Caption = #1047#1072#1076#1072#1095#1080' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      OnClick = mTableSelectorClick
    end
    object mTablePersLocalOrders: TMenuItem
      Caption = #1057#1083#1091#1078#1077#1073#1085#1099#1077' '#1079#1072#1087#1080#1089#1082#1080' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      OnClick = mTableSelectorClick
    end
  end
  object alPersonnel: TActionList
    Left = 162
    Top = 57
    object actRefresh: TAction
      Category = 'PersTree'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
      OnExecute = actRefreshExecute
    end
    object actLoad: TAction
      Category = 'PersTree'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      OnExecute = actLoadExecute
    end
    object actSave: TAction
      Category = 'PersTree'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnExecute = actSaveExecute
    end
    object actTableEdit: TAction
      Category = 'PersTree'
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1072#1073#1083#1080#1094#1099
      OnExecute = actTableEditExecute
    end
    object actPersAdd: TAction
      Category = 'PersList'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      OnExecute = actPersAddExecute
    end
    object actPersDel: TAction
      Category = 'PersList'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
    end
    object actPersSave: TAction
      Category = 'PersList'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1077#1088#1089#1086#1085#1091
      OnExecute = actPersSaveExecute
    end
  end
end
