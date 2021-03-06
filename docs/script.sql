
CREATE TABLE Tabelas(
	ATB_CdiTabela int NOT NULL PRIMARY KEY,
	ATB_DssTabela varchar(50),
	ATB_D1sLiteral varchar(200),
	ATB_DssLiteralPadrao varchar(50),
	ATB_CosPrefixoCampos varchar(3),
	ATB_OplDesativado int
);


CREATE TABLE CamposMascaras(
	ACM_CdiCampoMascara int NOT NULL PRIMARY KEY,
	ACM_DssCampoMascara varchar(200),
	ACM_DssMascara varchar(200)
);

CREATE TABLE Campos(
	ACP_CdiCampo int NOT NULL PRIMARY KEY,
	ACP_DssCampo varchar(50),
	ACP_CdiTabela int,
	ACP_D1sLiteral varchar(200),
	ACP_DssLiteralPadrao varchar(200),
	ACP_OplDesativado int ,
	ACP_OplInvisivel int ,
	ACP_OplObrigatorio int ,
	ACP_NuiOrdem int ,
	ACP_OplCampoChave int ,
	ACP_CdiCampoMascara int ,
	ACP_OplBloqueado int
);

CREATE TABLE CamposLookUps(
	ACL_CdiCampoLookUp int NOT NULL PRIMARY KEY,
	ACL_CdiCampoChave int NOT NULL,
	ACL_CdiCampoReferencia int NOT NULL,
	ACL_CdiCampoResultado int NOT NULL,
	ACL_DsbComandoSQL BLOB,
	ACL_CdiTabela int NOT NULL,
	ACL_DssDescricao varchar(200)
);    

CREATE TABLE Perfis(
	PER_CdiPerfil int NOT NULL PRIMARY KEY,
	PER_DssPerfil varchar(200)
);

CREATE TABLE PerfisxAcessos(
	PXA_CdiPerfilxAcesso int NOT NULL PRIMARY KEY,
	PXA_CdiPerfil int ,
	PXA_CdiAcesso int ,
	PXA_OplAtivo int
);

CREATE TABLE PerfisxUsuarios(
	PRU_CdiPerfilxUsuario int NOT NULL PRIMARY KEY,
	PRU_CdiPerfil int NOT NULL,
	PRU_CdiUsuario int
);

CREATE TABLE Usuarios(
	USR_CdiUsuario int NOT NULL PRIMARY KEY,
	USR_DssNome varchar(200) NOT NULL,
	USR_CosEmail varchar(200),
	USR_CdsUsuario varchar(100),
	USR_CosSenha varchar(100),
	USR_OplAtivo INT,
	USR_CdiPerfil int NOT NULL,
	USR_CdiPessoa int
);
    
CREATE TABLE UsuariosxAcessos(
	UAC_CdiUsuarioxAcesso int NOT NULL PRIMARY KEY,
	UAC_CdiUsuario int NOT NULL,
	UAC_CdiAcesso int NOT NULL,
	UAC_OplAtivo INT
);

CREATE TABLE Produtos(
	PRD_CdiProduto int not null primary key,
    PRD_DssProduto varchar(500),
    PRD_CosUnidade varchar(20)
);

CREATE TABLE Distribuidores(
	DIS_CdiDistribuidor int not null primary key,
    DIS_DssNomeDistribuidor varchar(500),
    DIS_CosCNPJ varchar(20)
);

CREATE TABLE Produtores(
	PRO_CdiProdutor int not null primary key,
    PRO_DssNomeProdutor varchar(500),
    PRO_CosTipoPessoa varchar(5),
	PRO_CosCPF varchar(15),
	PRO_CosCNPJ varchar(20)
);

CREATE TABLE LimitesProdsxDists(
	LPD_CdiLimiteProdxDist int not null primary key,
	LPD_CdiProdutor int,
	LPD_CdiDistribuidor int,
	LPD_VlnValorLimite numeric(18,4)
);

ALTER TABLE Campos ADD FOREIGN KEY (ACP_CdiTabela) REFERENCES Tabelas (ATB_CdiTabela);
ALTER TABLE Campos ADD FOREIGN KEY (ACP_CdiCampoMascara) REFERENCES CamposMascaras (ACM_CdiCampoMascara);

ALTER TABLE CamposLookUps ADD FOREIGN KEY(ACL_CdiTabela) REFERENCES Tabelas (ATB_CdiTabela);
ALTER TABLE CamposLookUps ADD FOREIGN KEY(ACL_CdiCampoChave) REFERENCES Campos (ACP_CdiCampo);
ALTER TABLE CamposLookUps ADD FOREIGN KEY(ACL_CdiCampoReferencia) REFERENCES Campos (ACP_CdiCampo);
ALTER TABLE CamposLookUps ADD FOREIGN KEY(ACL_CdiCampoResultado) REFERENCES Campos (ACP_CdiCampo);

