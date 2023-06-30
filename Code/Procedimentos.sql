USE T2_G3

--Procedimento "AdicionarNovoRequerente"

DROP PROCEDURE Testing_26;

CREATE PROCEDURE Testing_26 
    @Nome varchar(50),
	@Categoria VARCHAR(50),
	@ID_PedidoDesloca INT
AS
BEGIN
	DECLARE @ID_Requerente INT

	IF (SELECT COUNT(*) FROM Using_Schema.Requerente WHERE ID_PedidoDesloca = @ID_PedidoDesloca) <> 0
	BEGIN
		PRINT 'O ID do pedido de mobilidade já existe!'
		RETURN
	END

	SET @ID_Requerente = (SELECT ISNULL(MAX(ID_Requerente), 0) FROM Using_Schema.Requerente) + 1

	BEGIN TRAN
		INSERT INTO Using_Schema.Requerente (ID_Requerente, Nome, Categoria, ID_PedidoDesloca)
		VALUES (@ID_Requerente, @Nome, @Categoria, @ID_PedidoDesloca)

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERRO...!'
			ROLLBACK TRAN
			RETURN
		END

	COMMIT TRAN
	RETURN
END
GO
/*
#Testing do código acima

EXEC Testing_26 
    @Nome = 'Exemplo',
    @Categoria = 'Categoria Exemplo',
    @ID_PedidoDesloca = 123;


SELECT * FROM Using_Schema.Requerente

*/



--InsertPedidoAjudasCusto

DROP PROCEDURE Using_Schema.InsertPedidoDesloca

CREATE PROCEDURE Using_Schema.InsertPedidoDesloca
(
    @Data_Ida DATE,
    @Data_Voltar DATE,
    @Destino VARCHAR(150),
    @Motivo VARCHAR(150),
    @ID_Estado_PedidoDesloca INT,
    @ID_DocAnexo INT,
    @ID_Pedido_AjudasCusto INT
)
AS
BEGIN
	DECLARE @ID_PedidoDesloca INT, @Data_Pedido DATE

	SET @ID_PedidoDesloca = (SELECT ISNULL(MAX(ID_PedidoDesloca), 0) FROM Using_Schema.Pedido_DEsloca) + 1
	SET @Data_Pedido = GETDATE()

    INSERT INTO Using_Schema.Pedido_DEsloca (ID_PedidoDesloca, Data_Pedido, Data_Ida, Data_Voltar, Destino, Motivo, ID_Estado_PedidoDesloca, ID_DocAnexo, ID_Pedido_AjudasCusto)
    VALUES (@ID_PedidoDesloca, @Data_Pedido, @Data_Ida, @Data_Voltar, @Destino, @Motivo, @ID_Estado_PedidoDesloca, @ID_DocAnexo, @ID_Pedido_AjudasCusto)
END;
/*
#testar o codigo acima

EXECUTE Using_Schema.InsertPedidoDesloca
    @Data_Pedido = '2023-06-12',
    @Data_Ida = '2023-01-15',
    @Data_Voltar = '2024-03-23',
    @Destino = 'Cidade A',
    @Motivo = 'Viagem de negócioasds',
    @ID_Estado_PedidoDesloca = 2,
    @ID_DocAnexo = 123,
    @ID_Pedido_AjudasCusto = 123;

SELECT * FROM Using_Schema.Pedido_DEsloca
*/

--InserirEstadoDesloca
DROP PROCEDURE Using_Schema.InserirEstadoDesloca

CREATE PROCEDURE Using_Schema.InserirEstadoDesloca 
    @Estado VARCHAR(150),
	@Responsável VARCHAR(150)
AS
BEGIN TRAN
	DECLARE @ID_Estado_PedidoDesloca INT
	SET @ID_Estado_PedidoDesloca = (SELECT ISNULL(MAX(ID_Estado_PedidoDesloca), 0) FROM Using_Schema.Estado_PedidoDesloca) + 1

	INSERT INTO Using_Schema.Estado_PedidoDesloca(ID_Estado_PedidoDesloca,Estado,Responsável,Data_Estado)
	VALUES(@ID_Estado_PedidoDesloca,@Estado,@Responsável,NULL)

COMMIT TRAN;


/*
#testar o codigo acima

EXEC Using_Schema.InserirEstadoDesloca
	@Estado = 'Aprovado',
	@Responsável = 'Jbatatit'

*/
--UpdateEstadoPedido

DROP PROCEDURE Using_Schema.UpdateEstadoPedido

CREATE PROCEDURE Using_Schema.UpdateEstadoPedido
(
    @ID_PedidoDesloca INT,
    @ID_Estado_PedidoDesloca INT,
    @Estado VARCHAR(150),
    @Responsável VARCHAR(150)
)
AS
BEGIN
    UPDATE Using_Schema.Pedido_DEsloca
    SET ID_Estado_PedidoDesloca = @ID_Estado_PedidoDesloca
    WHERE ID_PedidoDesloca = @ID_PedidoDesloca
	

    UPDATE Using_Schema.Estado_PedidoDesloca
    SET Estado = @Estado, Responsável = @Responsável, Data_Estado = GETDATE()
    WHERE ID_Estado_PedidoDesloca = @ID_Estado_PedidoDesloca
