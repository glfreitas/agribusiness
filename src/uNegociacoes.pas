unit uNegociacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Data.DB, Data.Win.ADODB,
  Vcl.ImgList, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  Datasnap.DBClient, Datasnap.Provider;

type
  TFormNegociacoes = class(TFormCadastros)
    NEG_CDINEGOCIACAO: TLabel;
    DBEdit1: TDBEdit;
    NEG_CDIPRODUTOR: TLabel;
    DBEdit2: TDBEdit;
    NEG_CDIDISTRIBUIDOR: TLabel;
    DBEdit3: TDBEdit;
    NEG_CDISTATUSNEGOCIACAO: TLabel;
    DBEdit4: TDBEdit;
    NEG_DTDEMISSAO: TLabel;
    DBEdit5: TDBEdit;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    btnInserirDetalhe: TBitBtn;
    btnEditarDetalhe: TBitBtn;
    btnExcluirDetalhe: TBitBtn;
    btnConsultarDetalhe: TBitBtn;
    pTotais: TPanel;
    QDadosNEG_CDINEGOCIACAO: TIntegerField;
    QDadosNEG_CDIPRODUTOR: TIntegerField;
    QDadosNEG_CDIDISTRIBUIDOR: TIntegerField;
    QDadosNEG_CDISTATUSNEGOCIACAO: TIntegerField;
    QDadosNEG_DTDEMISSAO: TDateField;
    DSPDados: TDataSetProvider;
    CDSDados: TClientDataSet;
    CDSDadosNEG_CDINEGOCIACAO: TIntegerField;
    CDSDadosNEG_CDIPRODUTOR: TIntegerField;
    CDSDadosNEG_CDIDISTRIBUIDOR: TIntegerField;
    CDSDadosNEG_CDISTATUSNEGOCIACAO: TIntegerField;
    CDSDadosNEG_DTDEMISSAO: TDateField;
    DSNegociacoes: TDataSource;
    QNegociacoesProdutos: TADOQuery;
    QNegociacoesProdutosNEP_CDINEGOCIACAOPRODUTO: TIntegerField;
    QNegociacoesProdutosNEP_CDINEGOCIACAO: TIntegerField;
    QNegociacoesProdutosNEP_CDIPRODUTO: TIntegerField;
    QNegociacoesProdutosNEP_VLNQUANTIDADE: TBCDField;
    QNegociacoesProdutosNEP_VLNPRECO: TBCDField;
    QNegociacoesProdutosNEP_VLNTOTAL: TBCDField;
    CDSDadosQNegociacoesProdutos: TDataSetField;
    CDSNegociacoesProdutos: TClientDataSet;
    DSNegociacoesProdutos: TDataSource;
    CDSNegociacoesProdutosPRD_DSSPRODUTO: TStringField;
    CDSNegociacoesProdutosNEP_CDINEGOCIACAOPRODUTO: TIntegerField;
    CDSNegociacoesProdutosNEP_CDINEGOCIACAO: TIntegerField;
    CDSNegociacoesProdutosNEP_CDIPRODUTO: TIntegerField;
    CDSNegociacoesProdutosNEP_VLNQUANTIDADE: TBCDField;
    CDSNegociacoesProdutosNEP_VLNPRECO: TBCDField;
    CDSNegociacoesProdutosNEP_VLNTOTAL: TBCDField;
    CDSDadosSTN_DSSSTATUSNEGOCIACAO: TStringField;
    procedure PR_CalcTotais;
    procedure PR_StatusBotoesDetalhe;
    procedure ACT_SalvarExecute(Sender: TObject);
    procedure ACT_InserirExecute(Sender: TObject);
    procedure ACT_EditarExecute(Sender: TObject);
    procedure ACT_ExcluirExecute(Sender: TObject);
    procedure ACT_CancelarExecute(Sender: TObject);
    procedure btnInserirDetalheClick(Sender: TObject);
    procedure btnEditarDetalheClick(Sender: TObject);
    procedure btnExcluirDetalheClick(Sender: TObject);
    procedure btnConsultarDetalheClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure QDadosAfterOpen(DataSet: TDataSet);
    procedure QDadosBeforeClose(DataSet: TDataSet);
    procedure ADODataSet1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure FormShow(Sender: TObject);
    procedure CDSDadosBeforePost(DataSet: TDataSet);
    procedure DSPDadosBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure CDSNegociacoesProdutosCalcFields(DataSet: TDataSet);
    procedure CDSDadosCalcFields(DataSet: TDataSet);
    procedure DBEdit4Change(Sender: TObject);
    procedure ACT_PesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNegociacoes: TFormNegociacoes;

implementation

