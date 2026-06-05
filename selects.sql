-- informações de um determinado produtor
select
  p.id,
  p.nome,
  p.cpf,
  u.nome as usuario,
  e.cidade,
  e.estado
from produtores p
join usuarios u on u.produtor_id = p.id
join enderecos e on e.id = p.endereco_id
where p.id = 1;

-- dados de contato (telefone e email) de um produtor específico
select
  p.nome,
  t.telefone,
  t.tipo,
  u.email
from produtores p
left join telefones t on t.produtor_id = p.id
left join usuarios u on u.produtor_id = p.id
where p.id = 1;

-- lista de composteiras de um produtor
select
  c.id,
  c.modelo,
  c.descricao,
  c.capacidade_kg,
  c.modelo_sensor
from composteiras c
where c.produtor_id = 1;

-- últimas 10 detecções de temperatura e umidade
select
  d.id,
  d.temperatura,
  d.umidade,
  d.criado_em,
  d.composteira_id
from deteccoes d
order by d.criado_em desc
limit 10;

-- detecções com informações do produtor e composteira
select
  d.id,
  d.temperatura,
  d.umidade,
  d.criado_em,
  c.id as composteira_id,
  c.modelo as composteira_modelo,
  p.nome as produtor
from deteccoes d
left join composteiras c on c.id = d.composteira_id
left join produtores p on p.id = c.produtor_id
order by d.criado_em desc;

-- alertas com dados do usuário e detecção associada
select
  a.id,
  a.tipo,
  a.enviado_em,
  u.nome as usuario,
  d.temperatura,
  d.umidade,
  d.composteira_id
from alertas a
join usuarios u on u.id = a.usuario_id
join deteccoes d on d.id = a.deteccao_id
order by a.enviado_em desc;

-- detecções com status baseado em limites
select
  d.id,
  d.temperatura,
  d.umidade,
  d.composteira_id,
case
  when d.temperatura > 65 then 'alta temperatura'
  when d.temperatura < 45 then 'baixa temperatura'
  when d.umidade > 70 then 'alta umidade'
  when d.umidade < 50 then 'baixa umidade'
  else 'normal'
end as status
from deteccoes d;

-- média de temperatura e umidade por composteira
select
  c.id as composteira_id,
  c.modelo,
  avg(d.temperatura) as media_temp,
  avg(d.umidade) as media_umidade
from composteiras c
join deteccoes d on d.composteira_id = c.id
where c.id = 1;

-- histórico de detecções de uma composteira em ordem cronológica
select
  d.temperatura,
  d.umidade,
  d.criado_em
from deteccoes d
where d.composteira_id = 1
order by d.criado_em asc;

USE composteco;
SELECT * FROM usuario;

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




