object frmSetup: TfrmSetup
  Left = 770
  Top = 111
  Width = 695
  Height = 515
  Caption = #35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 679
    Height = 476
    ActivePage = TabSheet2
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #40664#35748#36716#25442#35774#23450
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 671
        Height = 41
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Note:'#25968#25454#24211#23383#27573#31867#22411#21521'JAVA'#36716#25442#20363#31243#20026'  Varchar=String'
        TabOrder = 0
      end
      object mmoTypeConvert: TMemo
        Left = 0
        Top = 41
        Width = 671
        Height = 367
        Align = alClient
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 0
        Top = 408
        Width = 671
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object btnSave: TButton
          Left = 560
          Top = 8
          Width = 75
          Height = 25
          Caption = 'save'
          TabOrder = 0
          OnClick = btnSaveClick
        end
        object btninit: TButton
          Left = 16
          Top = 8
          Width = 75
          Height = 25
          Caption = #21021#22987#21270
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btninitClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#24211#35774#23450
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 318
        Height = 12
        Caption = #20363#31243':127.0.0.1:1433 mydbatabasename username password'
      end
      object Label2: TLabel
        Left = 24
        Top = 40
        Width = 36
        Height = 12
        Caption = #21517'  '#31216
      end
      object Label3: TLabel
        Left = 24
        Top = 72
        Width = 36
        Height = 12
        Caption = #36830#25509#20018
      end
      object Panel4: TPanel
        Left = 0
        Top = 408
        Width = 671
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object btnsaveConfig: TButton
          Left = 288
          Top = 8
          Width = 75
          Height = 25
          Caption = #20445#23384
          TabOrder = 0
        end
      end
      object edtConnectionString: TEdit
        Left = 73
        Top = 67
        Width = 472
        Height = 20
        TabOrder = 1
      end
      object lbConfigs: TListBox
        Left = 73
        Top = 107
        Width = 472
        Height = 289
        ItemHeight = 12
        TabOrder = 2
        OnDblClick = lbConfigsDblClick
      end
      object btnAdd: TButton
        Left = 561
        Top = 64
        Width = 75
        Height = 25
        Caption = 'add'
        TabOrder = 3
        OnClick = btnAddClick
      end
      object edtConfigName: TEdit
        Left = 73
        Top = 35
        Width = 72
        Height = 20
        TabOrder = 4
      end
    end
  end
end
