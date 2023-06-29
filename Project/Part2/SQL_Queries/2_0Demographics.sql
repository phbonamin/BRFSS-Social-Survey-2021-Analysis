-- Pergunta inicial  2 - Alguma variavel demográfica parece ter efeito na proporção?

--- SEXVAR -- Mulheres parecem estar atualmente com asma mais do os homens.
SELECT 
SEXVAR,
CASE 
	WHEN SEXVAR = 1  THEN 'Male'
	WHEN SEXVAR = 2  THEN 'Female'
	ELSE NULL END AS  SEXVAR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY SEXVAR),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN Demographics
ON AsthmaStatus.ID = Demographics.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY SEXVAR,ASTHMS1
ORDER BY SEXVAR,ASTHMS1;

/* INCOME3 - Baseado nas categorias criadas no Urban Rural, vamos ver a distribuição.
Parece que quanto menor a renda, maior a proporção de pessoas asmáticas 
*/
WITH INCOME3_Categories(ID,INCOME3, INCOME3_Categories) AS(
SELECT ID,
INCOME3,
CASE 
	 WHEN INCOME3 IN (1, 2, 3, 4, 5) THEN 'Less than $35,000'
     WHEN INCOME3 IN (6, 7) THEN 'Less than $75,000 and more than $35,000'
     WHEN INCOME3 IN (8, 9, 10) THEN 'Less than $150,000 and more than $75,000'
     WHEN INCOME3 IN (10, 11) THEN '$150,000 or more'
	ELSE NULL END AS  INCOME3_Categories
FROM Demographics
WHERE INCOME3 IS NOT NULL 
)
SELECT 
INCOME3_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY INCOME3_Categories)
FROM AsthmaStatus 
INNER JOIN INCOME3_Categories
ON AsthmaStatus.ID = INCOME3_Categories.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY INCOME3_Categories,ASTHMS1
ORDER BY INCOME3_Categories,ASTHMS1;

/* AGEG5YR Vamos fazer uma análise similar de idade igual fizemos a renda.
Vamos tentar dividir em 4 quartis e depois vamos tentar analisar as distribuições 
dentro dessas faixas.
*/
WITH Age_not_null (AGEG5YR,AGEG5YR_Categories, Count,Percentage)  AS (
SELECT AGEG5YR,
CASE 
	WHEN  AGEG5YR = 1 THEN 'Age 18 to 24'
	WHEN  AGEG5YR = 2 THEN 'Age 25 to 29'
	WHEN  AGEG5YR = 3 THEN 'Age 30 to 34'
	WHEN  AGEG5YR = 4 THEN 'Age 35 to 39'
	WHEN  AGEG5YR = 5 THEN 'Age 40 to 44'
	WHEN  AGEG5YR = 6 THEN 'Age 45 to 49'
	WHEN  AGEG5YR = 7 THEN 'Age 50 to 54'
	WHEN  AGEG5YR = 8 THEN 'Age 55 to 59'
	WHEN  AGEG5YR = 9 THEN 'Age 60 to 64'
	WHEN  AGEG5YR = 10 THEN 'Age 65 to 69'
	WHEN  AGEG5YR = 11 THEN 'Age 70 to 74'
	WHEN  AGEG5YR = 12 THEN 'Age 75 to 79'
	WHEN  AGEG5YR = 13 THEN 'Age 80 or older'
	ELSE NULL END AS AGEG5YR_Categories,	
COUNT(*) AS Count,
CAST(COUNT(*) * 100 AS FLOAT) / SUM(COUNT(*)) OVER() AS Percentage
FROM Demographics
WHERE AGEG5YR IS NOT NULL
GROUP BY AGEG5YR)

