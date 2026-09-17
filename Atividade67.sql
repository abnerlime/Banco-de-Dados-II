create table pessoa (
  id_pessoa int auto_increment primary key,
  nome varchar(100),
  cpf char(11),
  telefone varchar(20)
);

select * from pessoa;

create table paciente (
  id_paciente int_auto increment primary key,
  debito_exames decimal(10,2),
  id_pessoa int,

  foreign key (id_pessoa) references pessoa(ID)
);

create table unidade (
  id_unidade int auto_increment primary key,
  nome_unidade varchar(100)
);

create table profissional (
  id_profissional int auto_increment primary key,
  crm_coren varchar(20),
  salario decimal(10,2),
  id_pessoa int,
  id_unidade int,

  foreign key (id_pessoa) references pessoa(id),
  foreign key (id_unidade) references unidade(id)
);

-- Tabelas criadas. A partir daqui irei inserir os valores.
insert into unidade (nome_unidade) values
  ('Cardiologia'),
  ('Pronto Atendimento'),
  ('Oncologia');

insert into pessoa (nome, cpf, telefone) values 
  ('Dr. Goku', 111, 9999-0001),
  ('Enf. Buma', 222, 9999-0002),
  ('Vegeta, 333, 9999-0003),
  ('Piccolo', 444, 9999-0004),
  ('Dra. Videl', 555, 9999-0005),
  ('Dr. Gohan', 666, 9999-0006),
  ('Trunks', 777, 9999-0007),
  ('Majin Boo', 888, 9999-0008),
  ('Broly', 999, 9999-0009);

insert into profissional (crm_coren, salario, id_pessoa, id_unidade) values
  ('MD123', 15000.00, 1, 1),
  ('ENF456', 6000.00, 2, 2),
  ('TEC789', 4500.00, 3, 2),
  ('MD555', 12000.00, 5, 1),
  ('MD666', 20000.00, 6, 3),
  ('MD888', 18000.00, 8, 3);

  insert into paciente (debito_exame, id_pessoa) values
    (250.00, 3),
    (1200.00, 4),
    (3500.00, 7),
    (50.00, 9);

  alter table profissional add status_plantao varchar(20) default 'Indisponível';

  select status_plantao from profissional;

  updade profissional set status_plantao = 'Disponível' where salario > 10000;

  
