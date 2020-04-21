unit uDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, DB, ADODB, IniFiles, Controls, Forms,
  Dialogs, ImgList, Math, Data.FMTBcd, Data.SqlExpr, Data.DBXFirebird;

type
  TDM = class(TDataModule)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    Conexao: TADOConnection;
    SQL: TADOQuery;
    Query: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Function FN_Mensagem(PAR_Mensagem, PAR_Titulo : String; PAR_Icone : TMsgDlgType; PAR_Botoes : TMsgDlgButtons) : Integer;
  Function FN_StringToWideChar(PAR_String : String) : PWideChar;
  Function FN_SqlQuery(PAR_Script : String) : Integer;
  Function FN_CalcDistancia(LatIni, LonIni, LatFim, LonFim: Extended): Extended;
  Function FN_GetUsuarioConetado (PAR_CdiUsuario : Integer): Boolean;
  Function FN_Maximo(PAR_Tabela, PAR_Campo : String; PAR_Conexao : TADOConnection ):Integer;
  Function FN_TrocaValor(PAR_Valor, PAR_SeValor, PAR_RetValor: Double):Double;
  Function FN_SeNulo(PAR_Valor : Variant; PAR_Retorno : Double):Double;
  Function FN_RecordCount(RecDataSet : TADOQuery): Integer;
  Function FN_Crypt(Texto,Chave :String):String;

var
  DM: TDM;

implementation

{$R *.dfm}

uses UnitPrincipal, uMensagens;

Function FN_Mensagem(PAR_Mensagem, PAR_Titulo : String; PAR_Icone : TMsgDlgType; PAR_Botoes : TMsgDlgButtons) : Integer;
begin
  Application.CreateForm(TFormMensagens, FormMensagens);
  VAR_DssMensagem := PAR_Mensagem;
  VAR_DssTitulo := PAR_Titulo;
  VAR_Icones := PAR_Icone;
  VAR_Botoes := PAR_Botoes;
  FormMensagens.ShowModal;
  Result := VAR_BotaoRetorno;
end;

// Função para converter String em PWideChar
Function FN_StringToWideChar(PAR_String : String) : PWideChar;
begin
  StringToWideChar(PAR_String, Result, Length(PAR_String) + 1);
end;

// Função para executar comandos diretos no SQL
Function FN_SqlQuery(PAR_Script : String) : Integer;
Var
  QSqlQuery : TADOQuery;
begin
  QSqlQuery := TADOQuery.Create(DM);
  try
    with QSqlQuery do
    begin
      Close;
      Connection := DM.Conexao;
      Sql.Clear;
      Sql.Add(PAR_Script);
      ExecSQL;
    end;
    Result := 1;
  except
    MessageDlg('Erro ao executar o comando SQL:' +CHR(10)+CHR(13) + PAR_Script, mtError, [mbOk], 0);
    Result := 0;
  end;
  QSqlQuery.Free;
end;
// Função para calcular distancias entre coordenadas geograficas
Function FN_CalcDistancia(LatIni, LonIni, LatFim, LonFim: Extended): Extended;
var
 arcoA, arcoB, arcoC : Extended;
 auxPI : Extended;
begin
   auxPi := Pi / 180;

   arcoA := (LonFim - LonIni) * auxPi;
   arcoB := (90 - LatFim) * auxPi;
   arcoC := (90 - LatIni) * auxPi;

   // cos (a) = cos (b) . cos (c)  + sen (b) . sen (c) . cos (A)
   Result := Cos(arcoB) * Cos(arcoC) + Sin(arcoB) * Sin(arcoC) * Cos(arcoA);
   Result := (40030 * ((180 / Pi) * ArcCos(Result))) / 360;
end;
// Função para Pegar o usuário conectado
Function FN_GetUsuarioConetado (PAR_CdiUsuario : Integer): Boolean;
Var
  Consulta : TADOQuery;
