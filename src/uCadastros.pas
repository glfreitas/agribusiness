unit uCadastros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ImgList, ActnList, DBActns, StdCtrls, Buttons,
  ADODB, DBCtrls, Mask, ComCtrls, ToolWin, Provider,
  DBClient, jpeg, ShellAPI, Vcl.Grids, Vcl.DBGrids, Data.FMTBcd, Data.SqlExpr;

type
  TFormCadastros = class(TForm)
    Image1: TImage;
    PBotoes: TPanel;
    DSDados: TDataSource;
    DSLiterais: TDataSource;
    ACLCadastros: TActionList;
    ImageList: TImageList;
    ACT_Fechar: TAction;
    ACT_Primeiro: TAction;
    ACT_Anterior: TAction;
    ACT_Proximo: TAction;
    ACT_Ultimo: TAction;
    ACT_Inserir: TAction;
    ACT_Editar: TAction;
    ACT_Excluir: TAction;
    ACT_Salvar: TAction;
    ACT_Cancelar: TAction;
    ACT_Pesquisar: TAction;
    DSQuery: TDataSource;
    Consultar: TBitBtn;
    Ultimo: TBitBtn;
    Proximo: TBitBtn;
    Anterior: TBitBtn;
    Primeiro: TBitBtn;
    Inserir: TBitBtn;
    Editar: TBitBtn;
    Apagar: TBitBtn;
    Salvar: TBitBtn;
    Cancelar: TBitBtn;
    Fechar: TBitBtn;
    pBotoesDireita: TPanel;
    BalloonHint1: TBalloonHint;
    QLiterais: TADOQuery;
    QDados: TADOQuery;
    Query: TADOQuery;

    function FN_LocalizaComponente(PAR_Form : TForm; PAR_DssClasse, PAR_DssNome : String) : TComponent;

    procedure PR_CarregaArquivo(PAR_DssCampoArquivo, PAR_DssCampoDescricao : String);
    procedure PR_DescarregaArquivo(PAR_DssCampoArquivo, PAR_DssCampoDescricao : String);
    procedure PR_PersonalizaGrid(Sender : TDBGrid; Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

    Procedure PR_CampoLookUp(PAR_Campo, PAR_Retorno : TObject);
    Procedure PR_StatusComponentes(PAR_DataSource : TDataSource; PAR_Operacao : String);
    Procedure PR_BotaoPesquisar(PAR_Botao, PAR_CampoRetorno : TObject);
    Procedure PR_MontaCampos(QueryLiterais : TDataSource; QueryDados : TDataSource);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ACT_SalvarExecute(Sender: TObject);
    procedure ACT_AnteriorExecute(Sender: TObject);
    procedure ACT_InserirExecute(Sender: TObject);
    procedure ACT_EditarExecute(Sender: TObject);
    procedure ACT_ExcluirExecute(Sender: TObject);
    procedure ACT_CancelarExecute(Sender: TObject);
    procedure ACT_PrimeiroExecute(Sender: TObject);
    procedure ACT_ProximoExecute(Sender: TObject);
    procedure ACT_UltimoExecute(Sender: TObject);
    procedure ACT_PesquisarExecute(Sender: TObject);
    procedure ACT_FecharExecute(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    Painel : Array of TPanel;
    DBEdit : Array of TDBEdit;
    DBMemo : Array of TDBRichEdit;
    DBChek : Array of TDBCheckBox;
    BitBtn : Array of TBitBtn;
    Texto : Array of TLabel;
    Datas : Array of TDBEdit;// DateEdit;

    { Private declarations }
  public
    DS,DSL : TDataSource;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    { Public declarations }
  end;

var
  FormCadastros: TFormCadastros;


implementation

uses uDM, uPesquisa;

{$R *.dfm}

function TFormCadastros.FN_LocalizaComponente(PAR_Form : TForm; PAR_DssClasse, PAR_DssNome : String) : TComponent;
Var
  I : Integer;
begin
  Result := Self;
  for I := 0 to PAR_Form.ComponentCount - 1 do
  begin
    if (PAR_Form.Components[I].ClassName = PAR_DssClasse)
      and (UpperCase( PAR_Form.Components[I].Name ) = UpperCase( PAR_DssNome )) then
    begin
      Result := PAR_Form.Components[I];
    end;
  end;
end;

procedure TFormCadastros.PR_PersonalizaGrid(Sender : TDBGrid; Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Begin

  if odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00B9FFFF //clMenuBar
  else
    TDBGrid(Sender).Canvas.Brush.Color:= clCream;

  TDbGrid(Sender).Canvas.font.Color:= clBlack;

  if gdSelected in State then
  with (Sender as TDBGrid).Canvas do
  begin
    Brush.Color := $004080FF; //clMoneyGreen;
    FillRect(Rect);
    Font.Style := [fsBold]
  end;

  TDbGrid(Sender).DefaultDrawDataCell(Rect, TDbGrid(Sender).columns[DataCol].Field, State);

  if (UpperCase(Copy(Column.FieldName,5,3)) = UpperCase('Opl')) and (not TDBGrid(Sender).DataSource.DataSet.Eof) then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    if TDBGrid(Sender).DataSource.DataSet.FieldByName(Column.FieldName).AsString = '0' then
      DM.ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top,0);

    if TDBGrid(Sender).DataSource.DataSet.FieldByName(Column.FieldName).AsString = '1' then
      DM.ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top,1);

  end;

End;

Procedure SetChildTaborders(const Parent: TWinControl) ;

procedure FixTabOrder(const Parent: TWinControl) ;
var
  ctl, L: Integer;
  List: TList;
begin
  List := TList.Create;
  try
    for ctl := 0 to Parent.ControlCount - 1 do
    begin
      if Parent.Controls[ctl] is TWinControl then
      begin
        if List.Count = 0 then
          L := 0
        else begin
          with Parent.Controls[ctl] do
            for L := 0 to List.Count - 1 do
              if (Top < TControl(List[L]).Top) or ((Top = TControl(List[L]).Top) and (Left < TControl(List[L]).Left)) then
                Break;
        end;
        List.Insert(L, Parent.Controls[ctl]) ;
        FixTabOrder(TWinControl(Parent.Controls[ctl])) ;
      end;
    end;
    for ctl := 0 to List.Count - 1 do
      TWinControl(List[ctl]).TabOrder := ctl;
  finally
    List.Free;
  end;
end;
begin
  FixTabOrder(Parent) ;
end;

procedure TFormCadastros.PR_CarregaArquivo(PAR_DssCampoArquivo, PAR_DssCampoDescricao : String);
begin
  if DM.OpenDialog1.Execute then
  begin
    TBlobField(DSDados.DataSet.FieldByName(PAR_DssCampoArquivo)).LoadFromFile(DM.OpenDialog1.FileName);
    DSDados.DataSet.FieldByName(PAR_DssCampoDescricao).Value := Copy(ExtractFileName(DM.OpenDialog1.FileName),1,40)+ExtractFileExt(DM.OpenDialog1.FileName);
  end;
end;

procedure TFormCadastros.PR_DescarregaArquivo(PAR_DssCampoArquivo, PAR_DssCampoDescricao : String);
Var
  VAR_Arquivo : TFileStream;
  MS : TMemoryStream;
begin

  if DSDados.DataSet.FieldByName(PAR_DssCampoArquivo).IsNull then
    Abort;

  DM.SaveDialog1.FileName := 'U:\Downloads HelpDesk\'+DSDados.DataSet.FieldByName(PAR_DssCampoDescricao).AsString;
  DM.SaveDialog1.DefaultExt := ExtractFileExt(DM.SaveDialog1.FileName);

  //if DM.SaveDialog1.Execute then
  //begin
    TBlobField(DSDados.DataSet.FieldByName(PAR_DssCampoArquivo)).SaveToFile(DM.SaveDialog1.FileName);

    //if Application.MessageBox('Deseja abrir o arquivo?','Atenção', MB_YESNO + MB_ICONQUESTION) = 6 then
    //begin
      ShellExecute(handle,nil,PChar(DM.SaveDialog1.FileName), '','',SW_SHOWNORMAL);
    //end;
  //end;

end;

procedure TFormCadastros.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  Rect: TRect;
  OurWidth: Integer;
  OurHeight: Integer;
begin
  if Showing then begin

    // Obtem o retângulo da área cliente MDI
    Windows.GetWindowRect(Application.MainForm.ClientHandle, Rect);

    // Calcular largura e altura da área cliente
    OurWidth := Rect.Right - Rect.Left;
    OurHeight := Rect.Bottom - Rect.Top;

    // Calcula a nova posição
    ALeft := (OurWidth - Width) div 2;
    ATop := (OurHeight - Height) div 2;
  end;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

Procedure TFormCadastros.PR_CampoLookUp(PAR_Campo, PAR_Retorno : TObject);
Var
  I : Integer;
  Query1, Query2 : TADOQuery;
begin

  Query1 := TADOQuery.Create(Self);
  //Query1.Connection := TADOQuery(DS.DataSet).Connection;
  Query1.Connection := DM.Conexao;

  Query2 := TADOQuery.Create(Self);
  //Query2.Connection := TADOQuery(DSL.DataSet).Connection;
  Query2.Connection := DM.Conexao;

  with Query2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select CampoChave.ACP_DssCampo as CampoChave, CampoReferencia.ACP_DssCampo as CampoReferencia,');
    SQL.Add('	CampoResultado.ACP_DssCampo as CampoResultado, Tabelas.ATB_DssTabela from CamposLookUps');
    SQL.Add('inner join Campos CampoChave on CampoChave.ACP_CdiCampo = CamposLookUps.ACL_CdiCampoChave');
    SQL.Add('inner join Campos CampoReferencia on CampoReferencia.ACP_CdiCampo = CamposLookUps.ACL_CdiCampoReferencia');
    SQL.Add('inner join Campos CampoResultado on CampoResultado.ACP_CdiCampo = ACL_CdiCampoResultado');
    SQL.Add('inner join Tabelas on ATB_CdiTabela = CampoResultado.ACP_CdiTabela');
    SQL.Add('where upper(CampoChave.ACP_DssCampo) = :CampoChave');
    Parameters.ParamByName('CampoChave').Value := UpperCase(TDBEdit(PAR_Campo).DataField);
    ExecSQL;
    Open;
  end;

  if (not Query2.Eof) and (TDBEdit(PAR_Campo).Text <> EmptyStr) then
  begin

    with Query1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select '+Query2.FieldByName('CampoResultado').AsString);
      SQL.Add(' from '+Query2.FieldByName('ATB_DssTabela').AsString);
      SQL.Add(' where '+Query2.FieldByName('CampoReferencia').AsString);
      SQL.Add(' = '+TDBEdit(PAR_Campo).Text);
      Open;
    end;

    if TDBEdit(PAR_Campo).Text = EmptyStr then
    begin
      TEdit(PAR_Retorno).Text := EmptyStr;
    end else begin
      TEdit(PAR_Retorno).Text := Query1.FieldByName(Query2.FieldByName('CampoResultado').AsString).AsString;
    end;
  end else begin
    TEdit(PAR_Retorno).Text := EmptyStr;
  end;
  Query1.Free;
  Query2.Free;
end;

procedure TFormCadastros.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if DS.DataSet.State in [dsInsert,dsEdit] then
  begin
    FN_Mensagem('Salve ou cancele esta operação para mudar a aba!','Atenção',mtInformation,[mbOK]);
    //MessageDlg('Salve ou cancele esta operação para mudar a aba!',mtInformation,[mbOK],1);
    AllowChange := False;
  end;
end;

Procedure TFormCadastros.PR_BotaoPesquisar(PAR_Botao, PAR_CampoRetorno : TObject);
var
  I : Integer;
  VAR_CdiCampoChave : String;
begin

  if DSL.DataSet.Locate('ACL_CdiCampoLookUp',IntToStr(TBitBtn(PAR_Botao).Tag),[]) then
  begin

    VAR_FormRetorno := Self;

    {*Se encontrar registro, monta uma variavel do tipo TDBRichEdit para decifrar o campo blob*}
    ComandoSQL := TDBRichEdit.Create(Self);
    ComandoSQL.Parent := TForm(VAR_FormRetorno);
    ComandoSQL.Visible := False;
    ComandoSQL.DataSource := DSL;
    ComandoSQL.DataField := 'ACL_DsbComandoSQL';

    {*Insere Select SQL*}
    VAR_Select := ComandoSQL.Text;
    ComandoSQL.Free;

    {*Seta campo retorno*}
    VAR_CampoRetorno := DSL.DataSet.FieldByName('LookupDssCampoReferencia').AsString;
    VAR_CdiCampoChave := DSL.DataSet.FieldByName('ACP_DssCampo').AsString;

  end;

  {Verifica se o componente é o campo que chamou a pesquisa}
  VAR_ObjetoRetorno := PAR_CampoRetorno;

  VAR_Filtro := '';
  VAR_TipoRetorno := 'Campo';

  Application.CreateForm(TFormPesquisa,FormPesquisa);
  FormPesquisa.QPesquisas.Connection := DM.Conexao;
  FormPesquisa.ShowModal;

end;

Procedure TFormCadastros.PR_MontaCampos(QueryLiterais, QueryDados : TDataSource);
Var
  iLoopFor, UlTop: Integer;
  Componente : TComponent;
begin

  QueryLiterais.DataSet.Close;

  {Abre os DataSets que serão usados para criação dinamica de Componentes}
  TADOQuery(QueryLiterais.DataSet).Connection := DM.Conexao;

  {Pega o número Tag da tabelas dados para buscar seus literais}
  TADOQuery(QueryLiterais.DataSet).Parameters.ParamByName('PCdiTabela').Value := QueryDados.DataSet.Tag;
  QueryLiterais.DataSet.Active := True;
  QueryLiterais.DataSet.First;

  QueryDados.DataSet.Active := True;

  {Inicia o laço para criação de componentes}
  For iLoopFor := 0 to TADOQuery(QueryLiterais.DataSet).RecordCount - 1 do
  begin

    {Define o nome do campo}
    if not QueryLiterais.DataSet.FieldByName('ACP_D1sLiteral').IsNull then
    begin
      QueryDados.DataSet.FieldByName(QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString).DisplayLabel := QueryLiterais.DataSet.FieldByName('ACP_D1sLiteral').AsString;
      // Localiza o Label correspondente
      Componente := FN_LocalizaComponente(Self,'TLabel',QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString);
      if Componente <> Self then
        TLabel(Componente).Caption := QueryLiterais.DataSet.FieldByName('ACP_D1sLiteral').AsString;
    end;

    (*Define o campo obrigatorio*)
    if QueryLiterais.DataSet.FieldByName('ACP_OplObrigatorio').Value = 1 then
    begin
      QueryDados.DataSet.FieldByName(QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString).Required := True;
      // Localiza o Label correspondente
      Componente := FN_LocalizaComponente(Self,'TLabel',QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString);
      if Componente <> Self then
        TLabel(Componente).Caption := '* ' + TLabel(Componente).Caption;
    end;

    // Trata bloqueio do campo
    if QueryLiterais.DataSet.FieldByName('ACP_OplBloqueado').AsInteger = 1 then
    begin
      QueryDados.DataSet.FieldByName(QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString).ReadOnly := True;
    end;

    // Configura a mascara dos campos
    if not (QueryLiterais.DataSet.FieldByName('ACM_DssMascara').AsString = EmptyStr) then
    begin
      if QueryLiterais.DataSet.FieldByName('ACM_DssMascara').AsString = '*' then
      begin
        //DBEdit[ High( DBEdit ) ].PasswordChar := '*';
      end else begin
        QueryDados.DataSet.FieldByName(QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString).EditMask := QueryLiterais.DataSet.FieldByName('ACM_DssMascara').AsString;
        //QueryDados.DataSet.FieldByName(QueryLiterais.DataSet.FieldByName('ACP_DssCampo').AsString).DisplayText := QueryLiterais.DataSet.FieldByName('ACM_DssMascara').AsString;
      end;
    end;

    QueryLiterais.DataSet.Next;
  end;
end;

Procedure TFormCadastros.PR_StatusComponentes(PAR_DataSource : TDataSource; PAR_Operacao : String);
Var
  I : Integer;
begin
  (*Primeiro*)
  if PAR_Operacao = 'First' then
  begin
    TDataSource(PAR_DataSource).DataSet.First;
  end;

  (*Anterior*)
  if PAR_Operacao = 'Prior' then
  begin
    TDataSource(PAR_DataSource).DataSet.Prior;
  end;

  (*Proximo*)
  if PAR_Operacao = 'Next' then
  begin
    TDataSource(PAR_DataSource).DataSet.Next;
  end;

  (*Último*)
  if PAR_Operacao = 'Last' then
  begin
    TDataSource(PAR_DataSource).DataSet.Last;
  end;

  (*Inserir*)
  if PAR_Operacao = 'Insert' then
  begin
    TDataSource(PAR_DataSource).DataSet.Insert;
  end;

  (*Editar*)
  if PAR_Operacao = 'Edit' then
  begin
    if TDataSource(PAR_DataSource).DataSet.RecordCount > 0 then
    begin
      TDataSource(PAR_DataSource).DataSet.Edit;
    end else begin
      FN_Mensagem('Não existe registro para edição, você deve inserir um registro!','Atenção',mtInformation,[mbOK]);
      //MessageDlg('Não existe registro para edição, você deve inserir um registro!',mtInformation,[mbOK],1);
      Abort;
    end;
  end;

  (*Cancelar*)
  if PAR_Operacao = 'Cancel' then
  begin
    TDataSource(PAR_DataSource).DataSet.Cancel;
  end;

  (*Excluir*)
  if PAR_Operacao = 'Delete' then
  begin

    if not TDataSource(PAR_DataSource).DataSet.Eof then
    begin
      if FN_Mensagem('Deseja realmente excluir este registro?','Atenção',mtConfirmation,[mbYes,mbNo]) = 0 then
      begin
        TDataSource(PAR_DataSource).DataSet.Delete;
      end;
    end else begin
      FN_Mensagem('Não existe registro para exclusão, você deve inserir um registro!','Atenção',mtInformation,[mbOK]);
    end;

  end;

  (*Salvar*)
  if PAR_Operacao = 'Post' then
  begin

    for I := 0 to TDataSource(PAR_DataSource).DataSet.FieldCount - 1 do
    begin
      if (TDataSource(PAR_DataSource).DataSet.Fields[I].Required) and (TDataSource(PAR_DataSource).DataSet.Fields[I].IsNull) then
      begin
        MessageDlg('O campo "'+TDataSource(PAR_DataSource).DataSet.Fields[I].DisplayLabel+'" é obrigatório e deve ser preenchido!',mtInformation,[mbOK],1);
        Abort;
      end;
    end;

    with Query do
    begin
      Connection := QLiterais.Connection;
      Close;
      SQL.Clear;
      SQL.Add('select * from Tabelas');
      SQL.Add('inner join Campos on ACP_CdiTabela = ATB_CdiTabela');
      SQL.Add('where ATB_CdiTabela = :PTabela and ACP_OplCampoChave = 1');
      Parameters.ParamByName('PTabela').Value := TDataSource(PAR_DataSource).DataSet.Tag;
      Open;
    end;

    if Query.RecordCount > 0 then
    begin
      for I := 0 to TDataSource(PAR_DataSource).DataSet.FieldCount - 1 do
      begin
        if UpperCase(TDataSource(PAR_DataSource).DataSet.Fields[I].FieldName) = UpperCase(Query.FieldByName('ACP_DssCampo').AsString) then
        begin
          if TDataSource(PAR_DataSource).DataSet.Fields[I].IsNull then
          begin
            TDataSource(PAR_DataSource).DataSet.Fields[I].Value := IntToStr(FN_Maximo(Query.FieldByName('ATB_DssTabela').AsString,Query.FieldByName('ACP_DssCampo').AsString, DM.Conexao));
           end;
        end;
      end;
    end;

    TDataSource(PAR_DataSource).DataSet.Post;
  end;

  (*Pesquisar*)
  if PAR_Operacao = 'Find' then
  begin
    Application.CreateForm(TFormPesquisa,FormPesquisa);
    VAR_Tabela := DSL.DataSet.FieldByName('DssTabela').AsString;
    VAR_Select := 'select * from ' + VAR_Tabela;
    VAR_TipoRetorno := 'Form1';
    VAR_QueryRetorno := QDados;
    DSL.DataSet.Locate('ACP_OplCampoChave','1',[loCaseInsensitive,loPartialKey]);
    VAR_CampoChave := DSL.DataSet.FieldByName('ACP_DssCampo').AsString;
    FormPesquisa.ShowModal;
  end;

  if TDataSource(PAR_DataSource).DataSet.State in [dsInsert, dsEdit] then
  begin
    ACT_Primeiro.Enabled  := False;
    ACT_Anterior.Enabled  := False;
    ACT_Proximo.Enabled   := False;
    ACT_Ultimo.Enabled    := False;
    ACT_Inserir.Enabled   := False;
    ACT_Excluir.Enabled   := False;
    ACT_Editar.Enabled    := False;
    ACT_Salvar.Enabled    := True;
    ACT_Cancelar.Enabled  := True;
    ACT_Fechar.Enabled    := False;
    ACT_Pesquisar.Enabled := False;

    for I := 0 to TForm(Self).ComponentCount - 1 do
    begin
      // Ativa os botoes de pesquisa quando em edição
      if (TForm(Self).Components[I].ClassType = TBitBtn) then
      begin
        if (TBitBtn(TForm(Self).Components[I]).Tag > 0) and (TBitBtn(TForm(Self).Components[I]).Visible = True) then
          TBitBtn(TForm(Self).Components[I]).Enabled := True;
      end;

      // Desativa os Grids ligados ao DS principal
      if (TForm(Self).Components[I].ClassType = TDBGrid) and (TDBGrid(TForm(Self).Components[I]).DataSource = TDataSource(PAR_DataSource)) then
      begin
        TDBGrid(TForm(Self).Components[I]).Enabled := False;
      end;
    end;

    for I := 0 to TDataSource(PAR_DataSource).DataSet.FieldCount - 1 do
    begin
      TDataSource(PAR_DataSource).DataSet.Fields[I].ReadOnly := False;
    end;

  end else begin

    ACT_Primeiro.Enabled  := True;
    ACT_Anterior.Enabled  := True;
    ACT_Proximo.Enabled   := True;
    ACT_Ultimo.Enabled    := True;
    ACT_Inserir.Enabled   := True;
    ACT_Excluir.Enabled   := True;
    ACT_Editar.Enabled    := True;
    ACT_Salvar.Enabled    := False;
    ACT_Cancelar.Enabled  := False;
    ACT_Fechar.Enabled    := True;
    ACT_Pesquisar.Enabled := True;

    for I := 0 to TForm(Self).ComponentCount - 1 do
    begin
      // Desativa os botoes de pesquisa quando em edição
      if (TForm(Self).Components[I].ClassType = TBitBtn) then
      begin
        if (TBitBtn(TForm(Self).Components[I]).Tag > 0) and (TBitBtn(TForm(Self).Components[I]).Visible = True) then
          TBitBtn(TForm(Self).Components[I]).Enabled := False;
      end;

      // Ativa os Grids ligados ao DS principal
      if (TForm(Self).Components[I].ClassType = TDBGrid) and (TDBGrid(TForm(Self).Components[I]).DataSource = TDataSource(PAR_DataSource)) then
      begin
        TDBGrid(TForm(Self).Components[I]).Enabled := True;
      end;
    end;

    for I := 0 to TDataSource(PAR_DataSource).DataSet.FieldCount - 1 do
    begin
      TDataSource(PAR_DataSource).DataSet.Fields[I].ReadOnly := True;
    end;

  end;
end;

procedure TFormCadastros.ACT_AnteriorExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Prior');
end;

Procedure TFormCadastros.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  If (DSDados.DataSet.Active = True) and (DSDados.DataSet.State in [dsInsert, dsEdit]) then
  begin
    FN_Mensagem('Você deve salvar ou cancelar o registro!','Atenção',mtInformation,[mbOK]);
    Abort;
  end;
end;

procedure TFormCadastros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //verifica se a tecla pressionada é a tecla ENTER, conhecida pelo Delphi como #13
  If key = #13 then
  Begin
    //se for, passa o foco para o próximo campo, zerando o valor da variável Key
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

Procedure TFormCadastros.FormShow(Sender: TObject);
begin

  DS := TDataSource.Create(Self);
  DSL := TDataSource.Create(Self);

  DS := DSDados;
  DSL := DSLiterais;

  PR_MontaCampos(DSL,DS);

  TForm(Sender).Caption := '.:: '+DSLiterais.DataSet.FieldByName('LiteralTabela').AsString;

  PR_StatusComponentes(DS,'ShowForm');
  VAR_FormRetorno := TForm(Sender);

  SetChildTaborders(TForm(Sender));

end;

procedure TFormCadastros.ACT_CancelarExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Cancel');
end;

procedure TFormCadastros.ACT_EditarExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Edit');
end;

procedure TFormCadastros.ACT_ExcluirExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Delete');
end;

procedure TFormCadastros.ACT_FecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormCadastros.ACT_InserirExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Insert');
end;

procedure TFormCadastros.ACT_PesquisarExecute(Sender: TObject);
begin
  //PR_StatusComponentes(DS,'Find');
end;

procedure TFormCadastros.ACT_PrimeiroExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'First');
end;

