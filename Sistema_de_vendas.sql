-- create DATABASE
CREATE DATABASE sistema_vendas;
USE sistema_vendas;

-- Tabela FORNECEDOR
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)
);

-- Tabela PRODUTO
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor INT,
    nome VARCHAR(100) NOT NULL,
    codigo VARCHAR(50) UNIQUE,
    quantidade_estoque INT DEFAULT 0,
    valor DECIMAL(10,2) NOT NULL,
    validade DATE,
    marca VARCHAR(50),
    peso DECIMAL(10,2),
    fabricacao DATE,
    categoria VARCHAR(50),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- Tabela FUNCIONARIO
CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100)
);

-- Tabela CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela VENDA
CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

--CREATE

-- Inserir fornecedor
INSERT INTO fornecedor (cnpj, nome, telefone)
VALUES ('12.345.678/0001-99', 'Fornecedor Alfa', '(11) 98888-7777');

-- Inserir produto
INSERT INTO produto (id_fornecedor, nome, codigo, quantidade_estoque, valor, categoria)
VALUES (1, 'Camiseta Preta', 'CAM001', 50, 59.90, 'Roupas');

-- Inserir funcionário
INSERT INTO funcionario (nome, cpf, email)
VALUES ('Carlos Silva', '123.456.789-00', 'carlos@email.com');

-- Inserir cliente
INSERT INTO cliente (nome, cpf, telefone, email)
VALUES ('Maria Souza', '987.654.321-00', '(11) 97777-6666', 'maria@email.com');

-- Inserir venda
INSERT INTO venda (id_cliente, id_funcionario, id_produto, quantidade)
VALUES (1, 1, 1, 2);

--READ

-- Listar todos os produtos
SELECT * FROM produto;

-- Listar todas as vendas com informações completas
SELECT v.id_venda, c.nome AS cliente, f.nome AS funcionario,
       p.nome AS produto, v.quantidade, p.valor, (v.quantidade * p.valor) AS total
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN funcionario f ON v.id_funcionario = f.id_funcionario
JOIN produto p ON v.id_produto = p.id_produto;

-- Buscar cliente pelo CPF
SELECT * FROM cliente WHERE cpf = '987.654.321-00';

--UPDATE

-- Atualizar telefone de fornecedor
UPDATE fornecedor
SET telefone = '(11) 99999-0000'
WHERE id_fornecedor = 1;

-- Atualizar estoque e preço de um produto
UPDATE produto
SET quantidade_estoque = 100, valor = 64.90
WHERE id_produto = 1;

-- DELETE

-- Atualizar e-mail de cliente
UPDATE cliente
SET email = 'maria.nova@email.com'
WHERE id_cliente = 1;

-- Excluir uma venda
DELETE FROM venda WHERE id_venda = 1;

-- Excluir um cliente
DELETE FROM cliente WHERE id_cliente = 1;

-- Excluir produto
DELETE FROM produto WHERE id_produto = 1;