SELECT *
, SUM(Percentage) OVER(ORDER BY AGEG5YR RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Age_not_null;

/*
Aparentemente podemos formar as seguintes faixas etárias:
18 to 39 ( ~24%)
40 to 54 (~22%)
55 to 69 ( ~ 30%)
70 or older( ~ 24%)

Lembrando que estamos tentando dividir em 4 quartis já que não temos as idades em número
mas não vai dar exato realmente.
Agora, vamos analisar essas faixas etárias.
Aparentemente não há muita diferença, só as pessoas com 70+ parecem ter menos asma e as 
pessoas com 18 a 39 parecem ter mais pessoas que tinham asma e não tem mais.
*/
WITH AGEG5YR_Categories(ID,AGEG5YR, AGEG5YR_Categories) AS(
SELECT ID,
AGEG5YR,
CASE 
	 WHEN AGEG5YR IN (1, 2, 3, 4) THEN '18 to 39 '
     WHEN AGEG5YR IN (5,6, 7) THEN '40 to 54'
     WHEN AGEG5YR IN (8, 9, 10) THEN '55 to 69'
     WHEN AGEG5YR IN (11, 12,13) THEN '70 or older'
	ELSE NULL END AS  AGEG5YR_Categories
FROM Demographics
WHERE AGEG5YR IS NOT NULL 
)
SELECT 
AGEG5YR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY AGEG5YR_Categories)
FROM AsthmaStatus 
INNER JOIN AGEG5YR_Categories
ON AsthmaStatus.ID = AGEG5YR_Categories.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY AGEG5YR_Categories,ASTHMS1
ORDER BY AGEG5YR_Categories,ASTHMS1

--- BMICAT - Pessoas obesar tem uma proporção diferente de pessoas atualmente com asma. 
--- Próxima analise trata disso.

SELECT 
BMI5CAT,
CASE 
	WHEN BMI5CAT = 1  THEN 'Underweight'
	WHEN BMI5CAT = 2  THEN 'Normal Weight'
	WHEN BMI5CAT = 3  THEN 'Overweight'
	WHEN BMI5CAT = 4  THEN 'Obese'
	ELSE NULL END AS  BMI5CAT_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY BMI5CAT)
FROM AsthmaStatus 
INNER JOIN Demographics
ON AsthmaStatus.ID = Demographics.ID
WHERE ASTHMS1 IS NOT NULL
AND BMI5CAT IS NOT NULL
GROUP BY BMI5CAT,ASTHMS1
ORDER BY BMI5CAT,ASTHMS1;

---RFBMI5 Pessoas acima do peso ou obesas versus não obesas ou acima do peso 
--- Pàrece ter um efeito, olhar melhor obesas vs não obesas.

SELECT 
RFBMI5,
CASE 
	WHEN RFBMI5 = 1  THEN 'Não Obesa ou acima do peso'
	WHEN RFBMI5 = 2  THEN 'Obesa ou acima do peso'
	ELSE NULL END AS  RFBMI5_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY RFBMI5)
FROM AsthmaStatus 
INNER JOIN Demographics
ON AsthmaStatus.ID = Demographics.ID
WHERE ASTHMS1 IS NOT NULL
AND RFBMI5 IS NOT NULL
GROUP BY RFBMI5,ASTHMS1
ORDER BY RFBMI5,ASTHMS1;

--- Vou olhar obesas e não obesas
-- Criar uma CTE para selecionar e agroupar pela nova coluna criada de obeso e não obeso
--- Ser obeso ou não parece estar rlacionado com asma, assim como não ser acima do peso ou não.

WITH BMI5CAT_Obese_non_obese(ID,BMI5CAT,BMI5CAT_Categories) AS 
( 
SELECT ID,
BMI5CAT,
CASE 
	WHEN BMI5CAT IN(1,2,3) THEN 'Non-obese'
	WHEN BMI5CAT = 4  THEN 'Obese'
	ELSE NULL END AS  BMI5CAT_Categories
FROM Demographics
WHERE BMI5CAT IS NOT NULL
)


SELECT 
BMI5CAT_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY BMI5CAT_Categories)

FROM AsthmaStatus 
INNER JOIN BMI5CAT_Obese_non_obese
ON AsthmaStatus.ID = BMI5CAT_Obese_non_obese.ID
WHERE ASTHMS1 IS NOT NULL

GROUP BY BMI5CAT_Categories,ASTHMS1
ORDER BY BMI5CAT_Categories,ASTHMS1;