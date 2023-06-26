-- Pergunta inicial  1-	Uma maior proporção de pessoas que moram em cidade é asmáticas quando comparadas aquelas que moram em zonas rurais?

-- Não , proporções são muito parecidas.
SELECT 
URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY URBSTAT)
FROM AsthmaStatus 
INNER JOIN UrbanStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY URBSTAT,ASTHMS1
ORDER BY URBSTAT,ASTHMS1;

-- Complementando agora para regiões metropolitanas e não metropolitanas - também não tem efeito
SELECT 
METSTAT,
CASE 
	WHEN METSTAT = 1  THEN 'Metropolitan'
	WHEN METSTAT = 2  THEN 'Non-metropolitan'
	ELSE NULL END AS  METSTAT_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY METSTAT)
FROM AsthmaStatus 
INNER JOIN UrbanStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY METSTAT,ASTHMS1
ORDER BY METSTAT,ASTHMS1;

/* Pergunta 1.1 Será que pessoas com asma que vivem em zonas rurais vs urbanas tem uma melhor saúde reportada?

Primeiro vamos comparar as pessoas que vivem em zonas rurais vs urbanas, depois incluimos a asma.
Vou utilizar o RFHLTH que é um resumo do GENHLTH que é se a pessoa disse que está com uma boa saúde ou não

Aparentemente pessoas em locais urbanos reportam ter uma maior saúde do que aqueles que vivem em zonas rurais
talvez devido ao maior acesso aos serviçoes de saúde.

Aqui é com relação a varios tipos de saúde que não só a fisica. 
*/

SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
GROUP BY URBSTAT,RFHLTH
ORDER BY RFHLTH

/* Agora vamos comparar com as pessoas que tem asma ASTHMS1  = 1

Aparentemente, a diferença é ainda maior!

Uma coisa a se notar porém, é que a proporção de pessoas que reportaram com uma boa saúde é bem menor.
*/
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 1
GROUP BY URBSTAT,RFHLTH
ORDER BY RFHLTH

/* Vamos comparar com as pessoas que tiveram asma mas não tem mais ASTHMS1  = 2
Seguem mais ou menos a proporção da população geral.
*/

SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 2
GROUP BY URBSTAT,RFHLTH
ORDER BY RFHLTH

/* Agora as pessoas que nunca tiveram ASTHMS1  = 3
Também seguem mais ou menos a proporção da população geral.
*/
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 3
GROUP BY URBSTAT,RFHLTH
ORDER BY RFHLTH

/*
Agora vamos olhar a saúde fisica apenas.
PHYS14D

Olhando para o público geral, parece não haver uma diferença.
Apenas nos 14+ dias de saúde fisica não boa, que ha uma leve diferença.
*/
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
WHERE URBSTAT IS NOT NULL
AND PHYS14D IS NOT NULL
GROUP BY URBSTAT,PHYS14D
ORDER BY PHYS14D,URBSTAT

/*
Agora vou olhar para as pessoas com asma igual fizemos no anterior.

Ao contrário do que eu pensava, pessoas que moram nas zonas urbanas reportam mais
que não tem nenhum dia com a saúde fisica ruim, e reportam menos vezes que tem mais de 
14 dias+ com a saúde fisica ruim quando comparada com as pessoas de zonas rurais.

Resumindo, as pessoas com asma de zonas urbanas reportam menos que tem uma saúde fisica ruim do que as
pessoas de zonas rurais.
*/
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE URBSTAT IS NOT NULL
AND PHYS14D IS NOT NULL
AND ASTHMS1  = 1
GROUP BY URBSTAT,PHYS14D
ORDER BY PHYS14D,URBSTAT

/*
Agora com as pessoas que tinham asma e não tem mais

A mesma coisa do anterior.
*/
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE URBSTAT IS NOT NULL
AND PHYS14D IS NOT NULL
AND ASTHMS1  = 2
GROUP BY URBSTAT,PHYS14D
ORDER BY PHYS14D,URBSTAT

/*
Finalmente, com as pessoas que não tem asma.

Mais parecido com a população geral, pois na verdade as pessoas que não tem
asma são a maioria.
*/

SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE URBSTAT IS NOT NULL
AND PHYS14D IS NOT NULL
AND ASTHMS1  = 3
GROUP BY URBSTAT,PHYS14D
ORDER BY PHYS14D,URBSTAT