{$R *.dfm}

uses uDM, uNegociacoesProdutos, uPesquisa;

procedure TFormNegociacoes.PR_CalcTotais;
begin
  if CDSNegociacoesProdutos.State in [dsInsert, dsEdit] then
  begin
    if (not CDSNegociacoesProdutos.FieldByName('NEP_VLNQUANTIDADE').IsNull) and (not CDSNegociacoesProdutos.FieldByName('NEP_VLNPRECO').IsNull) then
    begin
      CDSNegociacoesProdutos.FieldByName('NEP_VLNTOTAL').Value := CDSNegociacoesProdutos.FieldByName('NEP_VLNQUANTIDADE').Value * CDSNegociacoesProdutos.FieldByName('NEP_VLNPRECO').Value;
    end;
  end;
end;

procedure TFormNegociacoes.PR_StatusBotoesDetalhe;
begin
  if DSDados.DataSet.State in [dsEdit,dsInsert] then
  begin
    btnInserirDetalhe.Enabled := True;
    btnEditarDetalhe.Enabled := True;
    btnExcluirDetalhe.Enabled := True;
  end else begin
    btnInserirDetalhe.Enabled := False;
    btnEditarDetalhe.Enabled := False;
    btnExcluirDetalhe.Enabled := False;
  end;
end;

procedure TFormNegociacoes.QDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CDSDados.Active := True;
  QNegociacoesProdutos.Active := True;
  CDSNegociacoesProdutos.Active := True;
end;

procedure TFormNegociacoes.QDadosBeforeClose(DataSet: TDataSet);
begin
  inherited;
  CDSDados.Active := False;
  QNegociacoesProdutos.Active := False;
  CDSNegociacoesProdutos.Active := False;
end;

procedure TFormNegociacoes.ACT_CancelarExecute(Sender: TObject);
begin
  inherited;
  //CDSNegociacoesProdutos.CancelUpdates;
  //CdsDados.CancelUpdates;

  PR_StatusBotoesDetalhe;
end;

procedure TFormNegociacoes.ACT_EditarExecute(Sender: TObject);
begin
  inherited;

  PR_StatusBotoesDetalhe;

end;

procedure TFormNegociacoes.ACT_ExcluirExecute(Sender: TObject);
begin
  inherited;
  CdsDados.ApplyUpdates(0);
end;

procedure TFormNegociacoes.ACT_InserirExecute(Sender: TObject);
begin
  inherited;
  DSDados.DataSet.FieldByName('NEG_DTDEMISSAO').AsDateTime := Date;
  DBEdit5.SetFocus;

  PR_StatusBotoesDetalhe;
end;

procedure TFormNegociacoes.ACT_PesquisarExecute(Sender: TObject);
begin
  inherited;
  {
  VAR_Select := 'SELECT  ';
  VAR_Select := VAR_Select + ' NEG_CDINEGOCIACAO, NEG_DTDEMISSAO, STN_CDISTATUSNEGOCIACAO, STN_DSSSTATUSNEGOCIACAO, ';
  VAR_Select := VAR_Select + ' PRO_CDIPRODUTOR, PRO_DSSNOMEPRODUTOR, PRO_COSTIPOPESSOA, PRO_COSCPF, PRO_COSCNPJ, ';
  VAR_Select := VAR_Select + ' DIS_CDIDISTRIBUIDOR, DIS_DSSNOMEDISTRIBUIDOR, DIS_COSCNPJ, ';
  VAR_Select := VAR_Select + ' (SELECT SUM(NEP_VLNTOTAL) AS NEP_VLNTOTAL FROM NEGOCIACOESPRODUTOS WHERE NEP_CDINEGOCIACAO = NEG_CDINEGOCIACAO) AS NEP_VLNTOTAL FROM NEGOCIACOES ';
  VAR_Select := VAR_Select + ' JOIN PRODUTORES ON PRO_CDIPRODUTOR = NEG_CDIPRODUTOR ';
  VAR_Select := VAR_Select + ' JOIN DISTRIBUIDORES ON DIS_CDIDISTRIBUIDOR = NEG_CDIDISTRIBUIDOR ';
  VAR_Select := VAR_Select + ' JOIN STATUSNEGOCIACOES ON STN_CDISTATUSNEGOCIACAO = NEG_CDISTATUSNEGOCIACAO ';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'NEG_CDINEGOCIACAO';
  VAR_TipoRetorno := 'Form';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Close;
  FormPesquisa.QPesquisas.Connection := QDados.Connection;
  FormPesquisa.ShowModal;
  }
end;

