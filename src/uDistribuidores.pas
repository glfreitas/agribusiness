unit uDistribuidores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Data.DB, Data.Win.ADODB,
  Vcl.ImgList, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.DBCtrls;

type
  TFormDistribuidores = class(TFormCadastros)
    QDadosDIS_CDIDISTRIBUIDOR: TIntegerField;
    QDadosDIS_DSSNOMEDISTRIBUIDOR: TStringField;
    QDadosDIS_COSCNPJ: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    procedure ACT_PesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDistribuidores: TFormDistribuidores;

implementation

{$R *.dfm}

uses uPesquisa;

procedure TFormDistribuidores.ACT_PesquisarExecute(Sender: TObject);
begin
  //inherited;
  VAR_Select := 'select DIS_CdiDistribuidor, DIS_DssNomeDistribuidor, DIS_CosCNPJ from Distribuidores';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'DIS_CdiDistribuidor';
  VAR_TipoRetorno := 'Form';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Close;
  FormPesquisa.QPesquisas.Connection := TADOQuery(DSDados.DataSet).Connection;
  FormPesquisa.ShowModal;
end;

end.