/*1.1.1 - Será que a renda interfere nesse tópicos anteriores?
Sim, estou insistindo bastante nesse tópico pois eu tenho asma e me sinto melhor no interior.

Pensei que talvez isso se devesse ao um maior acesso as serviçoes de saúde e etc, portanto poderia
estar correlacionado com a renda.

Por exemplo, uma pessoa que já tenha dinheiro e acesso, vai viver melhor no interior do que uma pessoa 
que não tenha, principalmente as pessoas que tenham asma.

Para isso, vamos utilizar a variavel Income, e dividir mais ou menos em 4 quadrantes.
*/
WITH Income_not_null (INCOME3,INCOME3_Categories, Count,Percentage)  AS (
SELECT INCOME3,
CASE 
	WHEN  INCOME3 = 1 THEN 'Less than $10,000'
	WHEN  INCOME3 = 2 THEN 'Less than $15,000 ($10,000 to < $15,000)'
	WHEN  INCOME3 = 3 THEN 'Less than $20,000 ($15,000 to < $20,000)'
	WHEN  INCOME3 = 4 THEN 'Less than $25,000 ($20,000 to < $25,000)'
	WHEN  INCOME3 = 5 THEN 'Less than $35,000 ($25,000 to < $35,000)'
	WHEN  INCOME3 = 6 THEN 'Less than $50,000 ($35,000 to < $50,000)'
	WHEN  INCOME3 = 7 THEN 'Less than $75,000 ($50,000 to < $75,000)'
	WHEN  INCOME3 = 8 THEN 'Less than $100,000? ($75,000 to < $100,000)'
	WHEN  INCOME3 = 9 THEN 'Less than $150,000? ($100,000 to < $150,000)'
	WHEN  INCOME3 = 10 THEN 'Less than $200,000? ($150,000 to < $200,000)'
	WHEN  INCOME3 = 11 THEN '$200,000 or more'
	ELSE NULL END AS INCOME3_Categories,	
COUNT(*) AS Count,
CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER() AS Percentage
FROM Demographics
WHERE INCOME3 IS NOT NULL
GROUP BY INCOME3
)

SELECT *
, SUM(Percentage) OVER(ORDER BY INCOME3 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Income_not_null;

/*
Como podemos observar, vai ser dificil separar em 4 quartis, portanto vou tentar fazer o mais próximo 
disso, porém não será perfeitamente dividido em 4. 
Vou fazer da seguinte forma:
grupo 1 < 35.000(~30%)
grupo 2 < 75.000(~31%)
grupo 3 < 150.000(~28%)
grupo 4 > 150.000(~11%)
*/

-- Criando temp table
SELECT
       ID,
       INCOME3,
        CASE
            WHEN INCOME3 IN (1, 2, 3, 4, 5) THEN 'Less than $35,000'
            WHEN INCOME3 IN (6, 7) THEN 'Less than $75,000 and more than $35,000'
            WHEN INCOME3 IN (8, 9, 10) THEN 'Less than $150,000 and more than $75,000'
            WHEN INCOME3 IN (10, 11) THEN '$150,000 or more'
            ELSE NULL
        END AS INCOME3_Categories
INTO #Income_4_divided
FROM
    Demographics
WHERE
    INCOME3 IS NOT NULL;
-- Vendo os dados quando a pessoa tem asma
SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,

    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 1
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH
-- Vendo os dados quando a pessoa tinha asma mas não tem mais
SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,

    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 2
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH
-- Vendo os dados quando a pessoa nunca teve asma
SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,

    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 3
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH

/*
Bom, para a saude no geral vimos que o nivel muda conforme a faixa economica porém, 
as pessoas nas zonas urbanas com apenas 1 exceção( teve asma e tem entre 75 e 35) 
tem reportado uma maior saúde do que as áreas rurais.

Vamos dar uma olhada agora na saude fisica apenas.
*/

SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,

    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
PHYS14D IS NOT NULL AND
ASTHMS1 = 1
GROUP BY URBSTAT,INCOME3_Categories, PHYS14D
ORDER BY INCOME3_Categories,URBSTAT,PHYS14D
-- Vendo os dados quando a pessoa tinha asma mas não tem mais
SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,

    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
PHYS14D IS NOT NULL AND
ASTHMS1 = 2
GROUP BY URBSTAT,INCOME3_Categories, PHYS14D
ORDER BY INCOME3_Categories,URBSTAT,PHYS14D

-- Vendo os dados quando a pessoa nunca teve asma
SELECT
	URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,

    INCOME3_Categories,

PHYS14D,
CASE
	WHEN PHYS14D = 1  THEN 'Zero days when physical health not good'
	WHEN PHYS14D = 2 THEN '1-13 days when physical health not good'
	WHEN PHYS14D = 3 THEN '14+ days when physical health not good'
	ELSE NULL END AS  PHYS14D_Categories,


    COUNT(*) AS COUNT,

    CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories) AS PERCENTAGE
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
PHYS14D IS NOT NULL AND
ASTHMS1 = 3
GROUP BY URBSTAT,INCOME3_Categories, PHYS14D
ORDER BY INCOME3_Categories,URBSTAT,PHYS14D

