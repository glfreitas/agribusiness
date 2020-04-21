unit uCamposLoockUps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastros, ADODB, DB, ImgList, DBActns, ActnList, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, ToolWin, DBCtrls, Mask, jpeg, Data.FMTBcd,
  Data.SqlExpr;

type
  TFormCamposLoockUps = class(TFormCadastros)
    QDadosACL_CdiCampoLookUp: TIntegerField;
    QDadosACL_CdiCampoChave: TIntegerField;
    QDadosACL_CdiCampoReferencia: TIntegerField;
    QDadosACL_CdiCampoResultado: TIntegerField;
    QDadosACL_DsbComandoSQL: TBlobField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBRichEdit1: TDBRichEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    TreViewTabelas: TTreeView;
    ILTreeTabelas: TImageList;
    QTreeTableas: TADOQuery;
    QDadosACL_CdiTabela: TIntegerField;
    QDadosACL_DssDescricao: TStringField;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    procedure DBEdit2Change(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
    procedure DBEdit4Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreViewTabelasDblClick(Sender: TObject);
    procedure ACT_PesquisarExecute(Sender: TObject);
    procedure QDadosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCamposLoockUps: TFormCamposLoockUps;
  VAR_CdiTabela : Integer = 0;

implementation

{$R *.dfm}

uses uPesquisa;

procedure TFormCamposLoockUps.ACT_PesquisarExecute(Sender: TObject);
begin
  inherited;
  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'ACL_CdiCampoLookUp';
  VAR_TipoRetorno := 'Form';

  VAR_Tabela := 'CamposLookUps';
  VAR_Campos := '*';
  VAR_Filtro := ' and ACL_CdiTabela = '+inttoStr(Integer(TreViewTabelas.Selected.Data));

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Connection := TADOQuery(DS.DataSet).Connection;
  FormPesquisa.ShowModal;
end;

procedure TFormCamposLoockUps.BitBtn2Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit2);
end;

procedure TFormCamposLoockUps.BitBtn3Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit3);
end;

procedure TFormCamposLoockUps.BitBtn4Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit4);
end;

procedure TFormCamposLoockUps.DBEdit2Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit1);
end;

procedure TFormCamposLoockUps.DBEdit3Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit2);
end;

procedure TFormCamposLoockUps.DBEdit4Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit3);
end;

procedure TFormCamposLoockUps.FormShow(Sender: TObject);
Var
  VAR_Pai,VAR_Filho : TTreeNode;
begin
  inherited;


  with QTreeTableas do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Tabelas');
    Open;
  end;

  if QTreeTableas.RecordCount > 0 then
  begin
    VAR_Pai := TreViewTabelas.Items.Add(nil,'Tabelas');
    VAR_Pai.ImageIndex := 3;

    QTreeTableas.First;

    while not QTreeTableas.Eof do
    begin

      VAR_Filho := TreViewTabelas.Items.AddChild(VAR_Pai,QTreeTableas.FieldByName('ATB_D1sLiteral').AsString);
      VAR_Filho.Data := Pointer(QTreeTableas.FieldByName('ATB_CdiTabela').AsInteger);
      if QTreeTableas.FieldByName('ATB_OplDesativado').Value = 0 then
      begin
        VAR_Filho.ImageIndex := 1;
      end else begin
        VAR_Filho.ImageIndex := 2;
      end;

      QTreeTableas.Next;

    end;
  end;

end;

procedure TFormCamposLoockUps.QDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ACL_CdiTabela').Value := VAR_CdiTabela;
end;

procedure TFormCamposLoockUps.TreViewTabelasDblClick(Sender: TObject);
begin
  inherited;

  if DSDados.DataSet.State in [dsInsert, dsEdit] then
  begin
    MessageDlg('Salve ou cancele a transação!',mtInformation,[mbOK],1);
    Abort;
  end;

  VAR_CdiTabela := Integer(TreViewTabelas.Selected.Data);

  with QDados do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from CamposLookUps where ACL_CdiTabela = :P1');
    Parameters.ParamByName('P1').Value := VAR_CdiTabela;
    Open;
  end;
end;

end.
