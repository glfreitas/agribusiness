unit uTabelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastros, ADODB, DB, ImgList, DBActns, ActnList, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ToolWin, Mask, DBCtrls, jpeg, Data.FMTBcd,
  Data.SqlExpr;

type
  TFormTabelas = class(TFormCadastros)
    QDadosATB_CdiTabela: TIntegerField;
    QDadosATB_DssTabela: TStringField;
    QDadosATB_D1sLiteral: TStringField;
    QDadosATB_DssLiteralPadrao: TStringField;
    QDadosATB_CosPrefixoCampos: TStringField;
    QDadosATB_OplDesativado: TWordField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label6: TLabel;
    procedure ACT_PesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTabelas: TFormTabelas;

implementation

{$R *.dfm}

uses uPesquisa;

procedure TFormTabelas.ACT_PesquisarExecute(Sender: TObject);
begin
  inherited;
  VAR_Select := 'select ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado from Tabelas';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'ATB_CdiTabela';
  VAR_TipoRetorno := 'Form';

  //VAR_Tabela := 'Usuarios';
  //VAR_Campos := '*';
  //VAR_Filtro := ' order by USR_CdiUsuario';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Close;
  FormPesquisa.QPesquisas.Connection := TADOQuery(DSDados.DataSet).Connection;
  FormPesquisa.ShowModal;

end;

end.
