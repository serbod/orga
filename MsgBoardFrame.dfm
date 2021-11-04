object FrameMsgBoard: TFrameMsgBoard
  Left = 0
  Top = 0
  Width = 760
  Height = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter4: TSplitter
    Left = 218
    Top = 0
    Height = 450
  end
  object toolbarMsgBoard: TToolBar
    Left = 0
    Top = 0
    Width = 33
    Height = 450
    Align = alLeft
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'toolbarMsgBoard'
    TabOrder = 0
    object tbRefresh: TToolButton
      Left = 0
      Top = 0
      Hint = 'Refresh'
      Caption = 'tbRefresh'
      ImageIndex = 29
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbLoad: TToolButton
      Left = 0
      Top = 30
      Hint = 'Load'
      Caption = 'tbLoad'
      ImageIndex = 28
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbSave: TToolButton
      Left = 0
      Top = 60
      Hint = 'Save'
      Caption = 'tbSave'
      ImageIndex = 27
      OnClick = tbMsgBoardClick
    end
    object ToolButton1: TToolButton
      Left = 0
      Top = 60
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 28
      Wrap = True
      Style = tbsSeparator
    end
    object tbAdd: TToolButton
      Left = 0
      Top = 98
      Caption = 'tbAdd'
      ImageIndex = 0
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbDel: TToolButton
      Left = 0
      Top = 128
      Caption = 'tbDel'
      ImageIndex = 26
      Wrap = True
      OnClick = tbMsgBoardClick
    end
  end
  object panRight: TPanel
    Left = 221
    Top = 0
    Width = 539
    Height = 450
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object panTop: TPanel
      Left = 0
      Top = 0
      Width = 539
      Height = 450
      Align = alClient
      TabOrder = 0
      object panItemInfo: TPanel
        Left = 1
        Top = 1
        Width = 537
        Height = 41
        Align = alTop
        TabOrder = 0
        object lbAuthorName: TLabel
          Left = 8
          Top = 8
          Width = 40
          Height = 16
          Caption = #1040#1074#1090#1086#1088':'
        end
        object lbAuthorText: TLabel
          Left = 56
          Top = 8
          Width = 73
          Height = 16
          Caption = 'lbAuthorText'
        end
      end
      inline TextEditor: TFrameTextEditor
        Left = 1
        Top = 42
        Width = 537
        Height = 407
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 42
        ExplicitWidth = 537
        ExplicitHeight = 407
        inherited pcEditorControls: TPageControl
          Width = 537
          ExplicitWidth = 537
          inherited tsFile: TTabSheet
            ExplicitTop = 27
            ExplicitWidth = 529
            ExplicitHeight = 31
            inherited toolbarFile: TToolBar
              Width = 529
              Height = 31
              ExplicitWidth = 529
              inherited tbOpenFile: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbSaveAs: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbSepFile1: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbPrint: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbPrintPreview: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbSepFile2: TToolButton
                Top = 0
                ExplicitTop = 0
              end
              inherited tbSendTo: TToolButton
                Top = 0
                ExplicitTop = 0
              end
            end
          end
          inherited tsEdit: TTabSheet
            inherited toolbarEdit: TToolBar
              Width = 434
              ExplicitWidth = 434
            end
          end
          inherited tsInsert: TTabSheet
            inherited toolbarInsert: TToolBar
              Width = 434
              ExplicitWidth = 434
            end
          end
          inherited tsFormat: TTabSheet
            inherited toolbarFormat: TToolBar
              Width = 434
              ExplicitWidth = 434
            end
          end
          inherited tsRecent: TTabSheet
            inherited toolbarRecent: TToolBar
              Width = 434
              ExplicitWidth = 434
            end
          end
        end
        inherited reText: TRichEdit
          Width = 537
          Height = 345
          ExplicitWidth = 537
          ExplicitHeight = 345
        end
      end
    end
  end
  object panLeft: TPanel
    Left = 33
    Top = 0
    Width = 185
    Height = 450
    Align = alLeft
    TabOrder = 2
    object tvMsgBoardList: TTreeView
      Left = 1
      Top = 1
      Width = 183
      Height = 448
      Align = alClient
      Indent = 19
      TabOrder = 0
      OnChange = tvMsgBoardListChange
      Items.NodeData = {
        03030000004E0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        00000000000118370020003C04300440044204300420003F043E043A0443043F
        04300435043C0420003F043E043404300440043A043804440000000000000000
        000000FFFFFFFFFFFFFFFF000000000000000000000000011331003100200030
        043F04400435043B044F04200041044304310431043E0442043D0438043A0476
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
        2C1A0442043E0420003E04410442043004320438043B0420003204200045043E
        043B043E04340438043B044C043D0438043A0435042000310430043D043A0443
        042000410420003E04330443044004460430043C0438043F00}
    end
  end
end
