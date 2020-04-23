program AgriBusiness;

uses
  Vcl.Forms,
  uAcessos in 'src\uAcessos.pas' {FormAcessos},
  uCadastros in 'src\uCadastros.pas' {FormCadastros},
  uCampos in 'src\uCampos.pas' {FormCampos},
  uCamposLoockUps in 'src\uCamposLoockUps.pas' {FormCamposLoockUps},
  uCamposMascaras in 'src\uCamposMascaras.pas' {FormCamposMascaras},
  uDM in 'src\uDM.pas' {DM: TDataModule},
  uMensagens in 'src\uMensagens.pas' {FormMensagens},
  UnitLogin in 'src\UnitLogin.pas' {FormLogin},
  UnitPrincipal in 'src\UnitPrincipal.pas' {FormPrincipal},
  uPerfis in 'src\uPerfis.pas' {FormPerfis},
  uPesquisa in 'src\uPesquisa.pas' {FormPesquisa},
  uSobre in 'src\uSobre.pas' {FormSobre},
  uTabelas in 'src\uTabelas.pas' {FormTabelas},
  uUsuarios in 'src\uUsuarios.pas' {FormUsuarios},
  uProdutos in 'src\uProdutos.pas' {FormProdutos},
  uDistribuidores in 'src\uDistribuidores.pas' {FormDistribuidores},
  uProdutores in 'src\uProdutores.pas' {FormProdutores},
  uLimitesProdsxDists in 'src\uLimitesProdsxDists.pas' {FormLimitesProdsxDists};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
