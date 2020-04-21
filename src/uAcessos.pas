unit uAcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ImgList, DB, ADODB,
  PlatformDefaultStyleActnCtrls, ActnList, ActnMan, Data.FMTBcd, Data.SqlExpr;

type
  TFormAcessos = class(TForm)
    PUsuario: TPanel;
    ImageListAcessos: TImageList;
    PageControl1: TPageControl;
    TabAcessos: TTabSheet;
    TreeViewAcessos: TTreeView;
    Splitter1: TSplitter;
    PageControl2: TPageControl;
    TabPerfis: TTabSheet;
    TabUsuarios: TTabSheet;
    TreeViewUsuarios: TTreeView;
    TreeViewPerfis: TTreeView;
    QPerfis: TADOQuery;
    QUsuarios: TADOQuery;
    QSQL: TADOQuery;

    procedure PR_IniciaTreeViewAcessos(PAR_CdiUsuario : Integer);
    procedure PR_MontaTreViewAcessos(Item : TTreeNode; Pai : Integer; Usuario : Integer);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeViewAcessosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeViewUsuariosDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure PR_Acessos(ActionList : TActionManager; Usuario : Integer);
  procedure PR_Menus(ActionList : TActionManager);

var
  FormAcessos: TFormAcessos;

implementation

uses uDM, uUsuarios, UnitPrincipal;

{$R *.dfm}


procedure PR_Menus(ActionList : TActionManager);
Var
  I, J, CdiAcessoMaster, CdiAcesso : Integer;
begin

  //*Insere categorias das Actions*//
  For J := 0 to ActionList.ActionCount - 1 do
  begin

    with DM.SQL do
    begin
      Close;
      Connection := DM.Conexao;
      SQL.Clear;
      SQL.Add('select * from Acessos ');
      SQL.Add('where ACE_DssAcesso = :P1');
      Parameters.ParamByName('P1').Value := ActionList.Actions[J].Category;
      Open;
    end;

    if DM.SQL.Eof then
    begin

      with DM.SQL do
      begin
        Close;
        Connection := DM.Conexao;
        SQL.Clear;
        CdiAcessoMaster := FN_Maximo('Acessos','ACE_CdiAcesso',dm.Conexao);
        SQL.Add('Insert into Acessos (ACE_CdiAcesso, ACE_D1sAcesso, ACE_OplAtivo, ACE_DssAcesso )');
        SQL.Add(' values(:P1, :P2, :P3, :P4)');
        Parameters.ParamByName('P1').Value := CdiAcessoMaster;
        Parameters.ParamByName('P2').Value := ActionList.Actions[J].Category;
        Parameters.ParamByName('P3').Value := 0;
        Parameters.ParamByName('P4').Value := ActionList.Actions[J].Category;
        ExecSQL;

        SQL.Clear;
        SQL.Add('Insert into UsuariosxAcessos (UAC_CdiUsuarioxAcesso, UAC_CdiUsuario, UAC_CdiAcesso, UAC_OplAtivo )');
        SQL.Add(' values(:P0, :P1, :P2, :P3)');
        Parameters.ParamByName('P0').Value := FN_Maximo('UsuariosxAcessos','UAC_CdiUsuarioxAcesso',dm.Conexao);
        Parameters.ParamByName('P1').Value := 1;
        Parameters.ParamByName('P2').Value := CdiAcessoMaster;
        Parameters.ParamByName('P3').Value := 1;
        ExecSQL;
      end;
    end;
  end;

  //*Insere Actions*//
  For I := 0 to ActionList.ActionCount - 1 do
  begin

    with DM.SQL do
    begin
      Close;
      Connection := DM.Conexao;
      SQL.Clear;
      SQL.Add('select * from Acessos');
      SQL.Add('where ACE_DssAcesso = :P1');
      Parameters.ParamByName('P1').Value := ActionList.Actions[I].Name;
      Open;
    end;

    if DM.SQL.Eof then
    begin

      with DM.SQL do
      begin
        Close;
        Connection := DM.Conexao;
        SQL.Clear;
        SQL.Add('select * from Acessos ');
        SQL.Add('where ACE_DssAcesso = :P1');
        Parameters.ParamByName('P1').Value := ActionList.Actions[I].Category;
        Open;
      end;

      CdiAcessoMaster := DM.SQL.FieldValues['ACE_CdiAcesso'];

      with DM.SQL do
      begin
        Close;
        Connection := DM.Conexao;
        SQL.Clear;
        CdiAcesso := FN_Maximo('Acessos','ACE_CdiAcesso',dm.Conexao);
        SQL.Add('Insert into Acessos (ACE_CdiAcesso, ACE_D1sAcesso, ACE_CdiAcessoMaster, ACE_OplAtivo, ACE_DssAcesso )');
        SQL.Add(' values(:P0, :P1, :P2, :P3, :P4)');
        Parameters.ParamByName('P0').Value := CdiAcesso;
        Parameters.ParamByName('P1').Value := TAction(ActionList.Actions[I]).Caption;
        Parameters.ParamByName('P2').Value := CdiAcessoMaster;
        Parameters.ParamByName('P3').Value := 0;
        Parameters.ParamByName('P4').Value := ActionList.Actions[I].Name;
        ExecSQL;

        SQL.Clear;
        SQL.Add('Insert into UsuariosxAcessos (UAC_CdiUsuario, UAC_CdiAcesso, UAC_OplAtivo )');
        SQL.Add(' values(:P0, :P1, :P2)');
        Parameters.ParamByName('P0').Value := 1;
        Parameters.ParamByName('P1').Value := CdiAcesso;
        Parameters.ParamByName('P2').Value := 1;
        ExecSQL;
      end;
    end;
  end;