END;
/*
#testar o codigo acima


EXECUTE Using_Schema.UpdateEstadoPedido
    @ID_PedidoDesloca = 2,
    @ID_Estado_PedidoDesloca = 2,
    @Estado = 'Aprovadod',
    @Responsável = 'João';


SELECT * FROM Using_Schema.Estado_PedidoDesloca


*/

--InserirNovoDocumento
CREATE PROCEDURE Using_Schema.InserirNovoDocumento 
    @Nome_Ficheiro INT,
    @Anexo_Ficheiro INT  
AS
BEGIN TRAN
DECLARE @ID_DocAnexo VARCHAR(100)
SET @ID_DocAnexo = (SELECT ISNULL(MAX(ID_DocAnexo), 0) FROM Using_Schema.Documento) + 1

INSERT INTO Using_Schema.Documento(ID_DocAnexo,Nome_Ficheiro,Anexo_Ficheiro)
VALUES(@ID_DocAnexo,@Nome_Ficheiro,@Anexo_Ficheiro)

COMMIT TRAN;

/*
#testar o codigo acima

EXEC Using_Schema.InserirNovoDocumento 
	@Nome_Ficheiro = 'ficheiro.pdf',
	@Anexo_Ficheiro ='C:/PastaAFingir/ficheiro.pdf'

SELECT * FROM Using_Schema.Documento
*/

--InserirNovoPedido_AjudasCusto
CREATE PROCEDURE Using_Schema.Inserir_Pedido_AjudasCusto(
    @Data_Pedido_AjudasCusto DATE,
    @ID_Financiamento INT
)
AS
BEGIN
	DECLARE @ID_Pedido_AjudasCusto INT;
    SET @ID_Pedido_AjudasCusto = (SELECT ISNULL(MAX(ID_Pedido_AjudasCusto), 0) FROM Using_Schema.Pedido_AjudasCusto) + 1;
 
    INSERT INTO Using_Schema.Pedido_AjudasCusto (ID_Pedido_AjudasCusto,Data_Pedido_AjudasCusto,ID_Financiamento)
    VALUES (@ID_Pedido_AjudasCusto,@Data_Pedido_AjudasCusto,@ID_Financiamento)
END;
/*
#testar o codigo acima
DROP Using_Schema.Inserir_Pedido_AjudasCusto
EXEC Using_Schema.Inserir_Pedido_AjudasCusto
    @Data_Pedido_AjudasCusto = '2023-06-15',
    @ID_Financiamento = 1;


SELECT * FROM Using_Schema.Pedido_AjudasCusto
*/
--InserirNovoFinanciamento
CREATE PROCEDURE Using_Schema.Inserir_Financiamento(
    @Refeicao INT,
    @Transporte INT,
    @Inscricao INT,
    @Total_despesas INT,
    @ID_Mecenas INT
)
AS
BEGIN
    DECLARE @ID_Financiamento INT;
    SET @ID_Financiamento = (SELECT ISNULL(MAX(ID_Financiamento), 0) FROM Using_Schema.Financiamento) + 1;
    
    INSERT INTO Using_Schema.Financiamento (ID_Financiamento,Refeicao,Transporte,Inscricao,Total_despesas,ID_Mecenas)
    VALUES (@ID_Financiamento,@Refeicao,@Transporte,@Inscricao,@Total_despesas,@ID_Mecenas);
END;

/*
#testar o codigo acima

DROP PROC Using_Schema.Inserir_Financiamento

EXEC Using_Schema.Inserir_Financiamento
    @Refeicao = 50,
    @Transporte = 100,
    @Inscricao = 20,
    @Total_despesas = 170,
    @ID_Mecenas = 1;



*/
--InserirNovoMecenas

CREATE PROCEDURE Using_Schema.Inserir_Mecenas(
    @Interno VARCHAR(5),
    @Mecenas VARCHAR(100)
)
AS
BEGIN
    DECLARE @ID_Mecenas INT;
    SET @ID_Mecenas = (SELECT ISNULL(MAX(@ID_Mecenas), 0) FROM Using_Schema.Mecenas) + 1;
    
    INSERT INTO Using_Schema.Mecenas (ID_Mecenas,Interno,Mecenas)
    VALUES (@ID_Mecenas, @Interno,@Mecenas)
END;


/*
#testar o codigo acima

EXEC Using_Schema.Inserir_Mecenas
    @Interno = 'true',
    @Mecenas = 'Nome do Mecenas';
*/


--Procedimento AdicionarAprovacao
DROP PROCEDURE Using_Schema.AdicionarAprovacao

CREATE PROCEDURE Using_Schema.AdicionarAprovacao (
    @ID_PedidoDesloca INT,
    @Data_Aprovacao DATE,
    @Comentario VARCHAR(200)
)
AS
BEGIN TRAN
	DECLARE @ID_Aprovacao INT;
    SET @ID_Aprovacao = (SELECT ISNULL(MAX(ID_Financiamento), 0) FROM Using_Schema.Financiamento) + 1;
    


    INSERT INTO Using_Schema.Aprovacao (ID_Aprovacao, ID_PedidoDesloca, Data_Aprovacao, Comentario)
    VALUES (@ID_Aprovacao, @ID_PedidoDesloca, @Data_Aprovacao, @Comentario)
COMMIT TRAN;


EXEC Using_Schema.AdicionarAprovacao 
    @ID_PedidoDesloca = 17,
    @Data_Aprovacao = '2023-06-22',
    @Comentario = 'Aprovado'

SELECT * FROM Using_Schema.Aprovacao

