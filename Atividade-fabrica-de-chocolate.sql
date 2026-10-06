USE db_fabrica_chocolate;
-- Questão 1 

CREATE TABLE tb_setor (
	id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome_setor VARCHAR(50) NOT NULL UNIQUE,
    andar INT
);

CREATE TABLE tb_funcionario (
	id_funcinario INT AUTO_INCREMENT PRIMARY KEY,
	nome_funcionario VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    data_admissao DATE,
    id_setor INT,
    
    CONSTRAINT fk_func_set FOREIGN KEY (id_setor) REFERENCES tb_setor(id_setor),
	CONSTRAINT chk_salario CHECK (SALARIO > 0)
);

CREATE TABLE tb_fornecedor(
	id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    pais VARCHAR(50)

);

CREATE TABLE tb_ingrediente (
	id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nome_ingrediente VARCHAR(50),
    preco_kg DECIMAL(10,2),
    estoque_kg DECIMAL(10,2) DEFAULT 0,
    id_fornecedor INT, 
    
    CONSTRAINT chk_preco CHECK (preco_kg > 0),
    CONSTRAINT chk_estoque CHECK (estoque_kg >= 0),
    CONSTRAINT fk_ingre_forn FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor) 
);

CREATE TABLE tb_produto (
	id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(30),
    preco_venda DECIMAL(10,2),
    estoque INT DEFAULT 0,
    
    CONSTRAINT chk_preco_prod CHECK (preco_venda > 0)
);

CREATE TABLE tb_receita (
	id_produto INT,
	id_ingrediente INT, 
	qtd_kg DECIMAL(10,3) NOT NULL,

	PRIMARY KEY (id_produto, id_ingrediente),
    CONSTRAINT fk_rec_prod FOREIGN KEY (id_produto) REFERENCES tb_produto(id_produto),
    CONSTRAINT fk_rec_ingre FOREIGN KEY (id_ingrediente) REFERENCES tb_ingrediente(id_ingrediente)
    
);

CREATE TABLE tb_cliente (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    tipo VARCHAR(20)


);

CREATE TABLE tb_pedido (
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT, 
    data_pedido DATE NOT NULL,
    status_pedido VARCHAR(20) DEFAULT 'Pendente',
    
    CONSTRAINT fk_ped_cli FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
    
);

CREATE TABLE tb_item_pedido (
	id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    
    CONSTRAINT chk_quantidade CHECK (quantidade > 0),
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_itemped_ped FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido),
    CONSTRAINT fk_itemped_prod FOREIGN KEY (id_produto) REFERENCES tb_produto(id_produto)

);

-- Questão 1.1

INSERT INTO tb_setor (nome_setor, andar) VALUES
('Sala de Chocolate', 0),
('Sala de Invenções', 1),
('Sala de Embalagem', 0),
('Sala das Nozes', 2),
('Sala de Televisão', 3);

INSERT INTO tb_funcionario (nome_funcionario, cargo, salario, data_admissao, id_setor) VALUES
('Willy Wonka', 'Diretor', 25000.00, '2000-01-10', 2),
('Charlie Bucket', 'Aprendiz', 1800.00, '2024-03-01', 2),
('Vovô Joe', 'Supervisor', 4200.00, '2023-06-15', 1),
('Oompa Loompa Lux', 'Operador', 2500.00, '2019-05-20', 1),
('Oompa Loompa Zim', 'Operador', 2600.00, '2020-08-11', 1),
('Oompa Loompa Bip', 'Embalador', 2200.00, '2021-02-03', 3),
('Oompa Loompa Tuk', 'Embalador', 2300.00, '2022-09-14', 3),
('Oompa Loompa Nox', 'Tratador de Esquilos', 2100.00, '2018-11-30', 4),
('Senhora Bucket', 'Embaladora', 2400.00, '2024-01-08', 3),
('Oompa Loompa Kip', 'Operador', 2700.00, '2017-04-22', NULL);

select * from tb_funcionario;

INSERT INTO tb_fornecedor (nome_fornecedor, pais) VALUES
('Cacau Loompalândia', 'Loompalândia'),
('Açúcar Doce Vale', 'Brasil'),
('Laticínios dos Alpes', 'Suíça'),
('Nozes & Cia', 'Turquia'), 
('Baunilha Real', 'Madagascar');

INSERT INTO tb_ingrediente (nome_ingrediente, preco_kg, estoque_kg, id_fornecedor) VALUES
('Cacau em pó', 45.00, 500, 1),
('Manteiga de cacau', 80.00, 200, 1),
('Açúcar refinado', 5.50, 1000, 2),
('Leite em pó', 32.00, 300, 3),
('Avelã', 95.00, 80, 4),
('Amendoim', 22.00, 150, 4),
('Caramelo', 28.00, 0, 2);

