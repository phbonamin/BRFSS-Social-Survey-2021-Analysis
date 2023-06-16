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
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY SEXVAR)
FROM AsthmaStatus 
INNER JOIN Demographics
ON AsthmaStatus.ID = Demographics.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY SEXVAR,ASTHMS1
ORDER BY SEXVAR,ASTHMS1;

--- INCOME3 - Categorias muito espalhadas tem que estreitar mais # refazer

SELECT 
INCOME3,
CASE 
	WHEN INCOME3 = 1  THEN 'Less than $10,000'
	WHEN INCOME3 = 2  THEN '$10,000 to < $15,000'
	WHEN INCOME3 = 3  THEN '$15,000 to < $20,000'
	WHEN INCOME3 = 4  THEN '$20,000 to < $25,000'
	WHEN INCOME3 = 5  THEN '$25,000 to < $35,000'
	WHEN INCOME3 = 6  THEN '$35,000 to < $50,000'
	WHEN INCOME3 = 7  THEN '$50,000 to < $75,000)'
	WHEN INCOME3 = 8  THEN '$75,000 to < $100,000)'
	WHEN INCOME3 = 9  THEN '$100,000 to < $150,000'
	WHEN INCOME3 = 10  THEN '$100,000 to < $200,000'
	WHEN INCOME3 = 11  THEN '$200,000 or more'
	ELSE NULL END AS  INCOME3_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(ASTHMS1) AS COUNT,
count(ASTHMS1) * 100.0 / sum(count(ASTHMS1)) OVER(PARTITION BY INCOME3)
FROM AsthmaStatus 
INNER JOIN Demographics
ON AsthmaStatus.ID = Demographics.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY INCOME3,ASTHMS1
ORDER BY INCOME3,ASTHMS1;

--- AGEG5YR a mesma coisa do income # Pulado por enquanto

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
	WHEN BMI5CAT = 1 OR BMI5CAT = 2 OR BMI5CAT = 3 THEN 'Non-obese'
	WHEN BMI5CAT = 4  THEN 'Obese'
	ELSE NULL END AS  BMI5CAT_Categories
FROM Demographics

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