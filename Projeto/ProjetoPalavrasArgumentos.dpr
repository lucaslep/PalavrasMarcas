program ProjetoPalavrasArgumentos;

uses
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  dmDPA in 'dmDPA.pas' {DM: TDataModule},
  untInicializacao in 'untInicializacao.pas' {frmProcessamento},
  untMarcaSemAcento in 'untMarcaSemAcento.pas' {frmMarcaSemAcento},
  untMensagem in 'untMensagem.pas' {frmMessage},
  untAguardeProgresso in 'untAguardeProgresso.pas' {fAguardeProgresso},
  superobject in 'superobject.pas',
  untFuncs in 'untFuncs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