INSERT INTO tb_produto (nome_produto, categoria, preco_venda, estoque) VALUES
('Barra Wonka ao Leite', 'Barra', 12.90, 500),
('Barra Wonka Amargo 70%', 'Barra', 15.90, 300),
('Bombom de Avelã', 'Bombom', 4.50, 1000),
('Chiclete Três Refeições', 'Guloseima', 29.90, 50),
('Ovo de Páscoa Dourado', 'Sazonal', 89.90, 20),
('Bala Eterna', 'Guloseima', 3.00, 2000),
('Trufa de Caramelo', 'Bombom', 6.50, 0);

INSERT INTO tb_receita (id_produto, id_ingrediente, qtd_kg) VALUES 
(1, 1, 0.020),
(1, 3, 0.030),
(1, 4, 0.040),
(2, 1, 0.050),
(2, 2, 0.020),
(2, 3, 0.010),
(3, 1, 0.005),
(3, 5, 0.008), 
(3, 4, 0.005),
(5, 1, 0.200), 
(5, 2, 0.100), 
(5, 4, 0.100), 
(5, 5, 0.050),
(7, 1, 0.010), 
(7, 7, 0.010);

SELECT * FROM tb_receita;

INSERT INTO tb_cliente (nome_cliente, cidade, tipo) VALUES
('Doces da Veruca', 'Londres', 'Atacado'),
('Mercado Gloop', 'Düsseldorf', 'Varejo'),
('Loja Beauregarde', 'Atlanta', 'Varejo'),
('Teavee Distribuidora', 'Denver', 'Atacado'),
('Confeitaria Bucket', 'Londres', 'Varejo');

INSERT INTO tb_pedido (id_cliente, data_pedido, status_pedido) VALUES
(1, '2025-03-10', 'Entregue'),
(1, '2025-04-02', 'Entregue'),
(2, '2025-04-15', 'Entregue'),
(3, '2025-05-20', 'Cancelado'),
(4, '2025-06-01', 'Em produção'),
(2, '2025-06-18', 'Pendente'),
(4, '2025-07-07', 'Entregue');

INSERT INTO tb_item_pedido (id_pedido, id_produto, quantidade, preco_unitario) values
(1, 1, 100, 12.90),
(1, 3, 200, 4.50),
(2, 2, 50, 15.90), 
(2, 5, 5, 89.90),
(3, 1, 30, 12.90), 
(3, 6, 100, 3.00),
(4, 4, 10, 29.90),
(5, 3, 300, 4.50), 
(5, 2, 80, 15.90),
(6, 6, 50, 3.00),  
(6, 1, 20, 12.90),
(7, 5, 10, 89.90), 
(7, 1, 150, 12.90);

SELECT * FROM tb_item_pedido;

-- Questão 2.1

ALTER TABLE tb_funcionario ADD email VARCHAR(100);
ALTER TABLE tb_ingrediente ADD situacao_estoque VARCHAR(20) DEFAULT 'Normal';
ALTER TABLE tb_produto ADD ativo CHAR(1) DEFAULT 'S';
ALTER TABLE tb_cliente MODIFY COLUMN cidade VARCHAR(80);
ALTER TABLE tb_setor RENAME COLUMN andar to pavimento;

DESCRIBE tb_ingrediente;

select * from tb_funcionario;
SELECT * FROM tb_ingrediente;
UPDATE tb_funcionario SET email = LOWER(CONCAT(REPLACE(nome_funcionario, ' ', '.'), '@wonka.com')) WHERE id_funcinario > 0;
ALTER TABLE tb_funcionario RENAME COLUMN id_funcinario TO id_funcionario;

-- Questão 2.2

UPDATE tb_ingrediente SET situacao_estoque = REPLACE(situacao_estoque, 'Normal', 'Crítico') WHERE estoque_kg > 0 AND estoque_kg < 100 AND id_ingrediente > 0; 

select * from tb_ingrediente;

UPDATE tb_ingrediente SET situacao_estoque = 'Esgotado' WHERE estoque_kg = 0 AND id_ingrediente > 0;

SELECT * FROM tb_funcionario;

UPDATE tb_funcionario SET salario = salario * 1.08 WHERE nome_funcionario LIKE 'Oompa Loompa' AND data_admissao < '2021-01-01' AND id_funcionario > 0;

UPDATE tb_funcionario SET cargo = 'Herdeiro', salario = 9500.00 WHERE id_funcionario = 2;


select * from tb_receita 

-- UPDATE tb_produto SET preco_venda = poreco_venda * 1.10 WHERE id_produto IN 
