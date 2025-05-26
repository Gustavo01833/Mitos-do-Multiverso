-- CREATE DATABASE mitosMultiverso;
USE mitosMultiverso;

-- drop database mitosMultiverso;
CREATE TABLE usuario(
	idUsuario int primary key auto_increment,
	nome varchar(45) not null,
    senha varchar(45) not null,
    email varchar(255) not null,
    dataCriacao timestamp not null default current_timestamp  
);

CREATE TABLE sistemas(
	idSistemas int primary key auto_increment,
    nome varchar(45) not null
);

CREATE TABLE sala(
	idSala int primary key auto_increment,
    fkDono int not null,
    fkSistema int not null,
    nome varchar(45) not null,
    frequencia varchar(45) not null,
    visibilidade varchar(45) not null,
    dataCriacao timestamp not null default current_timestamp ,
    descricao varchar(200) not null,
    maxJogadores tinyint not null,
	senha varchar(45) null,
    CONSTRAINT tiposVisibilidade CHECK (visibilidade IN('Público', 'Privado')),   
    CONSTRAINT tiposFrequencia CHECK (frequencia IN('Semanal', 'Mensal', 'Diário', 'Anual', 'Esporádico')),
    
    CONSTRAINT fkSalaDono FOREIGN KEY (fkDono) REFERENCES usuario(idUsuario),
    CONSTRAINT fkSalaSistema FOREIGN KEY (fkSistema) REFERENCES sistemas(idSistemas)
);


CREATE TABLE participacao(
	pkSala int,
    pkUsuario int,
    dataEntrada timestamp not null default current_timestamp,
	CONSTRAINT pkComposta PRIMARY KEY (pkSala, pkUsuario)
    
);

CREATE TABLE personagem(
	idPersonagem int primary key auto_increment,
    nome varchar(45) not null,
    vida int null,
    fkSala int,
    fkSistema int,
    fkUsuario int,
    CONSTRAINT PersonagemSala FOREIGN KEY (fkSala) REFERENCES sala(idSala),
    CONSTRAINT PersonagemSistema FOREIGN KEY (fkSistema) REFERENCES sistemas(idSistemas),
    CONSTRAINT PersonagemUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);


INSERT INTO usuario (nome, senha, email) VALUES
	('Bilt', '123456', 'bilt@gmail.com'),
	('Alf', '123456', 'alf@gmail.com'),
    ('Colt', '123456', 'colt@gmail.com');

INSERT INTO usuario (nome, senha, email, dataCriacao) VALUES
	('Kris', '123456', 'kris@gmail.com', '2025-04-29'),
	('Robert', '123456', 'roberto@gmail.com', '2025-04-03'),
    ('Noah', '123456', 'nono@gmail.com', '2025-04-03'), 
    
	('Carlo', '123456', 'carcar@gmail.com', '2024-04-29'),
	('Elídio', '123456', 'minhoca@gmail.com', '2025-04-03'),
    ('Euclides', '123456', 'clideiro@gmail.com', '2025-04-03'),
	('Matheus', '123456', 'math@gmail.com', '2025-04-03');


	SELECT * FROM usuario;

INSERT INTO sistemas (nome) VALUES
	('D&D'),
    ('Tormenta'),
    ('Call of Cthulhu'),
	('Vampiro a Máscara'),
    ('AD&D'),
    ('Ordem Paranormal');
    
    
    SELECT * FROM sistemas;
    SELECT * FROM sala;
    