begin

  Consulta := TADOQuery.Create(DM);

  with Consulta do
  begin
    Close;
    Connection := DM.Conexao;
    SQL.Clear;
    SQL.Add('select * from Usuarios ');
    SQL.Add('left join Perfis on PER_CdiPerfil = USR_CdiPerfil ');
    //SQL.Add('left join Pessoas on PES_CdiPessoa = USR_CdiPessoa ');
    SQL.Add('where USR_CdiUsuario = :P1 ');
    Parameters[0].Value := PAR_CdiUsuario;
    Open;

    if not Eof then
    begin
      VAR_CdiUsuarioConectado     := FieldByName('USR_CdiUsuario').AsInteger;
      VAR_CdiContratadoConectado  := FieldByName('USR_CdiPessoa').AsInteger;
      VAR_CdsUsuarioConectado     := FieldByName('USR_CdsUsuario').AsString;
      VAR_DssUsuarioConectado     := FieldByName('USR_DssNome').AsString;
      VAR_DssPerfilCorrente       := FieldByName('PER_DssPerfil').AsString;
    end else begin
      Application.MessageBox('Falha ao carregar as informações do usuário.','Atenção',MB_OK + MB_ICONWARNING);
      Application.Terminate;
    end;
  end;
  Consulta.Free;
end;
// Função para pegar o valor máximo de um campo inteiro na tabela
function FN_Maximo(PAR_Tabela, PAR_Campo : String; PAR_Conexao : TADOConnection ):Integer;
Var
  Consulta : TADOQuery;
begin

  Consulta := TADOQuery.Create(Nil);

  with Consulta do
  begin
    Consulta.Connection := PAR_Conexao;// DM.Conexao;
    Close;
    SQL.Clear;
    SQL.Add('select coalesce(max('+PAR_Campo+'),0) Maximo from '+PAR_Tabela);
    ExecSQL;
    Open;
  end;

  if Consulta.RecordCount = 0 then
  begin
    Result := 1;
  end else begin
    Result := Consulta.FieldByName('Maximo').AsInteger + 1;
  end;
end;
// Função para trocar um valor por outro
Function FN_TrocaValor(PAR_Valor, PAR_SeValor, PAR_RetValor: Double):Double;
begin
  if PAR_Valor = PAR_SeValor then
  begin
    Result := PAR_RetValor;
  end else begin
    Result := PAR_Valor;
  end;
end;
// Função para retornar qualquer valor quando um parametro for nulo
Function FN_SeNulo(PAR_Valor : Variant; PAR_Retorno : Double):Double;
begin
  if PAR_Valor = Null then
  begin
    Result := PAR_Retorno;
  end else begin
    Result := PAR_Valor;
  end;
end;
// Função para retornar parametros de conexão de um arquivo .ini
Function FN_RetornaParametroConexao(Arquivo : String; Sessao : String; Parametro : String):String;
Var
  VAR_Arquivo : TIniFile;
  VAR_Parametro : String;
begin
  VAR_Arquivo := TiniFile.Create(Arquivo);
  VAR_Parametro := VAR_Arquivo.ReadString(Sessao,Parametro,'');
  VAR_Arquivo.Free;

  Result := VAR_Parametro;
end;
// Função para retornar a quantidade de registros de uma Query porque o RecNo e RecordCount são bugados no DBExpress
Function FN_RecordCount(RecDataSet : TADOQuery): Integer;
var
  VAR_Record : Integer;
begin

  VAR_Record := 0;
  RecDataSet.First;

  while not RecDataSet.Eof do
  begin
    VAR_Record := VAR_Record + 1;
    RecDataSet.Next;
  end;

  Result := VAR_Record;

end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  //Conexao.Connected := True;
  WITH Conexao do
  begin
    Connected := False;
    ConnectionString := 'Provider='+ FN_RetornaParametroConexao(ExtractFilePath(Application.ExeName) + '\Conexao.ini','AGRIBUSINESS','Provider')+';'+
                        'Data Source='+ FN_RetornaParametroConexao(ExtractFilePath(Application.ExeName) + '\Conexao.ini','AGRIBUSINESS','Data Source')+';'+
                        'Persist Security Info=' + FN_RetornaParametroConexao(ExtractFilePath(Application.ExeName) + '\Conexao.ini','AGRIBUSINESS','Persist Security Info')+';';
    Connected := True;
  end;

end;

// Função de criptografia de strings
Function FN_Crypt(Texto,Chave :String):String;
Var
  x, y : Integer;
  NovaSenha : String;
begin
  for x := 1 to Length(Chave) do
  begin
    NovaSenha := '';
    for y := 1 to Length(Texto) do
      NovaSenha := NovaSenha + Chr((Ord(Chave[x]) xor Ord(Texto[y])));
    Texto := NovaSenha;
  end;
  Result := Texto;
end;

end.
