USE T2_G3

--Trigger "AtualizarTotalDespesasPedido":

CREATE OR ALTER TRIGGER AtualizarTotalDespesasPedido ON Using_Schema.Financiamento
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	SET NOCOUNT ON -- For no duplicate messages
	IF TRIGGER_NESTLEVEL() > 1 -- Como vamos dar um I-U-D para ele não dar trigger no trigger
		RETURN


  UPDATE Using_Schema.Financiamento
  SET Total_despesas = Refeicao + Transporte + Inscricao
  WHERE ID_Financiamento IN (SELECT ID_Financiamento FROM inserted);
END;

/*
#testar o trigger "AtualizarTotalDespesasPedido"

DROP TRIGGER Using_Schema.AtualizarTotalDespesasPedido

--teste do trigger 1
-- Inserindo um novo financiamento
INSERT INTO Using_Schema.Financiamento (ID_Financiamento, Refeicao, Transporte, Inscricao, Total_despesas, ID_Mecenas)
VALUES (1, 100, 400, 12300, 0, 1);

--ver os valores
SELECT * FROM Using_Schema.Financiamento
WHERE ID_Financiamento = 1

--dar update para testar novamente
UPDATE Using_Schema.Financiamento
SET Refeicao = 100, Transporte = 2200, Inscricao = 2340, ID_Mecenas = 1
WHERE ID_Financiamento = 1;

*/
--Trigger "VerificarNomeRequerente"

CREATE OR ALTER TRIGGER VerificarNomeRequerente ON Using_Schema.Requerente
AFTER INSERT
AS
BEGIN TRAN

	SET NOCOUNT ON -- ´For no duplicate messages
	IF TRIGGER_NESTLEVEL() > 1 -- Como vamos dar um I-U-D para ele não dar trigger no trigger
		RETURN

  IF EXISTS (SELECT 1 FROM inserted WHERE Nome IS NULL)
  BEGIN
    RAISERROR ('Nome do requerente é obrigatório.', 16, 1);
    ROLLBACK;
    RETURN;
  END;
COMMIT TRAN;
/*
#testar o trigger "AtualizarNomeRequerente"

--exemplo que dá certo
INSERT INTO Using_Schema.Requerente (ID_Requerente,Nome,Categoria,ID_PedidoDesloca) VALUES (1, 'josé da silva','batateiro',13);

--exemplos que não dão certo
INSERT INTO Using_Schema.Requerente (ID_Requerente,Categoria,ID_PedidoDesloca) VALUES (1,'batateiro',13);


INSERT INTO Using_Schema.Requerente (ID_Requerente,Nome,Categoria,ID_PedidoDesloca) VALUES (1, NULL,'batateiro',13);
*/

--Trigger Interno_Externo


CREATE TRIGGER Interno_Externo ON Using_Schema.Mecenas
AFTER INSERT, UPDATE
AS
BEGIN TRAN

	SET NOCOUNT ON -- ´For no duplicate messages
	IF TRIGGER_NESTLEVEL() > 1 -- Como vamos dar um I-U-D para ele não dar trigger no trigger
		RETURN

--Se na tabela Interno for 'TRUE' ele vai colocar o nome do mecenas como 'interno'
	IF EXISTS (SELECT 1 FROM inserted WHERE Interno = 'TRUE')
	BEGIN
		UPDATE Using_Schema.Mecenas
		SET Mecenas = 'Interno'
		WHERE Interno = 'TRUE'
		RETURN;
	END;

--Se na tabela Interno for 'FALSE' e o campo do mecenas estiver vazio, ele dá erro e avisa
	ELSE IF EXISTS (SELECT 1 FROM inserted WHERE Interno = 'FALSE' AND Mecenas IS NULL)
	BEGIN
		THROW 50000, 'Nome do mecenas Inexistente!',1;
		RETURN;
	END;

	
--Se na tabela O valor não for nem FALSE nem TRUE ele não deixa introduzir
	ELSE IF EXISTS (SELECT 1 FROM inserted WHERE Interno != 'FALSE' AND Interno != 'TRUE')
	BEGIN
		THROW 50000, 'O valor na tabela "Interno" é um valor incorreto!''O valor deveria ser TRUE ou FALSE',1;
		RETURN;
	END;

COMMIT TRAN;


/*
DROP TRIGGER Using_Schema.Interno_Externo

--testar
INSERT INTO Using_Schema.Mecenas(ID_Mecenas,Interno,Mecenas)
VALUES (2,'FALSE','Batata Corporation')

UPDATE Using_Schema.Mecenas
SET Interno = 'FALSE'
WHERE ID_Mecenas = 221

UPDATE Using_Schema.Mecenas
SET Interno = 'TRUE'
WHERE ID_Mecenas = 221


SELECT * FROM Using_Schema.Mecenas
*/


--Trigger 

CREATE TRIGGER Atualizar_Tempo_Responsavel
    ON [Using_Schema].[Estado_PedidoDesloca]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN TRAN
		
		SET NOCOUNT ON -- ´For no duplicate messages
		IF TRIGGER_NESTLEVEL() > 1 -- Como vamos dar um I-U-D para ele não dar trigger no trigger
			RETURN
		
--Ao Atualizar o Estado, Atualiza a Data
		UPDATE Using_Schema.Estado_PedidoDesloca
		SET [Data_Estado] = GETDATE()
		FROM Using_Schema.Estado_PedidoDesloca EPD
		INNER JOIN inserted as I ON EPD.ID_Estado_PedidoDesloca = I.ID_Estado_PedidoDesloca


    COMMIT TRAN;

/*
DROP TRIGGER Using_Schema.Atualizar_Tempo_Responsavel

--Testar


EXEC Using_Schema.InserirEstadoDesloca
	@Estado = 'Aprovado',
	@Responsável = 'Jão manel'

SELECT * FROM Using_Schema.Estado_PedidoDesloca

*/

CREATE TRIGGER Atualizar_Aprovacao
ON Using_Schema.Estado_PedidoDesloca
    FOR INSERT, UPDATE
    AS
    BEGIN TRAN

	SET NOCOUNT ON -- ´For no duplicate messages
	IF TRIGGER_NESTLEVEL() > 1 -- Como vamos dar um I-U-D para ele não dar trigger no trigger
		RETURN
	
	DECLARE @ID_PedidoDesloca INT, @ID_Aprovacao INT
	SET @ID_PedidoDesloca = (SELECT ID_Estado_PedidoDesloca FROM inserted)
	
	SET @ID_Aprovacao = (SELECT ISNULL(MAX(ID_Aprovacao), 0) FROM Using_Schema.Aprovacao) + 1

	
	PRINT(@ID_PedidoDesloca)
	IF (SELECT Estado FROM inserted) = 'Aprovado' --se o ultimo estado for aprovado ele faz o seguinte
		INSERT INTO Using_Schema.Aprovacao(ID_Aprovacao, ID_PedidoDesloca,Data_Aprovacao,Comentario)
		VALUES (@ID_Aprovacao, @ID_PedidoDesloca, GETDATE(),'Aprovado. pm')

		PRINT('Foi inserido na tabela Aprovacao, marcado como "Aprovado. pm" para referenciar que ainda estaria pm(por modificar)')


	COMMIT TRAN;

/*
Teste do ´trigger acima:
	SELECT * FROM Using_Schema.Aprovacao


	DROP TRIGGER Using_Schema.Atualizar_Aprovacao

*/