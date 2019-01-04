object frmSetup: TfrmSetup
  Left = 484
  Top = 293
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
    ActivePage = TabSheet1
    Align = alClient
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
        Height = 363
        Align = alClient
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 0
        Top = 404
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
  end
end
