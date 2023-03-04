create database paperbook;

use paperbook;

create table cliente(
	idcliente int auto_increment primary key,
    idendereco int not null,
	nome varchar(100) not null,
	data_nascimento date not null,
	genero enum("Masculino","Feminino","Outros"),
	cpf varchar(12) unique not null
);

CREATE TABLE endereco(
	idendereco int auto_increment primary key,
	tipo enum("Rua","Avenida","Alameda","Travessa","Viela","Praça","Estrada"),
	logradouro varchar(100) not null,
	numero varchar(10) not null,
	complemento varchar(20),
	bairro varchar(20) not null,
	cep varchar(10) not null
);

CREATE TABLE contato(
	idcontato int auto_increment primary key,
    idcliente int not null,
	email varchar(200) not null,
	telefone varchar(15) not null
);

create table categoria(
	idcategoria int auto_increment primary key,
    nome varchar(100) not null
);

create table produto(
	idproduto int auto_increment primary key,
    idcategoria int not null,
    nome varchar(100),
    descricao text not null,
    marca varchar(100) not null,
    preco decimal(10,2) not null
);

create table pedido(
	idpedido int auto_increment primary key,
    idcliente int not null,
	idproduto int not null,
    data_pedido date not null,
    horario_pedido timestamp default current_timestamp(),
    data_entregar date not null
);

create table detalhes_pedido(
	iddetalhes_pedido int auto_increment primary key,
    idpedido int not null,
    idfornecedor int not null
);

create table fornecedor(
	idfornecedor int auto_increment primary key,
    nome varchar(150) not null,
    local_fornecimento varchar(100) not null,
    cnpj varchar(20) unique not null,
    data_produção date not null
);

ALTER TABLE `cliente`  
ADD CONSTRAINT `fk_clinte_pk_endereco`
FOREIGN KEY (`idendereco`) 
REFERENCES `endereco` (`idendereco`);

ALTER TABLE `contato`  
ADD CONSTRAINT `fk_contato_pk_cliente`
FOREIGN KEY (`idcliente`) 
REFERENCES `cliente` (`idcliente`);

ALTER TABLE `produto`  
ADD CONSTRAINT `fk_produto_pk_categoria`
FOREIGN KEY (`idcategoria`) 
REFERENCES `categoria` (`idcategoria`);

ALTER TABLE `pedido`  
ADD CONSTRAINT `fk_pedido_pk_cliente`
FOREIGN KEY (`idcliente`) 
REFERENCES `cliente` (`idcliente`);

ALTER TABLE `pedido`  
ADD CONSTRAINT `fk_pedido_pk_produto`
FOREIGN KEY (`idproduto`) 
REFERENCES `produto` (`idproduto`);

ALTER TABLE `detalhes_pedido`  
ADD CONSTRAINT `fk_detalhes_pedido_pk_pedido`
FOREIGN KEY (`idpedido`) 
REFERENCES `pedido` (`idpedido`);

ALTER TABLE `detalhes_pedido`  
ADD CONSTRAINT `fk_detalhes_pedido_pk_fornecedor`
FOREIGN KEY (`idfornecedor`) 
REFERENCES `fornecedor` (`idfornecedor`);

insert into endereco(tipo,logradouro,numero,complemento,bairro,cep) values ("Rua","Jóse Alves","121","Casa 1","Vilga Regina","08420-050");
select * from endereco;

insert into cliente(idendereco,nome,data_nascimento,genero,cpf) values ("1","Maria","1985-5-20","Feminino","220202320-20");
select * from cliente;

insert into contato(idcliente,email,telefone) values ("1","ksjsg@gmail.com","119721682");
select * from contato;

insert into categoria(nome) values ("Lápis");
select * from categoria;

insert into produto(idcategoria,nome,marca,descricao,preco) values ("1","Lápis-Utra-perfomance","Bic","Uma lindo lápis da bic e nova coleção.",10.09);
select * from produto;

insert into pedido(idcliente,idproduto,data_pedido,data_entregar) values ("1","1","2023-3-1","2023-3-5");
select * from pedido;

insert into fornecedor(nome,local_fornecimento,cnpj ,data_produção) values ("Bic","Maua,São Paulo","020.259.875/5242","2015-6-2");
select * from fornecedor;

insert into detalhes_pedido(idpedido,idfornecedor) values ("1","1");
select * from detalhes_pedido;