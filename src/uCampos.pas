unit uCampos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastros, ADODB, DB, ImgList, DBActns, ActnList, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ToolWin, DBCtrls, Mask, jpeg, Data.FMTBcd,
  Data.SqlExpr;

type
  TFormCampos = class(TFormCadastros)
    QTreeTableas: TADOQuery;
    ILTreeTabelas: TImageList;
    TreViewTabelas: TTreeView;
    QDadosACP_CdiCampo: TIntegerField;
    QDadosACP_DssCampo: TStringField;
    QDadosACP_CdiTabela: TIntegerField;
    QDadosACP_D1sLiteral: TStringField;
    QDadosACP_DssLiteralPadrao: TStringField;
    QDadosACP_OplDesativado: TWordField;
    QDadosACP_OplInvisivel: TWordField;
    QDadosACP_OplObrigatorio: TWordField;
    QDadosACP_NuiOrdem: TIntegerField;
    QDadosACP_OplCampoChave: TWordField;
    QDadosACP_CdiCampoMascara: TIntegerField;
    QDadosACP_OplBloqueado: TWordField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label3: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure TreViewTabelasDblClick(Sender: TObject);
    procedure ACT_PesquisarExecute(Sender: TObject);
    procedure DBEdit11Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure QDadosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCampos: TFormCampos;
  VAR_CdiTabela : Integer = 0;

implementation

{$R *.dfm}

uses uPesquisa, uDM;

procedure TFormCampos.ACT_PesquisarExecute(Sender: TObject);
begin
  //inherited;
  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'ACP_CdiCampo';
  VAR_TipoRetorno := 'Form';

  VAR_Tabela := 'Campos';
  VAR_Campos := '*';
  VAR_Filtro := ' and ACP_CdiTabela = '+inttoStr(Integer(TreViewTabelas.Selected.Data));

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Connection := TADOQuery(DS.DataSet).Connection;
  FormPesquisa.ShowModal;
end;

procedure TFormCampos.BitBtn2Click(Sender: TObject);
begin
  inherited;
  PR_BotaoPesquisar(Sender,DBEdit11);
end;

procedure TFormCampos.DBEdit11Change(Sender: TObject);
begin
  inherited;
  PR_CampoLookUp(Sender,Edit1);
end;

procedure TFormCampos.FormShow(Sender: TObject);
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

procedure TFormCampos.QDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ACP_CdiTabela').Value := VAR_CdiTabela;
end;

procedure TFormCampos.TreViewTabelasDblClick(Sender: TObject);
begin
  inherited;

  if DSDados.DataSet.State in [dsInsert, dsEdit] then
  begin
    FN_Mensagem('Salve ou cancele a transação!','Atenção',mtInformation,[mbOK]);
    Abort;
  end;

  VAR_CdiTabela := Integer(TreViewTabelas.Selected.Data);

  with QDados do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from Campos where ACP_CdiTabela = :P1');
    Parameters.ParamByName('P1').Value := VAR_CdiTabela;
    Open;
  end;

end;

end.
