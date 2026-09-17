unit untInicializacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxProgressBar,
  DB, IBDatabase, IBCustomDataSet, IBQuery, Grids, DBClient, DBGrids, ComCtrls,
  IBSQL, superObject, DBLocal, DBLocalI, DateUtils;

type
  TInserePalavra = record
    id_palavra: Integer;
    palavra_formatada: string;
    classe: integer;
    QtdPedido: string;
    QtdRegistro: string;
    QtdArquivado: string;
  end;

type
  TAtualizaPalavra = record
    id_palavra: Integer;
    palavra_formatada: string;
    classe: string;
    qtd_pedido: string;
    qtd_registro: string;
    qtd_arquivado: string;
  end;

type
  TPalavra = record
    IdPalavra: integer;
    Classe: String;
    Palavra: string;
    QtdArquivado: Integer;
    QtdPedido: Integer;
    QtdRegistro: Integer;
  end;

type
  TArrPalavra = array of TPalavra;

type
  IPalavrasRepository = interface
    procedure InserePalavra(Palavra: TInserePalavra);
    procedure DeletaAll();
    function ExistePalavra(const Palavra, Classe: string): Boolean;
    function ObtemPalavraPelaPalavraEClasse(const Palavra: string; Classe: Integer): TPalavra;
    function ObtemMaxID(): Integer;
    procedure IncrementaQtdeOcorrencia(IdPalavra: Integer; StatusPalavra: string);
    function ObtemUltimoIDPalavra(): integer;
    function VerificaUltimoPedacoNacionais(): integer;
    function VerificaUltimoPedacoInternacionais(): integer;
    procedure UpdateRestoreInternacionais(valorIni: Integer; tempo: TDateTime);
    procedure UpdateRestoreNacionais(valorIni:Integer; tempo: TDateTime);
    procedure UpdateRestoreFinalizadoNacionais();
    procedure UpdateRestoreFinalizadoInternacionais();
    procedure DeletaValoresRestore();
    procedure DeletaValoresPalavras();
    procedure UpdateValoresRestore();
  end;

type
  TPalavrasRepository = class(TInterfacedObject, IPalavrasRepository)
  private
    ibSQL: TIBSQL;
    Query: TIBQuery;
    FCachePalavras: TStringList;
    FCachePalavrasCarregado: Boolean;
    FQtdArquivadoPendente: TStringList;
    FQtdPedidoPendente: TStringList;
    FQtdRegistroPendente: TStringList;
    function MontaChaveCachePalavra(const Palavra: string; Classe: Integer): string;
    procedure CarregaCachePalavras;
    procedure AdicionaCachePalavra(const Palavra: string; Classe, IdPalavra: Integer);
    procedure IncrementaContadorPendente(Lista: TStringList; IdPalavra: Integer);
    procedure GravaContadoresPendentes;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserePalavra(Palavra: TInserePalavra);
    procedure DeletaAll();
    function ExistePalavra(const Palavra, Classe: string): Boolean;
    function ObtemPalavraPelaPalavraEClasse(const Palavra: string; Classe: Integer): TPalavra;
    function ObtemMaxID(): Integer;
    procedure IncrementaQtdeOcorrencia(IdPalavra: Integer; StatusPalavra: string);
    function ObtemUltimoIDPalavra(): integer;
    function VerificaUltimoPedacoNacionais(): integer;
    function VerificaUltimoPedacoInternacionais(): integer;
    procedure UpdateRestoreInternacionais(valorIni: Integer; tempo: TDateTime);
    procedure UpdateRestoreNacionais(valorIni:Integer; tempo: TDateTime);
    procedure UpdateRestoreFinalizadoNacionais();
    procedure UpdateRestoreFinalizadoInternacionais();
    procedure DeletaValoresRestore();
    procedure DeletaValoresPalavras();
    procedure UpdateValoresRestore();
  end;

type
  TProcesso = record
    CodMarca: Integer;
    MarcaSemAcento: string;
    Marca: string;
    ClasseInternacional: string;
    ClasseNacional: string;
    SubClasses: array of Integer;
    Status: string;
  end;

type
  TArrProcessos = array of TProcesso;

type
  TArrayInteger = array of Integer;

type
  IProcessosRepository = interface
    function CountPalavrasNacionais: Integer;
    function CountPalavrasInternacionais: Integer;
    function ObtemPalavrasInternacionais(QtdePedaco, ValorIni: Integer): TArrProcessos;
    function ObtemPalavrasNacionaisPorPedaco(QtdePedaco, ValorIni: Integer): TArrProcessos;
    procedure TrimClasseInternacionais();
    procedure TrimClasseNacionais();
    function ObtemMaxIDMarcas(): Integer;
  end;

type
  TProcessosRepository = class(TInterfacedObject, IProcessosRepository)
  private
    Query: TIBQuery;
    ibSQL: TIBSQL;
  public
    constructor Create;
    destructor Destroy; override;
    function CountPalavrasNacionais: Integer;
    function CountPalavrasInternacionais: Integer;
    function ObtemPalavrasInternacionais(QtdePedaco, ValorIni: Integer): TArrProcessos;
    function ObtemPalavrasNacionaisPorPedaco(QtdePedaco, ValorIni: Integer): TArrProcessos;
    procedure TrimClasseInternacionais();
    procedure TrimClasseNacionais();
    function ObtemMaxIDMarcas(): Integer;
  end;

type
  TfrmProcessamento = class(TForm)
    Panel1: TPanel;
    lblTexto: TLabel;
    ProgressBar1: TProgressBar;
    btnInternacional: TButton;
    Button1: TButton;
    cdsConversaoNacional: TIBClientDataSet;
    cdsConversaoNacionalCLASSE_NACIONAL: TStringField;
    cdsConversaoNacionalSUB_CLASSE: TStringField;
    cdsConversaoNacionalCLASSE_INTERNACIONAL: TStringField;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblTempoDecorrido: TLabel;
    lblPalavrasPorSegundo: TLabel;
    lblTempoEstimado: TLabel;
    lblProcessadas: TLabel;
    lblTotal: TLabel;
    Button2: TButton;
    ProgressBar2: TProgressBar;
    procedure btnInternacionalClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FTotalProcessamento: Integer;
    FBaseProcessamento: Integer;
    procedure InsereMarcasNacionaisTratadas(PalavraRepository: IPalavrasRepository; ProcessoRepository: IProcessosRepository; TempoInicio: TDateTime);
    procedure InsereMarcasInternacionaisTratadas(PalavraRepository: IPalavrasRepository; ProcessoRepository: IProcessosRepository; TempoInicio: TDateTime);
    procedure GaranteCampoMarcaSemAcento(Query: TIBQuery);
    procedure AtualizaMarcasSemAcento(TempoInicio: TDateTime);
    procedure AtualizaIndicadoresProcessamento(TempoInicio: TDateTime; QtdProcessada, QtdTotal: Integer);
    procedure PulsaProgressBarAtividade;
    function TotalMarcasSemAcento: Integer;
    function ExisteMarcaSemAcentoPreenchida(Query: TIBQuery): Boolean;
    function ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais: Integer): string;
    procedure PosicaoProgressBar(Posicao: Integer);
    procedure RegistraFalhaProcessamento(const TipoProcessamento: string; const Processo: TProcesso; const Palavra: string; Classe: Integer; const Motivo: string);
    function StatusPalavraValido(const StatusPalavra: string): Boolean;
    function ClasseNacionalToClasseInternacional(ClasseNacional, SubClasse: Integer): Integer;
    function ConverteVariasClassesNacionais(ClasseNacional: Integer; SubClasses: array of Integer): TArrayInteger;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcessamento: TfrmProcessamento;

const
  TIPO_NACIONAL = 'NACIONAL';
  TIPO_INTERNACIONAL = 'INTERNACIONAL';
  ARQUIVADO = 'X';
  PEDIDO = 'P';
  REGISTRO = 'R';
  QTDE_PEDACO_PROCESSAMENTO = 5000;
  INTERVALO_ATUALIZACAO_TELA = 1;
  QTDE_PEDACO_MARCA_SEM_ACENTO = 1000;

implementation

uses
  dmDPA, untFuncs;

{$R *.dfm}

procedure TfrmProcessamento.GaranteCampoMarcaSemAcento(Query: TIBQuery);
var
  CampoExiste: Boolean;
begin
  Query.Close;
  Query.SQL.Text :=
    'SELECT RDB$FIELD_NAME ' +
    'FROM RDB$RELATION_FIELDS ' +
    'WHERE RDB$RELATION_NAME = ''MARCAS'' ' +
    'AND RDB$FIELD_NAME = ''MARCA_SEM_ACENTO''';
  Query.Open;
  CampoExiste := not Query.Eof;
  Query.Close;

  if CampoExiste then
    Exit;

  Query.SQL.Text := 'ALTER TABLE marcas ADD marca_sem_acento VARCHAR(252)';
  Query.ExecSQL;
  Query.Transaction.CommitRetaining;
