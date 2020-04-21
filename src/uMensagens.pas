unit uMensagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TFormMensagens = class(TForm)
    pBotoes: TPanel;
    Image1: TImage;
    imgAlert: TImage;
    lbMensagem: TLabel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    btnSim: TBitBtn;
    btnNao: TBitBtn;
    btnIgnorar: TBitBtn;
    btnRepetir: TBitBtn;
    imgError: TImage;
    imgInformation: TImage;
    imgConfirmation: TImage;
    btnAbortar: TBitBtn;
    btnTodos: TBitBtn;
    btnSimParaTodos: TBitBtn;
    btnNaoParaTodos: TBitBtn;
    btnAjuda: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnFecharClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnRepetirClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnIgnorarClick(Sender: TObject);
    procedure btnAbortarClick(Sender: TObject);
    procedure btnNaoParaTodosClick(Sender: TObject);
    procedure btnSimParaTodosClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);

type
  //Message dialog
  TMsgTipo = (msgAviso, msgErro, msgInformacao, msgConfirmacao);
  TMsgBtn = (btnSim, btnNao, btnOk, btnCancelar, btnAbortar, btnRepetir, btnIgnorar,
            btnTodos, btnNaoParaTodos, btnSimParaTodos, btnAjuda, btnFechar);
  TMsgButtons = set of TMsgBtn;
  //TMsgDlgButtons = set of TMsgBtn;


    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMensagens: TFormMensagens;
  VAR_DssMensagem, VAR_DssTitulo : String;
  VAR_Icones : TMsgDlgType;
  VAR_Botoes : TMsgDlgButtons;
  VAR_BotaoRetorno : Integer = -1;

implementation

{$R *.dfm}

procedure TFormMensagens.btnAbortarClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 4;
  Close;
end;

procedure TFormMensagens.btnAjudaClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 10;
  Close;
end;

procedure TFormMensagens.btnCancelarClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 3;
  Close;
end;

procedure TFormMensagens.btnFecharClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 11;
  Close;
end;

procedure TFormMensagens.btnIgnorarClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 6;
  Close;
end;

procedure TFormMensagens.btnNaoClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 1;
  Close;
end;

procedure TFormMensagens.btnNaoParaTodosClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 8;
  Close;
end;

procedure TFormMensagens.btnOkClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 2;
  Close;
end;

procedure TFormMensagens.btnRepetirClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 5;
  Close;
end;

procedure TFormMensagens.btnSimClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 0;
  Close;
end;

procedure TFormMensagens.btnSimParaTodosClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 9;
  Close;
end;

procedure TFormMensagens.btnTodosClick(Sender: TObject);
begin
  VAR_BotaoRetorno := 7;
  Close;
end;

procedure TFormMensagens.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if VAR_BotaoRetorno = -1 then
    Abort;
end;

procedure TFormMensagens.FormShow(Sender: TObject);
Var
  I : Integer;

begin
  lbMensagem.Caption := VAR_DssMensagem;
  FormMensagens.Caption := '.:: ' + VAR_DssTitulo;

  case VAR_Icones of
    mtWarning       : imgAlert.Visible := True;
    mtError         : imgError.Visible := True;
    mtInformation   : imgInformation.Visible := True;
    mtConfirmation  : imgConfirmation.Visible := True;
    mtCustom        : imgInformation.Visible := True;
  else
    imgInformation.Visible := True;
  end;

  if mbClose   in VAR_Botoes then begin btnFechar.Visible := True;    btnSim.Left := 120 end;
  if mbHelp    in VAR_Botoes then begin btnAjuda.Visible := True;     btnSim.Left := 110 end;
  if mbNoToAll in VAR_Botoes then begin btnNaoParaTodos.Visible := True; btnSim.Left := 90 end;
  if mbYesToAll in VAR_Botoes then begin btnSimParaTodos.Visible := True; btnSim.Left := 100 end;
  if mbAll    in VAR_Botoes then begin  btnTodos.Visible := True;     btnSim.Left := 80 end;
  if mbIgnore in VAR_Botoes then begin  btnIgnorar.Visible := True;   btnSim.Left := 70 end;
  if mbRetry  in VAR_Botoes then begin  btnRepetir.Visible := True;   btnSim.Left := 60 end;
  if mbAbort  in VAR_Botoes then begin  btnAbortar.Visible := True;   btnSim.Left := 50 end;
  if mbCancel in VAR_Botoes then begin  btnCancelar.Visible := True;  btnSim.Left := 40 end;
  if mbOK     in VAR_Botoes then begin  btnOk.Visible := True;        btnSim.Left := 30 end;
  if mbNo     in VAR_Botoes then begin  btnNao.Visible := True;       btnNao.Left := 20 end;
  if mbYes    in VAR_Botoes then begin  btnSim.Visible := True;       btnSim.Left := 10 end;

  FormMensagens.Width := (Length(VAR_DssMensagem) * 8) + 100;

  if FormMensagens.Width > 600 then
  begin
    FormMensagens.Width := 600;
    FormMensagens.Height := round(Length(VAR_DssMensagem)/10) + 150;
    lbMensagem.Height := round(Length(VAR_DssMensagem)/10) + 150;
  end;

if FormMensagens.Width < 300 then
  begin
    FormMensagens.Width := 300;
  end;


end;

end.
