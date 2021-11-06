object frmTableEdit: TfrmTableEdit
  Left = 299
  Top = 126
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
  ClientHeight = 376
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 533
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 541
  end
  object sgTable: TStringGrid
    Left = 0
    Top = 0
    Width = 533
    Height = 161
    Align = alTop
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnSelectCell = sgTableSelectCell
    ExplicitWidth = 541
  end
  object Panel1: TPanel
    Left = 0
    Top = 164
    Width = 533
    Height = 212
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitWidth = 541
    ExplicitHeight = 217
    object vleItemEdit: TValueListEditor
      Left = 33
      Top = 1
      Width = 507
      Height = 215
      Align = alClient
      TabOrder = 0
      TitleCaptions.Strings = (
        #1050#1086#1083#1086#1085#1082#1072
        #1047#1085#1072#1095#1077#1085#1080#1077)
      ColWidths = (
        133
        368)
    end
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 32
      Height = 215
      Align = alLeft
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'toolbarTableEdit'
      Images = frmMain.ImageList24
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object tbNewItem: TToolButton
        Left = 0
        Top = 0
        Hint = #1053#1086#1074#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'tbNewItem'
        ImageIndex = 0
        Wrap = True
        OnClick = ToolButtonClick
      end
      object tbCopyItem: TToolButton
        Left = 0
        Top = 30
        Hint = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'tbCopyItem'
        ImageIndex = 12
        Wrap = True
        OnClick = ToolButtonClick
      end
      object tbSaveItem: TToolButton
        Left = 0
        Top = 60
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'tbSaveItem'
        ImageIndex = 4
        Wrap = True
        OnClick = ToolButtonClick
      end
      object tbDeleteItem: TToolButton
        Left = 0
        Top = 90
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'tbDeleteItem'
        ImageIndex = 26
        Wrap = True
        OnClick = ToolButtonClick
      end
    end
  end
end