procedure TFormNegociacoes.ACT_SalvarExecute(Sender: TObject);
begin
{
  if CDSNegociacoesProdutos.RecordCount = 0 then
  begin
    FN_Mensagem('Não existe nenhum produto inserido, por favor informe ao menos um produto para esta negociação!','Atenção',mtInformation,[mbOK]);
    Abort;
  end;
 }
  inherited;
  CDSDados.ApplyUpdates(0);

  //CDSNegociacoesProdutos.First;

  PR_StatusBotoesDetalhe;
end;

procedure TFormNegociacoes.ADODataSet1PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  ShowMessage(e.ToString);
end;

procedure TFormNegociacoes.BitBtn1Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit3);
end;

procedure TFormNegociacoes.BitBtn2Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit2);
end;

procedure TFormNegociacoes.btnConsultarDetalheClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFormNegociacoesProdutos,FormNegociacoesProdutos);
  FormNegociacoesProdutos.DSDados.DataSet := CDSNegociacoesProdutos;
  VAR_DssTransacao := 'Show';
  FormNegociacoesProdutos.ShowModal;
end;

procedure TFormNegociacoes.btnEditarDetalheClick(Sender: TObject);
Var
  I : Integer;
begin
  inherited;

  for I := 0 to TDataSource(DSDados).DataSet.FieldCount - 1 do
  begin
    if (TDataSource(DSDados).DataSet.Fields[I].Required) and (TDataSource(DSDados).DataSet.Fields[I].IsNull) then
    begin
      FN_Mensagem('O campo "'+TDataSource(DSDados).DataSet.Fields[I].DisplayLabel+'" é obrigatório e deve ser preenchido!','Atenção',mtInformation,[mbOK]);
      Abort;
    end;
  end;

  Application.CreateForm(TFormNegociacoesProdutos,FormNegociacoesProdutos);
  FormNegociacoesProdutos.DSDados.DataSet := CDSNegociacoesProdutos;
  VAR_DssTransacao := 'Edit';
  FormNegociacoesProdutos.ShowModal;
  //FormNegociacoesProdutos.Editar.Click;
end;

procedure TFormNegociacoes.btnExcluirDetalheClick(Sender: TObject);
Var
  I : Integer;
begin
  inherited;
  for I := 0 to TDataSource(DSDados).DataSet.FieldCount - 1 do
  begin
    if (TDataSource(DSDados).DataSet.Fields[I].Required) and (TDataSource(DSDados).DataSet.Fields[I].IsNull) then
    begin
      FN_Mensagem('O campo "'+TDataSource(DSDados).DataSet.Fields[I].DisplayLabel+'" é obrigatório e deve ser preenchido!','Atenção',mtInformation,[mbOK]);
      Abort;
    end;
  end;
  Application.CreateForm(TFormNegociacoesProdutos,FormNegociacoesProdutos);
  FormNegociacoesProdutos.DSDados.DataSet := CDSNegociacoesProdutos;
  VAR_DssTransacao := 'Delete';
  FormNegociacoesProdutos.ShowModal;
  //FormNegociacoesProdutos.Apagar.Click;
end;

procedure TFormNegociacoes.btnInserirDetalheClick(Sender: TObject);
Var
  I : Integer;
begin
  inherited;

  for I := 0 to TDataSource(DSDados).DataSet.FieldCount - 1 do
  begin
    if (TDataSource(DSDados).DataSet.Fields[I].Required) and (TDataSource(DSDados).DataSet.Fields[I].IsNull) then
    begin
      FN_Mensagem('O campo "'+TDataSource(DSDados).DataSet.Fields[I].DisplayLabel+'" é obrigatório e deve ser preenchido!','Atenção',mtInformation,[mbOK]);
      Abort;
    end;
  end;

  Application.CreateForm(TFormNegociacoesProdutos,FormNegociacoesProdutos);
  FormNegociacoesProdutos.DSDados.DataSet := CDSNegociacoesProdutos;
  //FormNegociacoesProdutos.Inserir.Click;
  VAR_DssTransacao := 'Insert';
  FormNegociacoesProdutos.ShowModal;
end;

procedure TFormNegociacoes.CDSDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  CDSDados.FieldByName('NEG_CDISTATUSNEGOCIACAO').Value := 1; //Status Pendente
end;

