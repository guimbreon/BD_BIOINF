USE T2_G3

--Vista "Vista_Requerente_PedidoDesloca":

CREATE VIEW Using_Schema.Vista_Requerente_PedidoDesloca AS
SELECT R.ID_Requerente, R.Nome, R.Categoria, PD.ID_PedidoDesloca, PD.Data_Pedido, PD.Data_Ida, PD.Data_Voltar, PD.ID_Itenerario, PD.Motivo
FROM Using_Schema.Requerente AS R
INNER JOIN Using_Schema.Pedido_Desloca AS PD ON R.ID_PedidoDesloca = PD.ID_PedidoDesloca;


/*
#testar o codigo acima

SELECT *
FROM Using_Schema.Vista_Requerente_PedidoDesloca;
*/


--Vista "Vista_PedidoDesloca_Estado":
CREATE VIEW Using_Schema.Vista_PedidoDesloca_Documento AS
SELECT PD.ID_PedidoDesloca, PD.Data_Pedido, PD.Data_Ida, PD.Data_Voltar, PD.ID_Itenerario, PD.Motivo, D.ID_DocAnexo, D.Nome_Ficheiro, D.Anexo_Ficheiro
FROM Using_Schema.Pedido_DEsloca AS PD
INNER JOIN Using_Schema.Documento AS D ON PD.ID_DocAnexo = D.ID_DocAnexo;

/*
#testar o codigo acima

SELECT *
FROM Using_Schema.Vista_PedidoDesloca_Documento;
*/

--Vista "Vista_PedidoDesloca_AjudasCusto":

CREATE VIEW Using_Schema.Vista_PedidoDesloca_AjudasCusto AS
SELECT PD.ID_PedidoDesloca, PD.Data_Pedido, PD.Data_Ida, PD.Data_Voltar, PD.ID_Itenerario, PD.Motivo, AC.ID_Pedido_AjudasCusto, AC.Data_Pedido_AjudasCusto, AC.ID_Financiamento
FROM Using_Schema.Pedido_DEsloca AS PD
INNER JOIN Using_Schema.Pedido_AjudasCusto AS AC ON PD.ID_Pedido_AjudasCusto = AC.ID_Pedido_AjudasCusto;

/*
#testar o codigo acima
SELECT *
FROM Using_Schema.Vista_PedidoDesloca_AjudasCusto;
*/

-- Vista "Vista_Requerente_PedidoDesloca_Documento":
CREATE VIEW Using_Schema.Vista_Requerente_PedidoDesloca_Documento AS
SELECT R.ID_Requerente, R.Nome, R.Categoria, PD.ID_PedidoDesloca, PD.Data_Pedido, PD.Data_Ida, PD.Data_Voltar, PD.ID_Itenerario, PD.Motivo, D.ID_DocAnexo, D.Nome_Ficheiro, D.Anexo_Ficheiro
FROM Using_Schema.Requerente AS R
INNER JOIN Using_Schema.Pedido_Desloca AS PD ON R.ID_PedidoDesloca = PD.ID_PedidoDesloca
INNER JOIN Using_Schema.Documento AS D ON PD.ID_DocAnexo = D.ID_DocAnexo;

/*
#testar o codigo acima

SELECT *
FROM Using_Schema.Vista_Requerente_PedidoDesloca_Documento;
*/
-- Vista "Vista_Requerente_PedidoDesloca_AjudasCusto":
CREATE VIEW Using_Schema.Vista_Requerente_PedidoDesloca_AjudasCusto AS
SELECT R.ID_Requerente, R.Nome, R.Categoria, PD.ID_PedidoDesloca, PD.Data_Pedido, PD.Data_Ida, PD.Data_Voltar, PD.ID_Itenerario, PD.Motivo, AC.ID_Pedido_AjudasCusto, AC.Data_Pedido_AjudasCusto, AC.ID_Financiamento
FROM Using_Schema.Requerente AS R
INNER JOIN Using_Schema.Pedido_Desloca AS PD ON R.ID_PedidoDesloca = PD.ID_PedidoDesloca
INNER JOIN Using_Schema.Pedido_AjudasCusto AS AC ON PD.ID_Pedido_AjudasCusto = AC.ID_Pedido_AjudasCusto;
/*
#testar o codigo acima

SELECT *
FROM Using_Schema.Vista_Requerente_PedidoDesloca_AjudasCusto;
*/
-- Vista "Vista_Financiamento_Mecenas":
CREATE VIEW Using_Schema.Vista_Financiamento_Mecenas AS
SELECT F.ID_Financiamento, F.Refeicao, F.Transporte, F.Inscricao, F.Total_despesas, M.ID_Mecenas, M.Interno, M.Mecenas
FROM Using_Schema.Financiamento AS F
INNER JOIN Using_Schema.Mecenas AS M ON F.ID_Mecenas = M.ID_Mecenas;

/*
#testar o codigo acima

SELECT *
FROM Using_Schema.Vista_Financiamento_Mecenas;
*/