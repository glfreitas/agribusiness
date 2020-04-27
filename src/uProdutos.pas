unit uProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Data.Win.ADODB, Vcl.ImgList, Vcl.ActnList, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TFormProdutos = class(TFormCadastros)
    QDadosPRD_CDIPRODUTO: TIntegerField;
    QDadosPRD_DSSPRODUTO: TStringField;
    QDadosPRD_COSUNIDADE: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    QDadosPRD_VLNPRECO: TBCDField;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    procedure ACT_PesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutos: TFormProdutos;

implementation

{$R *.dfm}

uses uPesquisa;

procedure TFormProdutos.ACT_PesquisarExecute(Sender: TObject);
begin
  //inherited;
  VAR_Select := 'select PRD_CdiProduto, PRD_DssProduto, PRD_CosUnidade, PRD_VlnPreco from Produtos';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'PRD_CdiProduto';
  VAR_TipoRetorno := 'Form';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Close;
  FormPesquisa.QPesquisas.Connection := TADOQuery(DSDados.DataSet).Connection;
  FormPesquisa.ShowModal;

end;

end.
