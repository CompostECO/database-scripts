drop database if exists composteco;
create database if not exists composteco;
use composteco;

create table estado (
  uf char(2) not null,
  nome varchar(50) not null,
  primary key (uf)
);

create table if not exists endereco (
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
  constraint fk_endereco_estado foreign key (estado) references estado(uf),
    index idx_estado (estado),
  constraint chk_pais_br check (pais = 'BR')
);

create table if not exists produtor (
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
  constraint fk_produtor_endereco foreign key (endereco_id) references endereco(id),
  constraint fk_filiacao_produtor foreign key (filiacao) references produtor(id),
  constraint chk_pessoa_fisica_juridica check ((cpf is not null and nome is not null) or (cnpj is not null and razao_social is not null and nome_fantasia is not null))
);

create table if not exists composteira (
  id int auto_increment,
  produtor_id int not null,
  modelo varchar(45),
  descricao text,
  capacidade_kg decimal(6,2) not null,
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  primary key (id),
  constraint fk_composteira_produtor foreign key (produtor_id) references produtor(id),
    index idx_produtor (produtor_id)
);


create table if not exists sensor (
  id int auto_increment,
  composteira_id int not null, 
  modelo_sensor varchar(45),
  instalado_em datetime default now(),
  desativado_em datetime,
  primary key (id),
  constraint fk_sensor_composteira foreign key (composteira_id) references composteira(id),
index idx_composteira (composteira_id)
);

create table if not exists deteccao (
  id int auto_increment,
  sensor_id int not null,
  temperatura decimal(5,2),
  umidade decimal(5,2),
  criado_em datetime not null default now(),
  primary key (id),
  constraint fk_deteccao_sensor foreign key (sensor_id) references sensor(id),
index idx_sensor (sensor_id)
);

create table if not exists usuario (
  id int auto_increment,
  nome varchar(255) not null unique,
  senha varchar(255) not null,
  email varchar(255) not null unique,
  nivel_acesso tinyint not null default 2, -- 1 = admin, 2 = admin-produtor, 3 = observador
  produtor_id int not null,
  criado_em datetime not null default now(),
 atualizado_em datetime,
  desativado_em datetime, 
  primary key (id),
  constraint fk_usuario_produtor foreign key (produtor_id) references produtor(id),
    index idx_produtor (produtor_id)
);

create table if not exists alerta (
  id int auto_increment,
  composteira_id  int not null,
  tipo varchar(60) not null,
  prioridade tinyint, -- 0 = risco baixo, 1 = risco moderado, 2 = risco alto, 3 = urgênte
  enviado_em datetime not null default now(),
  primary key (id),
  constraint fk_alerta_composteira foreign key (composteira_id) references composteira(id),
index idx_composteira (composteira_id),
  constraint chk_tipo_alerta check (tipo in (
    'baixa umidade','baixa temperatura','alta umidade',
    'alta temperatura','baixa umidade e temperatura',
    'alta umidade e temperatura', 'baixa umidade e alta temperatura',
    'alta umidade e baixa temperatura'
  ))
);

create table if not exists telefone (
  id int auto_increment,
  produtor_id int not null,
  telefone char(11) not null unique,
  tipo varchar(20) not null default 'celular',
  
  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,
  
  primary key (id),
  constraint fk_telefone_produtor foreign key (produtor_id) references produtor(id),
  index idx_produtor (produtor_id),
  constraint chk_tipo_telefone check (tipo in ('celular','comercial','residencial'))
);

create table if not exists codigo_ativacao (
  id int auto_increment,
  codigo char(6) not null unique,
  produtor_id int not null,

  criado_em datetime not null default now(),
  atualizado_em datetime,
  desativado_em datetime,

  primary key (id),
  constraint fk_codigo_produtor foreign key (produtor_id) references produtor(id),
  index idx_produtor (produtor_id)
);

