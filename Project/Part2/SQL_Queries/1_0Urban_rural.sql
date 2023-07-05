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
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY URBSTAT),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN UrbanStatus ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
AND URBSTAT IS NOT NULL
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
COUNT(*) AS COUNT,
ROUND(COUNT (*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY METSTAT),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN UrbanStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
AND METSTAT IS NOT NULL
GROUP BY METSTAT,ASTHMS1
ORDER BY METSTAT,ASTHMS1;

/* Pergunta 1.1 Será que pessoas com asma que vivem em zonas rurais vs urbanas tem uma melhor saúde reportada?

Primeiro vamos comparar as pessoas que vivem em zonas rurais vs urbanas, depois incluimos a asma.
Vou utilizar o RFHLTH que é um resumo do GENHLTH que é se a pessoa disse que está com uma boa saúde ou não

Aparentemente pessoas em locais urbanos reportam ter uma maior saúde do que aqueles que vivem em zonas rurais
talvez devido ao maior acesso aos serviçoes de saúde.

Aqui é com relação a varios tipos de saúde que não só a fisica. 
*/

/* Vamos dar uma olhada nas pessoas que tem asma ASTHMS1  = 1

Há uma diferença, pessoas nas zonas urbaas aparentemente reportam uma saúde melhor!
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
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY URBSTAT),2) AS Percentage
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 1
GROUP BY URBSTAT,RFHLTH
ORDER BY URBSTAT,RFHLTH

/* Vamos comparar com as pessoas que tiveram asma mas não tem mais ASTHMS1  = 2

a diferença é menor, algo em torno de 3%, porém segue a mesma ideia, as pessoas que 
vivem em zonas urbanas tendem a reportar uma maior saúde do que aquelas que vivem em
zonas rurais. 

Uma coisa a se notar porém é que as pessoas com asma, 
aparentemente dizem bem menos que estão com uma boa saúde do que as pessoas que tiveram asma. 
Comparando por exemplo apenas as pessoas de zonas urbanas, vemos uma diferença 
de algo em torno de 12%.
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
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY URBSTAT),2) AS Percentage
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 2
GROUP BY URBSTAT,RFHLTH
ORDER BY URBSTAT,RFHLTH;

/* Agora as pessoas que nunca tiveram ASTHMS1  = 3
A diferença é um pouco menor. Segue aparentemente o mesmo padrão da ASTHMS1  = 2
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
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY URBSTAT),2) AS Percentage
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus 
ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL
AND RFHLTH IS NOT NULL
AND ASTHMS1  = 3
GROUP BY URBSTAT,RFHLTH
ORDER BY URBSTAT,RFHLTH;
/*
Agora vamos olhar a saúde fisica apenas.
PHYS14D



Vou olhar para as pessoas com asma igual fizemos no anterior.

Em vez de ver se as pessoas disseram se sentir bem, vamos ver a média dos dias que elas não se sentem bem.
Apesar de utilizarmos a média aqui, não sabemos como é a distribuição, portanto, no futuro talvez utilizaremos a mediana
como medida de tendência central em vez da média, mas aqui é só para ter uma idéia.
*/

/*
Vamos dar uma olhada na mediana e média( Pois não sabemos como é a distribuição dos dias)
*/
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
ROUND(AVG(CAST(PHYSHLTH AS FLOAT)),2) AS Mean
FROM UrbanStatus
INNER JOIN HealthStatus 
ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE URBSTAT IS NOT NULL
AND ASTHMS1  IS NOT NULL
AND PHYSHLTH IS NOT NULL
GROUP BY URBSTAT,ASTHMS1
ORDER BY URBSTAT,ASTHMS1;


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
, ROUND(SUM(Percentage) OVER(ORDER BY INCOME3 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS Cumulutative_Percentage
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
DROP TABLE IF EXISTS #Income_4_divided; 
-- Criando temp table (colocamos os números para ordenar certo futuramente)
SELECT
       ID,
       INCOME3,
        CASE
            WHEN INCOME3 IN (1, 2, 3, 4, 5) THEN '1. Less than $35,000'
            WHEN INCOME3 IN (6, 7) THEN '2. More than $35,000 and less than $75,000'
            WHEN INCOME3 IN (8, 9, 10) THEN '3. More than $75,000 and less than $150,000'
            WHEN INCOME3 IN (10, 11) THEN '4. $150,000 or more'
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

    COUNT(*) AS Count,

  ROUND(CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories),2) AS Percentage
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 1
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH;
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

    ROUND(CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories),2) AS Percentage
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 2
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH;
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

    COUNT(*) AS Count,

    ROUND(CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT,INCOME3_Categories),2) AS Percentage
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
RFHLTH IS NOT NULL AND
ASTHMS1 = 3
GROUP BY URBSTAT,INCOME3_Categories, RFHLTH
ORDER BY INCOME3_Categories,URBSTAT,RFHLTH;

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
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(PHYSHLTH AS FLOAT)),2) AS Mean
FROM
   #Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = #Income_4_divided.ID
INNER JOIN HealthStatus ON UrbanStatus.ID = HealthStatus.ID
INNER JOIN AsthmaStatus ON UrbanStatus.ID = AsthmaStatus.ID
WHERE URBSTAT IS NOT NULL AND 
PHYSHLTH IS NOT NULL AND
ASTHMS1 IS NOT NULL
GROUP BY URBSTAT,INCOME3_Categories,ASTHMS1
ORDER BY INCOME3_Categories,URBSTAT,ASTHMS1;



/*
É, aparentemente pessoas que tem asma reportam uma saúde fisica melhor em locais urbanos.
Em contraste, principalmente aquelas pessoas, que ganham mais de 35000 pelo menos e  que deixaram der ser asmáticas, reportam uma melhor 
saúde fisica nas zonas rurais. Isso se repete ligeiramente no publico que nunca teve asma.
*/
