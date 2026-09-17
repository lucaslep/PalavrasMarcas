unit untMarcaSemAcento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxProgressBar,
  DB, IBDatabase, IBCustomDataSet, IBQuery, Grids, DBClient, DBGrids, ComCtrls,
  IBSQL;

type
  TfrmMarcaSemAcento = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    lblTexto: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    procedure InsereMarcasSemAcento();
    procedure PosicaoProgressBar(Posicao: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMarcaSemAcento: TfrmMarcaSemAcento;

implementation

uses dmDPA;

{$R *.dfm}

procedure TfrmMarcaSemAcento.InsereMarcasSemAcento();
var
  Query: TIBQuery;
  CmdSQL: string;
  qtdPedaco: Integer;
  ValorIni, ValorMax: Integer;
begin
  Query := TIBQuery.Create(nil);
  Query.Database := dm.dbCarga;
  Query.Transaction := dm.IBTCarga;

  CmdSQL :=
    'UPDATE marcas ' + #13 +
    'SET marca_sem_acento = '''' ' + #13 +
    'WHERE marca_sem_acento IS NOT NULL';

  Query.SQL.Text := CmdSQL;
  Query.ExecSQL;
  Query.Transaction.CommitRetaining;

  qtdPedaco := 100000;
  ValorIni := 0;

  ValorMax := DM.SelectMax(dm.dbCarga, dm.IBTCarga, 'MARCAS', 'COD_MARCA', 'COD_MARCA > 0').vResultInt + qtdPedaco;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ValorMax;
  while ValorIni <= ValorMax do
  begin
    CmdSQL :=
      'UPDATE marcas ' + #13 +
      'SET marca_sem_acento = DLL_TIRA_ACENTOS(marca) ' + #13 +
      'WHERE cod_marca >= ' + IntToStr(ValorIni) + #13 +
      'AND cod_marca <= ' + IntToStr(ValorIni + qtdPedaco);

    Query.SQL.Text := CmdSQL;
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;

    CmdSQL :=
      'UPDATE processos_ma SET pedido_registro = ''R'' ' + #13 +
      'WHERE (pedido_registro = '' '' OR pedido_registro IS NULL) ' + #13 +
      'AND data_concessao > ''1900-01-01''';

    Query.SQL.Text := CmdSQL;
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;

    CmdSQL :=
      'UPDATE processos_ma SET pedido_registro = ''P'' ' + #13 +
      'WHERE (pedido_registro = '' '' OR pedido_registro IS NULL) ' + #13 +
      'AND data_concessao IS NULL';

    Query.SQL.Text := CmdSQL;
    Query.ExecSQL;
    Query.Transaction.CommitRetaining;

    ValorIni := ValorIni + qtdPedaco;
    ProgressBar1.Position := ValorIni;
  end;
end;

procedure TfrmMarcaSemAcento.Button1Click(Sender: TObject);
begin
  Button1.Caption := 'Processando...';
  Button1.Enabled := False;
  InsereMarcasSemAcento();
end;

procedure TfrmMarcaSemAcento.PosicaoProgressBar(Posicao: Integer);
begin
  ProgressBar1.Position := Posicao;
  Application.ProcessMessages;
end;
end.

