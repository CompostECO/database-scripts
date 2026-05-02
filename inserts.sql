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
('14020-500', 300, 'bloco b', 'rua sao jose', 'jardim paulista', 'ribeirao preto', 'SP'),
('19015-100', 156, null, 'rua das acácias', 'centro', 'presidente prudente', 'SP'),
('17015-130', 234, 'apto 5', 'avenida paulista', 'vila mariana', 'sao paulo', 'SP'),
('15800-000', 412, 'casa', 'rua das industrias', 'morumbi', 'sorocaba', 'SP'),
('16010-260', 89, 'bloco a', 'rua piratininga', 'centro', 'araçatuba', 'SP'),
('18100-000', 567, null, 'rua comercial', 'vila nova', 'tatuí', 'SP'),
('20040020', 1000, 'sala 500', 'avenida rio branco', 'centro', 'rio de janeiro', 'RJ');

insert into produtores (cnpj, razao_social, nome_fantasia, filiacao, endereco_id)
values
('12312312312332', 'CompostEco', 'CompostEco', null, 1),
('12345678901234', 'Agro Verde Ltda', 'Verde Compostagem', null, 2),
('98765432100123', 'Eco Produções SA', 'Eco Comp', null, 3),
('45678901234567', 'Sustenta Agro Ltda', 'Sustenta', null, 4),
('32165498701234', 'Bio Resíduos Ltda', 'Bio Eco', null, 5),
('15975398701234', 'Composto Orgânico SA', 'Composto Plus', 2, 6);

insert into produtores (cpf, nome, endereco_id)
values
('12345678910', 'João Silva', 7),
('98765432100', 'Maria Oliveira', 8),
('45678912355', 'Carlos Souza', 9),
('32165498722', 'Ana Costa', 10),
('15975348699', 'Lucas Pereira', 11);

insert into usuarios (nome, senha, email, nivel_acesso, produtor_id)
values
('Admin', 'admin123', 'admin@composteco.com', 3, 1),
('Roberto Mendes', 'senha123', 'roberto.mendes@agroverde.com', 2, 2),
('Fernanda Lima', 'senha123', 'fernanda.lima@agroverde.com', 1, 2),
('Patricia Gomes', 'senha123', 'patricia.gomes@ecoproducoes.com', 2, 3),
('Diego Martins', 'senha123', 'diego.martins@sustentaagro.com', 2, 4),
('Camila Rocha', 'senha123', 'camila.rocha@sustentaagro.com', 1, 4),
('Gustavo Alves', 'senha123', 'gustavo.alves@bioresíduos.com', 2, 5),
('Mariana Santos', 'senha123', 'mariana.santos@bioresíduos.com', 1, 5),
('Felipe Ribeiro', 'senha123', 'felipe.ribeiro@compostoplus.com', 2, 6),
('João Silva',     'senha123', 'joao.silva@gmail.com',     2, 7),
('Maria Oliveira', 'senha123', 'maria.oliveira@gmail.com', 2, 8),
('Carlos Souza',   'senha123', 'carlos.souza@gmail.com',   2, 9),
('Ana Costa',      'senha123', 'ana.costa@gmail.com',      2, 10),
('Lucas Pereira',  'senha123', 'lucas.pereira@gmail.com',  2, 11);

insert into telefones (produtor_id, telefone, tipo)
values
(1, '11987654321', 'celular'),
(1, '1134567890',  'residencial'),
(2, '11976543210', 'celular'),
(2, '1145678901',  'comercial'),
(3, '11965432109', 'celular'),
(3, '1156789012',  'residencial'),
(4, '11954321098', 'celular'),
(4, '1167890123',  'comercial'),
(5, '11943210987', 'celular'),
(5, '1178901234',  'residencial'),
(6, '11932104567', 'celular'),
(6, '1132104567',  'comercial'),
(7, '11999887766', 'celular'),
(7, '1133445566',  'residencial'),
(8, '11988776655', 'celular'),
(8, '1133556677',  'residencial'),
(9, '11977665544', 'celular'),
(9, '1133667788',  'residencial'),
(10, '11966554433', 'celular'),
(10, '1133778899',  'residencial'),
(11, '11955443322', 'celular'),
(11, '1133889900',  'residencial');

-- Composteiras atualizadas (sem tamanho, com descricao e modelo_sensor)
insert into composteiras (produtor_id, modelo, descricao, capacidade_kg, modelo_sensor)
values
(1, 'eco100', 'Composteira residencial média', 100, 'DHT11'),
(1, 'eco50',  'Composteira residencial pequena', 50, 'DHT11'),
(1, 'bio30',  'Modelo compacto para apartamentos', 30, 'DHT11'),
(1, 'max200', 'Composteira de alta capacidade', 200, 'DHT11'),
(1, 'mini20', 'Mini composteira para teste', 20, 'DHT11'),