end;


procedure PR_Acessos(ActionList : TActionManager; Usuario : Integer);
Var
  I : Integer;
Begin

  with DM.SQL do
  begin
    Close;
    Connection := DM.Conexao;
    SQL.Clear;
    SQL.Add('insert into UsuariosxAcessos (UAC_CdiUsuario, UAC_CdiAcesso, UAC_OplAtivo) ');
    SQL.Add('select USR_CdiUsuario, ACE_CdiAcesso, ');
    SQL.Add('case when ACE_CdiAcesso in (-1) then 1 when ACE_CdiAcessoMaster is null then 1 else 0 end ');
    SQL.Add('from Acessos inner join Usuarios on 1 = 1');
    SQL.Add('where not exists (select * from UsuariosxAcessos where UAC_CdiUsuario = USR_CdiUsuario and UAC_CdiAcesso = ACE_CdiAcesso)');
    ExecSQL;
  end;

  For I := 0 to ActionList.ActionCount - 1 do
  begin

    with DM.SQL do
    begin
      Close;
      Connection := DM.Conexao;
      SQL.Clear;
      SQL.Add('select * from UsuariosxAcessos ');
      SQL.Add('inner join Acessos on ACE_CdiAcesso = UAC_CdiAcesso ');
      SQL.Add('inner join Usuarios on USR_CdiUsuario = UAC_CdiUsuario ');
      SQL.Add('where USR_CdiUsuario = :PUsuario and ACE_DssAcesso = :PAcesso');
      Parameters.ParamByName('PUsuario').Value := Usuario;
      Parameters.ParamByName('PAcesso').Value := ActionList.Actions[I].Name;
      Open;
    end;
    // Acessos dos usuários - Conforme liberação
    if not DM.SQL.Eof then
    begin
      if DM.SQL.FieldValues['UAC_OplAtivo'] = 1 then
      begin
        TAction(ActionList.Actions[I]).Enabled := True;
      end else begin
        TAction(ActionList.Actions[I]).Enabled := False;
      end;
    end;
    // Acessos do Administrador - Sempre tem acesso
    if DM.SQL.FieldByName('USR_CdiUsuario').AsInteger = 1 then
    begin
      TAction(ActionList.Actions[I]).Enabled := True;
    end;

    if ActionList.Actions[I].Name = 'ACT_Login' then
    begin
      TAction(ActionList.Actions[I]).Enabled := True;
    end;

  end;
