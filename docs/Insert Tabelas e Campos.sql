insert into Tabelas 
select 
	(select max(ATB_CdiTabela) from Tabelas) + row_number() over(order by TAB.TABLE_NAME),
	TAB.TABLE_NAME,
	TAB.TABLE_NAME,
	left(TAB.TABLE_NAME,50),
	(select top 1 LEFT(aa.column_name,3) from INFORMATION_SCHEMA.COLUMNS aa where aa.TABLE_NAME = TAB.TABLE_NAME),
	0
from INFORMATION_SCHEMA.TABLES TAB 
where not exists (select * from Tabelas where ATB_DssTabela = TAB.TABLE_NAME)
	

insert into Campos
select
	(select max(ACP_CdiCampo) from Campos) + row_number() over(order by table_name),
	COLUMN_NAME,
	ATB_CdiTabela,
	COLUMN_NAME,
	COLUMN_NAME,
	0,
	0,
	0,
	ORDINAL_POSITION,
	0,
	0,
	0
from Tabelas 
inner join information_schema.columns on table_name = ATB_DssTabela
where not exists (select * from Campos where ACP_DssCampo = COLUMN_NAME)
order by ATB_CdiTabela,ORDINAL_POSITION