(2, 'eco100', 'Composteira residencial média', 100, 'DHT11'),
(2, 'eco50',  'Composteira residencial pequena', 50, 'DHT11'),
(2, 'bio30',  'Modelo compacto para apartamentos', 30, 'DHT11'),
(2, 'max200', 'Composteira de alta capacidade', 200, 'DHT11'),
(2, 'mini20', 'Mini composteira para teste', 20, 'DHT11'),

(3, 'eco100', 'Composteira residencial média', 100, 'DHT11'),
(3, 'eco50',  'Composteira residencial pequena', 50, 'DHT11'),
(3, 'bio30',  'Modelo compacto para apartamentos', 30, 'DHT11'),
(3, 'max200', 'Composteira de alta capacidade', 200, 'DHT11'),
(3, 'mini20', 'Mini composteira para teste', 20, 'DHT11'),

(4, 'eco100', 'Composteira residencial média', 100, 'DHT11'),
(4, 'eco50',  'Composteira residencial pequena', 50, 'DHT11'),
(4, 'bio30',  'Modelo compacto para apartamentos', 30, 'DHT11'),
(4, 'max200', 'Composteira de alta capacidade', 200, 'DHT11'),
(4, 'mini20', 'Mini composteira para teste', 20, 'DHT11'),

(5, 'eco100', 'Composteira residencial média', 100, 'DHT11'),
(5, 'eco50',  'Composteira residencial pequena', 50, 'DHT11'),
(5, 'bio30',  'Modelo compacto para apartamentos', 30, 'DHT11'),
(5, 'max200', 'Composteira de alta capacidade', 200, 'DHT11'),
(5, 'mini20', 'Mini composteira para teste', 20, 'DHT11');

-- Detecções agora ligam direto na composteira_id
insert into deteccoes (composteira_id, temperatura, umidade) values
(1,22,75),(2,23,78),(3,21,80),(4,24,72),(5,20,70),
(6,22,82),(7,23,76),(8,21,79),(9,24,74),(10,22,73),
(11,23,77),(12,22,76),(13,24,78),(14,21,75),(15,23,74),
(16,22,79),(17,23,80),(18,21,78),(19,24,76),(20,22,75),

(1,26,78),(2,19,74),(3,23,68),(4,24,87),(5,18,69),
(6,27,82),(7,19,71),(8,22,67),(9,25,86),(10,18,68),
(11,26,84),(12,19,73),(13,23,69),(14,24,88),(15,18,70),
(16,27,83),(17,19,72),(18,22,66),(19,25,85),(20,18,67),

(1,30,65),(2,15,90),(3,28,60),(4,32,88),(5,14,50),
(6,31,64),(7,16,89),(8,29,61),(9,33,87),(10,15,52),
(11,30,66),(12,15,91),(13,28,62),(14,32,86),(15,14,53),
(16,31,63),(17,16,88),(18,29,60),(19,33,89),(20,15,51),

(1,23,76),(2,22,79),(3,21,77),(4,25,73),(5,20,72),
(6,24,83),(7,22,75),(8,21,78),(9,25,74),(10,23,71),
(11,24,77),(12,22,76),(13,25,78),(14,21,74),(15,23,73),
(16,24,79),(17,22,80),(18,21,77),(19,25,75),(20,23,74),

(1,22,74),(2,27,82),(3,19,69),(4,31,85),(5,21,71),
(6,23,76),(7,28,88),(8,18,65),(9,30,84),(10,22,73),
(11,24,77),(12,29,90),(13,17,64),(14,32,86),(15,23,72),
(16,22,75),(17,27,83),(18,19,68),(19,31,87),(20,21,70),

(1,23,75),(2,24,78),(3,22,79),(4,25,72),(5,21,71),
(6,23,81),(7,24,77),(8,22,78),(9,25,74),(10,23,73),
(11,24,76),(12,23,75),(13,25,77),(14,22,74),(15,24,73),
(16,23,78),(17,24,79),(18,22,76),(19,25,75),(20,23,74);

insert into alertas (deteccao_id, prioridade, tipo) values
(21,0,'alta temperatura'),
(22,0,'baixa temperatura'),
(23,0,'baixa umidade'),
(24,0,'alta umidade'),

(25,1,'baixa umidade'),
(26,1,'alta temperatura'),
(27,1,'baixa temperatura'),
(28,1,'alta umidade'),

(41,2,'alta temperatura'),
(42,2,'baixa temperatura'),
(43,2,'baixa umidade'),
(44,2,'alta umidade'),
(45,2,'baixa umidade e temperatura'),
(46,2,'alta umidade e temperatura'),

(61,3,'alta temperatura'),
(62,3,'baixa temperatura'),
(63,3,'baixa umidade'),
(64,3,'alta umidade'),
(65,3,'baixa umidade e temperatura'),
(66,3,'alta umidade e temperatura');