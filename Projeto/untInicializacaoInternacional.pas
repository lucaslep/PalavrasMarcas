unit untInicializacaoInternacional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxProgressBar,
  DB, IBDatabase, IBCustomDataSet, IBQuery, Grids, DBClient, DBGrids, ComCtrls,
  IBSQL;

type
  TfrmProcessamentoInt = class(TForm)
    Panel1: TPanel;
    lblTexto: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcessamentoInt: TfrmProcessamentoInt;


implementation

uses
  dmDPA;

{$R *.dfm}



end.

