unit uLimitesProdsxDists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Data.DB, Data.Win.ADODB,
  Vcl.ImgList, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TFormLimitesProdsxDists = class(TFormCadastros)
    TreeViewProdutores: TTreeView;
    QTreeView: TADOQuery;
    ILTree: TImageList;
    QDadosLPD_CDILIMITEPRODXDIST: TIntegerField;
    QDadosLPD_CDIPRODUTOR: TIntegerField;
    QDadosLPD_CDIDISTRIBUIDOR: TIntegerField;
    QDadosLPD_VLNVALORLIMITE: TBCDField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    QDadosDIS_DssNomeDistribuidor: TStringField;
    pSelecao: TPanel;
    procedure ACT_PesquisarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure QDadosBeforePost(DataSet: TDataSet);
    procedure QDadosCalcFields(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TreeViewProdutoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLimitesProdsxDists: TFormLimitesProdsxDists;
  VAR_CdiProdutor : Integer = 0;

implementation

{$R *.dfm}

uses uPesquisa, uDM;

procedure TFormLimitesProdsxDists.ACT_PesquisarExecute(Sender: TObject);
begin
  inherited;
  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'LPD_CdiLimiteProdxDist';
  VAR_TipoRetorno := 'Form';

  VAR_Tabela := 'LimitesProdsxDists';
  VAR_Campos := '*';
  VAR_Filtro := ' and LPD_CdiProdutor = '+inttoStr(Integer(TreeViewProdutores.Selected.Data));

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Connection := TADOQuery(DS.DataSet).Connection;
  FormPesquisa.ShowModal;
end;

procedure TFormLimitesProdsxDists.BitBtn2Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit3);
end;

procedure TFormLimitesProdsxDists.DBEdit3Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit1);
end;

procedure TFormLimitesProdsxDists.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  PR_PersonalizaGrid(TDBGrid(Sender), Rect, DataCol, Column, State);
end;

procedure TFormLimitesProdsxDists.FormShow(Sender: TObject);
Var
  VAR_Item : TTreeNode;
begin
  with QDados do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from LimitesProdsxDists where LPD_CdiProdutor = :P0');
    Parameters[0].Value := VAR_CdiProdutor;
    Open;
  end;

  inherited;

  with QTreeView do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select PRO_CdiProdutor, PRO_DssNomeProdutor, PRO_CosTipoPessoa, PRO_CosCPF, PRO_CosCNPJ from Produtores');
    Open;
  end;

  if QTreeView.RecordCount > 0 then
  begin

    QTreeView.First;

    while not QTreeView.Eof do
    begin

      VAR_Item := TreeViewProdutores.Items.Add(
        nil,
        QTreeView.FieldByName('PRO_CosTipoPessoa').AsString + ': '+
        QTreeView.FieldByName('PRO_CosCPF').AsString +
        QTreeView.FieldByName('PRO_CosCNPJ').AsString + ' - '+
        QTreeView.FieldByName('PRO_DssNomeProdutor').AsString
      );
      VAR_Item.Data := Pointer(QTreeView.FieldByName('PRO_CdiProdutor').AsInteger);
      VAR_Item.ImageIndex := 1;
      {
      if QTreeView.FieldByName('ATB_OplDesativado').Value = 0 then
      begin
        VAR_Filho.ImageIndex := 1;
      end else begin
        VAR_Filho.ImageIndex := 2;
      end;
      }

      QTreeView.Next;

    end;
  end;
end;

procedure TFormLimitesProdsxDists.QDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('LPD_CdiProdutor').Value := VAR_CdiProdutor;
end;

procedure TFormLimitesProdsxDists.QDadosCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QDados.State = dsCalcFields then
  begin
    // Seta o campo Tipo de VIsita
    if QDados.FieldByName('DIS_DssNomeDistribuidor').IsNull then
    begin
      with DM.Query do
      begin
        Connection := QDados.Connection;
        Close;
        SQL.Clear;
        SQL.Add('select DIS_DssNomeDistribuidor from Distribuidores where DIS_CdiDistribuidor = :P00');
        Parameters[0].value := QDados.FieldByName('LPD_CdiDistribuidor').Value;
        Open;

        if RecordCount > 0 then
        begin
          if not QDados.FieldByName('DIS_DssNomeDistribuidor').CanModify then
            QDados.FieldByName('DIS_DssNomeDistribuidor').ReadOnly := False;

          QDados.FieldByName('DIS_DssNomeDistribuidor').Value := FieldByName('DIS_DssNomeDistribuidor').AsString;
        end;
      end;
    end;
  end;
end;

procedure TFormLimitesProdsxDists.TreeViewProdutoresClick(Sender: TObject);
begin
  inherited;
  if DSDados.DataSet.State in [dsInsert, dsEdit] then
  begin
    FN_Mensagem('Salve ou cancele a transação!','Atenção',mtInformation,[mbOK]);
    Abort;
  end;

  VAR_CdiProdutor := Integer(TreeViewProdutores.Selected.Data);

  with QDados do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from LimitesProdsxDists where LPD_CdiProdutor = :P1');
    Parameters.ParamByName('P1').Value := VAR_CdiProdutor;
    Open;

    pSelecao.Caption := TreeViewProdutores.Selected.Text;
  end;
end;

end.
