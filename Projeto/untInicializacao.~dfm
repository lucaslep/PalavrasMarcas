object frmProcessamento: TfrmProcessamento
  Left = 546
  Top = 251
  Width = 383
  Height = 401
  Caption = 'Processamento de Palavras'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 367
    Height = 362
    Align = alClient
    Color = clWhite
    TabOrder = 0
    object lblTexto: TLabel
      Left = 9
      Top = 5
      Width = 345
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 32
      Width = 350
      Height = 23
      TabOrder = 0
    end
    object btnInternacional: TButton
      Left = 8
      Top = 264
      Width = 353
      Height = 25
      Caption = 'Processamento Internacionais e Nacionais'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnInternacionalClick
    end
    object Button1: TButton
      Left = 8
      Top = 296
      Width = 353
      Height = 25
      Caption = 'Exportar JSON'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object Panel2: TPanel
      Left = 8
      Top = 56
      Width = 353
      Height = 169
      Color = clWhite
      TabOrder = 3
      object Label4: TLabel
        Left = 8
        Top = 126
        Width = 62
        Height = 15
        Caption = 'Processados:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 150
        Width = 28
        Height = 15
        Caption = 'Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 102
        Width = 108
        Height = 15
        Caption = 'PROC. PALAVRAS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblProcessadas: TLabel
        Left = 80
        Top = 126
        Width = 3
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object lblTotal: TLabel
        Left = 43
        Top = 150
        Width = 3
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 8
        Top = 8
        Width = 337
        Height = 89
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 8
          Width = 88
          Height = 15
          Caption = 'Tempo Decorrido:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 7
          Top = 36
          Width = 99
          Height = 15
          Caption = 'Marcas por Segundo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 7
          Top = 64
          Width = 85
          Height = 15
          Caption = 'Tempo Estimado:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object lblTempoDecorrido: TLabel
          Left = 103
          Top = 8
          Width = 42
          Height = 13
          Caption = '00:00:00'
        end
        object lblPalavrasPorSegundo: TLabel
          Left = 116
          Top = 36
          Width = 42
          Height = 13
          Caption = '00:00:00'
          DragCursor = crAppStart
        end
        object lblTempoEstimado: TLabel
          Left = 95
          Top = 64
          Width = 42
          Height = 13
          Caption = '00:00:00'
        end
      end
    end
    object Button2: TButton
      Left = 8
      Top = 328
      Width = 353
      Height = 25
      Caption = 'Prepara Tabelas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = Button2Click
    end
    object ProgressBar2: TProgressBar
      Left = 11
      Top = 230
      Width = 350
      Height = 23
      TabOrder = 5
    end
  end
  object cdsConversaoNacional: TIBClientDataSet
    CommandText = 'SELECT * FROM conversao_nacionais'
    Aggregates = <>
    Options = [poAllowCommandText]
    Params = <>
    DBConnection = DM.dbPalavra
    DBTransaction = DM.IBTPalavra
    Left = 272
    Top = 72
    object cdsConversaoNacionalCLASSE_NACIONAL: TStringField
      FieldName = 'CLASSE_NACIONAL'
      Origin = '"CONVERSAO_NACIONAIS"."CLASSE_NACIONAL"'
      Size = 100
    end
    object cdsConversaoNacionalSUB_CLASSE: TStringField
      FieldName = 'SUB_CLASSE'
      Origin = '"CONVERSAO_NACIONAIS"."SUB_CLASSE"'
      Size = 100
    end
    object cdsConversaoNacionalCLASSE_INTERNACIONAL: TStringField
      FieldName = 'CLASSE_INTERNACIONAL'
      Origin = '"CONVERSAO_NACIONAIS"."CLASSE_INTERNACIONAL"'
      Size = 100
    end
  end
end
