USE T2_G3

Using_Schema = [202200596]

-- Requerente
CREATE TABLE Using_Schema.Requerente (
    ID_Requerente INT PRIMARY KEY,
    Nome VARCHAR(255),
    ID_Categoria INT,
    ID_Destino INT,
    ID_DataInicio INT,
    ID_DataFim INT,
    ID_Motivo INT,
    ID_ServicoDocente INT,
    ID_Encargos INT,
    ID_EstimaDespesa INT,
    ID_DocumentosAnexo INT
);

-- Destino
CREATE TABLE Using_Schema.Destino (
    ID_Destino INT PRIMARY KEY,
    Destino VARCHAR(255)
);

-- Categoria
CREATE TABLE Using_Schema.Categoria (
    ID_Categoria INT PRIMARY KEY,
    Categoria VARCHAR(255)
);

-- Data_inicio
CREATE TABLE Using_Schema.Data_inicio (
    ID_DataInicio INT PRIMARY KEY,
    Data_Inicio DATE
);

-- Data_fim
CREATE TABLE Using_Schema.Data_fim (
    ID_DataFim INT PRIMARY KEY,
    Data_fim DATE
);

-- Motivo
CREATE TABLE Using_Schema.Motivo (
    ID_Motivo INT PRIMARY KEY,
    Motivo VARCHAR(255)
);

-- Serviço_docente
CREATE TABLE Using_Schema.Servico_docente (
    ID_ServicoDocente INT PRIMARY KEY,
    Servico_docente VARCHAR(255)
);

-- Encargos
CREATE TABLE Using_Schema.Encargos (
    ID_Encargos INT PRIMARY KEY,
    ID_EntidadeConvida INT,
    ID_FP INT,
    ID_EntidadeExterna INT,
    Encargos VARCHAR(255)
);

-- Entidade_Convida
CREATE TABLE Using_Schema.Entidade_Convida (
    ID_EntidadeConvida INT PRIMARY KEY,
    Nome_Entidade_Convida VARCHAR(255)
);

-- FP
CREATE TABLE Using_Schema.FP (
    ID_FP INT PRIMARY KEY,
    FP VARCHAR(255)
);

-- Entidade_Externa
CREATE TABLE Using_Schema.Entidade_Externa (
    ID_EntidadeExterna INT PRIMARY KEY,
    Entidade_Externa VARCHAR(255)
);

-- Serviço
CREATE TABLE Using_Schema.Servico (
    ID_Servico INT PRIMARY KEY,
    Servico VARCHAR(255)
);

-- Objetivo
CREATE TABLE Using_Schema.Objetivo (
    ID_Objetivo INT PRIMARY KEY,
    Objetivo VARCHAR(255)
);

-- EstimaDespesa
CREATE TABLE Using_Schema.EstimaDespesa (
    ID_EstimaDespesa INT PRIMARY KEY,
    Inscrição VARCHAR(255),
    ID_Refeicoes INT,
    ID_Transportes INT
);

-- Refeicoes
CREATE TABLE Using_Schema.Refeicoes (
    ID_Refeicoes INT PRIMARY KEY,
    ID_EstimaDespesa INT,
    Almoco VARCHAR(255),
    Jantar VARCHAR(255)
);

-- Transportes
CREATE TABLE Using_Schema.Transportes (
    ID_Transportes INT PRIMARY KEY,
    Tipo_Transporte VARCHAR(255)
);

--DocumentosAnexo
CREATE TABLE Using_Schema.DocumentosAnexo (
    ID_DocumentoAnexo INT PRIMARY KEY,
    DocumentoAnexo VARCHAR(255)
);