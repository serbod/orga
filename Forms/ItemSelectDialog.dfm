object FormItemSelect: TFormItemSelect
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1086#1088' '#1101#1083#1077#1084#1077#1085#1090#1072
  ClientHeight = 355
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object panBottom: TPanel
    Left = 0
    Top = 325
    Width = 635
    Height = 30
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      635
      30)
    object btnCancel: TBitBtn
      Left = 528
      Top = 2
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ImageIndex = 18
      Images = frmMain.ilIcons16
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOK: TBitBtn
      Left = 423
      Top = 2
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ImageIndex = 17
      Images = frmMain.ilIcons16
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
end
