unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RibbonLunaStyleActnCtrls, Ribbon, ToolWin, ActnMan, ActnCtrls,
  ComCtrls, PlatformDefaultStyleActnCtrls, ActnList, DB, ADODB, ExtCtrls,
  ImgList, WinSkinData, ActnMenus, RibbonActnMenus, RibbonSilverStyleActnCtrls,
  Menus, jpeg, StdCtrls, Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.DBCGrids,
  IdSocketHandle, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPServer;

type
  TFormPrincipal = class(TForm)
    Ribbon1: TRibbon;
    ActionManager: TActionManager;
    BalloonHint: TBalloonHint;
    StatusBar1: TStatusBar;
    ACT_Usuarios: TAction;
    ImageList: TImageList;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonPage2: TRibbonPage;
    RibbonGroup4: TRibbonGroup;
    Image1: TImage;
    RibbonGroup3: TRibbonGroup;
    ACT_Tabelas: TAction;
    ACT_Campos: TAction;
    ACT_CamposLoockUps: TAction;
    ACT_CamposMascaras: TAction;
    ACT_Acessos: TAction;
    RibbonPage4: TRibbonPage;
    RibbonGroup9: TRibbonGroup;
    RibbonGroup10: TRibbonGroup;
    SkinData1: TSkinData;
    ACT_Perfis: TAction;
    RibbonGroup1: TRibbonGroup;
    ActionManagerGeral: TActionManager;
    ACT_Fechar: TAction;
    ACT_Login: TAction;
    RibbonGroup2: TRibbonGroup;
    procedure ACT_UsuariosExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ACT_Fechar1Execute(Sender: TObject);
    procedure ACT_Login1Execute(Sender: TObject);
    procedure ACT_TabelasExecute(Sender: TObject);
    procedure ACT_CamposExecute(Sender: TObject);
    procedure ACT_CamposLoockUpsExecute(Sender: TObject);
    procedure ACT_CamposMascarasExecute(Sender: TObject);
    procedure ACT_AcessosExecute(Sender: TObject);
    procedure Ribbon1HelpButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ACT_PerfisExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;
  VAR_CdiUsuarioConectado: Integer = -1;
  VAR_CdiContratadoConectado: Integer = -1;
  VAR_CdsUsuarioConectado, VAR_DssUsuarioConectado, VAR_DssPerfilCorrente: String;

implementation

{$R *.dfm}

uses uDM, UnitLogin, uCampos, uCamposLoockUps, uCamposMascaras, uTabelas, uUsuarios,
  uAcessos, uSobre, uPerfis;

procedure TFormPrincipal.ACT_CamposExecute(Sender: TObject);
begin
  Application.CreateForm(TFormCampos,FormCampos);
  FormCampos.Show;
end;

procedure TFormPrincipal.ACT_CamposLoockUpsExecute(Sender: TObject);
begin
  Application.CreateForm(TFormCamposLoockUps,FormCamposLoockUps);
  FormCamposLoockUps.Show;
end;

procedure TFormPrincipal.ACT_CamposMascarasExecute(Sender: TObject);
begin
  Application.CreateForm(TFormCamposMascaras,FormCamposMascaras);
  FormCamposMascaras.Show;
end;

procedure TFormPrincipal.ACT_AcessosExecute(Sender: TObject);
begin
  Application.CreateForm(TFormAcessos,FormAcessos);
  FormAcessos.Show;
end;

procedure TFormPrincipal.ACT_Fechar1Execute(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.ACT_Login1Execute(Sender: TObject);
begin
  VAR_CdiUsuarioConectado := 0;
  Application.CreateForm(TFormLogin,FormLogin);
  FormLogin.ShowModal;
end;

procedure TFormPrincipal.ACT_PerfisExecute(Sender: TObject);
begin
  Application.CreateForm(TFormPerfis,FormPerfis);
  FormPerfis.Show;
end;

procedure TFormPrincipal.ACT_TabelasExecute(Sender: TObject);
begin
  Application.CreateForm(TFormTabelas,FormTabelas);
  FormTabelas.Show;
end;

procedure TFormPrincipal.ACT_UsuariosExecute(Sender: TObject);
begin
    Application.CreateForm(TFormUsuarios,FormUsuarios);
    FormUsuarios.Show;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FN_Mensagem('Deseja sair do sistema?','Atenção',mtConfirmation,[mbYes,mbNo]) = 0 then
  begin
    Application.Terminate;
  end else begin
    Abort;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  TForm(Sender).FormStyle := fsMDIForm;

 (*Removendo Barra de títulos*)
  SetWindowLong(TForm(Sender).Handle,
                GWL_STYLE,
                GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
  Height := ClientHeight;

end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  if VAR_CdiUsuarioConectado < 0 then
  begin
    Application.CreateForm(TFormLogin,FormLogin);
    FormLogin.ShowModal;
  end;
end;

procedure TFormPrincipal.Ribbon1HelpButtonClick(Sender: TObject);
begin
  Application.CreateForm(TFormSobre,FormSobre);
  FormSobre.ShowModal;
end;

end.
