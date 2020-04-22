insert into Tabelas 
select DISTINCT
	(select max(ATB_CdiTabela) from Tabelas) + 1,
	TABS.RDB$RELATION_NAME,
	TABS.RDB$RELATION_NAME,
	left(TABS.RDB$RELATION_NAME,50),
	(select FIRST 1 LEFT(COL.RDB$FIELD_NAME,3) from RDB$RELATION_FIELDS COL where upper(COL.RDB$RELATION_NAME) = upper(TABS.RDB$RELATION_NAME)),
	0
from RDB$RELATION_FIELDS TABS
where not exists (select * from Tabelas where upper(ATB_DssTabela) = upper(TABS.RDB$RELATION_NAME))
AND TABS.RDB$RELATION_NAME='PRODUTOS';	


SET GENERATOR AUTOINSERTS TO 0;
insert into Campos
select
	(select max(ACP_CdiCampo) from Campos) + GEN_ID(AUTOINSERTS,1),
	RDB$FIELD_NAME,
	ATB_CdiTabela,
	RDB$FIELD_NAME,
	RDB$FIELD_NAME,
	0,
	0,
	0,
	RDB$FIELD_POSITION,
	0,
	0,
	0
from Tabelas 
inner join RDB$RELATION_FIELDS COL on upper(ATB_DssTabela) = upper(COL.RDB$RELATION_NAME)
where not exists (select * from Campos where UPPER(ACP_DssCampo) = UPPER(COL.RDB$FIELD_NAME))
order by ATB_CdiTabela, COL.RDB$FIELD_POSITION;