ALTER TABLE PerfisxAcessos ADD FOREIGN KEY(PXA_CdiPerfil) REFERENCES Perfis (PER_CdiPerfil);
ALTER TABLE PerfisxAcessos ADD FOREIGN KEY(PXA_CdiAcesso) REFERENCES Acessos (ACE_CdiAcesso);
ALTER TABLE PerfisxUsuarios ADD FOREIGN KEY(PRU_CdiPerfil) REFERENCES Perfis (PER_CdiPerfil);
ALTER TABLE PerfisxUsuarios ADD FOREIGN KEY(PRU_CdiUsuario) REFERENCES Usuarios (USR_CdiUsuario);

ALTER TABLE Usuarios ADD FOREIGN KEY(USR_CdiPerfil) REFERENCES Perfis (PER_CdiPerfil);
ALTER TABLE Usuarios ADD FOREIGN KEY(USR_CdiPerfil) REFERENCES Perfis (PER_CdiPerfil);

ALTER TABLE UsuariosxAcessos ADD FOREIGN KEY(UAC_CdiAcesso) REFERENCES Acessos (ACE_CdiAcesso);
ALTER TABLE UsuariosxAcessos ADD FOREIGN KEY(UAC_CdiUsuario) REFERENCES Usuarios (USR_CdiUsuario);

ALTER TABLE LimitesProdsxDists ADD FOREIGN KEY(LPD_CdiProdutor) REFERENCES Produtores (PRO_CdiProdutor);
ALTER TABLE LimitesProdsxDists ADD FOREIGN KEY(LPD_CdiDistribuidor) REFERENCES Distribuidores (DIS_CdiDistribuidor);

INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (1, 'Tabelas', 'Tabelas do Sistema', 'Tabelas do Sistema', 'ATB', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (2, 'Campos', 'Campos das tabelas do sistema', 'Campos das tabelas do sistema', 'ACP', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (3, 'CamposLookUps', 'Campos de ligação das tabelas do sistema', 'Campos de ligação das tabelas do sistema', 'ACL', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (4, 'CamposMascaras', 'Mascaras dos Campos', 'Mascaras dos Campos', 'ACM', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (5, 'Perfis', 'Perfis', 'Perfis', 'PER', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (6, 'Usuarios', 'Usuarios', 'Usuarios', 'USR', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (12, 'PerfisxAcessos', 'PerfisxAcessos', 'PerfisxAcessos', 'PXA', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (13, 'PerfisxUsuarios', 'PerfisxUsuarios', 'PerfisxUsuarios', 'PRU', 0);
INSERT INTO Tabelas (ATB_CdiTabela, ATB_DssTabela, ATB_D1sLiteral, ATB_DssLiteralPadrao, ATB_CosPrefixoCampos, ATB_OplDesativado) VALUES (17, 'UsuariosxAcessos', 'UsuariosxAcessos', 'UsuariosxAcessos', 'UAC', 0);

INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (0, 'Nenhum', '');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (1, 'CPF', '000.000.000-00;0;_');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (2, 'Datas', '!99/99/9999;1;');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (3, 'CEP', '!99.999-999;1;');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (4, 'Telefone', '!(99) 99999-9999;1;');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (5, 'CNPJ', '00.000.000/0000-00;0;_');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (6, 'Numérico', '!999,99;1;_');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (7, 'Senha', '*');
INSERT INTO CamposMascaras (ACM_CdiCampoMascara, ACM_DssCampoMascara, ACM_DssMascara) VALUES (8, 'Horas', '!90:00;1;_');

INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (1, 'ATB_CdiTabela', 1, 'ATB_CdiTabela', 'ATB_CdiTabela', 0, 0, 0, 1, 1, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (2, 'ATB_DssTabela', 1, 'ATB_DssTabela', 'ATB_DssTabela', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (3, 'ATB_D1sLiteral', 1, 'ATB_D1sLiteral', 'ATB_D1sLiteral', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (4, 'ATB_DssLiteralPadrao', 1, 'ATB_DssLiteralPadrao', 'ATB_DssLiteralPadrao', 0, 0, 0, 4, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (5, 'ATB_CosPrefixoCampos', 1, 'ATB_CosPrefixoCampos', 'ATB_CosPrefixoCampos', 0, 0, 0, 5, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (6, 'ATB_OplDesativado', 1, 'ATB_OplDesativado', 'ATB_OplDesativado', 0, 0, 0, 6, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (7, 'ACP_CdiCampo', 2, 'ACP_CdiCampo', 'ACP_CdiCampo', 0, 0, 0, 1, 1, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (8, 'ACP_DssCampo', 2, 'ACP_DssCampo', 'ACP_DssCampo', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (9, 'ACP_CdiTabela', 2, 'ACP_CdiTabela', 'ACP_CdiTabela', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (10, 'ACP_D1sLiteral', 2, 'ACP_D1sLiteral', 'ACP_D1sLiteral', 0, 0, 0, 4, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (11, 'ACP_DssLiteralPadrao', 2, 'ACP_DssLiteralPadrao', 'ACP_DssLiteralPadrao', 0, 0, 0, 5, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (12, 'ACP_OplDesativado', 2, 'ACP_OplDesativado', 'ACP_OplDesativado', 0, 0, 0, 6, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (13, 'ACP_OplInvisivel', 2, 'ACP_OplInvisivel', 'ACP_OplInvisivel', 0, 0, 0, 7, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (14, 'ACP_OplObrigatorio', 2, 'ACP_OplObrigatorio', 'ACP_OplObrigatorio', 0, 0, 0, 8, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (15, 'ACP_NuiOrdem', 2, 'ACP_NuiOrdem', 'ACP_NuiOrdem', 0, 0, 0, 9, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (16, 'ACP_OplCampoChave', 2, 'ACP_OplCampoChave', 'ACP_OplCampoChave', 0, 0, 0, 10, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (17, 'ACP_CdiCampoMascara', 2, 'ACP_CdiCampoMascara', 'ACP_CdiCampoMascara', 0, 0, 0, 11, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (18, 'ACP_OplBloqueado', 2, 'ACP_OplBloqueado', 'ACP_OplBloqueado', 0, 0, 0, 12, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (19, 'ACL_CdiCampoLookUp', 3, 'ACL_CdiCampoLookUp', 'ACL_CdiCampoLookUp', 0, 0, 0, 1, 1, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (20, 'ACL_CdiCampoChave', 3, 'ACL_CdiCampoChave', 'ACL_CdiCampoChave', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (21, 'ACL_CdiCampoReferencia', 3, 'ACL_CdiCampoReferencia', 'ACL_CdiCampoReferencia', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (22, 'ACL_CdiCampoResultado', 3, 'ACL_CdiCampoResultado', 'ACL_CdiCampoResultado', 0, 0, 0, 4, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (23, 'ACL_DsbComandoSQL', 3, 'ACL_DsbComandoSQL', 'ACL_DsbComandoSQL', 0, 0, 0, 5, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (24, 'ACL_CdiTabela', 3, 'ACL_CdiTabela', 'ACL_CdiTabela', 0, 0, 0, 6, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (25, 'ACL_DssDescricao', 3, 'ACL_DssDescricao', 'ACL_DssDescricao', 0, 0, 0, 7, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (26, 'ACM_CdiCampoMascara', 4, 'ACM_CdiCampoMascara', 'ACM_CdiCampoMascara', 0, 0, 0, 1, 1, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (27, 'ACM_DssCampoMascara', 4, 'ACM_DssCampoMascara', 'ACM_DssCampoMascara', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (28, 'ACM_DssMascara', 4, 'ACM_DssMascara', 'ACM_DssMascara', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (29, 'PER_CdiPerfil', 5, 'Id Perfil', 'PER_CdiPerfil', 0, 0, 0, 1, 1, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (30, 'PER_DssPerfil', 5, 'Perfil', 'PER_DssPerfil', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (31, 'USR_CdiUsuario', 6, 'USR_CdiUsuario', 'USR_CdiUsuario', 0, 0, 0, 1, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (32, 'USR_CdiCadastro', 6, 'USR_CdiCadastro', 'USR_CdiCadastro', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (33, 'USR_DssNome', 6, 'USR_DssNome', 'USR_DssNome', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (34, 'USR_CosEmail', 6, 'USR_CosEmail', 'USR_CosEmail', 0, 0, 0, 4, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (35, 'USR_CdsUsuario', 6, 'USR_CdsUsuario', 'USR_CdsUsuario', 0, 0, 0, 5, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (36, 'USR_CosSenha', 6, 'USR_CosSenha', 'USR_CosSenha', 0, 0, 0, 6, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (37, 'USR_OplAtivo', 6, 'USR_OplAtivo', 'USR_OplAtivo', 0, 0, 0, 7, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (38, 'USR_CdiUnidadeOrganizacional', 6, 'USR_CdiUnidadeOrganizacional', 'USR_CdiUnidadeOrganizacional', 0, 0, 0, 8, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (39, 'USR_CdiPerfil', 6, 'USR_CdiPerfil', 'USR_CdiPerfil', 0, 0, 0, 9, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (40, 'USR_CdiPessoa', 6, 'USR_CdiPessoa', 'USR_CdiPessoa', 0, 0, 0, 10, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (70, 'PXA_CdiPerfilxAcesso', 12, 'PXA_CdiPerfilxAcesso', 'PXA_CdiPerfilxAcesso', 0, 0, 0, 1, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (71, 'PXA_CdiPerfil', 12, 'PXA_CdiPerfil', 'PXA_CdiPerfil', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (72, 'PXA_CdiAcesso', 12, 'PXA_CdiAcesso', 'PXA_CdiAcesso', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (73, 'PXA_OplAtivo', 12, 'PXA_OplAtivo', 'PXA_OplAtivo', 0, 0, 0, 4, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (74, 'PRU_CdiPerfilxUsuario', 13, 'PRU_CdiPerfilxUsuario', 'PRU_CdiPerfilxUsuario', 0, 0, 0, 1, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (75, 'PRU_CdiPerfil', 13, 'PRU_CdiPerfil', 'PRU_CdiPerfil', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (76, 'PRU_CdiUsuario', 13, 'PRU_CdiUsuario', 'PRU_CdiUsuario', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (87, 'UAC_CdiUsuarioxAcesso', 17, 'UAC_CdiUsuarioxAcesso', 'UAC_CdiUsuarioxAcesso', 0, 0, 0, 1, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (88, 'UAC_CdiUsuario', 17, 'UAC_CdiUsuario', 'UAC_CdiUsuario', 0, 0, 0, 2, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (89, 'UAC_CdiAcesso', 17, 'UAC_CdiAcesso', 'UAC_CdiAcesso', 0, 0, 0, 3, 0, 0, 0);
INSERT INTO Campos (ACP_CdiCampo, ACP_DssCampo, ACP_CdiTabela, ACP_D1sLiteral, ACP_DssLiteralPadrao, ACP_OplDesativado, ACP_OplInvisivel, ACP_OplObrigatorio, ACP_NuiOrdem, ACP_OplCampoChave, ACP_CdiCampoMascara, ACP_OplBloqueado) VALUES (90, 'UAC_OplAtivo', 17, 'UAC_OplAtivo', 'UAC_OplAtivo', 0, 0, 0, 4, 0, 0, 0);

INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (1, 17, 26, 27, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D2043616D706F734D617363617261735C7061720D0A7D0D0A00, 2, 'Campos x Campos Mascaras');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (2, 9, 1, 2, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D20546162656C61735C7061720D0A7D0D0A00, 2, 'Campos x Tabelas');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (3, 20, 7, 8, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D2043616D706F735C7061720D0A7D0D0A00, 3, 'Campo chave x Campos');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (4, 21, 7, 8, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D2043616D706F735C7061720D0A7D0D0A00, 3, 'Campo referencia x Campos');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (5, 22, 7, 8, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D2043616D706F735C7061720D0A7D0D0A00, 3, 'Campo resultado x Campos');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (7, 40, 41, 42, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D20506573736F61735C7061720D0A7D0D0A00, 6, 'Usuários x Pessoas');
INSERT INTO CamposLookUps (ACL_CdiCampoLookUp, ACL_CdiCampoChave, ACL_CdiCampoReferencia, ACL_CdiCampoResultado, ACL_DsbComandoSQL, ACL_CdiTabela, ACL_DssDescricao) VALUES (8, 39, 29, 30, 0x7B5C727466315C616E73695C616E7369637067313235325C64656666305C6465666C616E67313034367B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A5C766965776B696E64345C7563315C706172645C66305C667331362073656C656374202A2066726F6D205065726669735C7061720D0A7D0D0A00, 6, 'Usuários x Perfis');

INSERT INTO Perfis (PER_CdiPerfil, PER_DssPerfil) VALUES (1, 'Administrador');

INSERT INTO Usuarios (USR_CdiUsuario, USR_DssNome, USR_CosEmail, USR_CdsUsuario, USR_CosSenha, USR_OplAtivo, USR_CdiPerfil, USR_CdiPessoa) VALUES (1, 'Administrador', 'admin@admin.com', 'admin', '102030', 1, 1, null);