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
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY URBSTAT)
FROM AsthmaStatus 
INNER JOIN UrbanStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
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
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY METSTAT)
FROM AsthmaStatus 
INNER JOIN UrbanStatus
ON AsthmaStatus.ID = UrbanStatus.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY METSTAT,ASTHMS1
ORDER BY METSTAT,ASTHMS1;

/* Pergunta 1.1 Ser� que pessoas com asma que vivem em zonas rurais vs urbanas tem uma melhor sa�de reportada?

Primeiro vamos comparar as pessoas que vivem em zonas rurais vs urbanas, depois incluimos a asma.
Vou utilizar o RFHLTH que � um resumo do GENHLTH que � se a pessoa disse que est� com uma boa sa�de ou n�o

Aparentemente pessoas em locais urbanos reportam ter uma maior sa�de do que aqueles que vivem em zonas rurais
talvez devido ao maior acesso aos servi�oes de sa�de.

Aqui � com rela��o a varios tipos de sa�de que n�o s� a fisica. 
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

Aparentemente, a diferen�a � ainda maior!

Uma coisa a se notar por�m, � que a propor��o de pessoas que reportaram com uma boa sa�de � bem menor.
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

/* Vamos comparar com as pessoas que tiveram asma mas n�o tem mais ASTHMS1  = 2
Seguem mais ou menos a propor��o da popula��o geral.
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
Tamb�m seguem mais ou menos a propor��o da popula��o geral.
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
Agora vamos olhar a sa�de fisica apenas.
PHYS14D

Olhando para o p�blico geral, parece n�o haver uma diferen�a.
Apenas nos 14+ dias de sa�de fisica n�o boa, que ha uma leve diferen�a.
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

Ao contr�rio do que eu pensava, pessoas que moram nas zonas urbanas reportam mais
que n�o tem nenhum dia com a sa�de fisica ruim, e reportam menos vezes que tem mais de 
14 dias+ com a sa�de fisica ruim quando comparada com as pessoas de zonas rurais.

Resumindo, as pessoas com asma de zonas urbanas reportam menos que tem uma sa�de fisica ruim do que as
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
Agora com as pessoas que tinham asma e n�o tem mais

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
Finalmente, com as pessoas que n�o tem asma.

Mais parecido com a popula��o geral, pois na verdade as pessoas que n�o tem
asma s�o a maioria.
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
, SUM(Percentage) OVER(ORDER BY INCOME3 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Income_not_null;

/*
Como podemos observar, vai ser dificil separar em 4 quartis, portanto vou tentar fazer o mais pr�ximo 
disso, por�m n�o ser� perfeitamente dividido em 4. 
Vou fazer da seguiente forma:
grupo 1 < 35.000(~30%)
grupo 2 < 75.000(~31%)
grupo 3 < 150.000(~28%)
grupo 4 > 150.000(~11%)
*/

WITH Income_4_divided(ID, INCOME3, INCOME3_Categories) AS (
    SELECT
        ID,
        INCOME3,
        CASE
            WHEN INCOME3 IN (1, 2, 3, 4, 5) THEN 'Less than $35,000'
            WHEN INCOME3 IN (6, 7) THEN 'Less than $75,000'
            WHEN INCOME3 IN (8, 9, 10) THEN 'Less than $150,000'
            WHEN INCOME3 IN (10, 11) THEN '$150,000 or more'
            ELSE NULL
        END AS INCOME3_Categories
    FROM
        Demographics
    WHERE
        INCOME3 IS NOT NULL
)
SELECT
    INCOME3_Categories,
    COUNT(*),
    COUNT(*) * 100 / SUM(COUNT(*)) OVER (PARTITION BY URBSTAT)
FROM
    Income_4_divided
INNER JOIN UrbanStatus ON UrbanStatus.ID = Income_4_divided.ID
INNER JOIN AsthmaStatus ON AsthmaStatus.ID = UrbanStatus.ID
GROUP BY URBSTAT,INCOME3_Categories, ASTHMS1
/* Pergunta 1.2 -- Existem uma diferen�a  no nivel de dificuldade reportada 
para fazer coisas sozinhas que pessoas com asma ou sem que vivem em zonas rurais vs urbanas ?

Vamos come�ar com a mais geral, 
*/