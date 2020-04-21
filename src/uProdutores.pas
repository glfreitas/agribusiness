unit uProdutores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastros, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask, Data.DB, Data.Win.ADODB, Vcl.ImgList, Vcl.ActnList,
  Vcl.Buttons, Vcl.Imaging.jpeg;

type
  TFormProdutores = class(TFormCadastros)
    QDadosPRO_CDIPRODUTOR: TIntegerField;
    QDadosPRO_DSSNOMEPRODUTOR: TStringField;
    QDadosPRO_COSCPF: TStringField;
    QDadosPRO_COSCNPJ: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    QDadosPRO_COSTIPOPESSOA: TStringField;
    procedure DBRadioGroup1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutores: TFormProdutores;

implementation

{$R *.dfm}

procedure TFormProdutores.DBRadioGroup1Change(Sender: TObject);
begin
  inherited;

  if DBRadioGroup1.ItemIndex = 0 then
  begin
    Label4.Caption := 'CPF';
    DBEdit4.DataField := 'PRO_CosCPF';
  end;
  if DBRadioGroup1.ItemIndex = 1 then
  begin
    Label4.Caption := 'CNPJ';
    DBEdit4.DataField := 'PRO_CosCNPJ';
  end;

end;

end.
