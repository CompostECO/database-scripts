drop database if exists composteco;
create database if not exists composteco;
use composteco;

create table estados (
  uf char(2) not null,
  nome varchar(50) not null,
  
  primary key (uf)
);

create table if not exists enderecos (
  id int auto_increment,
  cep char(9) not null,
  numero int not null,
  complemento varchar(45),
  logradouro varchar(60),
  bairro varchar(60),
  cidade varchar(60),
  estado char(2) not null,
  pais char(2) not null default 'BR',
  descricao text,
  
  primary key (id),
  constraint fk_endereco_estado foreign key (estado) references estados(uf),
  index idx_estado (estado),
  constraint chk_pais_br check (pais = 'BR')
);

create table if not exists produtores (
  id int auto_increment,

  cpf char(11) unique,
  nome varchar(60),

  cnpj char(14) unique,
  razao_social varchar(60),
  nome_fantasia varchar(60),

  filiacao int,
  endereco_id int not null unique,
  
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  
  primary key (id),
  constraint fk_produtor_endereco foreign key (endereco_id) references enderecos(id),
  constraint fk_filiacao_produtor foreign key (filiacao) references produtores(id),
  constraint chk_pessoa_fisica_juridica check ((cpf is not null and nome is not null) or (cnpj is not null and razao_social is not null and nome_fantasia is not null))
);

create table if not exists usuarios (
  id int auto_increment,
  nome varchar(255) not null unique,
  senha varchar(255) not null,
  email varchar(255) not null unique,

  nivel_acesso tinyint not null default 2, -- 1 = admin, 2 = produtor, 3 = observador
  produtor_id int not null,

  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  
  primary key (id),
  constraint fk_usuario_produtor foreign key (produtor_id) references produtores(id),
  index idx_produtor (produtor_id)
);

create table if not exists codigos_ativacao (
  id int auto_increment,
  codigo char(6) not null unique,
  produtor_id int not null,

  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,

  primary key (id),
  constraint fk_codigo_produtor foreign key (produtor_id) references produtores(id),
  index idx_produtor (produtor_id)
);

create table if not exists telefones (
  id int auto_increment,
  produtor_id int not null,
  telefone char(11) not null unique,
  tipo varchar(20) not null default 'celular',
  
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  
  primary key (id),
  constraint fk_telefone_produtor foreign key (produtor_id) references produtores(id),
  index idx_produtor (produtor_id),
  constraint chk_tipo_telefone check (tipo in ('celular','comercial','residencial'))
);

create table if not exists composteiras (
  id int auto_increment,
  produtor_id int not null,
  modelo varchar(45),
  descricao text,
  capacidade_kg decimal(6,2) not null,
  modelo_sensor varchar(45) not null,
  
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  
  primary key (id),
  constraint fk_composteira_produtor foreign key (produtor_id) references produtores(id),
  index idx_produtor (produtor_id)
);

create table if not exists deteccoes (
  id int auto_increment,
  composteira_id int,
  temperatura decimal(5,2),
  umidade decimal(5,2),
  
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,

  primary key (id),
  constraint fk_deteccao_sensor foreign key (composteira_id) references composteiras (id),
  index idx_composteira (composteira_id)
);

create table if not exists alertas (
  id int auto_increment,
  deteccao_id int not null,
  tipo varchar(60) not null,
  prioridade tinyint, -- 0 = sem risco aparente, 1 = risco moderado, 2 = risco alto, 3 = urgênte
  enviado_em datetime not null default now(),
  
  primary key (id),
  constraint fk_alerta_deteccao foreign key (deteccao_id) references deteccoes(id),
  index idx_deteccao (deteccao_id),
  constraint chk_tipo_alerta check (tipo in (
    'baixa umidade','baixa temperatura','alta umidade',
    'alta temperatura','baixa umidade e temperatura',
    'alta umidade e temperatura'
  ))
);