procedure TFormCadastros.ACT_ProximoExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Next');
end;

procedure TFormCadastros.ACT_SalvarExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Post');
end;

procedure TFormCadastros.ACT_UltimoExecute(Sender: TObject);
begin
  PR_StatusComponentes(DS,'Last');
end;

Procedure TFormCadastros.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  iLoopFor: Integer;
begin
{
  { Destroy componetes DBEdit
  for iLoopFor := 0 to High( DBEdit ) do
  begin
    FreeAndNil(DBEdit[ High( DBEdit ) ]);
    SetLength( DBEdit, High( DBEdit ) );
  end;

  { Destroy componetes BitBtn
  for iLoopFor := 0 to High( BitBtn ) do
  begin
    FreeAndNil(BitBtn[ High( BitBtn ) ]);
    SetLength( BitBtn, High( BitBtn ) );
  end;

  { Destroy componetes Text
  for iLoopFor := 0 to High( Texto ) do
  begin
    FreeAndNil(Texto[ High( Texto ) ]);
    SetLength( Texto, High( Texto ) );
  end;

  { Destroy componetes Datas
  for iLoopFor := 0 to High( Datas ) do
  begin
    FreeAndNil(Datas[ High( Datas ) ]);
    SetLength( Datas, High( Datas ) );
  end;

  { Destroy componetes DBMemo
  for iLoopFor := 0 to High( DBMemo ) do
  begin
    FreeAndNil(DBMemo[ High( DBMemo ) ]);
    SetLength( DBMemo, High( DBMemo ) );
  end;

  { Destroy componetes DBChek
  for iLoopFor := 0 to High( DBChek ) do
  begin
    FreeAndNil(DBChek[ High( DBChek ) ]);
    SetLength( DBChek, High( DBChek ) );
  end;

  // Destroy componetes DBText
  for iLoopFor := 0 to High( Painel ) do
  begin
    FreeAndNil(Painel[ High( Painel ) ]);
    SetLength( Painel, High( Painel ) );
  end;
}
  Action := caFree;
  //FreeAndNil(Sender);

end;
end.
