unit UnitLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Tabs, DB, ADODB, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  TFormLogin = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    edtNovaSenha: TEdit;
    edtConfirmacaoSenha: TEdit;
    btnAlterarSenha: TBitBtn;
    btnCancelarAlteracao: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAlterarSenhaClick(Sender: TObject);
    procedure btnCancelarAlteracaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;
  VAR_IdUsuario : Integer;

implementation

uses uDM, UnitPrincipal, uAcessos;

{$R *.dfm}

procedure TFormLogin.BitBtn1Click(Sender: TObject);
begin

  with DM.SQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select USR_CdiUsuario, USR_OplAtivo from Usuarios ');
    //SQL.Add('left join Perfis on PER_CdiPerfil = USR_CdiPerfil ');
    //SQL.Add('left join Pessoas on PES_CdiPessoa = USR_CdiPessoa ');
    SQL.Add('where USR_CdsUsuario = :P1 and USR_CosSenha = :P2 ');
    Parameters[0].Value := edtUsuario.Text;
    Parameters[1].Value := FN_Crypt(edtSenha.Text,'231287');
    Open;
    First;
    if not Eof then
    begin
      if FieldByName('USR_OplAtivo').AsInteger = 0 then
      begin
        //MessageDlg('Usuário Inativo!!!',mtInformation,[mbOK],1);
        FN_Mensagem('Usuário Inativo!!!','Atenção',mtConfirmation,[mbOK]);
        Abort;

      end;

      // Chama função para carregar as variáveis globais para o usuario conectado
      FN_GetUsuarioConetado(FieldByName('USR_CdiUsuario').AsInteger);

      // Cadastra novos menus
      PR_Menus(FormPrincipal.ActionManager);
      // Define acessos do usuario logado
      PR_Acessos(FormPrincipal.ActionManager,VAR_CdiUsuarioConectado);
      // Nome do usuario logado no statusbar
      FormPrincipal.StatusBar1.Panels[1].Text := 'Usuario: '+VAR_DssUsuarioConectado;
      FormPrincipal.StatusBar1.Panels[2].Text := 'Perfil: '+VAR_DssPerfilCorrente;
      FormLogin.Close;
    end else begin
      FN_Mensagem('Usuário ou senha informados estão incorretos ou não exitem!!!','Atenção',mtConfirmation,[mbOK]);
      //MessageDlg('Usuário ou senha informados estão incorretos ou não exitem!!!',mtInformation,[mbOK],1);
    end;
  end;
end;

procedure TFormLogin.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormLogin.BitBtn3Click(Sender: TObject);
begin

  if (edtUsuario.Text <> EmptyStr) and (edtSenha.Text <> EmptyStr) then
  begin
    with DM.SQL do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from Usuarios ');
      SQL.Add('where USR_CdsUsuario = :P0 ');
      SQL.Add(' and USR_CosSenha = :P1');
      Parameters[0].Value := edtUsuario.Text;
      Parameters[1].Value := FN_Crypt(edtSenha.Text,'231287');
      Open;

      if RecordCount > 0 then
      begin

        if FieldByName('USR_OplAtivo').AsInteger = 0 then
        begin
          FN_Mensagem('Usuário Inativo!!!','Atenção',mtConfirmation,[mbOK]);
          //MessageDlg('Usuário Inativo!!!',mtInformation,[mbOK],1);
          Abort;
        end;

        VAR_IdUsuario := FieldByName('USR_CdiUsuario').AsInteger;

        FormLogin.Height := 370;
        BitBtn1.Visible := False;
        BitBtn2.Visible := False;
        BitBtn3.Visible := False;

        btnAlterarSenha.Visible := True;
        btnCancelarAlteracao.Visible := True;
        edtNovaSenha.Visible := True;
        edtConfirmacaoSenha.Visible := True;

        edtNovaSenha.Clear;
        edtConfirmacaoSenha.Clear;
        edtNovaSenha.SetFocus;

      end else begin
        FN_Mensagem('O Usuário ou a senha informados estão incorretos!','Atenção',mtConfirmation,[mbOK]);
        //MessageDlg('O Usuário ou a senha informados estão incorretos!',mtInformation,[mbOK],1);
      end;
    end;
  end else begin
    FN_Mensagem('Informe corretamente o usuário e a senha para alteração!','Atenção',mtConfirmation,[mbOK]);
    //MessageDlg('Informe corretamente o usuário e a senha para alteração!',mtInformation,[mbOK],1);
  end;
end;

procedure TFormLogin.btnAlterarSenhaClick(Sender: TObject);
begin

  if edtNovaSenha.Text = edtConfirmacaoSenha.Text then
  begin
    with DM.SQL do
    begin
      Close;
      //Connection := DM.Conexao;
      SQl.Clear;
      SQL.Add('update Usuarios set USR_CosSenha = :P1 where USR_CdiUsuario = :P2');
      Parameters[0].Value := FN_Crypt(edtNovaSenha.Text,'231287');
      Parameters[1].Value := VAR_IdUsuario;
      ExecSQL;
    end;
  end else begin
    FN_Mensagem('A nova senha e a confirmação de nova senha devem ser iguais!','Atenção',mtConfirmation,[mbOK]);
    //MessageDlg('A nova senha e a confirmação de nova senha devem ser iguais!',mtInformation,[mbOK],1);
  end;

  FN_Mensagem('Sua senha foi alterada!','Atenção',mtConfirmation,[mbOK]);
  //MessageDlg('Sua senha foi alterada!',mtInformation,[mbOK],1);

  edtSenha.Text := edtNovaSenha.Text;

  FormLogin.Height := 275;
  BitBtn1.Visible := True;
  BitBtn2.Visible := True;
  BitBtn3.Visible := True;
  edtNovaSenha.Clear;
  edtConfirmacaoSenha.Clear;

end;

procedure TFormLogin.btnCancelarAlteracaoClick(Sender: TObject);
begin
  FormLogin.Height := 275;
  BitBtn1.Visible := True;
  BitBtn2.Visible := True;
  BitBtn3.Visible := True;
end;

procedure TFormLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (edtSenha.Text <> EmptyStr) then
  begin
    BitBtn1.Click;
  end;
end;

procedure TFormLogin.edtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (edtUsuario.Text <> EmptyStr) then
  begin
    edtSenha.SetFocus;
  end;
end;

procedure TFormLogin.FormActivate(Sender: TObject);
begin
  edtUsuario.SetFocus;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if VAR_CdiUsuarioConectado = -1 then
    Abort;
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  FormLogin.Height := 275;
  btnAlterarSenha.Visible := False;
  btnCancelarAlteracao.Visible := False;
  edtNovaSenha.Visible := False;
  edtConfirmacaoSenha.Visible := False;
  VAR_CdiUsuarioConectado := -1;
  edtUsuario.Text := 'admin';
  edtSenha.Text := '102030';
end;

end.
