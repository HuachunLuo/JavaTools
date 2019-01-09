object frmSetup: TfrmSetup
  Left = 632
  Top = 206
  Width = 729
  Height = 615
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
    Width = 713
    Height = 535
    ActivePage = TabSheet1
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
        Width = 705
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
        Width = 705
        Height = 426
        Align = alClient
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 0
        Top = 467
        Width = 705
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
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
          TabOrder = 0
          OnClick = btninitClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 24
        Height = 12
        Caption = #21253#21517
      end
      object edtPackageName: TEdit
        Left = 53
        Top = 4
        Width = 121
        Height = 20
        TabOrder = 0
        Text = 'cn.robert'
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 535
    Width = 713
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Button1: TButton
      Left = 296
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
