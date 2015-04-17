object FrameMsgBoard: TFrameMsgBoard
  Left = 0
  Top = 0
  Width = 760
  Height = 450
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
      Top = 2
      Hint = 'Refresh'
      Caption = 'tbRefresh'
      ImageIndex = 29
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbLoad: TToolButton
      Left = 0
      Top = 32
      Hint = 'Load'
      Caption = 'tbLoad'
      ImageIndex = 28
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbSave: TToolButton
      Left = 0
      Top = 62
      Hint = 'Save'
      Caption = 'tbSave'
      ImageIndex = 27
      OnClick = tbMsgBoardClick
    end
    object ToolButton1: TToolButton
      Left = 0
      Top = 62
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 28
      Wrap = True
      Style = tbsSeparator
    end
    object tbAdd: TToolButton
      Left = 0
      Top = 97
      Caption = 'tbAdd'
      ImageIndex = 0
      Wrap = True
      OnClick = tbMsgBoardClick
    end
    object tbDel: TToolButton
      Left = 0
      Top = 127
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
          Width = 35
          Height = 13
          Caption = #1040#1074#1090#1086#1088':'
        end
        object lbAuthorText: TLabel
          Left = 56
          Top = 8
          Width = 63
          Height = 13
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
        inherited pcEditorControls: TPageControl
          Width = 537
          inherited tsFile: TTabSheet
            inherited toolbarFile: TToolBar
              Width = 529
            end
          end
          inherited tsEdit: TTabSheet
            inherited toolbarEdit: TToolBar
              Width = 434
            end
          end
          inherited tsInsert: TTabSheet
            inherited toolbarInsert: TToolBar
              Width = 434
            end
          end
          inherited tsFormat: TTabSheet
            inherited toolbarFormat: TToolBar
              Width = 434
            end
          end
          inherited tsRecent: TTabSheet
            inherited toolbarRecent: TToolBar
              Width = 434
            end
          end
        end
        inherited reText: TRichEdit
          Width = 537
          Height = 345
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
      Items.Data = {
        03000000310000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        183720ECE0F0F2E020EFEEEAF3EFE0E5EC20EFEEE4E0F0EAE82C000000000000
        0000000000FFFFFFFFFFFFFFFF000000000000000013313120E0EFF0E5EBFF20
        F1F3E1E1EEF2EDE8EA450000000000000000000000FFFFFFFFFFFFFFFF000000
        00000000002CCAF2EE20EEF1F2E0E2E8EB20E220F5EEEBEEE4E8EBFCEDE8EAE5
        20E1E0EDEAF320F120EEE3F3F0F6E0ECE83F}
    end
  end
end