INSERT INTO sala (fkDono, fkSistema, nome, frequencia, visibilidade, descricao, maxJogadores, senha) VALUES
	(1, 1, "Era uma Vez", 'Semanal', 'Público', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),
	(1, 2, "Camomila", 'Diário', 'Público', 'Carmomila', 4, 'bobo'),
    (2, 1, "Aventuras em Baixo mar", 'Anual', 'Privado', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),
    
	(1, 3, "Era uma Vez", 'Semanal', 'Público', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),
	(1, 4, "Camomila", 'Diário', 'Público', 'Carmomila', 4, 'bobo'),
    (2, 5, "Aventuras em Baixo mar", 'Anual', 'Privado', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),

	(3, 1, "Era uma Vez", 'Semanal', 'Público', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),
	(2, 2, "Camomila", 'Diário', 'Público', 'Carmomila', 4, 'bobo'),
    (2, 6, "Aventuras em Baixo mar", 'Anual', 'Privado', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo');
    
    
SELECT * FROM sala;    

INSERT INTO participacao(pkSala, pkUsuario) VALUES
	(1,1),
	(1,2),
    (1,3),
    
	(2,2),
	(2,3),

	(3,3);
    
select * from participacao;



INSERT INTO personagem (nome,vida, fkSala,fkSistema,fkUsuario) VALUES
	('Carmoleão', 10, 1, 1, 1),
	('Adalberto', 14, 1 ,1, 2),
	('Geralt', 13 , 1, 1, 3),
    
    ('Queiroz', 9 , 2, 1, 1),
	('Vilhena', 13 , 2, 1, 1);

SELECT * FROM personagem;

SELECT * FROM sala;
SET sql_mode = ' ' ;


BEGIN; -- Listagem de Salas

SELECT 
  CONCAT(COUNT(par.pkUsuario), '/', s.MaxJogadores) AS MaximoJogadores,
  s.nome,
  s.frequencia,
  sis.nome AS sistema,
  s.visibilidade
FROM sala s
JOIN sistemas sis ON s.fkSistema = sis.idSistemas
LEFT JOIN participacao par ON s.idSala = par.pkSala
GROUP BY s.idSala, s.nome, s.frequencia, sis.nome, s.visibilidade, s.MaxJogadores
HAVING 
count(par.pkUsuario) > 0;

	-- LISTAGEM DE SALAS NO GERAL
SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala;

	-- LISTAGEM DE SALA PÚBLICA
SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala
           having
           s.visibilidade = 'Público';
           
	-- LISTAGEM DE SALA PRIVADA 
    
   SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala
           HAVING 
           s.visibilidade = 'Privado';
           
         
-- LISTAGEM DE SALAS QUE O USUARIO ESPECÍFICO PARTICIPA
    
	SELECT concat(
			 (select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           WHERE u.idUsuario = 1
           GROUP BY s.idSala;
           

-- LISTAGEM DA QUANTIDADE DE JOGADORES POR SALA
SELECT s.nome as NomeSala,
	   count(par.pkUsuario) quantidadeJogadores
       from 
       sala s JOIN participacao par
       ON par.pkSala = s.idSala 
       group by s.idSala;

END;
        
        
		
               
               
         
BEGIN; -- SELECT DE PERSONAGENS DE UMA SALA ESPECÍFICA
		SELECT s.idSala,
			   s.nome,
               u.nome as Usuario,
			   per.nome as Personagem
               FROM 
               usuario u JOIN participacao p
               ON u.idUsuario = p.pkUsuario
               JOIN sala s
               ON p.pkSala = s.idSala
               JOIN sistemas sis
               ON s.fkSistema = sis.idSistemas
               JOIN personagem per
               ON s.idSala = per.fkSala and per.fkUsuario = u.idUsuario 
               WHERE s.idSala = 1;
               
               
               
-- LISTAGEM DOS PERSONAGENS JÁ CRIADOS DE UMA SALA
			SELECT 
			personagem.nome
			FROM sala JOIN personagem 
			ON sala.idSala = personagem.fkSala 
			WHERE idSala = 1;
END;	

SELECT * from usuario;

BEGIN; -- Selects para a Dashboard

-- QUANTIDADE DE USUÁRIOS CADASTRADOS ENTRE O ÚLTIMO MÊS E O ATUAL
	SELECT count(u.idUsuario) as UsuariosCadastradosNoMes 
    FROM usuario u
    WHERE dataCriacao between date_format(current_date() - interval 1 month, '%Y-%m-01') and last_day(current_date);

-- SELECT DE USUÁRIOS CADASTRADOS ENTRE O ANTEPENULTIMO MÊS E O PENULTIMO
	SELECT count(u.idUsuario) as UsuariosCadastradosNoMes 
    FROM usuario u
    WHERE dataCriacao between date_format(current_date() - interval 2 month, '%Y-%m-01') and last_day(current_date() - interval 1 month);

-- SELECT DA MÉDIA DA QUANTIDADE DE USUÁRIOS CADASTRADOS POR MÊS

SELECT round(AVG(mensal.total_usuarios), 2) AS media_usuarios_por_mes
FROM (
    SELECT 
        YEAR(dataCriacao) AS ano,
        MONTH(dataCriacao) AS mes,
        COUNT(*) AS total_usuarios
    FROM usuario
    WHERE dataCriacao >= DATE_SUB(CURRENT_DATE(), interval 12 month) -- DATE_SUB subtrai datas e horarios
    GROUP BY 
    YEAR(dataCriacao), MONTH(dataCriacao)
) AS mensal;


-- SELECT DA QUANTIDADE DE USUÁRIOS ÚNICOS QUE SÃO DONOS DE UMA SALA
	SELECT count(distinct u.idUsuario) as 'Quantidade de usuários que criaram uma sala'
    FROM usuario u JOIN sala s
    ON u.idUsuario = s.fkDono;

-- SELECT DA PORCENTAGEM DE USUÁRIOS CADASTRADOS QUE JÁ CRIARAM/SÃO DONOS DE UMA SALA
	SELECT 
		round(
			(SELECT count(distinct u.idUsuario) as usuariosDonos
			FROM usuario u JOIN sala s
			ON u.idUsuario = s.fkDono) /
			
			(select count(distinct u.idUsuario) as totalUsuarios
			FROM usuario u) * 100
        , 2) as porcentagem_usuarios_donos_de_sala
        from usuario u
        LIMIT 1;


-- SELECT MÉDIA DE PESSOAS POR SALA REGISTRADA

	SELECT round(COUNT(*) / COUNT(distinct pkSala), 2) -- QUANTIDADE DE PARTICIPAÇÕES DIVIDIDO PELA QUANTIDADE DE SALAS
    -- EXEMPLO 10 PARTICIPAÇÕES E TOTAL DE 5 SALAS = 2 PESSOAS POR SALA 
    from participacao;
    
-- SELECT DO SISTEMA MAIS UTILIZADO 

SELECT sis.nome
	   from sistemas sis join sala s
	   on sis.idSistemas = s.fkSistema
	   group by sis.nome order by count(s.fkSistema) desc limit 1;
    
-- SELECT RETORNANDO A QUANTIDADE DE VEZES UTILIZADA
SELECT sis.nome,
	   count(s.fkSistema) quantidade_usada
	   from sistemas sis join sala s
	   on sis.idSistemas = s.fkSistema
	   group by sis.nome order by quantidade_usada desc limit 1;
 END;
 
 
BEGIN;-- SELECT DA PORCENTAGEM DE CADA SISTEMA UTILIZADO
SELECT
  CASE
    WHEN sis.nome IN ( -- RETORNA O NOME DOS 4 SISTEMAS MAIS UTILIZADOS COMO 'SISTEMA'
      SELECT sis2.nome
      
      FROM sistemas sis2
      JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
      GROUP BY sis2.nome
      ORDER BY count(s2.fkSistema) DESC
	  
    ) THEN sis.nome
    ELSE 'Outros' -- SE NÃO FOR UM DOS 4 MAIS UTILIZADOS É EXIBIDO EM OUTROS
  END AS sistema, -- O RETORNO É FEITO NA COLUNA 'SISTEMA'
  ROUND(COUNT(s.fkSistema) * 100.0 / (SELECT COUNT(sala.idSala) FROM sala), 2) AS porcentagem_uso -- 
FROM sistemas sis
JOIN sala s ON sis.idSistemas = s.fkSistema
GROUP BY
sistema
ORDER BY porcentagem_uso DESC;


 -- Retorna o nome dos 4 sistemas mais utilizados
SELECT sis2.nome
      FROM sistemas sis2
      JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
      GROUP BY sis2.nome
      ORDER BY count(s2.fkSistema) DESC
      LIMIT 4;
     

     
SELECT
  CASE
    WHEN top4.nome IS NOT NULL THEN sis.nome
    ELSE 'Outros'
  END AS sistema,
  ROUND(COUNT(s.fkSistema) * 100.0 / (SELECT COUNT(idSala) FROM sala), 2) AS porcentagem_uso
FROM sistemas sis
JOIN sala s ON sis.idSistemas = s.fkSistema
LEFT JOIN (
  SELECT sis2.nome
  FROM sistemas sis2
  JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
  GROUP BY sis2.nome
  ORDER BY COUNT(s2.fkSistema) DESC
  LIMIT 4
) AS top4 ON sis.nome = top4.nome
GROUP BY sistema
ORDER BY 
porcentagem_uso, sistema DESC;

END;

select * from usuario; 

SELECT count(idUsuario) from usuario;