unit untMensagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmMessage = class(TForm)
    Button1: TButton;
    pnlDados: TPanel;
    pnlBotoes: TPanel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    lblIcon: TLabel;
    lblTexto: TLabel;
    lblIntelectualSys: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    vLblHeightIni: Integer;
    vDlgHeightIni: Integer;
  public
    { Public declarations }
  end;

var
  frmMessage: TfrmMessage;

const
  cHorDistanciaLeft: Integer = 64;
  cHorDistanciaRight: Integer = 64;  

implementation

{$R *.dfm}


procedure TfrmMessage.btn1Click(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TfrmMessage.btn2Click(Sender: TObject);
begin
   ModalResult := 2;
end;

procedure TfrmMessage.btn3Click(Sender: TObject);
begin
  ModalResult := 3;
end;

procedure TfrmMessage.btn4Click(Sender: TObject);
begin
  ModalResult := 4;
end;

procedure TfrmMessage.FormShow(Sender: TObject);
var
  iNumBotoes: Integer;
  vSeparaBotoes: Integer;
  texto: string;
  edt: TEdit;
begin
  if btn4.Visible = True then begin
    btn4.SetFocus;
  end else if btn3.Visible = True then begin
    btn3.SetFocus;
  end else if btn2.Visible = True then begin
    btn2.SetFocus;
  end else if btn1.Visible = True then begin
    btn1.SetFocus;
  end;

  lblTexto.WordWrap := False;
  if lblTexto.Width >= lblTexto.Constraints.MaxWidth then begin
    lblTexto.WordWrap := True;
  end;
  texto := Copy(lblTexto.Caption, 0, 18);
  if texto = 'Mensagem recebida!' then
  begin
    Button1.SetFocus;
  end;

  //* Tamanho vertical do form

  if lblTexto.Height > vLblHeightIni then begin
    Height := vDlgHeightIni + (((lblTexto.Height div vLblHeightIni) - 1) * vLblHeightIni);
  end;

  //* Tamanho horizontal do form

  if (lblTexto.Width + cHorDistanciaLeft + cHorDistanciaRight) > Width then begin
    Width := cHorDistanciaLeft + lblTexto.Width + cHorDistanciaRight;
  end;

  lblIntelectualSys.Left := (pnlDados.Width div 2) - (lblIntelectualSys.Width div 2);

  //* Reposiciona botões
  iNumBotoes := 0;
  if btn1.Visible = True then begin
    iNumBotoes := iNumBotoes + 1;
  end;
  if btn2.Visible = True then begin
    iNumBotoes := iNumBotoes + 1;
  end;
  if btn3.Visible = True then begin
    iNumBotoes := iNumBotoes + 1;
  end;
  if btn4.Visible = True then begin
    iNumBotoes := iNumBotoes + 1;
  end;

  vSeparaBotoes := (pnlBotoes.Width - (iNumBotoes * btn1.Width)) div (iNumBotoes + 1);

  if iNumBotoes = 1 then begin
    //* Obs.: Rotina para 1 botão
    btn1.Left := (pnlBotoes.Width div 2) - (btn1.Width div 2);
  end else if iNumBotoes = 2 then begin
    //* Obs.: Rotina para 2 botões
    btn1.Left := vSeparaBotoes;
    btn2.Left := pnlBotoes.Width - btn2.Width - vSeparaBotoes;
  end else if iNumBotoes = 3 then begin
    //* Obs.: Rotina para 3 botões
    btn1.Left := vSeparaBotoes;
    btn2.Left := btn1.Left + btn1.Width + vSeparaBotoes;
    btn3.Left := pnlBotoes.Width - btn2.Width - vSeparaBotoes;
  end else if iNumBotoes = 4 then begin
    //* Obs.: Rotina para 4 botões
    btn1.Left := vSeparaBotoes;
    btn2.Left := btn1.Left + btn1.Width + vSeparaBotoes;
    btn3.Left := btn2.Left + btn2.Width + vSeparaBotoes;
    btn4.Left := pnlBotoes.Width - btn4.Width - vSeparaBotoes;
  end;

  if (btn1.Caption = 'O&K') or
    (btn1.Caption = 'OK') or
    (btn1.Caption = '&Sim') or
    (btn1.Caption = 'Sim') then begin
    btn1.NumGlyphs := 1;
    btn1.Glyph := btnOk.Glyph;
  end else if (btn1.Caption = '&Cancelar') or
    (btn1.Caption = 'Cancelar') or
    (btn1.Caption = '&Não') or
    (btn1.Caption = 'Não') then begin
    btn1.NumGlyphs := 2;
    btn1.Glyph := btnCancel.Glyph;
  end;

  if (btn2.Caption = 'O&K') or
    (btn2.Caption = 'OK') or
    (btn2.Caption = '&Sim') or
    (btn2.Caption = 'Sim') then begin
    btn2.NumGlyphs := 1;
    btn2.Glyph := btnOk.Glyph;
  end else if (btn2.Caption = '&Cancelar') or
    (btn2.Caption = 'Cancelar') or
    (btn2.Caption = '&Não') or
    (btn2.Caption = 'Não') then begin
    btn2.NumGlyphs := 2;
    btn2.Glyph := btnCancel.Glyph;
  end;

  if (btn3.Caption = 'O&K') or
    (btn3.Caption = 'OK') or
    (btn3.Caption = '&Sim') or
    (btn3.Caption = 'Sim') then begin
    btn3.NumGlyphs := 1;
    btn3.Glyph := btnOk.Glyph;
  end else if (btn3.Caption = '&Cancelar') or
    (btn3.Caption = 'Cancelar') or
    (btn3.Caption = '&Não') or
    (btn3.Caption = 'Não') then begin
    btn3.NumGlyphs := 2;
    btn3.Glyph := btnCancel.Glyph;
  end;

  if (btn4.Caption = 'O&K') or
    (btn4.Caption = 'OK') or
    (btn4.Caption = '&Sim') or
    (btn4.Caption = 'Sim') then begin
    btn4.NumGlyphs := 1;
    btn4.Glyph := btnOk.Glyph;
  end else if (btn4.Caption = '&Cancelar') or
    (btn4.Caption = 'Cancelar') or
    (btn4.Caption = '&Não') or
    (btn4.Caption = 'Não') then begin
    btn4.NumGlyphs := 2;
    btn4.Glyph := btnCancel.Glyph;
  end;
end;

procedure TfrmMessage.FormCreate(Sender: TObject);
begin
  vLblHeightIni := lblTexto.Height;
  vDlgHeightIni := lblTexto.Height;

  lblTexto.Left := (ClientWidth div 4) - (lblTexto.Width div 4);
  lblTexto.Top := (ClientHeight div 3) - (lblTexto.Height div 3);
end;
end.
