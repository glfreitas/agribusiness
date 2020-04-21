unit uPerfis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Data.Win.ADODB, Vcl.ImgList, Vcl.ActnList, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TFormPerfis = class(TFormCadastros)
    QDadosPER_CdiPerfil: TIntegerField;
    QDadosPER_DssPerfil: TStringField;
    PER_CdiPerfil: TLabel;
    DBEdit1: TDBEdit;
    PER_DssPerfil: TLabel;
    DBEdit2: TDBEdit;
    procedure ACT_PesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPerfis: TFormPerfis;

implementation

{$R *.dfm}

uses uPesquisa;

procedure TFormPerfis.ACT_PesquisarExecute(Sender: TObject);
begin
  //inherited;
  VAR_Select := 'select PER_CdiPerfil, PER_DssPerfil from Perfis';

  VAR_QueryRetorno := QDados;
  VAR_CampoChave := 'PER_CdiPerfil';
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
