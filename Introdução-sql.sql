--criando tabela do negócio de pintos
create table business(
	cd_business serial primary key,
	nm_business varchar(255) not null,
	dt_createdat date not null default current_date
)

--inserindo dados na tabela do negócio
insert into business(
	nm_business
)
values('jean corporation pintudos.ltda') 

--selecionando dados da tabela do negócio
select * from business

--criando tabela do estoque
create table bs_storage(
	cd_storage serial primary key,
	nm_storage varchar(255) not null,
	cd_business integer not null, 
	foreign key(cd_business) references business(cd_business)
)
--inserindo dados na tabela do estoque
insert into bs_storage(
	nm_storage,
	cd_business
)
values('estoque2',1)

--selecionando dados da tabela do estoque
select
	bs.cd_storage as storage_code,
	bs.nm_storage,
	bn.cd_business,
	bs.dt_createdat,
	bs.cd_user,
	case
		when bu.nm_user is not null 
		then bu.nm_user 
		else 'sem usuário'
	end as nm_user
from bs_storage bs
inner join business bn
on bs.cd_business=bn.cd_business
left join bs_user bu
on bu.cd_user=bs.cd_user

--adicionando coluna de data de criação na tabela de estoque
alter table bs_storage add column dt_createdat date not null default current_date

--adicionando coluna de responsável na tabela de estoque
alter table bs_storage add column cd_user integer null 

--adicionando chave estrangeira com a tabela de usuário na tabela de estoque
alter table bs_storage add foreign key (cd_user) references bs_user(cd_user)

--excluindo coluna de usuário da tabela de estoque
alter table bs_storage drop column cd_user

--criando tabela de usuário
create table bs_user(
	cd_user serial primary key,
	nm_user varchar(255) not null,
	dt_createdat date not null default current_date
)

--incluindo registro na tabela de usuário 
insert into bs_user(nm_user) 
values('pedrão da massa')

--selecionando dados da tabela do usuário
select * from bs_user

--atualizando tabela do estoque, adicionando o código do usuário
update bs_storage
set cd_user=2
where cd_storage=1

--excluindo os dados da tabela do usuário
delete from bs_user where cd_user=2

--removendo relação de usuário da tabela do estoque
update bs_storage set cd_user=null where cd_storage=1