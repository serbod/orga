object FrameEnterpiseStructure: TFrameEnterpiseStructure
  Left = 0
  Top = 0
  Width = 763
  Height = 526
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 296
    Top = 0
    Height = 526
    ExplicitLeft = 329
  end
  object panLeft: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 526
    Align = alLeft
    Caption = 'panLeft'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 374
      Width = 294
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object panLeftBottom: TPanel
      Left = 1
      Top = 377
      Width = 294
      Height = 148
      Align = alClient
      TabOrder = 0
      object gbDeptInfo: TGroupBox
        Left = 1
        Top = 1
        Width = 292
        Height = 146
        Align = alClient
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
        TabOrder = 0
      end
    end
    object tvDepartments: TTreeView
      Left = 1
      Top = 1
      Width = 294
      Height = 373
      Align = alTop
      Indent = 19
      TabOrder = 1
      OnChange = tvDepartmentsChange
      Items.NodeData = {
        0304000000360000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0007000000010C13043B04300432043D044B04390420003E0444043804410434
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000500000001
        0B110443044504330430043B0442043504400438044F04360000000000000000
        000000FFFFFFFFFFFFFFFF000000000000000000000000010C1E044204340435
        043B0420003A043004340440043E043204280000000000000000000000FFFFFF
        FFFFFFFFFF000000000000000000000000010510044004450438043204400000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000011113
        043B04300432043D044B0439042000310443044504330430043B044204350440
        04280000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
        0001051A043004410441043004340000000000000000000000FFFFFFFFFFFFFF
        FF000000000000000000000000010B110443044504330430043B044204350440
        0438044F04360000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0003000000010C1E044204340435043B0420003F0440043E0434043004360434
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
        0B1C04300440043A04350442043E043B043E04330438042C0000000000000000
        000000FFFFFFFFFFFFFFFF0000000000000000000000000107200435043A043B
        0430043C043004480000000000000000000000FFFFFFFFFFFFFFFF0000000000
        0000000000000001151C0435043D04350434043604350440044B0420003F043E
        0420003F0440043E0434043004360430043C04380000000000000000000000FF
        FFFFFFFFFFFFFF000000000000000003000000010D1E044204340435043B0420
        00370430043A0443043F043E043A04380000000000000000000000FFFFFFFFFF
        FFFFFF000000000000000000000000010D1E044204340435043B042000370430
        043A0443043F043E043A04300000000000000000000000FFFFFFFFFFFFFFFF00
        000000000000000000000001091B043E04330438044104420438043A04300438
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
        0D1404380441043F043504420447043504400441043A0430044F042400000000
        00000000000000FFFFFFFFFFFFFFFF0000000000000000020000000103100421
        042304360000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
        000000010C1F0440043E043304400430043C043C043804410442044B04300000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000010921
        04350440043204350440043D0430044F042E0000000000000000000000FFFFFF
        FFFFFFFFFF00000000000000000000000001081F044004380435043C043D0430
        044F042E0000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
        0000000108210442043E043B043E04320430044F043800000000000000000000
        00FFFFFFFFFFFFFFFF000000000000000000000000010D1A043E043D04440435
        04400435043D0446042D00370430043B042E0000000000000000000000FFFFFF
        FFFFFFFFFF000000000000000000000000010821043A043B0430043404200016
        213100280000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
        0000000105130430044004300436043A0000000000000000000000FFFFFFFFFF
        FFFFFF000000000000000000000000010E240438043B04380430043B04200012
        043E0440043E043D0435043604}
      ExplicitLeft = 0
      ExplicitTop = 26
    end
  end
  object panRight: TPanel
    Left = 299
    Top = 0
    Width = 464
    Height = 526
    Align = alClient
    TabOrder = 1
    object gbPersonnel: TGroupBox
      Left = 1
      Top = 1
      Width = 462
      Height = 208
      Align = alTop
      Caption = #1055#1077#1088#1089#1086#1085#1072#1083' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object lvDeptPersonnel: TListView
        Left = 7
        Top = 23
        Width = 448
        Height = 178
        Align = alClient
        Columns = <
          item
            Caption = #1048#1084#1103
            Width = 200
          end
          item
            Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            Width = 100
          end
          item
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            Width = 100
          end>
        GridLines = True
        HotTrack = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object gbTasks: TGroupBox
      Left = 1
      Top = 209
      Width = 462
      Height = 196
      Align = alTop
      Caption = #1047#1072#1076#1072#1095#1080' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 1
      object lvDeptTasks: TListView
        Left = 7
        Top = 23
        Width = 448
        Height = 166
        Align = alClient
        Columns = <
          item
            Caption = #1047#1072#1076#1072#1095#1072
            Width = 300
          end
          item
            Caption = #1055#1077#1088#1080#1086#1076
          end
          item
            Caption = #1040#1074#1090#1086#1088
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        StateImages = frmMain.ilIcons16
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object gbDeptExtraInfo: TGroupBox
      Left = 1
      Top = 405
      Width = 462
      Height = 120
      Align = alClient
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 2
      object MemoDeptExtraInfo: TMemo
        Left = 7
        Top = 23
        Width = 448
        Height = 90
        Align = alClient
        TabOrder = 0
      end
    end
  end
end
