object frmMarcaSemAcento: TfrmMarcaSemAcento
  Left = 434
  Top = 330
  Width = 391
  Height = 141
  Caption = 'Marca Sem Acento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 375
    Height = 102
    Align = alClient
    TabOrder = 0
    object lblTexto: TLabel
      Left = 16
      Top = 11
      Width = 3
      Height = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 13
      Top = 32
      Width = 350
      Height = 23
      TabOrder = 0
    end
    object Button1: TButton
      Left = 7
      Top = 72
      Width = 356
      Height = 25
      Caption = 'Processar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
