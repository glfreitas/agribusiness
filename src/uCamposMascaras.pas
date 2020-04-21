unit uCamposMascaras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uCadastros, DB, ADODB,
  ImgList, DBActns, ActnList, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, Mask, DBCtrls, jpeg;

type
  TFormCamposMascaras = class(TFormCadastros)
    QDadosACM_CdiCampoMascara: TIntegerField;
    QDadosACM_DssCampoMascara: TStringField;
    QDadosACM_DssMascara: TStringField;
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
  FormCamposMascaras: TFormCamposMascaras;

implementation

{$R *.dfm}

end.
