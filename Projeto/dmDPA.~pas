unit dmDPA;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery, DBClient, DBLocal,
  DBLocalI, IBSQL, Windows, Graphics, GraphicEx;

type
  TResultFunctionDB = record
    bProcessamentoOk: Boolean;
    bProcOk: Boolean;
    vMsg: string;
    vResultFloat: Double;
    vResultInt: Integer;
    vResultInt2: Integer;
    vResultStr: string;
    vResultStr2: string;
    vResultDate: TDateTime;
    vResultSQLCode: Integer;
  end;

type
  TMsgType = (mtErro, mtInformacao, mtAviso, mtConfirmacao);

type
  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);

  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp);

  TMsgDlgButtons = set of TMsgDlgBtn;

type
  TDM = class(TDataModule)
    dbCarga: TIBDatabase;
    IBTCarga: TIBTransaction;
    dbPalavra: TIBDatabase;
    IBTPalavra: TIBTransaction;
    dbIntelectual: TIBDatabase;
    IBTIntelectual: TIBTransaction;
    IBClientDataSet1: TIBClientDataSet;
    qryLimpezaRpiMarcasPALAVRA_EXCLUIR: TStringField;
    qryLimpezaRpiMarcasCLASSES_ANT: TStringField;
    qryLimpezaRpiMarcasCLASSES_INT: TStringField;
    qryLimpezaRpiMarcasTODAS_CLASSES: TStringField;
    qryLimpezaRpiMarcasRS_JORNA: TStringField;
    qryLimpezaRpiMarcasMARCA: TStringField;
    IBClientDataSet2: TIBClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
  private
    function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
    { Private declarations }
  public
    gCancelouAguardeProcesso: Boolean;
    function LimpaMarca(const NomeMarca: string): string;
    function AnsiContainsStr(const AText, ASubText: string): Boolean;
    function QuebraString(const S: string; const Separator: Char): TStringList;
    procedure IncNewFieldID(NomeTabela: string; PrimaryKey: TField);
    function FormataTexto(const NomeMarca: string): string;
    function SelectSingleStr(const DB: TIBDatabase; const TC: TIBTransaction; const cTabela: string; const cCampo: string; const cWhere: string): TResultFunctionDB;
    function SelectCount(const DB: TIBDatabase; const TC: TIBTransaction; cTabela: string; const cWhere: string): TResultFunctionDB;
    function SelectMax(const DB: TIBDatabase; const TC: TIBTransaction; const cTabela: string; const cCampo: string; const cWhere: string = ''): TResultFunctionDB;
    function ExecutaSQL(const DB: TIBDatabase; const TC: TIBTransaction; const cComandoSQL: string): TResultFunctionDB;
    function M(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
    function FDlgMessage(const cTexto: string; const cMsgType: TMsgType; const cNumBotoes: Integer; const cCaptionBotoes: string; const cHandle: Integer): Integer;
    function ObtemCampo(const cLin: string; const cNumCampo: Integer; const cSeparador: string): string;
    procedure AguardeProgresso(const cTexto: string; const cProgressoAtu: Integer; const cProgressoTot: Integer);
    { Public declarations }
  end;

var
  DM: TDM;
  sUsuario: string;
  sPathSystem: string;

const
  mrNone = 0;
  mrOk = idOk;
  mrCancel = idCancel;
  mrAbort = idAbort;
  mrRetry = idRetry;
  mrIgnore = idIgnore;
  mrYes = idYes;
  mrNo = idNo;
  mrAll = mrNo + 1;
  mrNoToAll = mrAll + 1;
  mrYesToAll = mrNoToAll + 1;

implementation

uses
  untMensagem, untAguardeProgresso, untInicializacao;

{$R *.dfm}

function TDM.AnsiContainsStr(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(ASubText, AText) > 0;
end;

function TDM.LimpaMarca(const NomeMarca: string): string;
var
  ListaPalavras: TStringList;
  PalavrasRemover: TStringList;
  Palavra: string;
  i: Integer;
begin
  PalavrasRemover := TStringList.Create;

  PalavrasRemover.Add('do');
  PalavrasRemover.Add('de');
  PalavrasRemover.Add('da');
  PalavrasRemover.Add('dos');
  PalavrasRemover.Add('das');
  PalavrasRemover.Add('No');
  PalavrasRemover.Add('Na');
  PalavrasRemover.Add('Nos');
  PalavrasRemover.Add('Nas');
  PalavrasRemover.Add('A');
  PalavrasRemover.Add('O');
  PalavrasRemover.Add('E');
  PalavrasRemover.Add('Para');
  PalavrasRemover.Add('Ate');
  PalavrasRemover.Add('Com');
  PalavrasRemover.Add('Sem');
  PalavrasRemover.Add('As');
  PalavrasRemover.Add('Os');
  PalavrasRemover.Add('&');

  ListaPalavras := TStringList.Create;
  try
    ListaPalavras.Delimiter := ' ';
    ListaPalavras.DelimitedText := NomeMarca;

    for i := ListaPalavras.Count - 1 downto 0 do
    begin
      Palavra := ListaPalavras[i];
      if PalavrasRemover.IndexOf(Palavra) <> -1 then
        ListaPalavras.Delete(i);
    end;

    Result := ListaPalavras.DelimitedText;
  finally
    ListaPalavras.Free;
    PalavrasRemover.Free;
  end;
end;

function TDM.PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I, X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

function TDM.QuebraString(const S: string; const Separator: Char): TStringList;
var
  EndPos, StartPos: Integer;
  Value: string;
begin
  Result := TStringList.Create;
  StartPos := 1;

  repeat
    EndPos := PosEx(Separator, S, StartPos);

    if EndPos > 0 then
    begin
      Result.Add(Trim(Copy(S, StartPos, EndPos - StartPos)));
      StartPos := EndPos + Length(Separator);
    end
    else
    begin
      Value := Trim(Copy(S, StartPos, Length(S)));
      if Value <> '' then
        Result.Add(Value);
    end;
  until EndPos = 0;
end;

procedure TDM.IncNewFieldID(NomeTabela: string; PrimaryKey: TField);
var
  QryINC: TIBQuery;
  DataBase: TIBDatabase;
begin
  DataBase := dbPalavra;

  if PrimaryKey.DataSet.State <> dsInsert then
  begin
    Exit;
  end;
  QryINC := TIBQuery.Create(nil);
  try
    QryINC.Database := DataBase;
    QryINC.SQL.Add('SELECT MAX(CAST(' + PrimaryKey.FieldName + ' AS INT)) AS SYS_ID FROM ' + NomeTabela);
    QryINC.Open;
    if QryINC.Fields[0].IsNull then
    begin
      PrimaryKey.AsInteger := 1;
    end
    else
    begin
      PrimaryKey.AsInteger := QryINC.Fields[0].AsInteger + 1;
    end;
  finally
    FreeAndNil(QryINC);
  end;
end;

function TDM.FormataTexto(const NomeMarca: string): string;
var
  i: Integer;
  Texto: string;
begin
  Texto := '';
  for i := 1 to Length(NomeMarca) do
  begin
    if NomeMarca[i] in ['0'..'9', 'A'..'Z', 'a'..'z', ' '] then
      Texto := Texto + NomeMarca[i];
  end;
  Result := Texto;
end;

function TDM.SelectSingleStr(const DB: TIBDatabase; const TC: TIBTransaction; const cTabela: string; const cCampo: string; const cWhere: string): TResultFunctionDB;
var
  Query: TIBQuery;
begin
  Result.bProcessamentoOk := True;
  Result.bProcOk := True;
  Result.vMsg := '';
  Result.vResultInt := 0;
  Result.vResultStr := '';

  Query := TIBQuery.Create(nil);
  try
    Query.Database := DB;
    Query.Transaction := TC;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT ' + cCampo + ' FROM ' + cTabela);

    if cWhere <> '' then
    begin
      Query.SQL.Add('WHERE ' + cWhere);
    end;

    Query.SQL.Text;
    Query.Open;

    Result.vResultStr := Query.Fields[0].AsString;
    Result.vResultInt := StrToIntDef(Query.Fields[0].AsString, 0);
    if Result.vResultInt <= 0 then
    begin
      Result.vResultInt := 0;
    end;
  finally
    Query.Close;
    Query.Close;
  end;
end;

function TDM.SelectCount(const DB: TIBDatabase; const TC: TIBTransaction; cTabela: string; const cWhere: string): TResultFunctionDB;
var
  Query: TIBQuery;
begin
  Result.bProcessamentoOk := True;
  Result.bProcOk := True;
  Result.vMsg := '';
  Result.vResultInt := 0;
  Result.vResultStr := '';

  Query := TIBQuery.Create(nil);
  try
    Query.Database := DB;
    Query.Transaction := TC;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT COUNT(*) FROM ' + cTabela);

    if cWhere <> '' then
    begin
      Query.SQL.Add('WHERE ' + cWhere);
    end;

    Query.SQL.Text;
    Query.Open;
    Result.vResultInt := Query.Fields[0].AsInteger;
  finally
    Query.Close;
    Query.Close;
  end;
end;

function TDM.SelectMax(const DB: TIBDatabase; const TC: TIBTransaction; const cTabela: string; const cCampo: string; const cWhere: string = ''): TResultFunctionDB;
var
  Query: TIBQuery;
begin
  Result.bProcessamentoOk := True;
  Result.bProcOk := True;
  Result.vMsg := '';
  Result.vResultInt := 0;
  Result.vResultStr := '';

  Query := TIBQuery.Create(nil);
  try
    Query.Database := DB;
    Query.Transaction := TC;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT MAX(' + cCampo + ') FROM ' + cTabela);

    if cWhere <> '' then
    begin
      Query.SQL.Add('WHERE ' + cWhere);
    end;

    Query.Open;

    if StrToIntDef(Query.Fields[0].AsString, 0) > 0 then
    begin
      Result.vResultInt := Query.Fields[0].AsInteger;
    end;
    Result.vResultStr := Query.Fields[0].AsString;
  finally
    Query.Close;
    Query.Close;
  end;
end;

function TDM.ExecutaSQL(const DB: TIBDatabase; const TC: TIBTransaction; const cComandoSQL: string): TResultFunctionDB;
var
  ibSQL: TIBSQL;
begin
  Result.bProcessamentoOk := True;
  Result.bProcOk := True;
  Result.vMsg := '';
  Result.vResultInt := 0;
  Result.vResultStr := '';
  Result.vResultSQLCode := 0;

  ibSQL := TIBSQL.Create(nil);
  try
    ibSQL.Database := DB;
    ibSQL.Transaction := TC;

    ibSQL.Close;
    ibSQL.SQL.Clear;

    if cComandoSQL <> '' then
    begin
      ibSQL.SQL.Add(cComandoSQL);
      dm.IBTPalavra.StartTransaction;
      ibSQL.ExecQuery;
      ibSQL.Transaction.CommitRetaining;
    end;
  finally
    ibSQL.Close;
  end;
end;

function TDM.M(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
var
  vMsgType: TMsgType;
  iNumBotoes: Integer;
  sCaptionBotoes: string;
  vResult: Integer;
  iResultOk: Integer;
  iResultYes: Integer;
  iResultCancel: Integer;
  iResultNo: Integer;
  vHandle: Integer;
begin
  vMsgType := mtInformacao;

  iResultOk := 0;
  iResultYes := 0;
  iResultCancel := 0;
  iResultNo := 0;

  if DlgType = mtInformation then
  begin
    vMsgType := mtInformacao;
  end
  else if DlgType = mtConfirmation then
  begin
    vMsgType := mtConfirmacao;
  end
  else if DlgType = mtWarning then
  begin
    vMsgType := mtAviso;
  end
  else if DlgType = mtError then
  begin
    vMsgType := mtErro;
  end;

  if Buttons = [mbOk] then
  begin
    iNumBotoes := 1;
    sCaptionBotoes := 'O&K';
    iResultOk := 1;
  end
  else if Buttons = [mbYes] then
  begin
    iNumBotoes := 1;
    sCaptionBotoes := '&Sim';
    iResultYes := 1;
  end
  else if Buttons = [mbCancel] then
  begin
    iNumBotoes := 1;
    sCaptionBotoes := '&Cancelar';
    iResultCancel := 1;
  end
  else if Buttons = [mbNo] then
  begin
    iNumBotoes := 1;
    sCaptionBotoes := '&Não';
    iResultNo := 1;
  end
  else if Buttons = [mbOK, mbCancel] then
  begin
    iNumBotoes := 2;
    sCaptionBotoes := 'O&K;&Cancelar';
    iResultOk := 1;
    iResultCancel := 2;
  end
  else if Buttons = [mbYes, mbNo] then
  begin
    iNumBotoes := 2;
    sCaptionBotoes := '&Sim;&Não';
    iResultYes := 1;
    iResultNo := 2;
  end
  else if Buttons = [mbYes, mbNo, mbCancel] then
  begin
    iNumBotoes := 3;
    sCaptionBotoes := '&Sim;&Não;&Cancelar';
    iResultYes := 1;
    iResultNo := 2;
    iResultCancel := 3;
  end
  else
  begin
    Result := DM.FDlgMessage('>>> Erro ao formatar mensagem <<<', mtErro, 1, 'O&K', vHandle);
    exit;
  end;

  vResult := DM.FDlgMessage(Msg, vMsgType, iNumBotoes, sCaptionBotoes, vHandle);

  if vResult = iResultOk then
  begin
    Result := mrOk;
  end
  else if vResult = iResultYes then
  begin
    Result := mrYes;
  end
  else if vResult = iResultCancel then
  begin
    Result := mrCancel;
  end
  else if vResult = iResultNo then
  begin
    Result := mrNo;
  end
  else
  begin
    Result := 0;
  end;
end;

function TDM.FDlgMessage(const cTexto: string; const cMsgType: TMsgType; const cNumBotoes: Integer; const cCaptionBotoes: string; const cHandle: Integer): Integer;
begin
  LockWindowUpdate(cHandle);

  frmMessage := TfrmMessage.Create(Self);

  frmMessage.lblTexto.Caption := cTexto;

  if cNumBotoes <= 0 then
  begin
    frmMessage.btn1.Visible := False;
    frmMessage.btn2.Visible := False;
    frmMessage.btn3.Visible := False;
    frmMessage.btn4.Visible := False;
  end
  else if cNumBotoes = 1 then
  begin
    frmMessage.btn1.Visible := True;
    frmMessage.btn2.Visible := False;
    frmMessage.btn3.Visible := False;
    frmMessage.btn4.Visible := False;

    frmMessage.btn1.Caption := cCaptionBotoes;
  end
  else if cNumBotoes = 2 then
  begin
    frmMessage.btn1.Visible := True;
    frmMessage.btn2.Visible := True;
    frmMessage.btn3.Visible := False;
    frmMessage.btn4.Visible := False;

    frmMessage.btn1.Caption := ObtemCampo(cCaptionBotoes, 1, ';');
    frmMessage.btn2.Caption := ObtemCampo(cCaptionBotoes, 2, ';');
  end
  else if cNumBotoes = 3 then
  begin
    frmMessage.btn1.Visible := True;
    frmMessage.btn2.Visible := True;
    frmMessage.btn3.Visible := True;
    frmMessage.btn4.Visible := False;

    frmMessage.btn1.Caption := ObtemCampo(cCaptionBotoes, 1, ';');
    frmMessage.btn2.Caption := ObtemCampo(cCaptionBotoes, 2, ';');
    frmMessage.btn3.Caption := ObtemCampo(cCaptionBotoes, 3, ';');
  end
  else if cNumBotoes >= 4 then
  begin
    frmMessage.btn1.Visible := True;
    frmMessage.btn2.Visible := True;
    frmMessage.btn3.Visible := True;
    frmMessage.btn4.Visible := True;

    frmMessage.btn1.Caption := ObtemCampo(cCaptionBotoes, 1, ';');
    frmMessage.btn2.Caption := ObtemCampo(cCaptionBotoes, 2, ';');
    frmMessage.btn3.Caption := ObtemCampo(cCaptionBotoes, 3, ';');
    frmMessage.btn4.Caption := ObtemCampo(cCaptionBotoes, 4, ';');
  end;

  if cMsgType = mtErro then
  begin
    frmMessage.Caption := 'Mensagem de Erro';
    frmMessage.lblIcon.Caption := 'X';
    frmMessage.lblIcon.Font.Color := clRed;
    frmMessage.lblIntelectualSys.Font.Color := clRed;
  end
  else if cMsgType = mtInformacao then
  begin
    frmMessage.Caption := 'Mensagem de Informação';
    frmMessage.lblIcon.Caption := 'i';
    frmMessage.lblIcon.Font.Color := clBlue;
    frmMessage.lblIntelectualSys.Font.Color := clNavy;

  end
  else if cMsgType = mtAviso then
  begin
    frmMessage.Caption := 'Mensagem de Aviso';
    frmMessage.lblIcon.Caption := '!';
    frmMessage.lblIcon.Font.Color := clOlive;
    frmMessage.lblIntelectualSys.Font.Color := clBlack;
  end
  else if cMsgType = mtConfirmacao then
  begin
    frmMessage.Caption := 'Mensagem de Confirmação';
    frmMessage.lblIcon.Caption := '?';
    frmMessage.lblIcon.Font.Color := clBlue;
    frmMessage.lblIntelectualSys.Font.Color := clNavy;
  end;

  Result := frmMessage.ShowModal;

  frmMessage.Free;
  frmMessage := nil;

  LockWindowUpdate(0);
end;

function TDM.ObtemCampo(const cLin: string; const cNumCampo: Integer; const cSeparador: string): string;
var
  i: Integer;
  vCampos: array of string;
  l: Integer;
  S: string;
begin
  Result := '';

  l := 0;
  SetLength(vCampos, l);
  S := '';

  for i := 1 to Length(cLin) do
  begin
    if cLin[i] = cSeparador then
    begin
      SetLength(vCampos, l + 1);
      vCampos[l] := S;
      l := l + 1;

      S := '';
    end
    else
    begin
      S := S + cLin[i];
    end;
  end;

  SetLength(vCampos, l + 1);
  vCampos[l] := S;

  if Length(vCampos) >= cNumCampo then
  begin
    Result := vCampos[cNumCampo - 1];
  end;
end;

procedure TDM.AguardeProgresso(const cTexto: string; const cProgressoAtu: Integer; const cProgressoTot: Integer);
begin
//  if cTexto = '' then
//  begin
//    if fAguardeProgresso <> nil then
//    begin
//      fAguardeProgresso.Close;
//    end;
//    exit;
//  end;
//
//  if fAguardeProgresso = nil then
//  begin
//    fAguardeProgresso := TfAguardeProgresso.Create(Self);
//    fAguardeProgresso.Show;
//  end;
//
//  fAguardeProgresso.lblTexto.Caption := cTexto;
//  if cProgressoTot = 0 then
//  begin
//    fAguardeProgresso.cxProgressBar1.Visible := False;
//  end
//  else
//  begin
//    fAguardeProgresso.cxProgressBar1.Properties.Max := cProgressoTot;
//    fAguardeProgresso.cxProgressBar1.Position := cProgressoAtu;
//    fAguardeProgresso.cxProgressBar1.Visible := True;
//  end;
//
//  if fAguardeProgresso.cxProgressBar1.Visible then
//    fAguardeProgresso.Height := 165
//  else
//    fAguardeProgresso.Height := 121;
//
//  fAguardeProgresso.Show;

//  Application.ProcessMessages;
end;
end.

