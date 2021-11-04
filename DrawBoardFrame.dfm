object FrameDrawBoard: TFrameDrawBoard
  Left = 0
  Top = 0
  Width = 731
  Height = 483
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object toolbarDBoardTools: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 483
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'toolbarDBoardMain'
    Images = frmMain.ImageList24
    TabOrder = 0
    object btn3: TToolButton
      Left = 0
      Top = 0
      Caption = 'btnImgLibrary'
      ImageIndex = 47
      Wrap = True
    end
    object btn1: TToolButton
      Left = 0
      Top = 30
      Caption = 'btnOpenImage'
      ImageIndex = 28
      Wrap = True
    end
    object btn2: TToolButton
      Left = 0
      Top = 60
      Caption = 'btnSaveImage'
      ImageIndex = 27
    end
    object btn4: TToolButton
      Left = 0
      Top = 60
      Width = 8
      Caption = 'btn4'
      ImageIndex = 3
      Wrap = True
      Style = tbsSeparator
    end
    object btn5: TToolButton
      Left = 0
      Top = 98
      Caption = 'btn5'
      ImageIndex = 40
      Wrap = True
    end
    object btn6: TToolButton
      Left = 0
      Top = 128
      Caption = 'btn6'
      ImageIndex = 41
    end
  end
  object panLeft: TPanel
    Left = 33
    Top = 0
    Width = 128
    Height = 483
    Align = alLeft
    TabOrder = 1
    object btnSelect: TBitBtn
      Left = 8
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Select'
      TabOrder = 0
    end
    object btnMove: TBitBtn
      Left = 64
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Move'
      TabOrder = 1
    end
    object btnPen: TBitBtn
      Left = 8
      Top = 48
      Width = 49
      Height = 25
      Caption = 'Pen'
      TabOrder = 2
    end
    object btnBrush: TBitBtn
      Left = 8
      Top = 80
      Width = 49
      Height = 25
      Caption = 'Brush'
      TabOrder = 3
    end
    object btnLine: TBitBtn
      Left = 64
      Top = 48
      Width = 49
      Height = 25
      Caption = 'Line'
      TabOrder = 4
    end
    object btnFill: TBitBtn
      Left = 64
      Top = 80
      Width = 49
      Height = 25
      Caption = 'Fill'
      TabOrder = 5
    end
    object clrbx1: TColorBox
      Left = 8
      Top = 304
      Width = 121
      Height = 22
      Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
      TabOrder = 6
    end
    object btnRect: TBitBtn
      Left = 8
      Top = 112
      Width = 49
      Height = 25
      Caption = 'Rect'
      TabOrder = 7
    end
    object btnPoly: TBitBtn
      Left = 64
      Top = 112
      Width = 49
      Height = 25
      Caption = 'Poly'
      TabOrder = 8
    end
    object btnOval: TBitBtn
      Left = 8
      Top = 144
      Width = 49
      Height = 25
      Caption = 'Oval'
      TabOrder = 9
    end
    object btnText: TBitBtn
      Left = 64
      Top = 144
      Width = 49
      Height = 25
      Caption = 'Text'
      TabOrder = 10
    end
    object btnErase: TBitBtn
      Left = 8
      Top = 176
      Width = 49
      Height = 25
      Caption = 'Erase'
      TabOrder = 11
    end
    object btnPick: TBitBtn
      Left = 64
      Top = 176
      Width = 49
      Height = 25
      Caption = 'Pick'
      TabOrder = 12
    end
    object clrgrd1: TColorGrid
      Left = 8
      Top = 336
      Width = 112
      Height = 136
      TabOrder = 13
    end
  end
  object panImage: TPanel
    Left = 161
    Top = 0
    Width = 570
    Height = 483
    Align = alClient
    TabOrder = 2
    object panTop: TPanel
      Left = 1
      Top = 1
      Width = 568
      Height = 24
      Align = alTop
      TabOrder = 0
      object lbCursorPos: TLabel
        Left = 432
        Top = 8
        Width = 129
        Height = 13
        AutoSize = False
        Caption = 'Position:'
        ShowAccelChar = False
      end
    end
    object scrollBox: TScrollBox
      Left = 1
      Top = 25
      Width = 568
      Height = 457
      Align = alClient
      AutoSize = True
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ParentBackground = True
      TabOrder = 1
      object pbImage: TPaintBox
        Left = 0
        Top = 0
        Width = 568
        Height = 457
        Cursor = crCross
        Color = clWhite
        ParentColor = False
        OnMouseMove = img1MouseMove
      end
    end
  end
end
