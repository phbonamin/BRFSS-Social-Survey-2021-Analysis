-- Pergunta inicial  1-	Uma maior propor��o de pessoas que moram em cidade � asm�ticas quando comparadas aquelas que moram em zonas rurais?

-- N�o , propor��es s�o muito parecidas.
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
-- Complementando agora para regi�es metropolitanas e n�o metropolitanas - tamb�m n�o tem efeito
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

/* Pergunta 1.1 Ser� que pessoas com asma que vivem em zonas rurais vs urbanas tem uma melhor sa�de reportada?

Primeiro vamos comparar as pessoas que vivem em zonas rurais vs urbanas, depois incluimos a asma.
Vou utilizar o RFHLTH que � um resumo do GENHLTH que � se a pessoa disse que est� com uma boa sa�de ou n�o

Aparentemente pessoas em locais urbanos reportam ter uma maior sa�de do que aqueles que vivem em zonas rurais
talvez devido ao maior acesso aos servi�oes de sa�de.

Aqui � com rela��o a varios tipos de sa�de que n�o s� a fisica. 
*/

/* Vamos dar uma olhada nas pessoas que tem asma ASTHMS1  = 1

H� uma diferen�a, pessoas nas zonas urbaas aparentemente reportam uma sa�de melhor!
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

/* Vamos comparar com as pessoas que tiveram asma mas n�o tem mais ASTHMS1  = 2

a diferen�a � menor, algo em torno de 3%, por�m segue a mesma ideia, as pessoas que 
vivem em zonas urbanas tendem a reportar uma maior sa�de do que aquelas que vivem em
zonas rurais. 

Uma coisa a se notar por�m � que as pessoas com asma, 
aparentemente dizem bem menos que est�o com uma boa sa�de do que as pessoas que tiveram asma. 
Comparando por exemplo apenas as pessoas de zonas urbanas, vemos uma diferen�a 
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
A diferen�a � um pouco menor. Segue aparentemente o mesmo padr�o da ASTHMS1  = 2
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
Agora vamos olhar a sa�de fisica apenas.
PHYS14D



Vou olhar para as pessoas com asma igual fizemos no anterior.

Em vez de ver se as pessoas disseram se sentir bem, vamos ver a m�dia dos dias que elas n�o se sentem bem.
Apesar de utilizarmos a m�dia aqui, n�o sabemos como � a distribui��o, portanto, no futuro talvez utilizaremos a mediana
como medida de tend�ncia central em vez da m�dia, mas aqui � s� para ter uma id�ia.
*/

/*
Vamos dar uma olhada na mediana e m�dia( Pois n�o sabemos como � a distribui��o dos dias)
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


/*1.1.1 - Ser� que a renda interfere nesse t�picos anteriores?
Sim, estou insistindo bastante nesse t�pico pois eu tenho asma e me sinto melhor no interior.

Pensei que talvez isso se devesse ao um maior acesso as servi�oes de sa�de e etc, portanto poderia
estar correlacionado com a renda.

Por exemplo, uma pessoa que j� tenha dinheiro e acesso, vai viver melhor no interior do que uma pessoa 
que n�o tenha, principalmente as pessoas que tenham asma.

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
Como podemos observar, vai ser dificil separar em 4 quartis, portanto vou tentar fazer o mais pr�ximo 
disso, por�m n�o ser� perfeitamente dividido em 4. 
Vou fazer da seguinte forma:
grupo 1 < 35.000(~30%)
grupo 2 < 75.000(~31%)
grupo 3 < 150.000(~28%)
grupo 4 > 150.000(~11%)
*/
DROP TABLE IF EXISTS #Income_4_divided; 
-- Criando temp table (colocamos os n�meros para ordenar certo futuramente)
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
-- Vendo os dados quando a pessoa tinha asma mas n�o tem mais
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
Bom, para a saude no geral vimos que o nivel muda conforme a faixa economica por�m, 
as pessoas nas zonas urbanas com apenas 1 exce��o( teve asma e tem entre 75 e 35) 
tem reportado uma maior sa�de do que as �reas rurais.

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
�, aparentemente pessoas que tem asma reportam uma sa�de fisica melhor em locais urbanos.
Em contraste, principalmente aquelas pessoas, que ganham mais de 35000 pelo menos e  que deixaram der ser asm�ticas, reportam uma melhor 
sa�de fisica nas zonas rurais. Isso se repete ligeiramente no publico que nunca teve asma.
*/
