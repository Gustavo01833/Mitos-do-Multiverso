CREATE DATABASE mitosMultiverso;
USE mitosMultiverso;

CREATE TABLE usuario(
	idUsuario int primary key auto_increment,
	nome varchar(45),
    senha varchar(45),
    email varchar(255),
    dataCriacao date default timestamp
);
