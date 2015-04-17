object FrameUserOptions: TFrameUserOptions
  Left = 0
  Top = 0
  Width = 576
  Height = 375
  TabOrder = 0
  object toolbarUserOptions: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 375
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'toolbarUserOptions'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object tbApply: TToolButton
      Left = 0
      Top = 0
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Caption = 'tbApply'
      ImageIndex = 6
      Wrap = True
      OnClick = tbApplyClick
    end
    object tbHelp: TToolButton
      Left = 0
      Top = 30
      Caption = 'tbHelp'
      ImageIndex = 1
      Wrap = True
    end
  end
  object panCenter: TPanel
    Left = 33
    Top = 0
    Width = 543
    Height = 375
    Align = alClient
    TabOrder = 1
    object gbDbOptions: TGroupBox
      Left = 8
      Top = 8
      Width = 161
      Height = 105
      Caption = #1051#1086#1082#1072#1083#1100#1085#1072#1103' '#1073#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 91
        Height = 13
        Caption = #1048#1084#1103' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      end
      object Label2: TLabel
        Left = 8
        Top = 56
        Width = 88
        Height = 13
        Caption = #1058#1080#1087' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      end
      object edDbName: TEdit
        Left = 8
        Top = 32
        Width = 145
        Height = 21
        TabOrder = 0
      end
      object comboxDbType: TComboBox
        Left = 8
        Top = 72
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object GroupBox1: TGroupBox
      Left = 176
      Top = 8
      Width = 353
      Height = 105
      Caption = #1044#1072#1085#1085#1099#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      TabOrder = 1
      object Label3: TLabel
        Left = 8
        Top = 24
        Width = 88
        Height = 13
        Caption = #1048#1084#1103' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072
      end
      object Label4: TLabel
        Left = 8
        Top = 48
        Width = 96
        Height = 13
        Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      end
      object Label5: TLabel
        Left = 8
        Top = 72
        Width = 49
        Height = 13
        Caption = 'IP '#1072#1076#1088#1077#1089#1072
      end
      object lbHostName: TLabel
        Left = 120
        Top = 24
        Width = 68
        Height = 13
        Caption = 'lbHostName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbUserName: TLabel
        Left = 120
        Top = 48
        Width = 68
        Height = 13
        Caption = 'lbUserName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbIpList: TLabel
        Left = 120
        Top = 72
        Width = 42
        Height = 13
        Caption = 'lbIpList'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