end;

procedure TfrmProcessamento.PulsaProgressBarAtividade;
begin
  if ProgressBar1.Max <> 100 then
  begin
    ProgressBar1.Max := 100;
    ProgressBar1.Position := 0;
  end;

  if ProgressBar1.Position >= ProgressBar1.Max then
    ProgressBar1.Position := 0
  else
    ProgressBar1.Position := ProgressBar1.Position + 1;

  Application.ProcessMessages;
end;

procedure TfrmProcessamento.AtualizaIndicadoresProcessamento(TempoInicio: TDateTime; QtdProcessada, QtdTotal: Integer);
var
  TempoDecorrido: TDateTime;
  TempoEstimado: TDateTime;
  TempoDecorridoSegundos, TempoEstimadoSegundos: Double;
  Velocidade: Double;
  QtdProcessadaGeral, QtdTotalGeral: Integer;
begin
  QtdProcessadaGeral := FBaseProcessamento + QtdProcessada;
  QtdTotalGeral := FTotalProcessamento;
  if QtdTotalGeral <= 0 then
    QtdTotalGeral := QtdTotal;

  if QtdProcessadaGeral < 0 then
    QtdProcessadaGeral := 0;
  if (QtdTotalGeral > 0) and (QtdProcessadaGeral > QtdTotalGeral) then
    QtdProcessadaGeral := QtdTotalGeral;

  TempoDecorrido := Now - TempoInicio;
  TempoDecorridoSegundos := SecondsBetween(TempoInicio, Now);

  if TempoDecorridoSegundos > 0 then
    Velocidade := QtdProcessada / TempoDecorridoSegundos
  else
    Velocidade := 0;

  if Velocidade > 0 then
    TempoEstimadoSegundos := (QtdTotal - QtdProcessada) / Velocidade
  else
    TempoEstimadoSegundos := 0;

  TempoEstimado := TempoEstimadoSegundos / SecsPerDay;

  if QtdTotalGeral > 0 then
  begin
    ProgressBar2.Max := QtdTotalGeral;
    ProgressBar2.Position := QtdProcessadaGeral;
  end;

  lblTempoEstimado.Caption := FormatDateTime('hh:nn:ss', TempoEstimado);
  lblPalavrasPorSegundo.Caption := FormatFloat('###,###,##0.00', Velocidade) + ' marcas/s';
  lblTempoDecorrido.Caption := FormatDateTime('hh:nn:ss', TempoDecorrido);
  lblProcessadas.Caption := IntToStr(QtdProcessada);
  lblTotal.Caption := IntToStr(QtdTotal);
  PulsaProgressBarAtividade;
  frmProcessamento.Repaint;
end;

function TfrmProcessamento.TotalMarcasSemAcento: Integer;
begin
  Result := DM.SelectMax(dm.dbCarga, dm.IBTCarga, 'MARCAS', 'COD_MARCA', 'COD_MARCA > 0').vResultInt + QTDE_PEDACO_MARCA_SEM_ACENTO;
end;

function TfrmProcessamento.ExisteMarcaSemAcentoPreenchida(Query: TIBQuery): Boolean;
begin
  Query.Close;
  Query.SQL.Text :=
    'SELECT FIRST 1 cod_marca ' +
    'FROM marcas ' +
    'WHERE marca_sem_acento IS NOT NULL ' +
    'AND marca_sem_acento <> ''''';
  Query.Open;
  Result := not Query.Eof;
  Query.Close;
end;

function TfrmProcessamento.ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais: Integer): string;
begin
  Result := Format(
    'Remoção de Acentos: %d / Total Nacionais: %d / Total Internacionais: %d',
    [TotalAcentos, TotalNacionais, TotalInternacionais]
  );
end;

procedure TfrmProcessamento.AtualizaMarcasSemAcento(TempoInicio: TDateTime);
var
  Query: TIBQuery;
  CmdSQL: string;
  QtdePedaco: Integer;
  ValorIni, ValorMax, PosicaoAtual: Integer;
begin
  Query := TIBQuery.Create(nil);
  try
    Query.Database := dm.dbCarga;
    Query.Transaction := dm.IBTCarga;

    lblTexto.Caption := 'Verificando campo MARCA_SEM_ACENTO...';
    AtualizaIndicadoresProcessamento(TempoInicio, 0, 0);
    Application.ProcessMessages;
    GaranteCampoMarcaSemAcento(Query);

    if ExisteMarcaSemAcentoPreenchida(Query) then
    begin
      lblTexto.Caption := 'Marcas sem acento ja preenchidas. Pulando remoção de acentos...';
      AtualizaIndicadoresProcessamento(TempoInicio, TotalMarcasSemAcento, TotalMarcasSemAcento);
      Application.ProcessMessages;
      Exit;
    end;

    QtdePedaco := QTDE_PEDACO_MARCA_SEM_ACENTO;
    ValorIni := 0;
    ValorMax := TotalMarcasSemAcento;
    ProgressBar1.Position := 0;
    ProgressBar1.Max := ValorMax;

    lblTexto.Caption := 'Removendo acentos das marcas...';
    AtualizaIndicadoresProcessamento(TempoInicio, 0, ValorMax);
    Application.ProcessMessages;

    while ValorIni <= ValorMax do
    begin
      CmdSQL :=
        'UPDATE marcas ' + #13 +
        'SET marca_sem_acento = DLL_TIRA_ACENTOS(marca) ' + #13 +
        'WHERE cod_marca >= ' + IntToStr(ValorIni) + #13 +
        'AND cod_marca <= ' + IntToStr(ValorIni + QtdePedaco);

      Query.Close;
      Query.SQL.Text := CmdSQL;
      Query.ExecSQL;
      Query.Transaction.CommitRetaining;

      CmdSQL :=
        'UPDATE processos_ma SET pedido_registro = ''R'' ' + #13 +
        'WHERE (pedido_registro = '' '' OR pedido_registro IS NULL) ' + #13 +
        'AND data_concessao > ''1900-01-01''';

      Query.Close;
      Query.SQL.Text := CmdSQL;
      Query.ExecSQL;
      Query.Transaction.CommitRetaining;

      CmdSQL :=
        'UPDATE processos_ma SET pedido_registro = ''P'' ' + #13 +
        'WHERE (pedido_registro = '' '' OR pedido_registro IS NULL) ' + #13 +
        'AND data_concessao IS NULL';

      Query.Close;
      Query.SQL.Text := CmdSQL;
      Query.ExecSQL;
      Query.Transaction.CommitRetaining;

      ValorIni := ValorIni + QtdePedaco;
      PosicaoAtual := ValorIni;
      if PosicaoAtual > ValorMax then
        PosicaoAtual := ValorMax;
      PosicaoProgressBar(PosicaoAtual);
      AtualizaIndicadoresProcessamento(TempoInicio, PosicaoAtual, ValorMax);
    end;
  finally
    Query.Free;
  end;
end;
procedure TfrmProcessamento.Button1Click(Sender: TObject);
const
  BatchSize = 100;
var
  Query: TIBQuery;
  CmdSQL: string;
  JSON: ISuperObject;
  RecordJSON: ISuperObject;
  Arr: ISuperObject;
  i, j, RecordCount, ValorIni, ValorMax: Integer;
  JsonFileName: string;
  F: TextFile;
  FirstRecord: Boolean;
begin
  ValorIni := 0;
  ValorMax := DM.SelectMax(dm.dbPalavra, dm.IBTPalavra, 'PALAVRA', 'ID_PALAVRA', 'ID_PALAVRA > 0').vResultInt;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ValorMax;

  Query := TIBQuery.Create(nil);
  try
    Query.Database := dm.dbPalavra;
    Query.Transaction := dm.IBTPalavra;
    Query.Unidirectional := True;
    try
      CmdSQL := 'SELECT ID_PALAVRA, PALAVRA_FORMATADA, CLASSE, QTD_PEDIDO, QTD_REGISTRO, QTD_ARQUIVADO FROM PALAVRA';
      Query.SQL.Text := CmdSQL;
      Query.Open;

      JsonFileName := 'C:\Palavras Marcas\Banco de Dados\JSON\palavra_banco.json';
      AssignFile(F, JsonFileName);
      Rewrite(F);

      RecordCount := 0;
      FirstRecord := True;
      Write(F, '[');

      while not Query.Eof do
      begin
        for i := 0 to BatchSize - 1 do
        begin
          if Query.Eof then Break;

          if not FirstRecord then
            Write(F, ',')
          else
            FirstRecord := False;

          RecordJSON := SO();
          RecordJSON.S['idPalavra'] := Query.FieldByName('ID_PALAVRA').AsString;
          RecordJSON.S['word'] := Query.FieldByName('PALAVRA_FORMATADA').AsString;
          RecordJSON.I['class'] := Query.FieldByName('CLASSE').AsInteger;
          RecordJSON.I['applicationCount'] := Query.FieldByName('QTD_PEDIDO').AsInteger;
          RecordJSON.I['registrationCount'] := Query.FieldByName('QTD_REGISTRO').AsInteger;
          RecordJSON.I['archivedCount'] := Query.FieldByName('QTD_ARQUIVADO').AsInteger;

          Write(F, RecordJSON.AsString);
          RecordJSON := nil;

          Query.Next;
          Inc(RecordCount);

          ValorIni := RecordCount;
          PosicaoProgressBar(ValorIni);
        end;

        Flush(F);
      end;

      Write(F, ']');
      CloseFile(F);
    except
      on E: Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
  finally
    Query.Free;
  end;
