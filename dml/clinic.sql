create table convenio(
    id      int,
    nome    varchar(30),
    constraint convenio_pk primary key(id),
    constraint nome_uk unique(nome)
)

create table paciente(
id          int,
cpf         varchar(14),
nome        varchar(50),
sexo        char(1),
datanasc    date,
endereco    varchar(60),
id_convenio int,
constraint paciente_pk primary key(id),
constraint cpf_uk unique(cpf),
constraint sexo check(sexo in ('M', 'F'))
)

create table medico(
id              int,
cpf             varchar(14) not null,
nome            varchar(50) not null,
crm             varchar(13),
especialidade   varchar(20),
constraint medico_pk primary key(id),
constraint med_cpf_uk unique(cpf),
constraint med_nome_uk unique(nome)
)

create table consulta(
numero      int generated always as identity,
data        date not null,
tipo        char(1) default 'C',
valor       real,
id_paciente int not null,
id_medico   int not null,
constraint consulta_pk primary key(numero),
constraint tipo_ck check(tipo in ('P', 'C')),
constraint valor_ck check(valor > 0)
)

alter table consulta add constraint consulta_paciente_fk foreign key(id_paciente) references paciente(id)
alter table consulta add constraint consulta_medico_fk foreign key(id_medico) references medico(id)

-- Inserir dados
insert into convenio values(1, 'Unimed');
insert into convenio(nome, id) values('São Franciso', 2);
select * from convenio;

insert into paciente values(1, '123.456.556-99', 'João José da Silva', 'M', '2004-03-09', 'Rua das Margaridas, 316', null);

insert into paciente(id, cpf, nome, sexo, datanasc, id_convenio) values(2, '321.947.112-65', 'Maria Felizardo', 'F', '2008-11-30', 1);

insert into paciente(id, nome, id_convenio, datanasc, cpf) values(3, 'Paulo Antunes Aguiar', 1, '14/07/2012', '615.885.001-78');

select * from paciente;

insert into medico values(1, '789.654.109-00', 'Marcelo Gonçalves', 'CRM/SP 98002', 'Cardiologia');

insert into medico values(2, '315.477.217-58', 'Vanessa Domingues', 'CRM/SP 900342', 'Neurologia');

insert into medico values(3, '712.112.347-26', 'Luciana Marques Santiago', 'CRM/MG 845543', 'Neurologia');

select * from medico;

insert into consulta(data, tipo, valor, id_paciente, id_medico) values('2024-03-18', 'P', 345.8, 1, 1);

insert into consulta(data, id_paciente, id_medico) values('2024-03-18', 1, 2);

insert into consulta(data, tipo, valor, id_paciente, id_medico) values('2024-04-10', 'P', 345.8, 1, 1);

insert into consulta(data, id_paciente, id_medico) values('2024-02-02', 2, 2);

select * from consulta;

insert into paciente(id, cpf, nome, id_convenio) values(4, '290.415.734-01', 'Márcia Godofredo', 5);

-- Atualização da dados
update medico set especialidade = 'Pediatria';

select * from medico;

update medico set especialidade = 'Cardiologia' where id = 1;

update medico set especialidade = 'Neurologia' where nome = 'Vanessa Domingues' or nome = 'Luciana Marques Santiago';

update consulta set data = '2024-04-20' where numero = 4;

select * from consulta;

update paciente set endereco = 'N/I' where id in (2, 3);

select * from paciente;

update consulta set tipo = 'P', valor = 450.8 where valor is null;

select * from consulta;

update consulta set valor = valor * 1.1 where valor > 400;

update consulta set tipo = 'C', valor = null where valor >= 450;

update paciente set endereco = null where id_convenio is not null;

select * from paciente;

-- Apagar dados em tabelas
delete from paciente where nome = 'Paulo Antunes Aguiar';

select * from paciente;
select * from consulta;
select * from convenio;

delete from consulta where valor >= 400 and valor <= 500;

delete from convenio where id = 1;

-- Transformar um FK em modo Cascade
alter table paciente drop constraint convenio_paciente_fk;

alter table paciente add constraint convenio_paciente_fk foreign key(id_convenio) references convenio(id) on delete cascade;

alter table consulta drop constraint consulta_paciente_fk;

alter table consulta add constraint consulta_paciente_fk foreign key(id_paciente) references paciente(id) on delete cascade;

update paciente set id_convenio = 2 where id = 1;

insert into paciente(id, cpf, nome, id_convenio) values(4, '111', 'Ingrid', 2);

-- Transformar um FK em Set Null
alter table paciente drop constraint convenio_paciente_fk;

alter table paciente add constraint convenio_paciente_fk foreign key(id_convenio) references convenio(id) on delete set null;

select * from paciente;
select * from convenio;
delete from convenio where id = 2;

-- Transformar um FK em Restrict
alter table paciente drop constraint convenio_paciente_fk;

alter table paciente add constraint convenio_paciente_fk foreign key(id_convenio) references convenio(id);