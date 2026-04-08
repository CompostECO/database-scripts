use composteco;

insert into estados (uf, nome) values
('AC', 'Acre'), ('AL', 'Alagoas'), ('AP', 'Amapá'), ('AM', 'Amazonas'),
('BA', 'Bahia'), ('CE', 'Ceará'), ('DF', 'Distrito Federal'), ('ES', 'Espírito Santo'),
('GO', 'Goiás'), ('MA', 'Maranhão'), ('MT', 'Mato Grosso'), ('MS', 'Mato Grosso do Sul'),
('MG', 'Minas Gerais'), ('PA', 'Pará'), ('PB', 'Paraíba'), ('PR', 'Paraná'),
('PE', 'Pernambuco'), ('PI', 'Piauí'), ('RJ', 'Rio de Janeiro'), ('RN', 'Rio Grande do Norte'),
('RS', 'Rio Grande do Sul'), ('RO', 'Rondônia'), ('RR', 'Roraima'), ('SC', 'Santa Catarina'),
('SP', 'São Paulo'), ('SE', 'Sergipe'), ('TO', 'Tocantins');

insert into enderecos (cep, numero, complemento, logradouro, bairro, cidade, estado)
values
('05145-120', 123, null, 'rua das flores', 'vila perus', 'sao paulo', 'SP'),
('13050-321', 45, 'casa fundos', 'avenida brasil', 'centro', 'campinas', 'SP'),
('11025-000', 890, 'apto 12', 'rua da praia', 'gonzaga', 'santos', 'SP'),
('06010-200', 77, null, 'rua antonio agú', 'centro', 'osasco', 'SP'),
('14020-500', 300, 'bloco b', 'rua sao jose', 'jardim paulista', 'ribeirao preto', 'SP');

-- Produtores agora são inseridos ANTES dos usuários (relação invertida)
-- CPF limpo (char(11) sem pontuação), campos PJ e filiação ficam nulos
insert into produtores (cpf, nome, endereco_id)
values
('12345678910', 'joao silva', 1),
('98765432100', 'maria oliveira', 2),
('45678912355', 'carlos souza', 3),
('32165498722', 'ana costa', 4),
('15975348699', 'lucas pereira', 5);

-- Usuários agora referenciam produtor_id e já possuem o campo email (tabela emails foi removida)
insert into usuarios (nome, senha, email, nivel_acesso, produtor_id)
values
('joao.silva', 'hash123', 'joao.silva@gmail.com', 2, 1),
('maria.oliveira', 'hash123', 'maria.oliveira@gmail.com', 2, 2),
('carlos.souza', 'hash123', 'carlos.souza@gmail.com', 2, 3),
('ana.costa', 'hash123', 'ana.costa@gmail.com', 2, 4),
('lucas.pereira', 'hash123', 'lucas.pereira@gmail.com', 2, 5);

insert into telefones (produtor_id, telefone, tipo)
values
(1, '11987654321', 'celular'),
(1, '1134567890', 'residencial'),
(2, '11976543210', 'celular'),
(2, '1145678901', 'comercial'),
(3, '11965432109', 'celular'),
(3, '1156789012', 'residencial'),
(4, '11954321098', 'celular'),
(4, '1167890123', 'comercial'),
(5, '11943210987', 'celular'),
(5, '1178901234', 'residencial');

insert into composteiras (produtor_id, modelo, capacidade_kg, tamanho)
values
(1,'eco100',100,'g'),(1,'eco50',50,'m'),(1,'bio30',30,'p'),(1,'max200',200,'gg'),(1,'mini20',20,'pp'),
(2,'eco100',100,'g'),(2,'eco50',50,'m'),(2,'bio30',30,'p'),(2,'max200',200,'gg'),(2,'mini20',20,'pp'),
(3,'eco100',100,'g'),(3,'eco50',50,'m'),(3,'bio30',30,'p'),(3,'max200',200,'gg'),(3,'mini20',20,'pp'),
(4,'eco100',100,'g'),(4,'eco50',50,'m'),(4,'bio30',30,'p'),(4,'max200',200,'gg'),(4,'mini20',20,'pp'),
(5,'eco100',100,'g'),(5,'eco50',50,'m'),(5,'bio30',30,'p'),(5,'max200',200,'gg'),(5,'mini20',20,'pp');

insert into sensores (composteira_id, modelo)
values
(1,'DHT11'),(2,'DHT11'),(3,'DHT11'),(4,'DHT11'),(5,'DHT11'),
(6,'DHT11'),(7,'DHT11'),(8,'DHT11'),(9,'DHT11'),(10,'DHT11'),
(11,'DHT11'),(12,'DHT11'),(13,'DHT11'),(14,'DHT11'),(15,'DHT11'),
(16,'DHT11'),(17,'DHT11'),(18,'DHT11'),(19,'DHT11'),(20,'DHT11'),
(21,'DHT11'),(22,'DHT11'),(23,'DHT11'),(24,'DHT11'),(25,'DHT11');

insert into deteccoes (sensor_id, temperatura, umidade)
values
(1,55,60),(2,48,65),(3,62,58),(4,70,72),(5,45,50),
(6,52,66),(7,49,61),(8,60,59),(9,68,75),(10,43,48),
(11,57,63),(12,50,64),(13,61,57),(14,69,74),(15,44,49),
(16,53,67),(17,47,62),(18,59,60),(19,67,73),(20,42,47),
(21,56,61),(22,51,65),(23,63,58),(24,71,76),(25,46,52),
(1,54,62),(2,47,66),(3,64,57),(4,72,78),(5,46,51),
(6,51,68),(7,50,60),(8,58,61),(9,66,72),(10,41,46),
(11,58,64),(12,52,63),(13,62,59),(14,70,77),(15,45,50),
(16,54,69),(17,48,63),(18,60,62),(19,68,74),(20,43,48),
(21,57,60),(22,53,66),(23,65,58),(24,73,79),(25,47,53),
(1,55,61),(2,49,67),(3,63,56),(4,71,75),(5,44,52),
(6,52,67),(7,48,62),(8,61,60),(9,67,73),(10,42,49),
(11,56,65),(12,51,64),(13,62,58),(14,69,76),(15,46,51),
(16,53,68),(17,47,61),(18,60,63),(19,68,74),(20,43,47),
(21,58,62),(22,54,65),(23,64,59),(24,72,78),(25,48,54);

insert into alertas (deteccao_id, usuario_id, tipo, prioridade)
values
(1,1,'alta temperatura', 2),
(2,2,'alta umidade', 1),
(3,3,'alta umidade e temperatura', 3),
(4,4,'baixa temperatura', 1),
(5,5,'baixa umidade', 3),
(6,1,'baixa umidade e temperatura', 3),
(7,2,'alta temperatura', 2),
(8,3,'alta umidade', 1),
(9,4,'alta umidade e temperatura', 3),
(10,5,'baixa temperatura', 2);