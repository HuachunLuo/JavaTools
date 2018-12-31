object frmMain: TfrmMain
  Left = 464
  Top = 326
  Width = 664
  Height = 415
  Caption = #20027#31383#20307
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object Splitter1: TSplitter
    Left = 0
    Top = 41
    Width = 648
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 11
      Width = 18
      Height = 19
      Caption = 'DB'
    end
    object edtServer: TEdit
      Left = 59
      Top = 8
      Width = 86
      Height = 27
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object Button1: TButton
      Left = 448
      Top = 8
      Width = 75
      Height = 25
      Caption = 'connect'
      TabOrder = 1
      OnClick = Button1Click
    end
    object edtPort: TEdit
      Left = 152
      Top = 8
      Width = 41
      Height = 27
      TabOrder = 2
      Text = '1433'
    end
    object edtDBName: TEdit
      Left = 208
      Top = 8
      Width = 73
      Height = 27
      TabOrder = 3
      Text = 'Mytest'
    end
    object edtUserName: TEdit
      Left = 288
      Top = 8
      Width = 81
      Height = 27
      TabOrder = 4
      Text = 'sa'
    end
    object edtPassWord: TEdit
      Left = 376
      Top = 8
      Width = 65
      Height = 27
      TabOrder = 5
      Text = '1nihao'
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 357
    Width = 648
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
    Width = 648
    Height = 313
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 187
      Top = 2
      Height = 309
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 185
      Height = 309
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object lbTables: TListBox
        Left = 2
        Top = 2
        Width = 181
        Height = 305
        Align = alClient
        ItemHeight = 19
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
    end
    object Panel4: TPanel
      Left = 190
      Top = 2
      Width = 456
      Height = 309
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object mmoContext: TMemo
        Left = 2
        Top = 2
        Width = 452
        Height = 305
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 34
    Top = 70
    object mirefres: TMenuItem
      Caption = #21047#26032
      OnClick = mirefresClick
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