end;

function LimpaTextoLog(const Valor: string): string;
begin
  Result := StringReplace(Valor, #13, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
end;

procedure TfrmProcessamento.RegistraFalhaProcessamento(const TipoProcessamento: string; const Processo: TProcesso; const Palavra: string; Classe: Integer; const Motivo: string);
var
  LogFile: TextFile;
  LogPath: string;
begin
  try
    LogPath := ExtractFilePath(ParamStr(0)) + 'log_processamento_palavras.txt';
    AssignFile(LogFile, LogPath);

    if FileExists(LogPath) then
      Append(LogFile)
    else
      Rewrite(LogFile);

    try
      Writeln(
        LogFile,
        Format(
          '%s | Tipo=%s | CodMarca=%d | Marca=%s | Palavra=%s | Classe=%d | Status=%s | Motivo=%s',
          [
            FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
            TipoProcessamento,
            Processo.CodMarca,
            LimpaTextoLog(Processo.Marca),
            LimpaTextoLog(Palavra),
            Classe,
            LimpaTextoLog(Processo.Status),
            LimpaTextoLog(Motivo)
          ]
        )
      );
    finally
      CloseFile(LogFile);
    end;
  except
  end;
end;

function TfrmProcessamento.StatusPalavraValido(const StatusPalavra: string): Boolean;
begin
  Result := False;

  if StatusPalavra = '' then
    Exit;

  case StatusPalavra[1] of
    ARQUIVADO, PEDIDO, REGISTRO:
      Result := True;
  end;
end;

procedure TfrmProcessamento.FormCreate(Sender: TObject);
begin
  cdsConversaoNacional.Open;

end;

function TfrmProcessamento.ClasseNacionalToClasseInternacional(ClasseNacional, SubClasse: Integer): Integer;
begin
  if cdsConversaoNacional.Locate('CLASSE_NACIONAL;SUB_CLASSE', VarArrayOf([ClasseNacional, SubClasse]), []) then begin
    Result := cdsConversaoNacionalCLASSE_INTERNACIONAL.AsInteger;
  end else begin
    Result := ClasseNacional;
  end;
end;

function TfrmProcessamento.ConverteVariasClassesNacionais(ClasseNacional: Integer; SubClasses: array of Integer): TArrayInteger;
var
  i, ClasseInternacional: Integer;
  ClasseJaInserida: Boolean;
begin
  SetLength(Result, 0);

  for i := 0 to Length(SubClasses) - 1 do
  begin
    ClasseInternacional := ClasseNacionalToClasseInternacional(ClasseNacional, SubClasses[i]);

    if ClasseInternacional <= 0 then Continue;

    ClasseJaInserida := ArrayHasValue(Result, ClasseInternacional);

    if ClasseJaInserida then Continue;

    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := ClasseInternacional;
  end;
end;

procedure TfrmProcessamento.PosicaoProgressBar(Posicao: Integer);
begin
  if FTotalProcessamento > 0 then
  begin
    PulsaProgressBarAtividade;
    Exit;
  end;

  ProgressBar1.Position := Posicao;
  Application.ProcessMessages;
end;

constructor TPalavrasRepository.Create;
begin
  inherited Create;

  Self.ibSQL := TIBSQL.Create(nil);
  Self.ibSQL.Database := dm.dbPalavra;
  Self.ibSQL.Transaction := dm.IBTPalavra;

  Self.Query := TIBQuery.Create(nil);
  Self.Query.Database := dm.dbPalavra;
  Self.Query.Transaction := dm.IBTPalavra;

  Self.FCachePalavras := TStringList.Create;
  Self.FCachePalavras.Sorted := True;
  Self.FCachePalavras.Duplicates := dupIgnore;
  Self.FCachePalavrasCarregado := False;

  Self.FQtdArquivadoPendente := TStringList.Create;
  Self.FQtdArquivadoPendente.Sorted := True;
  Self.FQtdArquivadoPendente.Duplicates := dupIgnore;

  Self.FQtdPedidoPendente := TStringList.Create;
  Self.FQtdPedidoPendente.Sorted := True;
  Self.FQtdPedidoPendente.Duplicates := dupIgnore;

  Self.FQtdRegistroPendente := TStringList.Create;
  Self.FQtdRegistroPendente.Sorted := True;
  Self.FQtdRegistroPendente.Duplicates := dupIgnore;
end;

procedure TPalavrasRepository.IncrementaContadorPendente(Lista: TStringList; IdPalavra: Integer);
var
  Chave: string;
  Indice: Integer;
begin
  if IdPalavra <= 0 then
    Exit;

  Chave := IntToStr(IdPalavra);
  Indice := Lista.IndexOf(Chave);
  if Indice >= 0 then
    Lista.Objects[Indice] := TObject(Integer(Lista.Objects[Indice]) + 1)
  else
    Lista.AddObject(Chave, TObject(1));
end;

procedure TPalavrasRepository.GravaContadoresPendentes;

  procedure GravaContador(Lista: TStringList; const Campo: string);
  var
    i, IdPalavra, Qtde: Integer;
  begin
    for i := 0 to Lista.Count - 1 do
    begin
      IdPalavra := StrToIntDef(Lista[i], 0);
      Qtde := Integer(Lista.Objects[i]);
      if (IdPalavra <= 0) or (Qtde <= 0) then
        Continue;

      ibSQL.Close;
      ibSQL.SQL.Text :=
        'UPDATE palavra SET ' + Campo + ' = ' + Campo + ' + :qtd ' +
        'WHERE id_palavra = :id_palavra';
      ibSQL.ParamByName('qtd').AsInteger := Qtde;
      ibSQL.ParamByName('id_palavra').AsInteger := IdPalavra;
      ibSQL.ExecQuery;
    end;

    Lista.Clear;
  end;

begin
  GravaContador(FQtdArquivadoPendente, 'qtd_arquivado');
  GravaContador(FQtdPedidoPendente, 'qtd_pedido');
  GravaContador(FQtdRegistroPendente, 'qtd_registro');
  ibSQL.Close;
end;
function TPalavrasRepository.MontaChaveCachePalavra(const Palavra: string; Classe: Integer): string;
begin
  Result := IntToStr(Classe) + '|' + Palavra;
end;

procedure TPalavrasRepository.AdicionaCachePalavra(const Palavra: string; Classe, IdPalavra: Integer);
begin
  if IdPalavra <= 0 then
    Exit;

  FCachePalavras.AddObject(MontaChaveCachePalavra(Palavra, Classe), TObject(IdPalavra));
end;

procedure TPalavrasRepository.CarregaCachePalavras;
begin
  if FCachePalavrasCarregado then
    Exit;

  FCachePalavras.Clear;
  Query.Close;
  Query.SQL.Text := 'SELECT id_palavra, palavra_formatada, classe FROM palavra';
  Query.Open;
  try
    while not Query.Eof do
    begin
      AdicionaCachePalavra(
        Query.FieldByName('palavra_formatada').AsString,
        Query.FieldByName('classe').AsInteger,
        Query.FieldByName('id_palavra').AsInteger
      );
      Query.Next;
    end;
  finally
    Query.Close;
  end;

  FCachePalavrasCarregado := True;
end;
procedure TPalavrasRepository.DeletaAll();
begin
  ibSQL.SQL.Text := 'DELETE FROM palavra';
  ibSQL.ExecQuery;
  ibSQL.Transaction.CommitRetaining;
end;

destructor TPalavrasRepository.Destroy;
begin
  try
    GravaContadoresPendentes;
  except
  end;
  Self.FQtdRegistroPendente.Free;
  Self.FQtdPedidoPendente.Free;
  Self.FQtdArquivadoPendente.Free;
  Self.FCachePalavras.Free;
  Self.ibSQL.Free;
  Self.Query.Free;
  inherited;
end;

procedure TPalavrasRepository.DeletaValoresPalavras();
var
  QueryCarga: TIBQuery;
  CampoExiste: Boolean;
  IndicesCriados: TStringList;

  function ExisteIndiceCargaPorCampo(const Tabela, Campo: string): Boolean;
  begin
    QueryCarga.Close;
    QueryCarga.SQL.Text :=
      'SELECT FIRST 1 i.RDB$INDEX_NAME ' +
      'FROM RDB$INDICES i ' +
      'JOIN RDB$INDEX_SEGMENTS s ON s.RDB$INDEX_NAME = i.RDB$INDEX_NAME ' +
      'WHERE i.RDB$RELATION_NAME = :TABELA ' +
      'AND s.RDB$FIELD_NAME = :CAMPO ' +
      'AND s.RDB$FIELD_POSITION = 0';
    QueryCarga.ParamByName('TABELA').AsString := Tabela;
    QueryCarga.ParamByName('CAMPO').AsString := Campo;
    QueryCarga.Open;
    Result := not QueryCarga.Eof;
    QueryCarga.Close;
  end;

  procedure CriaIndiceCargaSeNaoExiste(const Tabela, Campo, NomeIndice, SQLCreate: string);
  begin
    if ExisteIndiceCargaPorCampo(Tabela, Campo) then
      Exit;

    QueryCarga.Close;
    QueryCarga.SQL.Text := SQLCreate;
    QueryCarga.ExecSQL;
    dm.IBTCarga.CommitRetaining;
    IndicesCriados.Add(NomeIndice);
  end;

begin
  QueryCarga := nil;
  IndicesCriados := TStringList.Create;
  try
    ibSQL.Close;
    ibSQL.SQL.Text := 'DROP TABLE palavra';
    ibSQL.ExecQuery;
    dm.IBTPalavra.CommitRetaining;

    ibSQL.Close;
    ibSQL.SQL.Text :=
      'CREATE TABLE palavra (' +
      ' id_palavra INTEGER NOT NULL,' +
      ' palavra_formatada VARCHAR(252) NOT NULL,' +
      ' classe VARCHAR(2),' +
      ' qtd_arquivado INTEGER,' +
      ' qtd_pedido INTEGER,' +
      ' qtd_registro INTEGER,' +
      ' CONSTRAINT pk_palavra PRIMARY KEY (id_palavra)' +
      ')';
    ibSQL.ExecQuery;
    dm.IBTPalavra.CommitRetaining;

    ibSQL.Close;
    ibSQL.SQL.Text := 'CREATE INDEX idx_palavra_classe ON palavra (classe)';
    ibSQL.ExecQuery;
    dm.IBTPalavra.CommitRetaining;
    IndicesCriados.Add('idx_palavra_classe');

    FCachePalavras.Clear;
    FCachePalavrasCarregado := False;
    FQtdArquivadoPendente.Clear;
    FQtdPedidoPendente.Clear;
    FQtdRegistroPendente.Clear;

    QueryCarga := TIBQuery.Create(nil);
    QueryCarga.Database := dm.dbCarga;
    QueryCarga.Transaction := dm.IBTCarga;

    CriaIndiceCargaSeNaoExiste('MARCAS', 'COD_MARCA', 'idx_marcas_cod_marca', 'CREATE INDEX idx_marcas_cod_marca ON marcas (cod_marca)');
    CriaIndiceCargaSeNaoExiste('PROCESSOS_MA', 'COD_MARCA', 'idx_proc_ma_cod_marca', 'CREATE INDEX idx_proc_ma_cod_marca ON processos_ma (cod_marca)');

    QueryCarga.SQL.Text :=
      'SELECT RDB$FIELD_NAME ' +
      'FROM RDB$RELATION_FIELDS ' +
      'WHERE RDB$RELATION_NAME = ''MARCAS'' ' +
      'AND RDB$FIELD_NAME = ''MARCA_SEM_ACENTO''';
    QueryCarga.Open;
    CampoExiste := not QueryCarga.Eof;
    QueryCarga.Close;

    if CampoExiste then
    begin
      QueryCarga.SQL.Text := 'ALTER TABLE marcas DROP marca_sem_acento';
      QueryCarga.ExecSQL;
      dm.IBTCarga.CommitRetaining;
    end;

    QueryCarga.SQL.Text := 'ALTER TABLE marcas ADD marca_sem_acento VARCHAR(252)';
    QueryCarga.ExecSQL;
    dm.IBTCarga.CommitRetaining;

    if IndicesCriados.Count > 0 then
      ShowMessage('Tabela "palavra" e campo "marca_sem_acento" recriados com sucesso.' + #13 + 'Indices criados: ' + IndicesCriados.CommaText)
    else
      ShowMessage('Tabela "palavra" e campo "marca_sem_acento" recriados com sucesso.' + #13 + 'Nenhum indice novo foi criado.');
  except
    on E: Exception do
    begin
      dm.IBTPalavra.RollbackRetaining;
      dm.IBTCarga.RollbackRetaining;
      ShowMessage('Erro ao recriar tabela "palavra" e campo "marca_sem_acento": ' + E.Message);
    end;
  end;

  if Assigned(QueryCarga) then
    QueryCarga.Free;
  IndicesCriados.Free;
end;

procedure TPalavrasRepository.DeletaValoresRestore();
begin
  try
    ibSQL.Close;
    ibSQL.SQL.Text := 'DELETE FROM restore';
    ibSQL.ExecQuery;

    ibSQL.Close;
    ibSQL.SQL.Text :=
      'UPDATE restore ' +
      'SET qtd_registros_nacionais = 0, ' +
      '    qtd_registros_internacionais = 0, ' +
      '    finalizado_nacionais = ''N'', ' +
      '    finalizado_internacionais = ''N'' ' +
      'WHERE 1 = 0';

    ibSQL.ExecQuery;
    dm.IBTPalavra.CommitRetaining;

    ShowMessage('Todos os registros da tabela "restore" foram deletados com sucesso.');
  except
    on E: Exception do
    begin
      dm.IBTCarga.RollbackRetaining;
      ShowMessage('Erro ao deletar registros da tabela "restore": ' + E.Message);
    end;
  end;
end;

procedure TPalavrasRepository.UpdateValoresRestore();
begin
  try
    ibSQL.Close;
    ibSQL.SQL.Text :=
      'INSERT INTO restore (qtd_registros_nacionais, qtd_registros_internacionais, finalizado_nacionais, finalizado_internacionais) ' +
      'VALUES (0, 0, ''N'', ''N'')';

    ibSQL.ExecQuery;
    dm.IBTPalavra.CommitRetaining;
  except
    on E: Exception do
    begin
      dm.IBTCarga.RollbackRetaining;
      ShowMessage('Erro ao setar valores padrões na tabela "restore": ' + E.Message);
    end;
  end;
end;

procedure TfrmProcessamento.Button2Click(Sender: TObject);
var
  PalavraRepository: IPalavrasRepository;
begin
  PalavraRepository := TPalavrasRepository.Create;

  try
    PalavraRepository.DeletaValoresPalavras;
    PalavraRepository.DeletaValoresRestore;
    PalavraRepository.UpdateValoresRestore;
  finally
    PalavraRepository := nil;
  end;
end;

function TPalavrasRepository.ObtemMaxID(): Integer;
begin
  ibSQL.Close;
  ibSQL.SQL.Text := 'SELECT MAX(id_palavra) FROM palavra';
  ibSQL.ExecQuery;
  Result := ibSQL.Fields[0].AsInteger;
  ibSQL.Close;
end;

function TProcessosRepository.ObtemMaxIDMarcas(): Integer;
begin
  ibSQL.Close;
  ibSQL.SQL.Text := 'SELECT MAX(cod_marca) FROM MARCAS';
  ibSQL.ExecQuery;
  Result := ibSQL.Fields[0].AsInteger;
  ibSQL.Close;
end;

 procedure TPalavrasRepository.IncrementaQtdeOcorrencia(IdPalavra: Integer; StatusPalavra: string);
begin
  case StatusPalavra[1] of
    ARQUIVADO:
      IncrementaContadorPendente(FQtdArquivadoPendente, IdPalavra);
    PEDIDO:
      IncrementaContadorPendente(FQtdPedidoPendente, IdPalavra);
    REGISTRO:
      IncrementaContadorPendente(FQtdRegistroPendente, IdPalavra);
  else
    raise Exception.Create('Status da palavra inválido.');
  end;
end;

procedure TPalavrasRepository.InserePalavra(Palavra: TInserePalavra);
begin
  ibSQL.Close;
  ibSQL.SQL.Text := 'INSERT INTO palavra (id_palavra, palavra_formatada, classe, qtd_pedido, qtd_registro, qtd_arquivado) ' + #13 + 'VALUES (:id_palavra, :palavra_formatada, :classe, :qtd_pedido, :qtd_registro, :qtd_arquivado)';

  ibSQL.ParamByName('id_palavra').AsInteger := Palavra.id_palavra;
  ibSQL.ParamByName('palavra_formatada').AsString := Palavra.palavra_formatada;
  ibSQL.ParamByName('classe').AsInteger := Palavra.classe;
  ibSQL.ParamByName('qtd_pedido').AsString := Palavra.QtdPedido;
  ibSQL.ParamByName('qtd_registro').AsString := Palavra.QtdRegistro;
  ibSQL.ParamByName('qtd_arquivado').AsString := Palavra.QtdArquivado;

  ibSQL.ExecQuery;
  ibSQL.Close;
  if FCachePalavrasCarregado then
    AdicionaCachePalavra(Palavra.palavra_formatada, Palavra.classe, Palavra.id_palavra);
end;

function TPalavrasRepository.ExistePalavra(const Palavra, Classe: string): Boolean;
begin
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'SELECT 1 FROM palavra WHERE palavra_formatada = :Palavra AND classe = :Classe ROWS 1';

  ibSQL.ParamByName('Palavra').AsString := Palavra;
  ibSQL.ParamByName('Classe').AsString := Classe;

  ibSQL.ExecQuery;

  Result := not ibSQL.Eof;
  ibSQL.Close;
end;

function TPalavrasRepository.ObtemPalavraPelaPalavraEClasse(const Palavra: string; Classe: Integer): TPalavra;
var
  IndiceCache: Integer;
begin
  Result.IdPalavra := 0;
  Result.Palavra := Palavra;
  Result.Classe := IntToStr(Classe);
  Result.QtdArquivado := 0;
  Result.QtdPedido := 0;
  Result.QtdRegistro := 0;

  CarregaCachePalavras;
  IndiceCache := FCachePalavras.IndexOf(MontaChaveCachePalavra(Palavra, Classe));
  if IndiceCache >= 0 then
  begin
    Result.IdPalavra := Integer(FCachePalavras.Objects[IndiceCache]);
    Exit;
  end;
end;

function TPalavrasRepository.ObtemUltimoIDPalavra(): integer;
var
  CmdSQL: string;
  UltimoID: Integer;
begin
  ibSQL.Close;
  ibSQL.Transaction.Active := True;
  CmdSQL := 'SELECT FIRST 1 id_palavra FROM palavra ORDER BY id_palavra DESC';

  ibSQL.SQL.Text := CmdSQL;

  ibSQL.ExecQuery;

  UltimoID := ibSQL.Fields[0].AsInteger;
  Result := UltimoID;
  ibSQL.Close;
end;

constructor TProcessosRepository.Create;
begin
  inherited Create;

  Self.ibSQL := TIBSQL.Create(nil);
  Self.ibSQL.Database := dm.dbCarga;
  Self.ibSQL.Transaction := dm.IBTCarga;

  Self.Query := TIBQuery.Create(nil);
  Self.Query.Database := dm.dbCarga;
  Self.Query.Transaction := dm.IBTCarga;
end;

destructor TProcessosRepository.Destroy;
begin
  Self.ibSQL.Free;
  Self.Query.Free;
  inherited;
end;

function TPalavrasRepository.VerificaUltimoPedacoInternacionais(): integer;
var
  qtdProcessosProcessados, ValorIni: Integer;
  finalizado, tempoStr: string;
begin
  Query.Close;
  Query.SQL.Text := 'SELECT qtd_registros_internacionais, finalizado_internacionais FROM RESTORE';
  Query.Open;
  if not Query.IsEmpty then
  begin
    qtdProcessosProcessados := Query.FieldByName('qtd_registros_internacionais').AsInteger;
    finalizado := Trim(Query.FieldByName('finalizado_internacionais').AsString);

    if finalizado = 'N' then
    begin
      ValorIni := qtdProcessosProcessados;
    end
    else if finalizado = 'S' then
    begin
      Result := qtdProcessosProcessados;
      Query.Close;
      Exit;
    end;
  end
  else
  begin
    ValorIni := 0;
    Query.Close;
    Query.SQL.Text := 'INSERT INTO RESTORE (qtd_registros_internacionais, finalizado_internacionais, tempo_internacionais) VALUES (:qtd, :finalizado, :tempo)';
    Query.Params[0].AsInteger := ValorIni;
    Query.Params[1].AsString := 'N';
    Query.Params[2].AsString := '00:00:00';
    Query.ExecSQL;
    dm.IBTPalavra.CommitRetaining;
  end;
  Query.Close;
  Result := ValorIni;
end;

function TPalavrasRepository.VerificaUltimoPedacoNacionais(): integer;
var
  qtdProcessosProcessados, ValorIni: Integer;
  finalizado:string;
begin
  Query.Close;
  Query.SQL.Text := 'SELECT qtd_registros_nacionais, finalizado_nacionais FROM RESTORE';
  Query.Open;
  if not Query.IsEmpty then
  begin
    qtdProcessosProcessados := Query.FieldByName('qtd_registros_nacionais').AsInteger;
    finalizado := trim(Query.FieldByName('finalizado_nacionais').AsString);

    if finalizado = 'N' then
    begin
      valorIni := qtdProcessosProcessados;
    end
    else if finalizado = 'S' then
    begin
      Result := qtdProcessosProcessados;
      Query.Close;
      Exit;
    end;
  end
  else
  begin
    valorIni := 0;
    Query.Close;
    Query.SQL.Text := 'INSERT INTO RESTORE (qtd_registros_nacionais, finalizado_nacionais) VALUES (:qtd, :finalizado)';
    Query.Params[0].AsInteger := valorIni;
    Query.Params[1].AsString := 'N';
    Query.ExecSQL;
    dm.IBTPalavra.CommitRetaining;
  end;
  Query.Close;
  Result := ValorIni;
end;

procedure TPalavrasRepository.UpdateRestoreInternacionais(valorIni: Integer; tempo: TDateTime);
begin
  GravaContadoresPendentes;
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'UPDATE RESTORE SET qtd_registros_internacionais = :qtd, ' +
    'finalizado_internacionais = :finalizado';

  ibSQL.Params[0].AsInteger := valorIni;
  ibSQL.Params[1].AsString := 'N';

  ibSQL.ExecQuery;
  dm.IBTPalavra.CommitRetaining;
  ibSQL.Close;
end;

procedure TPalavrasRepository.UpdateRestoreNacionais(valorIni:Integer; tempo: TDateTime);
begin
  GravaContadoresPendentes;
  ibSQL.Close;
  ibSQL.SQL.Text :=
  'UPDATE RESTORE SET qtd_registros_nacionais = :qtd, ' + #13 +
  'finalizado_nacionais = :finalizado';

  ibSQL.Params[0].AsInteger := ValorIni;
  ibSQL.Params[1].AsString := 'N';

  ibSQL.ExecQuery;
  dm.IBTPalavra.CommitRetaining;
  ibSQL.Close;
end;

procedure TPalavrasRepository.UpdateRestoreFinalizadoNacionais();
begin
  GravaContadoresPendentes;
  ibSQL.Close;
  ibSQL.SQL.Text := 'UPDATE RESTORE SET finalizado_nacionais = :finalizado';
  ibSQL.Params[0].AsString := 'S';
  ibSQL.ExecQuery;
  dm.IBTPalavra.CommitRetaining;
  ibSQL.Close;
  ShowMessage('Processamento concluído com sucesso!');
end;

procedure TPalavrasRepository.UpdateRestoreFinalizadoInternacionais();
begin
  GravaContadoresPendentes;
  ibSQL.Close;
  ibSQL.SQL.Text := 'UPDATE RESTORE SET finalizado_internacionais = :finalizado';
  ibSQL.Params[0].AsString := 'S';
  ibSQL.ExecQuery;
  dm.IBTPalavra.CommitRetaining;
  ibSQL.Close;
  ShowMessage('Processamento concluído com sucesso!');
end;

function TProcessosRepository.CountPalavrasInternacionais(): Integer;
begin
  ibSQL.Close;
  ibSQL.SQL.Text :=
  'SELECT COUNT(cod_marca) ' + #13 +
  'FROM processos_ma ' + #13 +
  'WHERE cod_marca > 0 ' +
  'AND (classe_antiga_1 = '''' or classe_antiga_1 IS NULL) ';

  ibSQL.ExecQuery;
  Result := ibSQL.Fields[0].AsInteger;
  ibSQL.Close;
end;

function TProcessosRepository.CountPalavrasNacionais(): Integer;
begin
  ibSQL.Close;
  ibSQL.SQL.Text :=
  'SELECT COUNT(cod_marca) ' + #13 +
  'FROM processos_ma ' + #13 +
  'WHERE cod_marca > 0 ' + 'AND (classe_internacional = '''' or classe_internacional IS NULL)';

  ibSQL.ExecQuery;
  Result := ibSQL.Fields[0].AsInteger;
  ibSQL.Close;
end;

procedure TProcessosRepository.TrimClasseInternacionais();
begin  
  // Atualiza classe_internacional
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'UPDATE processos_ma SET classe_internacional = substring(classe_internacional from 2 for 400)' + #13 +
    'WHERE (substring(classe_internacional from 1 for 1) = '' '' and substring(classe_internacional from 2 for 1) <> '' '')';

  ibSQL.ExecQuery;
  dm.IBTCarga.CommitRetaining;
  ibSQL.Close;
end;

procedure TProcessosRepository.TrimClasseNacionais();
begin
  // Atualiza as colunas classe_antiga_1 a classe_antiga_4 em um único comando
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'UPDATE processos_ma ' +
    'SET ' +
    '  classe_antiga_1 = CASE ' +
    '    WHEN substring(classe_internacional from 1 for 1) = '' '' AND substring(classe_internacional from 2 for 1) <> '' '' ' +
    '    THEN substring(classe_internacional from 2 for 2) ' +
    '    ELSE classe_antiga_1 ' +
    '  END, ' +
    '  classe_antiga_2 = CASE ' +
    '    WHEN substring(classe_internacional from 1 for 1) = '' '' AND substring(classe_internacional from 4 for 1) <> '' '' ' +
    '    THEN substring(classe_internacional from 4 for 2) ' +
    '    ELSE classe_antiga_2 ' +
    '  END, ' +
    '  classe_antiga_3 = CASE ' +
    '    WHEN substring(classe_internacional from 1 for 1) = '' '' AND substring(classe_internacional from 6 for 1) <> '' '' ' +
    '    THEN substring(classe_internacional from 6 for 2) ' +
    '    ELSE classe_antiga_3 ' +
    '  END, ' +
    '  classe_antiga_4 = CASE ' +
    '    WHEN substring(classe_internacional from 1 for 1) = '' '' AND substring(classe_internacional from 8 for 1) <> '' '' ' +
    '    THEN substring(classe_internacional from 8 for 2) ' +
    '    ELSE classe_antiga_4 ' +
    '  END';

  ibSQL.ExecQuery;
  dm.IBTCarga.CommitRetaining;
  ibSQL.Close;
end;

function TProcessosRepository.ObtemPalavrasNacionaisPorPedaco(QtdePedaco, ValorIni: Integer): TArrProcessos;
var
  ProcessosNacionais: TArrProcessos;
  SubClassesProcessos: array of Integer;
  j, iClasses, ClasseInt: Integer;
  CampoClasse, ClasseStr, Classe: string;
  Count: Integer;
begin
  Result := nil;
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'SELECT FIRST :QtdePedaco ma.cod_marca, ma.marca_sem_acento, pm.classe_antiga_1 as classe, ' +
    'pm.classe_antiga_2 as classe2, pm.classe_antiga_3 as classe3, pm.classe_antiga_4 as classe4, ' +
    'pm.pedido_registro as pedido ' +
    'FROM marcas ma ' +
    'LEFT JOIN processos_ma pm ON ma.cod_marca = pm.cod_marca ' +
    'WHERE ma.cod_marca > :ValorIni ' +
    'AND (pm.classe_internacional = '''' or pm.classe_internacional IS NULL) ' +
    'AND ma.cod_marca <= :ValorIniPlusPedaco ' +
    'ORDER BY ma.cod_marca';

  ibSQL.ParamByName('QtdePedaco').AsInteger := QtdePedaco;
  ibSQL.ParamByName('ValorIni').AsInteger := ValorIni;
  ibSQL.ParamByName('ValorIniPlusPedaco').AsInteger := ValorIni + QtdePedaco;

  ibSQL.ExecQuery;

  try
    Count := 0;
    SetLength(ProcessosNacionais, QtdePedaco);
    while not ibSQL.Eof do
    begin
      ProcessosNacionais[Count].CodMarca := ibSQL.FieldByName('cod_marca').AsInteger; //* guarda última marca processada pelo Id
      ProcessosNacionais[Count].MarcaSemAcento := ibSQL.FieldByName('marca_sem_acento').AsString;
      ProcessosNacionais[Count].Marca := ProcessosNacionais[Count].MarcaSemAcento;
      ProcessosNacionais[Count].Status := ibSQL.FieldByName('pedido').AsString;
      ProcessosNacionais[Count].ClasseNacional := ibSQL.FieldByName('classe').AsString;

      SetLength(SubClassesProcessos, 0);
      iClasses := 0;

      for j := 2 to 4 do
      begin
        CampoClasse := 'classe' + IntToStr(j);
        if not ibSQL.FieldByName(CampoClasse).IsNull then
        begin
          ClasseStr := ibSQL.FieldByName(CampoClasse).AsString;
          Classe := Trim(ClasseStr);

          Classe := StringReplace(Classe, ';', '', [rfReplaceAll]);

          if (Classe = '') or (Classe = ' ') then
            Break;

          ClasseInt := StrToIntDef(Classe, 0);
          if ClasseInt > 0 then
          begin
            SetLength(SubClassesProcessos, iClasses + 1);
            SubClassesProcessos[iClasses] := ClasseInt;
            Inc(iClasses);
          end;
        end;
      end;

      SetLength(ProcessosNacionais[Count].SubClasses, Length(SubClassesProcessos));

      for j := 0 to High(SubClassesProcessos) do
      begin
        ProcessosNacionais[Count].SubClasses[j] := SubClassesProcessos[j];
      end;

      Inc(Count);
      ibSQL.Next;
    end
  finally
    ibSQL.Close;
  end;
  Result := ProcessosNacionais;
end;

procedure TfrmProcessamento.InsereMarcasNacionaisTratadas(PalavraRepository: IPalavrasRepository; ProcessoRepository: IProcessosRepository; TempoInicio: TDateTime);
var
  i, j, k, u: Integer;
  NextID, QtdePedaco, QtdPalavrasProcessadas: integer;
  QtdPalavrasTotal, ClasseNacionalInt, ClassInt: Integer;
  MinutosRestantes, SegundosRestantes: integer;
  DiasRestantes, HorasRestantes: Integer;
  TempoDecorrido, TempoRestanteEstimado, TempoMedioPorPalavra: TDateTime;
  TempoInicial, TempoSalvo, TempoAtual: TDateTime;
  ListaPalavrasNac, ListaClasseNac: TStringList;
  MarcaFinalNac, MarcaFormatadaNac: string;
  ClasseNacional, PalavraNac: string;
  ClasseInternacional: TArrayInteger;
  ProcessosNacionais: TArrProcessos;
  InserePalavrasDTO: TInserePalavra;
  PalavraExistente: TPalavra;
  Processo: TProcesso;
  InserePrimeiroID: Integer;
  TempoEstimado: TDateTime;
  TempoDecorridoSegundos, TempoEstimadoSegundos: Double;
  Velocidade: Double;
  Cont: Integer;
  UltimoProcesso: Integer;
  MaxCodMarca: Integer;
begin
  cont := 0;
  UltimoProcesso := 0;
  InserePrimeiroID := 0;
  ProgressBar1.Position := 0;

  QtdePedaco := QTDE_PEDACO_PROCESSAMENTO;

  QtdPalavrasProcessadas := PalavraRepository.VerificaUltimoPedacoNacionais();
  QtdPalavrasTotal := ProcessoRepository.CountPalavrasNacionais;
  ProgressBar1.Max := QtdPalavrasTotal;

  MaxCodMarca := ProcessoRepository.ObtemMaxIDMarcas;

  while QtdPalavrasProcessadas < QtdPalavrasTotal do
  begin
    try
      ProcessosNacionais := ProcessoRepository.ObtemPalavrasNacionaisPorPedaco(QtdePedaco, UltimoProcesso);
    except
      on E: Exception do
      begin
        Processo.CodMarca := UltimoProcesso;
        Processo.Marca := '';
        Processo.Status := '';
        RegistraFalhaProcessamento(TIPO_NACIONAL, Processo, '', 0, 'Erro ao buscar lote: ' + E.Message);
        UltimoProcesso := UltimoProcesso + QtdePedaco;
        Continue;
      end;
    end;
    if Length(ProcessosNacionais) = 0 then begin
      UltimoProcesso := UltimoProcesso + QtdePedaco;
    end;
    if UltimoProcesso > MaxCodMarca then begin
       QtdPalavrasProcessadas := QtdPalavrasTotal;
    end;
    for i := 0 to Length(ProcessosNacionais) - 1 do
    begin
      Inc(QtdPalavrasProcessadas);
      Processo := ProcessosNacionais[i];
      UltimoProcesso := Processo.CodMarca;

      MarcaFormatadaNac := DM.FormataTexto(Processo.MarcaSemAcento);
      MarcaFinalNac := DM.LimpaMarca(Trim(MarcaFormatadaNac));

      ListaPalavrasNac := nil;
      ListaClasseNac := nil;
      try
        ListaPalavrasNac := DM.quebraString(MarcaFinalNac, ' ');
        ListaClasseNac := DM.quebraString(Processo.ClasseNacional, ';');
        for j := 0 to ListaPalavrasNac.Count - 1 do
        begin
          PalavraNac := ListaPalavrasNac[j];
          for k := 0 to ListaClasseNac.Count - 1 do
          begin
            ClasseNacional := ListaClasseNac[k];
            if not TryStrToInt(ClasseNacional, ClasseNacionalInt) then
            begin
              RegistraFalhaProcessamento(TIPO_NACIONAL, Processo, PalavraNac, 0, 'Classe nacional invalida: ' + ClasseNacional);
              Continue;
            end;

            ClasseInternacional := ConverteVariasClassesNacionais(ClasseNacionalInt, Processo.SubClasses);

            for u := 0 to Length(ClasseInternacional) - 1 do
            begin
              ClassInt := ClasseInternacional[u];

              try
                if not StatusPalavraValido(Processo.Status) then
                begin
                  RegistraFalhaProcessamento(TIPO_NACIONAL, Processo, PalavraNac, ClassInt, 'Status da palavra invalido.');
                  Continue;
                end;

                PalavraExistente := PalavraRepository.ObtemPalavraPelaPalavraEClasse(PalavraNac, ClassInt);
                if PalavraExistente.IdPalavra > 0 then
                begin
                  NextID := PalavraExistente.IdPalavra;
                end
                else
                begin
                  if InserePrimeiroID = 0 then begin
                    NextID := PalavraRepository.ObtemMaxID + 1;
                  end else begin
                    NextID := InserePrimeiroID + 1;
                  end;
                  InserePrimeiroID := NextID;

                  InserePalavrasDTO.id_palavra := NextID;
                  InserePalavrasDTO.palavra_formatada := PalavraNac;
                  InserePalavrasDTO.classe := ClassInt;
                  InserePalavrasDTO.QtdArquivado := '0';
                  InserePalavrasDTO.QtdRegistro := '0';
                  InserePalavrasDTO.QtdPedido := '0';

                  PalavraRepository.InserePalavra(InserePalavrasDTO);
                end;
                PalavraRepository.IncrementaQtdeOcorrencia(NextID, Processo.Status);
              except
                on E: Exception do
                  RegistraFalhaProcessamento(TIPO_NACIONAL, Processo, PalavraNac, ClassInt, E.Message);
              end;
            end;
          end;

          Inc(cont);

          if ((QtdPalavrasProcessadas mod INTERVALO_ATUALIZACAO_TELA) = 0) or (i = Length(ProcessosNacionais) - 1) then
          begin
            TempoDecorrido := Now - TempoInicio;
            TempoDecorridoSegundos := SecondsBetween(TempoInicio, Now);

          if TempoDecorridoSegundos > 0 then
          begin
            Velocidade := cont / TempoDecorridoSegundos;
          end
          else
          begin
            Velocidade := 0;
          end;

          if Velocidade > 0 then
          begin
            TempoEstimadoSegundos := (QtdPalavrasTotal - QtdPalavrasProcessadas) / Velocidade;
          end
          else
          begin
            TempoEstimadoSegundos := 0;
          end;

          TempoEstimado := TempoEstimadoSegundos / SecsPerDay;

          AtualizaIndicadoresProcessamento(TempoInicio, QtdPalavrasProcessadas, QtdPalavrasTotal);
          end;
        end;
      finally
        FreeAndNil(ListaPalavrasNac);
        FreeAndNil(ListaClasseNac);
      end;
    end;

    TempoDecorrido := Now - TempoInicio;
    TempoDecorridoSegundos := SecondsBetween(TempoInicio, Now);

    if TempoDecorridoSegundos > 0 then
    begin
      Velocidade := cont / TempoDecorridoSegundos;
    end
    else
    begin
      Velocidade := 0;
    end;

    if Velocidade > 0 then
    begin
      TempoEstimadoSegundos := (QtdPalavrasTotal - QtdPalavrasProcessadas) / Velocidade;
    end
    else
    begin
      TempoEstimadoSegundos := 0;
    end;

    TempoEstimado := TempoEstimadoSegundos / SecsPerDay;

    AtualizaIndicadoresProcessamento(TempoInicio, QtdPalavrasProcessadas, QtdPalavrasTotal);

    PosicaoProgressBar(QtdPalavrasProcessadas);

    PalavraRepository.UpdateRestoreNacionais(QtdPalavrasProcessadas, TempoDecorrido);
    SetLength(ProcessosNacionais, 0);
  end;
  PalavraRepository.UpdateRestoreFinalizadoNacionais;
end;

function TProcessosRepository.ObtemPalavrasInternacionais(QtdePedaco, ValorIni: Integer): TArrProcessos;
var
  ProcessosInternacionais: TArrProcessos;
  Count: Integer;
begin
  Result := nil;
  ibSQL.Close;
  ibSQL.SQL.Text :=
    'SELECT FIRST :QtdePedaco ma.cod_marca, pm.nro_processo, ma.marca_sem_acento, pm.classe_internacional as classe, pm.pedido_registro as pedido ' +
    'FROM marcas ma ' +
    'LEFT JOIN processos_ma pm ON ma.cod_marca = pm.cod_marca ' +
    'WHERE ma.cod_marca > :ValorIni ' +
    'AND (pm.classe_antiga_1 = '''' or pm.classe_antiga_1 IS NULL) ' +
    'AND (pm.classe_antiga_2 = '''' or pm.classe_antiga_2 IS NULL) ' +
    'AND (pm.classe_antiga_3 = '''' or pm.classe_antiga_3 IS NULL) ' +
    'AND (pm.classe_antiga_4 = '''' or pm.classe_antiga_4 IS NULL) ' +
    'AND ma.cod_marca <= :ValorIniPlusPedaco ' +
    'ORDER BY ma.cod_marca';


  ibSQL.ParamByName('QtdePedaco').AsInteger := QtdePedaco;
  ibSQL.ParamByName('ValorIni').AsInteger := ValorIni;
  ibSQL.ParamByName('ValorIniPlusPedaco').AsInteger := ValorIni + QtdePedaco;

  ibSQL.ExecQuery;

  try
    Count := 0;
    SetLength(ProcessosInternacionais, QtdePedaco);
    while not ibSQL.Eof do
    begin
      ProcessosInternacionais[Count].CodMarca := ibSQL.FieldByName('cod_marca').AsInteger; //* guardar o último processado
      ProcessosInternacionais[Count].MarcaSemAcento := ibSQL.FieldByName('marca_sem_acento').AsString;
      ProcessosInternacionais[Count].Marca := ProcessosInternacionais[Count].MarcaSemAcento;
      ProcessosInternacionais[Count].ClasseInternacional := ibSQL.FieldByName('classe').AsString;
      ProcessosInternacionais[Count].Status := ibSQL.FieldByName('pedido').AsString;

      Inc(Count);
      ibSQL.Next;
    end;

    SetLength(ProcessosInternacionais, Count);
  finally
    ibSQL.Close;
  end;

  Result := ProcessosInternacionais;
end;

procedure TfrmProcessamento.InsereMarcasInternacionaisTratadas(PalavraRepository: IPalavrasRepository; ProcessoRepository: IProcessosRepository; TempoInicio: TDateTime);
var
  i, j, k: Integer;
  NextID, QtdePedaco, QtdPalavrasProcessadas, DiasRestantes, HorasRestantes: integer;
  QtdPalavrasTotal, ClasseInternacional, MinutosRestantes, SegundosRestantes: integer;
  TempoRestanteEstimado, TempoMedioPorPalavra: TDateTime;
  TempoInicial, TempoSalvo, TempoAtual: TDateTime;
  ListaPalavrasInt, ListaClasseInt: TStringList;
  ProcessosInternacionais: TArrProcessos;
  InserePalavrasDTO: TInserePalavra;
  MarcaFinalInt, MarcaFormatadaInt: string;
  PalavraInt, ClasseIntQuebrada: string;
  PalavraExistente: TPalavra;
  Processo: TProcesso;
  TempoDecorrido: TDateTime;
  Velocidade: Double;
  TempoEstimado: TDateTime;
  TempoRestante: TDateTime;
  cont: Integer;
  TempoDecorridoSegundos, TempoEstimadoSegundos: Double;
  InserePrimeiroID: integer;
  UltimoProcesso: Integer;
  MaxCodMarca: Integer;
begin
  InserePrimeiroID := 0;
  ProgressBar1.Position := 0;
  cont := 0;
  UltimoProcesso := 0;
  QtdePedaco := QTDE_PEDACO_PROCESSAMENTO;

  QtdPalavrasProcessadas := PalavraRepository.VerificaUltimoPedacoInternacionais();
  QtdPalavrasTotal := ProcessoRepository.CountPalavrasInternacionais;
  ProgressBar1.Max := QtdPalavrasTotal;

  MaxCodMarca := ProcessoRepository.ObtemMaxIDMarcas;

  while QtdPalavrasProcessadas < QtdPalavrasTotal do
  begin
    try
      ProcessosInternacionais := ProcessoRepository.ObtemPalavrasInternacionais(QtdePedaco, UltimoProcesso);
    except
      on E: Exception do
      begin
        Processo.CodMarca := UltimoProcesso;
        Processo.Marca := '';
        Processo.Status := '';
        RegistraFalhaProcessamento(TIPO_INTERNACIONAL, Processo, '', 0, 'Erro ao buscar lote: ' + E.Message);
        UltimoProcesso := UltimoProcesso + QtdePedaco;
        Continue;
      end;
    end;
    if Length(ProcessosInternacionais) = 0 then begin
      UltimoProcesso := UltimoProcesso + QtdePedaco;
    end;
    if UltimoProcesso > MaxCodMarca then begin
      QtdPalavrasProcessadas := QtdPalavrasTotal;
    end;
    for i := 0 to Length(ProcessosInternacionais) - 1 do
    begin
      Inc(QtdPalavrasProcessadas);
      Processo := ProcessosInternacionais[i];
      UltimoProcesso := Processo.CodMarca;

      MarcaFormatadaInt := DM.FormataTexto(Processo.MarcaSemAcento);
      MarcaFinalInt := DM.LimpaMarca(Trim(MarcaFormatadaInt));

      ListaPalavrasInt := nil;
      ListaClasseInt := nil;
      try
        ListaPalavrasInt := DM.quebraString(MarcaFinalInt, ' ');
        ListaClasseInt := DM.quebraString(Processo.ClasseInternacional, ';');
        for j := 0 to ListaPalavrasInt.Count - 1 do
        begin
          PalavraInt := ListaPalavrasInt[j];
          for k := 0 to ListaClasseInt.Count - 1 do
          begin
            ClasseIntQuebrada := ListaClasseInt[k];
            if not TryStrToInt(ClasseIntQuebrada, ClasseInternacional) then
            begin
              RegistraFalhaProcessamento(TIPO_INTERNACIONAL, Processo, PalavraInt, 0, 'Classe internacional invalida: ' + ClasseIntQuebrada);
              Continue;
            end;

            try
              if not StatusPalavraValido(Processo.Status) then
              begin
                RegistraFalhaProcessamento(TIPO_INTERNACIONAL, Processo, PalavraInt, ClasseInternacional, 'Status da palavra invalido.');
                Continue;
              end;

              PalavraExistente := PalavraRepository.ObtemPalavraPelaPalavraEClasse(PalavraInt, ClasseInternacional);

              if PalavraExistente.IdPalavra > 0 then
              begin
                NextID := PalavraExistente.IdPalavra;
              end
              else
              begin
                if InserePrimeiroID = 0 then begin
                  NextID := PalavraRepository.ObtemMaxID + 1;
                end else begin
                  NextID := InserePrimeiroID + 1;
                end;
                InserePrimeiroID := NextID;

                InserePalavrasDTO.id_palavra := NextID;
                InserePalavrasDTO.palavra_formatada := PalavraInt;
                InserePalavrasDTO.classe := ClasseInternacional;

                InserePalavrasDTO.QtdArquivado := '0';
                InserePalavrasDTO.QtdRegistro := '0';
                InserePalavrasDTO.QtdPedido := '0';

                PalavraRepository.InserePalavra(InserePalavrasDTO);
              end;

              PalavraRepository.IncrementaQtdeOcorrencia(NextID, Processo.Status);
            except
              on E: Exception do
                RegistraFalhaProcessamento(TIPO_INTERNACIONAL, Processo, PalavraInt, ClasseInternacional, E.Message);
            end;
          end;
        end;
        Inc(cont);

        if ((QtdPalavrasProcessadas mod INTERVALO_ATUALIZACAO_TELA) = 0) or (i = Length(ProcessosInternacionais) - 1) then
        begin
          TempoDecorrido := Now - TempoInicio;
          TempoDecorridoSegundos := SecondsBetween(TempoInicio, Now);

        if TempoDecorridoSegundos > 0 then
        begin
          Velocidade := cont / TempoDecorridoSegundos;
        end
        else
        begin
          Velocidade := 0;
        end;

        if Velocidade > 0 then
        begin
          TempoEstimadoSegundos := (QtdPalavrasTotal - QtdPalavrasProcessadas) / Velocidade;
        end
        else
        begin
          TempoEstimadoSegundos := 0;
        end;

        TempoEstimado := TempoEstimadoSegundos / SecsPerDay;

        AtualizaIndicadoresProcessamento(TempoInicio, QtdPalavrasProcessadas, QtdPalavrasTotal);
        end;

      finally
        FreeAndNil(ListaPalavrasInt);
        FreeAndNil(ListaClasseInt);
      end;
    end;

    PosicaoProgressBar(QtdPalavrasProcessadas);

    PalavraRepository.UpdateRestoreInternacionais(QtdPalavrasProcessadas, TempoDecorrido);
    SetLength(ProcessosInternacionais, 0);
  end;
  PalavraRepository.UpdateRestoreFinalizadoInternacionais;
end;

procedure TfrmProcessamento.btnInternacionalClick(Sender: TObject);
var
  PalavrasRepository: IPalavrasRepository;
  ProcessosRepository: IProcessosRepository;
  CaptionOriginal: string;
  TempoInicio: TDateTime;
  TotalAcentos, TotalNacionais, TotalInternacionais: Integer;
begin
  TempoInicio := Now;

  CaptionOriginal := btnInternacional.Caption;
  btnInternacional.Enabled := False;
  btnInternacional.Caption := 'Processando...';

  PalavrasRepository := TPalavrasRepository.Create;
  ProcessosRepository := TProcessosRepository.Create;

  try
    TotalAcentos := TotalMarcasSemAcento;
    TotalNacionais := 0;
    TotalInternacionais := 0;
    FBaseProcessamento := 0;
    FTotalProcessamento := TotalAcentos;
    if FTotalProcessamento <= 0 then
      FTotalProcessamento := 1;

    lblTexto.Caption := 'Removendo acentos... ' + ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais);
    ProgressBar2.Position := 0;
    ProgressBar2.Max := FTotalProcessamento;
    AtualizaIndicadoresProcessamento(TempoInicio, 0, TotalAcentos);

    AtualizaMarcasSemAcento(TempoInicio);

    lblTexto.Caption := 'Calculando totais Nacionais e Internacionais...';
    Application.ProcessMessages;
    TotalNacionais := ProcessosRepository.CountPalavrasNacionais;
    TotalInternacionais := ProcessosRepository.CountPalavrasInternacionais;
    FBaseProcessamento := TotalAcentos;
    FTotalProcessamento := TotalAcentos + TotalNacionais + TotalInternacionais;
    if FTotalProcessamento <= 0 then
      FTotalProcessamento := 1;
    ProgressBar2.Max := FTotalProcessamento;
    lblTexto.Caption := ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais);
    Application.ProcessMessages;

    if TotalNacionais > 0 then
    begin
      TempoInicio := Now;
      lblTexto.Caption := 'Processando Nacionais... ' + ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais);
      AtualizaIndicadoresProcessamento(TempoInicio, 0, TotalNacionais);
      Application.ProcessMessages;
      InsereMarcasNacionaisTratadas(PalavrasRepository, ProcessosRepository, TempoInicio);
      AtualizaIndicadoresProcessamento(TempoInicio, TotalNacionais, TotalNacionais);
    end;

    FBaseProcessamento := TotalAcentos + TotalNacionais;

    if TotalInternacionais > 0 then
    begin
      TempoInicio := Now;
      lblTexto.Caption := 'Processando Internacionais... ' + ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais);
      AtualizaIndicadoresProcessamento(TempoInicio, 0, TotalInternacionais);
      Application.ProcessMessages;
      InsereMarcasInternacionaisTratadas(PalavrasRepository, ProcessosRepository, TempoInicio);
      AtualizaIndicadoresProcessamento(TempoInicio, TotalInternacionais, TotalInternacionais);
    end;

    FBaseProcessamento := FTotalProcessamento;
    if ProgressBar2.Max > 0 then
      ProgressBar2.Position := ProgressBar2.Max;

    lblTexto.Caption := 'Processamento Finalizado! ' + ResumoTotaisProcessamento(TotalAcentos, TotalNacionais, TotalInternacionais);
  finally

    FBaseProcessamento := 0;
    FTotalProcessamento := 0;
    btnInternacional.Caption := CaptionOriginal;
    btnInternacional.Enabled := True;
  end;
end;

end.
