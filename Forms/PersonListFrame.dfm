object FramePersonList: TFramePersonList
  Left = 0
  Top = 0
  Width = 497
  Height = 307
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object lvPersonnel: TListView
    Left = 0
    Top = 35
    Width = 497
    Height = 272
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
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lvPersonnelData
    OnSelectItem = lvPersonnelSelectItem
  end
  object panToolbar: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 35
    Align = alTop
    TabOrder = 1
    DesignSize = (
      497
      35)
    object edFilterText: TEdit
      Left = 288
      Top = 5
      Width = 169
      Height = 24
      Anchors = [akTop, akRight]
      Color = clGradientInactiveCaption
      TabOrder = 0
      OnChange = edFilterTextChange
    end
    object btnFilterClear: TBitBtn
      Left = 463
      Top = 4
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'X'
      TabOrder = 1
    end
  end
  object tmr100ms: TTimer
    OnTimer = tmr100msTimer
    Left = 376
    Top = 96
  end
end
