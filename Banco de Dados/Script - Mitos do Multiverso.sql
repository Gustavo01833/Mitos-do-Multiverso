CREATE DATABASE mitosMultiverso;
USE mitosMultiverso;

CREATE TABLE usuario(
	idUsuario int primary key auto_increment,
	nome varchar(45),
    senha varchar(45),
    email varchar(255),
    dataCriacao timestamp not null default current_timestamp  
);

CREATE TABLE sistemas(
	idSistemas int primary key auto_increment,
    nome varchar(45)
);

CREATE TABLE sala(
	idSala int primary key auto_increment,
    fkDono int,
    fkSistema int,
    nome varchar(45),
    frequencia varchar(45),
    visibilidade varchar(45),
    dataCriacao timestamp not null default current_timestamp ,
    descricao varchar(200),
    maxJogadores tinyint,
	senha varchar(45),
    CONSTRAINT tiposVisibilidade CHECK (visibilidade IN('Público', 'Privado')),    
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
    
-- INSERT INTO sala (fkDono, fkSistema, nome, frequencia, visibilidade, descricao, maxJogadores)






