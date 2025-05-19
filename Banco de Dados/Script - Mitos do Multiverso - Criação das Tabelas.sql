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

INSERT INTO usuario (nome, senha, email, dataCriacao) VALUES
	('Kris', '123456', 'kris@gmail.com', '2025-04-29'),
	('Robert', '123456', 'roberto@gmail.com', '2025-04-03'),
    ('Noah', '123456', 'nono@gmail.com', '2025-04-03'), 
    
	('Carlo', '123456', 'carcar@gmail.com', '2024-04-29'),
	('Elídio', '123456', 'minhoca@gmail.com', '2025-04-03'),
    ('Euclides', '123456', 'clideiro@gmail.com', '2025-04-03'),
	('Matheus', '123456', 'math@gmail.com', '2025-04-03');


INSERT INTO sistemas (nome) VALUES
	('D&D'),
    ('Tormenta'),
    ('Call of Cthulhu'),
	('Vampiro a Máscara'),
    ('AD&D'),
    ('Ordem Paranormal');
    
    
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
       

INSERT INTO participacao(pkSala, pkUsuario) VALUES
	(1,1),
	(1,2),
    (1,3),
    
	(2,2),
	(2,3),

	(3,3);
    

INSERT INTO personagem (nome,vida, fkSala,fkSistema,fkUsuario) VALUES
	('Carmoleão', 10, 1, 1, 1),
	('Adalberto', 14, 1 ,1, 2),
	('Geralt', 13 , 1, 1, 3),
    
    ('Queiroz', 9 , 2, 1, 1),
	('Vilhena', 13 , 2, 1, 1);