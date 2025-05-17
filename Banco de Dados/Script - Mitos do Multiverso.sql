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
    
	