-- view que junta os dados de deteccao a uma composteira
CREATE OR REPLACE VIEW vw_grafico
AS
SELECT us.id AS id_usuario, pro.nome_fantasia AS trabalha_em, com.id AS id_composteira,com.modelo AS modelo_composteira, de.temperatura AS registro_temperatura, de.umidade AS registro_umidade ,de.criado_em AS data_registro FROM usuario AS us
JOIN produtor AS pro ON us.produtor_id = pro.id
JOIN composteira AS com ON com.produtor_id = pro.id
JOIN sensor AS se ON se.composteira_id = com.id 
JOIN deteccao AS de ON de.sensor_id = se.id;

-- view que pega a média de deteccoes feitas e uma hora
CREATE OR REPLACE VIEW vw_media_por_hora
AS
SELECT id_usuario, id_composteira, modelo_composteira AS nome, TRUNCATE(AVG(registro_temperatura), 0) AS temperatura, TRUNCATE(AVG(registro_umidade), 0) AS umidade, HOUR(data_registro) AS hora_registro FROM vw_grafico
WHERE DATE(data_registro) = DATE(NOW())
GROUP BY id_usuario,id_composteira, HOUR(data_registro)
ORDER BY id_usuario, hora_registro, temperatura, umidade ASC;

-- view que pega a ultima 4 horas de alerta
CREATE OR REPLACE VIEW vw_ultimos_alertas
AS
SELECT us.id AS id_usuario, com.id AS composteira_id, al.id AS alerta_id, al.tipo AS tipo_alerta, al.prioridade AS prioridade_alerta, al.enviado_em AS data_alerta FROM usuario AS us
JOIN produtor AS pro ON us.produtor_id = pro.id
JOIN composteira AS com ON com.produtor_id = pro.id
JOIN alerta AS al ON al.composteira_id = com.id
ORDER BY alerta_id ASC;

-- views para os gráficos da página de dashboard
CREATE OR REPLACE VIEW vw_grafico2
AS
SELECT  pro.nome_fantasia AS trabalha_em, com.id AS id_composteira,com.modelo AS modelo_composteira, de.temperatura AS registro_temperatura, de.umidade AS registro_umidade ,de.criado_em AS data_registro FROM produtor AS pro 
JOIN composteira AS com ON com.produtor_id = pro.id
JOIN sensor AS se ON se.composteira_id = com.id 
JOIN deteccao AS de ON de.sensor_id = se.id;

CREATE OR REPLACE VIEW vw_media_por_dia
AS
SELECT id_composteira, modelo_composteira AS nome, TRUNCATE(AVG(registro_temperatura), 0) AS temperatura, TRUNCATE(AVG(registro_umidade), 0) AS umidade, DATE(data_registro) AS hora_registro FROM vw_grafico2
WHERE DATE(data_registro) > DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY id_composteira, DATE(data_registro)
ORDER BY hora_registro ASC;

CREATE OR REPLACE VIEW vw_media_por_mes
AS
SELECT  id_composteira, modelo_composteira AS nome, TRUNCATE(AVG(registro_temperatura), 0) AS temperatura, TRUNCATE(AVG(registro_umidade), 0) AS umidade, MONTH(data_registro) AS hora_registro FROM vw_grafico2
WHERE DATE(data_registro) > DATE_SUB(NOW(), INTERVAL 12 MONTH)
GROUP BY id_composteira, MONTH(data_registro)
ORDER BY hora_registro ASC;

CREATE OR REPLACE VIEW vw_media_por_hora_composteira
AS
SELECT  id_composteira, modelo_composteira AS nome, TRUNCATE(AVG(registro_temperatura), 0) AS temperatura, TRUNCATE(AVG(registro_umidade), 0) AS umidade, HOUR(data_registro) AS hora_registro FROM vw_grafico2
WHERE DATE(data_registro) = DATE(NOW())
GROUP BY id_composteira, HOUR(data_registro)
ORDER BY hora_registro ASC;
