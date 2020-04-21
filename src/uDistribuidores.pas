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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDistribuidores: TFormDistribuidores;

implementation

{$R *.dfm}

end.
