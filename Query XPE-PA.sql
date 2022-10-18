USE XPE_PA

/***********************************/
/***********VISUALIZA��O************/
/***********************************/

--Visualizando o Dado Recebido
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Verifica base
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Verificando quais e quantos tipos de nacionalidade aparecem na base
SELECT DISTINCT NACIONALIDADE, COUNT(Nacionalidade) Qt_Nac_Presente FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]
GROUP BY Nacionalidade

--Existem registros com o campo Nacionalidade Vazio ou inv�lido?
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE Nacionalidade in ('','0')--5

--Verifica padr�o de data (M/A)
SELECT DISTINCT [M�S ANO] FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

--Existem registros com data vazia ou inv�lida ao per�odo da extra��o?
--Verificando o valor minimo que possuo
SELECT MIN(SUBSTRING([M�s Ano],4,6)) DT_MIN FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] --inv�lido
--Verificando o valor maximo que possuo
SELECT MAX(SUBSTRING([M�s Ano],4,6)) DT_MAX FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] --inv�lido

--Ap�s uma verifica��o detalhada das datas, foi visto que existiam mais registros inv�lidos
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE [M�s Ano] IN ('03/2053','03/2053','03/2035','03/1820','03/2089')--5

--Por se tratar de um dataset quantitativo, existem registros com a quantidade vazia ou igual a 0?
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE Quantidade IN ('','0') --4

/***********************************/
/*************TRATAMENTO************/
/***********************************/
--Em contato com a SRB, foi notificado que para os registros inv�lidos, ser� realizado a exclus�o.

--Visto que meus registros n�o possuem um id, realizei a inser��o de uma nova coluna para que dessa forma facilitasse a exclus�o.
ALTER TABLE [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] ADD
ID INT IDENTITY (1,1)

--Visualiza registros inv�lidos
SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE ID IN ('4403','4404','4405','4406','4407','4408','4409','4410','4411','4412','4413','4414','4415','4416') --0

--Apaga Registros
DELETE FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE ID IN ('4403','4404','4405','4406','4407','4408','4409','4410','4411','4412','4413','4414','4415','4416') 


/***********************************/
/***************EXTRA***************/
/***********************************/
SELECT top 2 * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

SELECT TOP 2 [Tipo de Alertas e Restri��es] TP_ALERTA, Nacionalidade DC_NAC, [M�s Ano] DT, UF, Quantidade QT,ID FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado]

SELECT * FROM [solicitacoes-de-reconhecimento-da-condicao-de-refugiado] WHERE [M�s Ano] LIKE '%2019'