object fAguardeProgresso: TfAguardeProgresso
  Left = 534
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Aguarde Progresso'
  ClientHeight = 133
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 133
    Align = alClient
    Color = clWhite
    TabOrder = 0
    object lblTexto: TLabel
      Left = 7
      Top = 16
      Width = 387
      Height = 22
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblTexto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 1
      Top = 91
      Width = 401
      Height = 41
      Align = alBottom
      Color = clSilver
      TabOrder = 0
    end
    object cxProgressBar1: TcxProgressBar
      Left = 5
      Top = 50
      Width = 391
      Height = 21
      ParentColor = False
      Properties.BeginColor = clLime
      Properties.BarBevelOuter = cxbvLowered
      Properties.EndColor = clGreen
      Properties.ShowText = False
      Properties.BarStyle = cxbsGradient
      Properties.PeakValue = 50.000000000000000000
      Style.BorderColor = cl3DLight
      Style.BorderStyle = ebsFlat
      TabOrder = 1
    end
  end
end