procedure TFormNegociacoes.CDSDadosCalcFields(DataSet: TDataSet);
begin
  inherited;
  if CDSDados.State = dsCalcFields then
  begin
    // Seta o campo Status
    if CDSDados.FieldByName('STN_DSSSTATUSNEGOCIACAO').IsNull then
    begin
      with DM.Query do
      begin
        Connection := QDados.Connection;
        Close;
        SQL.Clear;
        SQL.Add('select STN_CDISTATUSNEGOCIACAO, STN_DSSSTATUSNEGOCIACAO from STATUSNEGOCIACOES where STN_CDISTATUSNEGOCIACAO = :P00');
        Parameters[0].value := CDSDados.FieldByName('NEG_CDISTATUSNEGOCIACAO').Value;
        Open;

        if RecordCount > 0 then
        begin
          if CDSDados.FieldByName('STN_DSSSTATUSNEGOCIACAO').CanModify then
          begin
            CDSDados.FieldByName('STN_DSSSTATUSNEGOCIACAO').Value := FieldByName('STN_DSSSTATUSNEGOCIACAO').AsString;
          //PR_CalcTotais;
          //CDSNegociacoesProdutos.FieldByName('PRD_DSSPRODUTO').Value := FieldByName('PRD_DSSPRODUTO').AsString;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormNegociacoes.CDSNegociacoesProdutosCalcFields(DataSet: TDataSet);
var
  cds : TClientDataSet;
  valor : double;
begin
  inherited;
  if CDSNegociacoesProdutos.State = dsCalcFields then
  begin
    // Seta o campo Nome do Produto
    if CDSNegociacoesProdutos.FieldByName('PRD_DSSPRODUTO').IsNull then
    begin
      with DM.Query do
      begin
        Connection := QDados.Connection;
        Close;
        SQL.Clear;
        SQL.Add('select PRD_DSSPRODUTO, PRD_COSUNIDADE, PRD_VLNPRECO from PRODUTOS where PRD_CDIPRODUTO = :P00');
        Parameters[0].value := CDSNegociacoesProdutos.FieldByName('NEP_CDIPRODUTO').Value;
        Open;

        if RecordCount > 0 then
        begin
          CDSNegociacoesProdutos.FieldByName('PRD_DSSPRODUTO').Value := FieldByName('PRD_DSSPRODUTO').AsString;
          CDSNegociacoesProdutos.FieldByName('NEP_VLNPRECO').Value := FieldByName('PRD_VLNPRECO').Value;
          //PR_CalcTotais;
          //CDSNegociacoesProdutos.FieldByName('PRD_DSSPRODUTO').Value := FieldByName('PRD_DSSPRODUTO').AsString;
        end;
      end;
    end;
    {
    cds := TClientDataSet.Create(self);
    cds.CloneCursor(CDSNegociacoesProdutos, False, False);
    //cds := CDSNegociacoesProdutos;
    cds.First;
    while not cds.Eof do
    begin
      valor := valor + cds.FieldByName('NEP_VLNTOTAL').Value;
      cds.Next;
    end;
    pTotais.Caption := FormatFloat('#,0.00',valor);
    cds.Free;
    }
  end;
end;

procedure TFormNegociacoes.DBEdit2Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit1);
end;

procedure TFormNegociacoes.DBEdit3Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit2);
end;

procedure TFormNegociacoes.DBEdit4Change(Sender: TObject);
begin
  inherited;

  if TDBEdit(Sender).Text = 'Pendente' then
  begin
     TDBEdit(Sender).Color := clGradientInactiveCaption;
  end;

  if TDBEdit(Sender).Text = 'Aprovada' then
  begin
     TDBEdit(Sender).Color := clMoneyGreen;
  end;

  if TDBEdit(Sender).Text = 'Concluida' then
  begin
     TDBEdit(Sender).Color := clSilver;
  end;

  if TDBEdit(Sender).Text = 'Cancelada' then
  begin
     TDBEdit(Sender).Color := clRed;
  end;
end;

procedure TFormNegociacoes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  PR_PersonalizaGrid(TDBGrid(Sender), Rect, DataCol, Column, State);
end;

procedure TFormNegociacoes.DSPDadosBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
  inherited;
  // Verifica se o Dataset é o QItens
  if (SourceDS = QNegociacoesProdutos) then
  begin
    // Verifica se a transação é de Insert
    if UpdateKind = ukInsert then
    begin
      // Geração automatica dos campos chaves das tabelas
      if DeltaDS.FieldByName('NEP_CDINEGOCIACAO').IsNull then
      begin
        DeltaDS.FieldByName('NEP_CDINEGOCIACAO').NewValue := CdsDados.FieldByName('NEG_CDINEGOCIACAO').Value;
        DeltaDS.FieldByName('NEP_CDINEGOCIACAOPRODUTO').NewValue := FN_Maximo('NEGOCIACOESPRODUTOS','NEP_CDINEGOCIACAOPRODUTO',QDados.Connection);
      end;
    end;
  end;
end;

procedure TFormNegociacoes.FormShow(Sender: TObject);
begin
  inherited;
  QDados.Open
end;

end.
