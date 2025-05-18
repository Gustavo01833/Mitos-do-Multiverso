CREATE DATABASE mitosMultiverso;
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

	SELECT * FROM usuario;

INSERT INTO sistemas (nome) VALUES
	('D&D'),
    ('Tormenta'),
    ('Call of Cthulhu');
    
    SELECT * FROM sistemas;
    SELECT * FROM sala;
    
INSERT INTO sala (fkDono, fkSistema, nome, frequencia, visibilidade, descricao, maxJogadores, senha) VALUES
	(1, 1, "Era uma Vez", 'Semanal', 'Público', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo'),
	(1, 2, "Camomila", 'Diário', 'Público', 'Carmomila', 4, 'bobo'),
    (2, 1, "Aventuras em Baixo mar", 'Anual', 'Privado', 'Era uma vez.. O que mesmo? Como vim parar aqui?', 5, 'bobo');
    
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

BEGIN; -- Listagem de Salas

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
           GROUP BY s.idSala ;
           
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
           
           
-- LISTAGEM DE SALAS QUE O USUARIO ESPECÍFCIO PARTICIPA
    
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
END;	

    
    SELECT 
    personagem.nome
    FROM sala JOIN personagem 
    ON sala.idSala = personagem.fkSala 
    WHERE idSala = 1;