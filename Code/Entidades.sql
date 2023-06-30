-- Mecenas:
-- DROP TABLE Using_Schema.Mecenas
CREATE TABLE Using_Schema.Mecenas (
	ID_Mecenas INT PRIMARY KEY NOT NULL,
	Interno VARCHAR(5), -- aqui pode ser apenas true ou false
	Mecenas VARCHAR(100)
);

-- Itenerário
-- DROP TABLE Using_Schema.Itenerario
CREATE TABLE Using_Schema.Itenerario (
	ID_Itenerario INT PRIMARY KEY NOT NULL,
	Deslocacoes VARCHAR(150)
);

--Responsavel
--DROP TABLE Using_Schema.Responsavel
CREATE TABLE Using_Schema.Responsavel(
	ID_Responsavel INT PRIMARY KEY NOT NULL,
	Nome VARCHAR(150),
	Cargo VARCHAR(150)

);
-- Estado_PedidoDesloca:
-- DROP TABLE Using_Schema.Estado_PedidoDesloca
CREATE TABLE Using_Schema.Estado_PedidoDesloca (
	ID_Estado_PedidoDesloca INT PRIMARY KEY NOT NULL,
	Estado VARCHAR(150),
	ID_Responsavel INT FOREIGN KEY REFERENCES Using_Schema.Responsavel(ID_Responsavel),
	Data_Estado DATE
);




-- Documento:
-- DROP TABLE Using_Schema.Documento
CREATE TABLE Using_Schema.Documento (
	ID_DocAnexo INT PRIMARY KEY NOT NULL,
	Nome_Ficheiro VARCHAR(100),
	Anexo_Ficheiro VARCHAR(100)
);

-- Financiamento:
-- DROP TABLE Using_Schema.Financiamento
CREATE TABLE Using_Schema.Financiamento (
	ID_Financiamento INT PRIMARY KEY NOT NULL,
	Refeicao INT,
	Transporte INT,
	Inscricao INT,
	Total_despesas INT,
	ID_Mecenas INT NOT NULL REFERENCES Using_Schema.Mecenas(ID_Mecenas) -- quem paga
);

-- Pedido_AjudasCusto:
-- DROP TABLE Using_Schema.Pedido_AjudasCusto
CREATE TABLE Using_Schema.Pedido_AjudasCusto (
	ID_Pedido_AjudasCusto INT PRIMARY KEY NOT NULL,
	Data_Pedido_AjudasCusto DATE,
	ID_Financiamento INT NOT NULL REFERENCES Using_Schema.Financiamento(ID_Financiamento)
);

-- Pedido_Desloca:
-- DROP TABLE Using_Schema.Pedido_Desloca
CREATE TABLE Using_Schema.Pedido_Desloca (
	ID_PedidoDesloca INT PRIMARY KEY NOT NULL,
	Data_Pedido DATE,
	Data_Ida DATE,
	Data_Voltar DATE,
	ID_Itenerario INT NOT NULL REFERENCES Using_Schema.Itenerario(ID_Itenerario),
	Motivo VARCHAR(150),
	ID_Estado_PedidoDesloca INT NOT NULL REFERENCES Using_Schema.Estado_PedidoDesloca(ID_Estado_PedidoDesloca),
	ID_DocAnexo INT NOT NULL REFERENCES Using_Schema.Documento(ID_DocAnexo),
	ID_Pedido_AjudasCusto INT NOT NULL REFERENCES Using_Schema.Pedido_AjudasCusto(ID_Pedido_AjudasCusto)
);

-- Aprovação
-- DROP TABLE Using_Schema.Aprovacao
CREATE TABLE Using_Schema.Aprovacao (
	ID_Aprovacao INT PRIMARY KEY NOT NULL,
	ID_PedidoDesloca INT NOT NULL REFERENCES Using_Schema.Pedido_Desloca(ID_PedidoDesloca),
	Data_Aprovacao DATE,
	Comentario VARCHAR(200)
);

-- Requerente:
-- DROP TABLE Using_Schema.Requerente
CREATE TABLE Using_Schema.Requerente (
    ID_Requerente INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    ID_PedidoDesloca INT NOT NULL REFERENCES Using_Schema.Pedido_Desloca(ID_PedidoDesloca)
);
