object frmMain: TfrmMain
  Left = 541
  Top = 306
  Width = 663
  Height = 524
  Caption = 'JavaTools'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 0
    Top = 41
    Width = 647
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 647
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Button1: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'connect'
      TabOrder = 0
      OnClick = Button1Click
    end
    object cbbServers: TComboBox
      Left = 10
      Top = 10
      Width = 145
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 466
    Width = 647
    Height = 19
    Panels = <
      item
        Text = #29366#24577
        Width = 35
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 44
    Width = 647
    Height = 422
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 187
      Top = 2
      Height = 418
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 185
      Height = 418
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object lbTables: TListBox
        Left = 2
        Top = 2
        Width = 181
        Height = 414
        Align = alClient
        ItemHeight = 12
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
    end
    object Panel4: TPanel
      Left = 190
      Top = 2
      Width = 455
      Height = 418
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object mmoContext: TMemo
        Left = 2
        Top = 34
        Width = 451
        Height = 382
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        WantReturns = False
      end
      object Panel5: TPanel
        Left = 2
        Top = 2
        Width = 451
        Height = 32
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object cbUpperCase: TCheckBox
          Left = 8
          Top = 8
          Width = 81
          Height = 17
          Caption = #20840#37096#22823#20889
          TabOrder = 0
          OnClick = cbUpperCaseClick
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 34
    Top = 70
    object N2: TMenuItem
      Caption = #35774#32622
      OnClick = N2Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object getEntity: TMenuItem
      Caption = #21462#24471#23454#20307
      OnClick = getEntityClick
    end
    object miMapperSelect: TMenuItem
      Caption = '-'
    end
    object miSelect: TMenuItem
      Caption = '@Select'
      OnClick = miSelectClick
    end
    object miInsert: TMenuItem
      Caption = '@Insert'
      OnClick = miInsertClick
    end
    object miUpdate: TMenuItem
      Caption = '@Update'
      OnClick = miUpdateClick
    end
    object miDelete: TMenuItem
      Caption = '@Delete'
      OnClick = miDeleteClick
    end
  end
end
