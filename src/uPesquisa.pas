unit uPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons, Mask, DBCtrls,
  Vcl.Imaging.pngimage, Data.FMTBcd, Data.SqlExpr;

type
  TFormPesquisa = class(TForm)
    Panel1: TPanel;
    DSPesquisa: TDataSource;
    GroupBox1: TGroupBox;
    edtPesquisa: TEdit;
    btnPesquisar: TBitBtn;
    Image1: TImage;
    DBGridDados: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    pTopo: TPanel;
    QPesquisas: TADOQuery;
    procedure DBGridDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure QPesquisasAfterOpen(DataSet: TDataSet);
    procedure DBGridDadosTitleClick(Column: TColumn);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridDadosDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPesquisa: TFormPesquisa;
  // Variáveis de consulta do form Owner
  VAR_Tabela, VAR_Campos, VAR_Select, VAR_Filtro : String;
  VAR_NomesCampos : Array of String;

  // Variáveis de retorno ao form Owner
  VAR_ObjetoRetorno : TObject;
  VAR_FormRetorno : TControl;
  VAR_CampoRetorno : String;
  VAR_TipoRetorno : String; // Se (Campo) o retorno é para um campo LookUp / Se (Form) o retorno é para um Form
  VAR_QueryRetorno : TADOQuery; // Query que será retornado o valor da pesquisa para Form
  VAR_CampoChave : String; //Campo chave da tabela para consulta em caso de Form

  // Variáveis usadas no form pesquisa
  VAR_CampoPesquisa : String;
  VAR_TipoCampo : TFieldType;

  ComandoSQL : TDBRichEdit;   //Variavel que vai receber o conteudo do campo BLOB comando SQL

implementation

{$R *.dfm}

Uses uDM, uCadastros;

procedure TFormPesquisa.DBGridDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 FormCadastros.PR_PersonalizaGrid(TDBGrid(Sender),Rect,DataCol,Column,State);
  {
  if Column.Width > 200 then
  begin
    Column.Width := 200;
  end;

  if odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
    TDBGrid(Sender).Canvas.Brush.Color:= clMenuBar
  else
    TDBGrid(Sender).Canvas.Brush.Color:= clCream;

  TDbGrid(Sender).Canvas.font.Color:= clBlack;

  if gdSelected in State then
  with (Sender as TDBGrid).Canvas do
  begin
    Brush.Color := clMoneyGreen;
    FillRect(Rect);
    Font.Style := [fsBold]
  end;

  TDbGrid(Sender).DefaultDrawDataCell(Rect, TDbGrid(Sender).columns[datacol].field, State);
}
end;

procedure TFormPesquisa.FormShow(Sender: TObject);
begin

  with QPesquisas do
  begin
    Close;
    SQL.Clear;
    if VAR_Select = EmptyStr then
    begin
      SQL.Add('select '+VAR_Campos+' from '+ VAR_Tabela +' where 1 = 1 '+VAR_Filtro);
    end else begin
      SQL.Add(VAR_Select + ' where 1 = 1 '+ VAR_Filtro);
    end;
    Open;
  end;
end;

procedure TFormPesquisa.QPesquisasAfterOpen(DataSet: TDataSet);
Var
  I : Integer;
begin

  For I := 0 to DBGridDados.Columns.Count - 1 do
  begin

    with DM.Query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select ACP_D1sLiteral from Campos where UPPER(ACP_DssCampo) like UPPER(:P1)');
      Parameters.ParamByName('P1').Value := DBGridDados.Columns[I].FieldName;
      Open;

      if RecordCount > 0 then
      begin
        DBGridDados.Columns[I].Title.Caption := FieldValues['ACP_D1sLiteral'];
        DBGridDados.Columns[I].Width := DBGridDados.Columns[I].Field.Size;
        if DBGridDados.Columns[I].Width < Length(FieldValues['ACP_D1sLiteral']) * 8 then
          DBGridDados.Columns[I].Width := Length(FieldValues['ACP_D1sLiteral']) * 8;
      end;
    end;

    //DBGridDados.Columns[I].Title.Caption := VAR_NomesCampos[I]
  end;

end;

procedure TFormPesquisa.DBGridDadosTitleClick(Column: TColumn);
begin

  GroupBox1.Caption := ' Pesquisa por: '+Column.Title.Caption+' ';
  VAR_CampoPesquisa := Column.FieldName;
  VAR_TipoCampo := Column.Field.DataType;
  edtPesquisa.Clear;
  edtPesquisa.SetFocus;

