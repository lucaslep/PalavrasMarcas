object DM: TDM
  OldCreateOrder = False
  Left = 640
  Top = 275
  Height = 173
  Width = 256
  object dbCarga: TIBDatabase
    Connected = True
    DatabaseName = 'localhost:C:\CARGAREVISTA\MARCAS.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=NONE')
    LoginPrompt = False
    DefaultTransaction = IBTCarga
    Left = 16
    Top = 16
  end
  object IBTCarga: TIBTransaction
    Active = True
    DefaultDatabase = dbCarga
    Left = 16
    Top = 64
  end
  object dbPalavra: TIBDatabase
    Connected = True
    DatabaseName = 'localhost:C:\Palavras Marcas\Banco de Dados\BDPALAVRA.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTCarga
    Left = 88
    Top = 16
  end
  object IBTPalavra: TIBTransaction
    DefaultDatabase = dbPalavra
    Left = 88
    Top = 64
  end
  object dbIntelectual: TIBDatabase
    DatabaseName = 
      'localhost:C:\IntelectualSys\394\Banco de Dados\INTELECTUALSYS.FD' +
      'B'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252'
      '')
    LoginPrompt = False
    DefaultTransaction = IBTIntelectual
    Left = 168
    Top = 16
  end
  object IBTIntelectual: TIBTransaction
    DefaultDatabase = dbPalavra
    Left = 160
    Top = 64
  end
  object IBClientDataSet1: TIBClientDataSet
    CommandText = 'SELECT * FROM LIMPEZA_RPI_MARCAS'
    Aggregates = <>
    Options = [poAllowCommandText]
    Params = <>
    Left = 872
    Top = 560
    object qryLimpezaRpiMarcasPALAVRA_EXCLUIR: TStringField
      FieldName = 'PALAVRA_EXCLUIR'
      Required = True
      Size = 25
    end
    object qryLimpezaRpiMarcasCLASSES_ANT: TStringField
      FieldName = 'CLASSES_ANT'
      Size = 200
    end
    object qryLimpezaRpiMarcasCLASSES_INT: TStringField
      FieldName = 'CLASSES_INT'
      Size = 200
    end
    object qryLimpezaRpiMarcasTODAS_CLASSES: TStringField
      FieldName = 'TODAS_CLASSES'
      FixedChar = True
      Size = 1
    end
    object qryLimpezaRpiMarcasRS_JORNA: TStringField
      FieldName = 'RS_JORNA'
      FixedChar = True
      Size = 1
    end
    object qryLimpezaRpiMarcasMARCA: TStringField
      FieldName = 'MARCA'
      FixedChar = True
      Size = 1
    end
  end
  object IBClientDataSet2: TIBClientDataSet
    CommandText = 'SELECT * FROM LIMPEZA_RPI_MARCAS'
    Aggregates = <>
    Options = [poAllowCommandText]
    Params = <>
    Left = 872
    Top = 560
    object StringField1: TStringField
      FieldName = 'PALAVRA_EXCLUIR'
      Required = True
      Size = 25
    end
    object StringField2: TStringField
      FieldName = 'CLASSES_ANT'
      Size = 200
    end
    object StringField3: TStringField
      FieldName = 'CLASSES_INT'
      Size = 200
    end
    object StringField4: TStringField
      FieldName = 'TODAS_CLASSES'
      FixedChar = True
      Size = 1
    end
    object StringField5: TStringField
      FieldName = 'RS_JORNA'
      FixedChar = True
      Size = 1
    end
    object StringField6: TStringField
      FieldName = 'MARCA'
      FixedChar = True
      Size = 1
    end
  end
end
