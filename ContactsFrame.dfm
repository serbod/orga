object FrameContacts: TFrameContacts
  Left = 0
  Top = 0
  Width = 766
  Height = 424
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter8: TSplitter
    Left = 266
    Top = 0
    Height = 424
  end
  object toolbarContacts: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 424
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = toolbarContactsClick
    object tbRefreshList: TToolButton
      Left = 0
      Top = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 29
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object tbLoadList: TToolButton
      Left = 0
      Top = 30
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      Caption = 'tbLoadList'
      ImageIndex = 28
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object tbSaveList: TToolButton
      Left = 0
      Top = 60
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Caption = 'tbSaveList'
      ImageIndex = 27
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object ToolButton1: TToolButton
      Left = 0
      Top = 90
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 28
      Wrap = True
      Style = tbsSeparator
    end
    object tbAddItem: TToolButton
      Left = 0
      Top = 128
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      Caption = 'tbAddItem'
      ImageIndex = 0
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object tbDelItem: TToolButton
      Left = 0
      Top = 158
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      Caption = 'tbDelItem'
      ImageIndex = 26
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object tbSaveItem: TToolButton
      Left = 0
      Top = 188
      Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      Caption = 'tbSaveItem'
      ImageIndex = 4
      Wrap = True
      OnClick = toolbarContactsClick
    end
    object tbEditList: TToolButton
      Left = 0
      Top = 218
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1077#1081
      Caption = 'tbEditList'
      ImageIndex = 5
      PopupMenu = pmTablesMenu
      Wrap = True
      OnClick = toolbarContactsClick
    end
  end
  object panRight: TPanel
    Left = 269
    Top = 0
    Width = 497
    Height = 424
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object gbContactMain: TGroupBox
      Left = 0
      Top = 0
      Width = 497
      Height = 192
      Align = alTop
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1082#1086#1085#1090#1072#1082#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        497
        192)
      object lbContData1: TLabel
        Left = 8
        Top = 64
        Width = 105
        Height = 16
        Caption = #1055#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077
      end
      object lbContData2: TLabel
        Left = 8
        Top = 104
        Width = 162
        Height = 16
        Caption = #1060#1072#1084#1080#1083#1080#1103', '#1080#1084#1103', '#1086#1090#1095#1077#1089#1090#1074#1086
      end
      object lbContData3: TLabel
        Left = 8
        Top = 144
        Width = 85
        Height = 16
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      end
      object lbContType: TLabel
        Left = 8
        Top = 24
        Width = 97
        Height = 13
        AutoSize = False
        Caption = #1058#1080#1087' '#1082#1086#1085#1090#1072#1082#1090#1072
      end
      object lbName: TLabel
        Left = 200
        Top = 24
        Width = 121
        Height = 16
        Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      end
      object edContData1: TEdit
        Left = 8
        Top = 80
        Width = 481
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        TabOrder = 0
      end
      object edContData2: TEdit
        Left = 8
        Top = 120
        Width = 481
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        TabOrder = 1
      end
      object edContData3: TEdit
        Left = 8
        Top = 160
        Width = 481
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        TabOrder = 2
      end
      object cmboxContType: TComboBox
        Left = 8
        Top = 40
        Width = 185
        Height = 24
        TabOrder = 3
        OnChange = cmboxContTypeChange
        Items.Strings = (
          #1063#1072#1089#1090#1085#1086#1077' '#1083#1080#1094#1086
          #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
          #1043#1088#1091#1087#1087#1072' '#1082#1086#1085#1090#1072#1082#1090#1086#1074)
      end
      object edName: TEdit
        Left = 200
        Top = 40
        Width = 289
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        TabOrder = 4
      end
    end
    object gbContactExtra: TGroupBox
      Left = 0
      Top = 192
      Width = 497
      Height = 232
      Align = alClient
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object vledExtraData: TValueListEditor
        Left = 2
        Top = 18
        Width = 493
        Height = 212
        Align = alClient
        TabOrder = 0
        TitleCaptions.Strings = (
          #1057#1074#1086#1081#1089#1090#1074#1086
          #1047#1085#1072#1095#1077#1085#1080#1077)
        ColWidths = (
          150
          337)
      end
    end
  end
  object tvContacts: TTreeView
    Left = 33
    Top = 0
    Width = 233
    Height = 424
    Align = alLeft
    DragMode = dmAutomatic
    Indent = 19
    PopupMenu = pmContListPopup
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    OnChange = tvContactsChange
    OnDragDrop = tvContactsDragDrop
    OnDragOver = tvContactsDragOver
    Items.NodeData = {
      0305000000320000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0002000000010A21043E0442044004430434043D0438043A0438043600000000
      00000000000000FFFFFFFFFFFFFFFF000000000000000002000000010C13043B
      04300432043D044B04390420003E044404380441043600000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000000000000010C1A043E043C04300440
      043E043204200012042E0012042E003C0000000000000000000000FFFFFFFFFF
      FFFFFF000000000000000000000000010F220435043F043B043E04320441043A
      0438043904200010042E001C042E00400000000000000000000000FFFFFFFFFF
      FFFFFF0000000000000000010000000111240438043B04380430043B04200033
      042E00200012043E0440043E043D04350436043E0000000000000000000000FF
      FFFFFFFFFFFFFF000000000000000000000000011021043A0443043B044C0431
      04380446043A0430044F04200013042E001F042E003200000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000002000000010A1F043E043A0443043F
      043004420435043B043804380000000000000000000000FFFFFFFFFFFFFFFF00
      0000000000000000000000010D1E041E041E04200022001F0440043E04410442
      043E0440042200300000000000000000000000FFFFFFFFFFFFFFFF0000000000
      00000000000000010918041F042000210438043B043004350432043200000000
      00000000000000FFFFFFFFFFFFFFFF000000000000000002000000010A1F043E
      044104420430043204490438043A0438043E0000000000000000000000FFFFFF
      FFFFFFFFFF000000000000000000000000011018041F0420001F043E043D0438
      0442043A043E04320420001C042E0024042E00380000000000000000000000FF
      FFFFFFFFFFFFFF000000000000000000000000010D1E041E041E04200022001F
      0440043504410442043804360422002A0000000000000000000000FFFFFFFFFF
      FFFFFF0000000000000000000000000106230441043B044304330438042A0000
      000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001061F
      0440043E04470438043504}
  end
  object pmContListPopup: TPopupMenu
    Left = 56
    Top = 240
    object mAddItem: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      OnClick = ContListPopupClick
    end
    object mAddSubItem: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076'-'#1082#1086#1085#1090#1072#1082#1090
      OnClick = ContListPopupClick
    end
    object mDiv1: TMenuItem
      Caption = '-'
    end
    object mDelItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1099#1081' '#1082#1086#1085#1090#1072#1082#1090
      OnClick = ContListPopupClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mExpandSel: TMenuItem
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1086#1077
      OnClick = ContListPopupClick
    end
    object mExpandAll: TMenuItem
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      OnClick = ContListPopupClick
    end
    object mCollapseAll: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      OnClick = ContListPopupClick
    end
  end
  object pmTablesMenu: TPopupMenu
    Left = 104
    Top = 240
    object mContactsTable: TMenuItem
      Caption = #1050#1086#1085#1090#1072#1082#1090#1099
      OnClick = TablesMenuClick
    end
    object mContDataTable: TMenuItem
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1085#1090#1072#1090#1082#1090#1086#1074
      OnClick = TablesMenuClick
    end
    object mContDataTypeTable: TMenuItem
      Caption = #1058#1080#1087#1099' '#1089#1074#1086#1081#1089#1090#1074' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      OnClick = TablesMenuClick
    end
  end
end
