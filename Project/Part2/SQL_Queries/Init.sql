-- Pergunta inicial  1 - 1-	Uma maior proporção de pessoas que moram em cidade é asmáticas quando comparadas aquelas que moram em zonas rurais?

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
ORDER BY URBSTAT,ASTHMS1

-- Complementando agora para regiões metropolitanas e não metropolitanas
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
ORDER BY METSTAT,ASTHMS1

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
ORDER BY SEXVAR,ASTHMS1

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
ORDER BY INCOME3,ASTHMS1

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
ORDER BY BMI5CAT,ASTHMS1

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
ORDER BY RFBMI5,ASTHMS1