end;


procedure TFormAcessos.FormShow(Sender: TObject);
Var
  Item : TTreeNode;
begin
  FormAcessos.Top := 10;

  with DM.SQL do
  begin
    Close;
    Connection := DM.Conexao;
    // INSERE ACESSOS DOS USUÁRIOS
    SQL.Clear;
    SQL.Add('insert into UsuariosxAcessos (UAC_CdiUsuario, UAC_CdiAcesso, UAC_OplAtivo) ');
    SQL.Add('select USR_CdiUsuario, ACE_CdiAcesso, ');
    SQL.Add('case when ACE_CdiAcesso in (-1) then 1 when ACE_CdiAcessoMaster is null then 1 else 0 end ');
    SQL.Add('from Acessos inner join Usuarios on 1 = 1');
    SQL.Add('where not exists (select * from UsuariosxAcessos where UAC_CdiUsuario = USR_CdiUsuario and UAC_CdiAcesso = ACE_CdiAcesso)');
    ExecSQL;

    // INSERE ACESSOS DOS PERFIS
    Close;
    SQL.Clear;
    SQL.Add('insert into PerfisxAcessos (PXA_CdiPerfil,	PXA_CdiAcesso,	PXA_OplAtivo)');
    SQL.Add('select PER_CdiPerfil, ACE_CdiAcesso, ');
    SQL.Add('case when ACE_CdiAcesso in (-1) then 1 when ACE_CdiAcessoMaster is null then 1 else 0 end ');
    SQL.Add('from Acessos inner join Perfis on 1 = 1 ');
    SQL.Add('where not exists (select * from PerfisxAcessos where PXA_CdiPerfil = PER_CdiPerfil and PXA_CdiAcesso = ACE_CdiAcesso); ');
    ExecSQL;
  end;

  // MONTA TREEVIEW PERFIS
  with QPerfis do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Perfis order by PER_DssPerfil');
    Open;

    First;

    while not Eof do
    begin
      Item := TreeViewPerfis.Items.Add(nil,FieldByName('PER_DssPerfil').AsString);
      Item.ImageIndex := 5;
      Item.SelectedIndex := 5;
      Item.Data := Pointer(FieldByName('PER_CdiPerfil').AsInteger);
      Next;
    end;
  end;

  // MONTA TREEVIEW USUARIOS
  with QUsuarios do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Usuarios '+
            'where USR_OplAtivo = 1 and USR_CdiUsuario > 1 '+
            'order by USR_DssNome '
            );
    Open;

    First;

    while not Eof do
    begin
      Item := TreeViewUsuarios.Items.Add(nil,FieldByName('USR_DssNome').AsString);
      Item.ImageIndex := 4;
      Item.SelectedIndex := 4;
      Item.Data := Pointer(FieldByName('USR_CdiUsuario').AsInteger);
      Next;
    end;
  end;

  PageControl1.ActivePageIndex := 0;
end;

procedure TFormAcessos.PR_IniciaTreeViewAcessos(PAR_CdiUsuario : Integer);
Var
  Item : TTreeNode;
begin

  TreeViewAcessos.Items.Clear;

  with QSQL do
  begin
    Close;
    Connection := DM.Conexao;
    Close;
    SQL.Clear;
    SQL.Add('select * from UsuariosxAcessos ');
    SQL.Add('inner join Acessos on ACE_CdiAcesso = UAC_CdiAcesso');
    SQL.Add('inner join Usuarios on USR_CdiUsuario = UAC_CdiUsuario');
    SQL.Add('where USR_CdiUsuario = :PUsuario and ACE_CdiAcessoMaster is null');
    Parameters.ParamByName('PUsuario').Value := PAR_CdiUsuario;
    Open;
  end;

  if not QSQL.Eof then
  begin
    while not QSQL.Eof do
    begin
      Item := TreeViewAcessos.Items.Add(nil,QSQL.FieldValues['ACE_D1sAcesso']);
      Item.ImageIndex := 2;
      Item.SelectedIndex := 2;
      Item.Data := Pointer(QSQL.FieldByName('ACE_CdiAcesso').AsInteger);
      PR_MontaTreViewAcessos(Item,QSQL.FieldValues['ACE_CdiAcesso'],QSQL.FieldValues['USR_CdiUsuario']);
      QSQL.Next;
    end;
  end;
