USE XPE_PA

/***********************************/
/***********VISUALIZAÇÃO************/
/***********************************/

--Visualizando o Dado Recebido
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Verifica base
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Verificando quais e quantos tipos de nacionalidade aparecem na base
SELECT DISTINCT NACIONALIDADE, COUNT(Nacionalidade) Qt_Nac_Presente FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]
GROUP BY Nacionalidade

--Existem registros com o campo Nacionalidade Vazio ou inválido?
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE Nacionalidade in ('','0')--5

--Verifica padrão de data (M/A)
SELECT DISTINCT [MÊS ANO] FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Existem registros com data vazia ou inválida ao período da extração?
--Verificando o valor minimo que possuo
SELECT MIN(SUBSTRING([Mês Ano],4,6)) DT_MIN FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] --inválido
--Verificando o valor maximo que possuo
SELECT MAX(SUBSTRING([Mês Ano],4,6)) DT_MAX FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] --inválido

--Após uma verificação detalhada das datas, foi visto que existiam mais registros inválidos
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE [Mês Ano] IN ('03/2053','03/2053','03/2035','03/1820','03/2089')--5

--Por se tratar de um dataset quantitativo, existem registros com a quantidade vazia ou igual a 0?
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE Quantidade IN ('','0') --4

/***********************************/
/*************TRATAMENTO************/
/***********************************/
--Em contato com a SRB, foi notificado que para os registros inválidos, será realizado a exclusão.

--Visto que meus registros não possuem um id, realizei a inserção de uma nova coluna para que dessa forma facilitasse a exclusão.
ALTER TABLE [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] ADD
ID INT IDENTITY (1,1)

--Visualiza registros inválidos
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE ID IN ('4403','4404','4405','4406','4407','4408','4409','4410','4411','4412','4413','4414','4415','4416') --0

--Apaga Registros
DELETE FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE ID IN ('4403','4404','4405','4406','4407','4408','4409','4410','4411','4412','4413','4414','4415','4416') 


/***********************************/
/***************EXTRA***************/
/***********************************/
SELECT top 2 * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

SELECT TOP 2 [Tipo de Alertas e Restrições] TP_ALERTA, Nacionalidade DC_NAC, [Mês Ano] DT, UF, Quantidade QT,ID FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE [Mês Ano] LIKE '%2019'