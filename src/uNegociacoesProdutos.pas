unit uNegociacoesProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Data.DB, Data.Win.ADODB,
  Vcl.ImgList, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.DBCtrls;

type
  TFormNegociacoesProdutos = class(TFormCadastros)
    DBEdit2: TDBEdit;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    NEP_CdiProduto: TLabel;
    NEP_VlnQuantidade: TLabel;
    DBEdit5: TDBEdit;
    DBEdit1: TDBEdit;
    NEP_VlnPreco: TLabel;
    DBEdit3: TDBEdit;
    NEP_VlnTotal: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ACT_SalvarExecute(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEdit5Change(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNegociacoesProdutos: TFormNegociacoesProdutos;
  VAR_DssTransacao : String;


implementation

{$R *.dfm}

uses UnitPrincipal, uNegociacoes, uDM;

procedure TFormNegociacoesProdutos.ACT_SalvarExecute(Sender: TObject);
begin
  if DSDados.DataSet.FieldByName('NEP_CdiNegociacaoProduto').IsNull then
    DSDados.DataSet.FieldByName('NEP_CdiNegociacaoProduto').Value := DSDados.DataSet.RecordCount + 1;

    inherited;

end;

procedure TFormNegociacoesProdutos.BitBtn2Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit2);
end;

procedure TFormNegociacoesProdutos.DBEdit2Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit1);
end;

procedure TFormNegociacoesProdutos.DBEdit2Exit(Sender: TObject);
begin
  inherited;
// Seta o campo Nome do Produto
  //if DSDados.DataSet.FieldByName('PRD_DSSPRODUTO').IsNull then
  //begin
    with DM.Query do
    begin
      Connection := QDados.Connection;
      Close;
      SQL.Clear;
      SQL.Add('select PRD_DSSPRODUTO, PRD_COSUNIDADE, PRD_VLNPRECO from PRODUTOS where PRD_CDIPRODUTO = :P00');
      Parameters[0].value := DSDados.DataSet.FieldByName('NEP_CDIPRODUTO').Value;
      Open;

      if RecordCount > 0 then
      begin
        DSDados.DataSet.FieldByName('PRD_DSSPRODUTO').Value := FieldByName('PRD_DSSPRODUTO').AsString;
        DSDados.DataSet.FieldByName('NEP_VLNPRECO').Value := FieldByName('PRD_VLNPRECO').Value;
        //FormNegociacoes.PR_CalcTotais;
        //CDSNegociacoesProdutos.FieldByName('PRD_DSSPRODUTO').Value := FieldByName('PRD_DSSPRODUTO').AsString;
      end;
    end;
  //end;
end;

procedure TFormNegociacoesProdutos.DBEdit5Change(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> EmptyStr then
  begin

    //FormNegociacoes.PR_CalcTotais;
    if (not FormNegociacoes.CDSNegociacoesProdutos.FieldByName('NEP_VLNPRECO').IsNull) then
    begin

      FormNegociacoes.CDSNegociacoesProdutos.FieldByName('NEP_VLNTOTAL').Value := StrToFloat( DBEdit5.Text ) * FormNegociacoes.CDSNegociacoesProdutos.FieldByName('NEP_VLNPRECO').AsFloat
    end;
  end;
end;

procedure TFormNegociacoesProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FormPrincipal.Enabled := True;
end;

procedure TFormNegociacoesProdutos.FormShow(Sender: TObject);
begin
  inherited;
  FormPrincipal.Enabled := False;

  if VAR_DssTransacao = 'Insert' then
    Inserir.Click;

  if VAR_DssTransacao = 'Edit' then
    Editar.Click;

  if VAR_DssTransacao = 'Delete' then
    Apagar.Click;

  if not (FormNegociacoes.DSDados.DataSet.State in [dsInsert,dsEdit]) then
  begin
    Inserir.Enabled := False;
    Editar.Enabled := False;
    Apagar.Enabled := False;
  end;
end;

end.
