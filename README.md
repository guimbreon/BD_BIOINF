# Trabalho_BD

Este repositório contém o trabalho de base de dados para uma organização responsável por solicitações de deslocação e ajudas de custo. O objetivo é administrar os pedidos de deslocação feitos pelos requerentes, armazenando informações relevantes sobre os requerentes, unidades orgânicas, pedidos de deslocação, documentos anexados, despachos, despesas, financiamentos, refeições e aprovações.

##Documentos de apoio:

No ficheiro [Docs_Apoio](Docs_Apoio) temos os Documentos de Apoio usados para elaborar o trabalho.


## Estrutura da Base de Dados

A seguir está a lista das entidades presentes no esquema do banco de dados:

1. Mecenas:
   - ID_Mecenas (INT)
   - Interno (VARCHAR(5))
   - Mecenas (VARCHAR(100))

2. Itinerário:
   - ID_Itinerario (INT)
   - Deslocacoes (VARCHAR(150))

3. Responsavel:
   - ID_Responsavel (INT)
   - Nome (VARCHAR(150))
   - Cargo (VARCHAR(150))

4. Estado_PedidoDesloca:
   - ID_Estado_PedidoDesloca (INT)
   - Estado (VARCHAR(150))
   - ID_Responsavel (INT) (chave estrangeira referenciando a tabela Responsavel)
   - Data_Estado (DATE)

5. Documento:
   - ID_DocAnexo (INT)
   - Nome_Ficheiro (VARCHAR(100))
   - Anexo_Ficheiro (VARCHAR(100))

6. Financiamento:
   - ID_Financiamento (INT)
   - Refeicao (INT)
   - Transporte (INT)
   - Inscricao (INT)
   - Total_despesas (INT)
   - ID_Mecenas (INT) (chave estrangeira referenciando a tabela Mecenas)

7. Pedido_AjudasCusto:
   - ID_Pedido_AjudasCusto (INT)
   - Data_Pedido_AjudasCusto (DATE)
   - ID_Financiamento (INT) (chave estrangeira referenciando a tabela Financiamento)

8. Pedido_Desloca:
   - ID_PedidoDesloca (INT)
   - Data_Pedido (DATE)
   - Data_Ida (DATE)
   - Data_Voltar (DATE)
   - ID_Itinerario (INT) (chave estrangeira referenciando a tabela Itinerario)
   - Motivo (VARCHAR(150))
   - ID_Estado_PedidoDesloca (INT) (chave estrangeira referenciando a tabela Estado_PedidoDesloca)
   - ID_DocAnexo (INT) (chave estrangeira referenciando a tabela Documento)
   - ID_Pedido_AjudasCusto (INT) (chave estrangeira referenciando a tabela Pedido_AjudasCusto)

9. Aprovacao:
   - ID_Aprovacao (INT)
   - ID_PedidoDesloca (INT) (chave estrangeira referenciando a tabela Pedido_Desloca)
   - Data_Aprovacao (DATE)
   - Comentario (VARCHAR(200))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

10. Requerente:
    - ID_Requerente (INT)
    - Nome (VARCHAR(50))
    - Categoria (VARCHAR(50))
    - ID_PedidoDesloca (INT) (chave estrangeira referenciando a tabela Pedido_Desloca)

Essas entidades representam os principais elementos do sistema de gerenciamento de pedidos de deslocação e ajudas de custo da empresa.

## Outros Elementos do trabalho:

Foram feitos tambem Views, Trigger e Storage procedures para as tabelas da base de dados.

##README.md em Inglês
[README.md](english/README.md)

## Licença

Este projeto está licenciado sob os termos da [Licença](LICENSE).

