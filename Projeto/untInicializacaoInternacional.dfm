object frmProcessamentoInt: TfrmProcessamentoInt
  Left = 456
  Top = 304
  Width = 387
  Height = 143
  Caption = 'Processa Marcas Internacionais'
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
    Width = 371
    Height = 104
    Align = alClient
    Color = clWhite
    TabOrder = 0
    object lblTexto: TLabel
      Left = -7
      Top = 16
      Width = 387
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 8
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
      TabOrder = 0
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 32
      Width = 350
      Height = 23
      TabOrder = 1
    end
  end
end
