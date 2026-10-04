create table jogador(
	id			serial,
	nome		varchar(50),
	cpf			varchar(14),
	data_nasc 	date,
	salario		numeric(8,2),
	id_equipe	smallint,
	constraint	jogador_pk primary key(id),
	constraint	cpf_uk unique(cpf),
	constraint	salario_ck check(salario > 0)
);

create table equipe(
	id smallint,
	nome varchar(30),
	constraint equipe_pk primary key(id)
);

alter table jogador alter nome set not null;
alter table equipe alter nome set not null;

alter table jogador add constraint id_equipe_fk
	foreign key(id_equipe) references equipe(id);

alter table jogador add contato varchar(10);

alter table jogador alter contato type varchar(20);

alter table jogador rename contato to telefone;

alter table jogador add email varchar(60);

alter table jogador drop email;

alter table equipe add estado char(2);

alter table equipe alter estado set default 'SP';

alter table equipe add constraint estado_ck check(estado in ('SP', 'RJ', 'MG', 'ES'));

alter table jogador drop constraint salario_ck;

alter table jogador add constraint salario_ck check(salario > 1000);

alter table jogador drop constraint jogador_pk;

alter table jogador add constraint pk_jogador primary key(id);

alter table equipe alter nome drop not null;

create table treinador(
	id		int,
	nome	varchar(30),
	constraint treinador_pk primary key(id)
);

alter table treinador alter nome type varchar(40);

alter table treinador add constraint nome_uk unique(nome);

alter table equipe add id_treinador int;

alter table equipe add constraint treinador_fk
	foreign key(id_treinador) references treinador(id);

alter table equipe drop constraint treinador_fk;

drop table treinador;

alter table jogador drop constraint id_equipe_fk;

drop table equipe;

drop table jogador;