/*
É, aparentemente pessoas que tem asma reportam uma saúde fisica melhor em locais urbanos.
Em contraste, principalmente aquelas pessoas, que ganham mais de 35000 pelo menos e  que deixaram der ser asmáticas, reportam uma melhor 
saúde fisica nas zonas rurais. Isso se repete ligeiramente no publico que nunca teve asma.
*/



/* Pergunta 1.2 -- Existem uma diferença  no nivel de dificuldade reportada 
para fazer coisas sozinhas que pessoas com asma ou sem que vivem em zonas rurais vs urbanas ?

Vamos começar com a mais geral, dificuldade em subir escadas ou andar.

De novo, vemos a mesma tendência, pessoas em zonas urbanas tem uma menor dificuldade em subir 
escadas ou andar do que as em zonas rurais, independente se tem asma ou não.
*/
--Pessoas com asma
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFWALK,
CASE
	WHEN DIFFWALK = 1  THEN 'Yes'
	WHEN DIFFWALK = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFWALK IS NOT NULL
AND ASTHMS1 = 1
GROUP BY URBSTAT,DIFFWALK
ORDER BY DIFFWALK, URBSTAT
--Pessoas que já tiveram asma
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFWALK,
CASE
	WHEN DIFFWALK = 1  THEN 'Yes'
	WHEN DIFFWALK = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFWALK IS NOT NULL
AND ASTHMS1 = 2
GROUP BY URBSTAT,DIFFWALK
ORDER BY DIFFWALK, URBSTAT
--Pessoas que não tem asma
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFWALK,
CASE
	WHEN DIFFWALK = 1  THEN 'Yes'
	WHEN DIFFWALK = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFWALK IS NOT NULL
AND ASTHMS1 = 3
GROUP BY URBSTAT,DIFFWALK
ORDER BY DIFFWALK, URBSTAT

/* 
Agora vamos para quem reporta que não consegue fazer nada sozinho sem ajuda

Para o público geral não há diferença, porém, vemos que para o publico que já teve asma ou
tem asma, a diferença é algo em torno de 2%, sendo que as pessoas em regiões urbanas tem menos
dificuldade.
*/

SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFALON,
CASE
	WHEN DIFFALON= 1  THEN 'Yes'
	WHEN DIFFALON = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFALON IS NOT NULL
AND ASTHMS1 = 1
GROUP BY URBSTAT,DIFFALON
ORDER BY DIFFALON, URBSTAT
--Pessoas que já tiveram asma
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFALON,
CASE
	WHEN DIFFALON = 1  THEN 'Yes'
	WHEN DIFFALON = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFALON IS NOT NULL
AND ASTHMS1 = 2
GROUP BY URBSTAT,DIFFALON
ORDER BY DIFFALON, URBSTAT
--Pessoas que não tem asma
SELECT  URBSTAT,
CASE 
	WHEN URBSTAT = 1  THEN 'Urban'
	WHEN URBSTAT = 2  THEN 'Rural'
	ELSE NULL END AS  URBSTAT_Categories,
DIFFALON,
CASE
	WHEN DIFFALON = 1  THEN 'Yes'
	WHEN DIFFALON = 2  THEN 'No'
	ELSE NULL END AS  RFHLTH_Categories,
COUNT(*),
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY URBSTAT)
FROM UrbanStatus
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND DIFFALON IS NOT NULL
AND ASTHMS1 = 3
GROUP BY URBSTAT,DIFFALON
ORDER BY DIFFALON, URBSTAT