/*
Vamos criar o banco de dados da loja kibaratu.
Usaremos o comando DDL(data difinition language) chamado
CREATE DATABASE nome_banco_dados
*/
CREATE DATABASE kibaratu;

#Para selecionar o banco de dados, utilize o comando USE nome_banco_dados
USE kibaratu;

/*
Para criar a tabela "USUARIO", íremos utilizar o comando DDL(DATA DEFINITION LANGUAGE) chamado
CREATE TABLE nome_da_tabela
*/

CREATE TABLE usuario(
	idusuario int auto_increment primary key,
	nomeusuario varchar(50) not null unique,
	senha varchar(255) not null
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
	email varchar(100) not null unique,
	telefone varchar(15) not null
);

CREATE TABLE cliente(
	idcliente int auto_increment primary key,
	nomecliente varchar(100) not null,
	cpf varchar(15) not null unique,
	sexo enum("Masculino","Feminino","Outros"),
	idcontato int not null,
	idendereco int not null,
	idusuario int not null
);

CREATE TABLE produto(
	idproduto int auto_increment primary key,
	nomeproduto varchar(50) not null,
	descricao text not null,
	preco decimal(8,2) not null,
	idfoto int not null
);

CREATE TABLE foto(
	idfoto int auto_increment primary key,
	foto1 varchar(255) not null,
	foto2 varchar(255),
	foto3 varchar(255),
	foto4 varchar(255)
);

CREATE TABLE pedido(
	idpedido int auto_increment primary key,
    idcliente int not null,
    datapedido timestamp default current_timestamp()
);

CREATE TABLE intespedido (
	idintespedido int auto_increment primary key,
    idpedido int not null,
    idproduto int not null,
    quantidade int not null default 1 
);

CREATE TABLE pagamento(
	idpagamento int auto_increment primary key,
    idpedido int not null,
    tipo enum ("Crédito","Débito","Boleto","Transferência bancária","Pix") not null,
    descricao text not null,
    valor decimal (8,2) not null,
	parcela int not null default 1 ,
    valorparcela decimal (8,2) not null
);


# Estabelecer o relacionamento ebtres as tableas cliente e cotanto, usuário e endereço
# Vamos usar um comando DDL (data definition language) que permite altera a estrutura da tabela 
# Neste caso iremos aplicar um relacionamento entres as tabelas cliente e contato

ALTER TABLE `cliente`  
ADD CONSTRAINT `fk_clinte_pk_contato`
FOREIGN KEY (`idcontato`) 
REFERENCES `contato` (`idcontato`);

#Relacionamento entre cliente e usuario
ALTER TABLE `cliente`  
ADD CONSTRAINT `fk_clinte_pk_usuario`
FOREIGN KEY (`idusuario`) 
REFERENCES `usuario` (`idusuario`);

#Relacionamento entre cliente e endereco
ALTER TABLE `cliente`  
ADD CONSTRAINT `fk_clinte_pk_endereco`
FOREIGN KEY (`idendereco`) 
REFERENCES `endereco` (`idendereco`);

#Relacionamento entre produto e foto
ALTER TABLE `produto`  
ADD CONSTRAINT `fk_produto_pk_foto`
FOREIGN KEY (`idfoto`) 
REFERENCES `foto` (`idfoto`);

#Relacionamento entre pedido e cliente
ALTER TABLE `pedido`  
ADD CONSTRAINT `fk_pedido_pk_cliente`
FOREIGN KEY (`idcliente`) 
REFERENCES `cliente` (`idcliente`);

#Relacionamento entre intespedido e pedido
ALTER TABLE `intespedido`  
ADD CONSTRAINT `fk_intespedido_pk_pedido`
FOREIGN KEY (`idpedido`) 
REFERENCES `pedido` (`idpedido`);

#Relacionamento entre intespedido e produto
ALTER TABLE `intespedido`  
ADD CONSTRAINT `fk_intespedido_pk_produto`
FOREIGN KEY (`idproduto`) 
REFERENCES `produto` (`idproduto`);

#Relacionamento entre pagamento e pedido
ALTER TABLE `pagamento`  
ADD CONSTRAINT `fk_pagamento_pk_pedido`
FOREIGN KEY (`idpedido`) 
REFERENCES `pedido` (`idpedido`);