end;

procedure TFormPesquisa.btnPesquisarClick(Sender: TObject);
begin
  if VAR_CampoPesquisa = EmptyStr then
  begin
    MessageDlg('Seleciona alguma coluna para pesquisar!',mtInformation,[mbOK],1);
    Abort;
  end;

  with QPesquisas do
  begin
    Close;
    SQL.Clear;

    if VAR_Select = EmptyStr then
    begin
      if edtPesquisa.Text = EmptyStr then
      begin
        SQL.Add('select '+VAR_Campos+' from '+VAR_Tabela+' where 1 = 1 '+VAR_Filtro);
      end else begin
        if (VAR_TipoCampo = ftDate) or (VAR_TipoCampo = ftDateTime) then
        begin
          try
            SQL.Add('select '+VAR_Campos+' from '+VAR_Tabela+' where '+VAR_CampoPesquisa+' = '+QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',StrToDateTime(edtPesquisa.Text)))+' '+VAR_Filtro);
          except
            Application.MessageBox('Data inválida para pesquisa!','Atenção',MB_OK + MB_ICONINFORMATION);
            Abort;
          end;
        end else begin;
          SQL.Add('select '+VAR_Campos+' from '+VAR_Tabela+' where '+VAR_CampoPesquisa+' like '+QuotedStr('%'+edtPesquisa.Text+'%')+' '+VAR_Filtro);
        end;
      end;
    end else begin
      if edtPesquisa.Text = EmptyStr then
      begin
        SQL.Add(VAR_Select+' where 1 = 1 '+VAR_Filtro);
      end else begin
        if (VAR_TipoCampo = ftDate) or (VAR_TipoCampo = ftDateTime) then
        begin
          try
            SQL.Add(VAR_Select+' where '+VAR_CampoPesquisa+' = '+QuotedStr(FormatDateTime('yyyy-MM-dd HH:mm:ss',StrToDateTime(edtPesquisa.Text)))+' '+VAR_Filtro);
          except
            Application.MessageBox('Data inválida para pesquisa!','Atenção',MB_OK + MB_ICONINFORMATION);
            Abort;
          end;
        end else begin
          SQL.Add(VAR_Select+' where '+VAR_CampoPesquisa+' like '+QuotedStr('%'+edtPesquisa.Text+'%')+' '+VAR_Filtro);
        end;
      end;
    end;
    Open;
  end;
end;

procedure TFormPesquisa.edtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #13 then
  begin
    btnPesquisar.Click;
  end;
end;

procedure TFormPesquisa.DBGridDadosDblClick(Sender: TObject);
Var
  I : Integer;
begin

  if VAR_TipoRetorno = 'Campo' then
  begin
    for I := 0 to VAR_FormRetorno.ComponentCount - 1 do
    begin
      if TObject(VAR_FormRetorno.Components[I]) = VAR_ObjetoRetorno then
      begin
        if VAR_ObjetoRetorno.ClassName = 'TEdit' then
        begin
          TEdit(VAR_FormRetorno.Components[I]).Text := Trim(QPesquisas.FieldByName(VAR_CampoRetorno).AsString);
          TEdit(VAR_FormRetorno.Components[I]).SetFocus;
        end;

        if VAR_ObjetoRetorno.ClassName = 'TDBEdit' then
        begin
          TDBEdit(VAR_FormRetorno.Components[I]).DataSource.DataSet.FieldByName(TDBEdit(VAR_FormRetorno.Components[I]).DataField).Value := Trim(QPesquisas.FieldByName(VAR_CampoRetorno).AsString);
          TDBEdit(VAR_FormRetorno.Components[I]).SetFocus;
        end;
      end;
    end;
  end;

  if VAR_TipoRetorno = 'Form' then
  begin
    VAR_QueryRetorno.Locate(VAR_CampoChave,QPesquisas.FieldByName(VAR_CampoChave).Value,[loCaseInsensitive]);
  end;

  if VAR_TipoRetorno = 'Form1' then
  begin
    with VAR_QueryRetorno do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from '+VAR_Tabela+' where 1 = 1 and '+VAR_CampoChave+' = '+QPesquisas.FieldByName(VAR_CampoChave).AsString);
      Open;
    end;
  end;
  Close;
end;

procedure TFormPesquisa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  VAR_Select := EmptyStr;
  Action := caFree;
end;

end.