end;

Procedure TFormAcessos.PR_MontaTreViewAcessos(Item : TTreeNode; Pai : Integer; Usuario : Integer);
Var
  Filho : TTreeNode;
  Consulta : TADOQuery;
Begin

  Consulta := TADOQuery.Create(Self);

  with Consulta do
  begin
    Close;
    Connection := DM.Conexao;
    SQL.Clear;
    SQL.Add('select * from UsuariosxAcessos ');
    SQL.Add('inner join Acessos on ACE_CdiAcesso = UAC_CdiAcesso');
    SQL.Add('inner join Usuarios on UAC_CdiUsuario = USR_CdiUsuario');
    SQL.Add('where USR_CdiUsuario = :PUsuario and ACE_CdiAcessoMaster = :PPai');
    Parameters.ParamByName('PUsuario').Value := Usuario;
    Parameters.ParamByName('PPai').Value := Pai;
    Open;
  end;

  if not Consulta.Eof then
  begin

    while not Consulta.Eof do
    begin
      Filho := TreeViewAcessos.Items.AddChild(Item,Consulta.FieldValues['ACE_D1sAcesso']);
      Filho.ImageIndex := Consulta.FieldValues['UAC_OplAtivo'];
      Filho.SelectedIndex := Consulta.FieldValues['UAC_OplAtivo'];
      Filho.Data := Pointer(Consulta.FieldByName('ACE_CdiAcesso').AsInteger);
      PR_MontaTreViewAcessos(Filho,Consulta.FieldValues['ACE_CdiAcesso'],Consulta.FieldValues['USR_CdiUsuario']);
      Consulta.Next;
    end;
  end;
end;


procedure TFormAcessos.FormActivate(Sender: TObject);
begin
    TForm(Sender).Top := 10;
end;

procedure TFormAcessos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormAcessos.TreeViewAcessosDblClick(Sender: TObject);
Var
  VAR_CdiAcesso, VAR_Usuario : Integer;
begin

  if TreeViewAcessos.Selected.Parent = nil then
  begin
    Abort;
  end;

  VAR_CdiAcesso := Integer(TreeViewAcessos.Selected.Data);
  VAR_Usuario := Integer(TreeViewUsuarios.Selected.Data);

  With QSQL do
  begin
    Close;
    Connection := DM.Conexao;
    SQL.Clear;
    SQL.Add('update UsuariosxAcessos set UAC_OplAtivo = case coalesce(UAC_OplAtivo,0) when 0 then 1 when 1 then 0 end ');
    SQL.Add(' where UAC_CdiUsuario = :P1 and UAC_CdiAcesso = :P2');
    Parameters[0].Value := VAR_Usuario;
    Parameters[1].Value := VAR_CdiAcesso;
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('select * from UsuariosxAcessos where UAC_CdiUsuario = :P1 and UAC_CdiAcesso = :P2');
    Parameters[0].Value := VAR_Usuario;
    Parameters[1].Value := VAR_CdiAcesso;
    Open;
  end;

  if not QSQL.Eof then
  begin
    TreeViewAcessos.Selected.ImageIndex := QSQL.FieldValues['UAC_OplAtivo'];
    TreeViewAcessos.Selected.SelectedIndex := QSQL.FieldValues['UAC_OplAtivo'];
  end;

  TreeViewAcessos.Refresh;

end;

procedure TFormAcessos.TreeViewUsuariosDblClick(Sender: TObject);
begin
  PR_IniciaTreeViewAcessos(Integer(TreeViewUsuarios.Selected.Data));
  PUsuario.Caption := TreeViewUsuarios.Selected.Text;
end;

end.
