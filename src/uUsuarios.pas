unit uUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastros, StdCtrls, Mask, DBCtrls, DB, ADODB, ImgList, ActnList,
  Buttons, ExtCtrls, jpeg, Data.FMTBcd, Data.SqlExpr, Datasnap.Provider,
  Datasnap.DBClient;

type
  TFormUsuarios = class(TFormCadastros)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    QDadosUSR_CdiUsuario: TIntegerField;
    QDadosUSR_DssNome: TStringField;
    QDadosUSR_CosEmail: TStringField;
    QDadosUSR_CdsUsuario: TStringField;
    QDadosUSR_CosSenha: TStringField;
    QDadosUSR_OplAtivo: TWordField;
    QDadosUSR_CdiPerfil: TIntegerField;
    QDadosUSR_CdiPessoa: TIntegerField;
    Edit1: TEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEdit9Change(Sender: TObject);
    procedure ACT_PesquisarExecute(Sender: TObject);
    procedure QDadosBeforeDelete(DataSet: TDataSet);
    procedure QDadosBeforePost(DataSet: TDataSet);
    procedure ACT_InserirExecute(Sender: TObject);
    procedure DSDadosStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuarios: TFormUsuarios;

implementation

uses uPesquisa, uDM;

{$R *.dfm}

procedure TFormUsuarios.ACT_InserirExecute(Sender: TObject);
begin
  inherited;
  Edit1.Text := '';
end;

procedure TFormUsuarios.ACT_PesquisarExecute(Sender: TObject);
begin
  //inherited;

  VAR_Select := 'select USR_CdiUsuario, USR_CdsUsuario, USR_OplAtivo, USR_CdiPessoa, USR_DssNome from Usuarios';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'USR_CdiUsuario';
  VAR_TipoRetorno := 'Form';

  //VAR_Tabela := 'Usuarios';
  //VAR_Campos := '*';
  //VAR_Filtro := ' order by USR_CdiUsuario';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Close;
  FormPesquisa.QPesquisas.Connection := TADOQuery(DSDados.DataSet).Connection;
  FormPesquisa.ShowModal;

end;

procedure TFormUsuarios.BitBtn1Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit9);
end;

procedure TFormUsuarios.DBEdit9Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit2);
end;

procedure TFormUsuarios.DSDadosStateChange(Sender: TObject);
begin
  inherited;

  if DSDados.DataSet.State = dsEdit then
    Edit1.Text := FN_Crypt(QDados.FieldByName('USR_CosSenha').AsString,'231287');

  if DSDados.DataSet.State = dsInsert then
    Edit1.Text := '';

  if not (DSDados.DataSet.State in [dsEdit,dsInsert]) then
  begin
    DBEdit6.Visible := True;
    Edit1.Visible := False;
  end else begin
    DBEdit6.Visible := False;
    Edit1.Visible := True;
  end;

end;

procedure TFormUsuarios.QDadosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  with Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('delete from UsuariosxAcessos where UAC_CdiUsuario = :P00');
    Parameters[0].Value := QDados.FieldByName('USR_CdiUsuario').Value;
    ExecSQL
  end;
end;

procedure TFormUsuarios.QDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  QDados.FieldByName('USR_CosSenha').Value := FN_Crypt(Edit1.Text,'231287');
end;

end.
