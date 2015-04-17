object FramePersonnel: TFramePersonnel
  Left = 0
  Top = 0
  Width = 744
  Height = 486
  TabOrder = 0
  object panCentral: TPanel
    Left = 33
    Top = 0
    Width = 711
    Height = 486
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 226
      Width = 709
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object panTop: TPanel
      Left = 1
      Top = 1
      Width = 709
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
        Items.Data = {
          02000000290000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
          10D6E5EDF2F0E0EBFCEDFBE920EEF4E8F1270000000000000000000000FFFFFF
          FFFFFFFFFF00000000000000000ED4E8EBE8E0EB20C2EEF0EEEDE5E6}
      end
      object lvPersonnel: TListView
        Left = 191
        Top = 0
        Width = 518
        Height = 225
        Align = alClient
        Columns = <
          item
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            Width = 25
          end
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
        Items.Data = {
          370000000100000000000000FFFFFFFFFFFFFFFF0200000000000000000CD1E5
          ECE5EDEEE220C22EC22E08C4E8F0E5EAF2EEF0FFFFFFFF}
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmPersList
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvPersonnelChange
      end
    end
    object panBottom: TPanel
      Left = 1
      Top = 229
      Width = 709
      Height = 256
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pcPersInfo: TPageControl
        Left = 0
        Top = 0
        Width = 709
        Height = 256
        ActivePage = tsPersOrders
        Align = alClient
        TabOrder = 0
        object tsEmpInfo: TTabSheet
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
          object Splitter3: TSplitter
            Left = 233
            Top = 0
            Height = 228
          end
          object gbEmployeeInfo: TGroupBox
            Left = 236
            Top = 0
            Width = 465
            Height = 228
            Align = alClient
            Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1077
            TabOrder = 0
            object vledPersInfo: TValueListEditor
              Left = 2
              Top = 15
              Width = 461
              Height = 211
              Align = alClient
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
              PopupMenu = pmPersInfo
              TabOrder = 0
              TitleCaptions.Strings = (
                #1057#1074#1086#1081#1089#1090#1074#1086
                #1047#1085#1072#1095#1077#1085#1080#1077)
              ColWidths = (
                150
                305)
            end
          end
          object gbEmployeePhoto: TGroupBox
            Left = 0
            Top = 0
            Width = 233
            Height = 228
            Align = alLeft
            Caption = #1060#1086#1090#1086#1075#1088#1072#1092#1080#1103' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
            TabOrder = 1
            object imgPersPhoto: TImage
              Left = 2
              Top = 15
              Width = 229
              Height = 211
              Align = alClient
              PopupMenu = pmPersInfo
              Stretch = True
            end
          end
        end
        object tsPersTasks: TTabSheet
          Caption = #1047#1072#1076#1072#1095#1080' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
          ImageIndex = 1
          object Splitter4: TSplitter
            Left = 385
            Top = 0
            Height = 228
          end
          object gbPersTaskInfo: TGroupBox
            Left = 388
            Top = 0
            Width = 313
            Height = 228
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
            Width = 385
            Height = 228
            Align = alLeft
            Columns = <
              item
                Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
                MaxWidth = 100
                MinWidth = 22
                Width = 22
              end
              item
                Caption = #1057#1090#1072#1090#1091#1089
                MaxWidth = 100
                MinWidth = 22
                Width = 22
              end
              item
                Caption = #1054#1087#1080#1089#1072#1085#1080#1077
                MinWidth = 100
                Width = 320
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvPersTasksChange
          end
        end
        object tsPersOrders: TTabSheet
          Caption = #1057#1083#1091#1078#1077#1073#1085#1099#1077' '#1079#1072#1087#1080#1089#1082#1080
          ImageIndex = 2
          object Splitter5: TSplitter
            Left = 337
            Top = 0
            Height = 228
          end
          object lvPersLocalOrders: TListView
            Left = 0
            Top = 0
            Width = 337
            Height = 228
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
            TabOrder = 0
            ViewStyle = vsReport
            OnSelectItem = lvPersLocalOrdersSelectItem
          end
          object gbPersLocalOrdersInfo: TGroupBox
            Left = 340
            Top = 0
            Width = 361
            Height = 228
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
      end
    end
  end
  object toolbarPersonnel: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 486
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbRefreshList: TToolButton
      Left = 0
      Top = 0
      Hint = 'Refresh'
      Caption = 'tbRefreshList'
      ImageIndex = 29
      Wrap = True
      OnClick = toolbarPersonnelClick
    end
    object tbLoadList: TToolButton
      Left = 0
      Top = 30
      Hint = 'Load'
      Caption = 'tbLoadList'
      ImageIndex = 28
      Wrap = True
      OnClick = toolbarPersonnelClick
    end
    object tbSaveList: TToolButton
      Left = 0
      Top = 60
      Hint = 'Save'
      Caption = 'tbSaveList'
      ImageIndex = 27
      Wrap = True
      OnClick = toolbarPersonnelClick
    end
    object ToolButton1: TToolButton
      Left = 0
      Top = 90
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 3
      Wrap = True
      Style = tbsSeparator
    end
    object tbTableEdit: TToolButton
      Left = 0
      Top = 128
      Hint = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1072#1073#1083#1080#1094#1099
      Caption = 'tbTableEdit'
      ImageIndex = 3
      PopupMenu = pmTableSelector
      Wrap = True
      OnClick = toolbarPersonnelClick
    end
    object ToolButton3: TToolButton
      Left = 0
      Top = 158
      Caption = 'ToolButton3'
      ImageIndex = 4
      Wrap = True
      OnClick = toolbarPersonnelClick
    end
  end
  object pmPersTree: TPopupMenu
    Left = 88
    Top = 56
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
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = PersListPopupClick
    end
    object mDelItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = PersListPopupClick
    end
    object mSaveItem: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = PersListPopupClick
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
end
