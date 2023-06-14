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
ORDER BY URBSTAT,ASTHMS1;

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
ORDER BY METSTAT,ASTHMS1;

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

-- Pergunta 3	Fumar afeta está relacionado de alguma forma com  asma? 
-- SMOKE 100 fumar pele menos 100 cigarros na vida toda - Não parece ter nenhuma diferença muito significativa.
SELECT 
SMOKE100,
CASE 
	WHEN SMOKE100 = 1 THEN 'Yes'
	WHEN SMOKE100 = 2 THEN 'No'
	ELSE NULL END AS SMOKE100_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY SMOKE100)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY SMOKE100,ASTHMS1
ORDER BY SMOKE100,ASTHMS1;

/* SMOKEDAY2 das pessoas que já fumaram 100 cigarros na vida toda, qual a frequência 
de fumo hoje em dia. 
 Parece ter algum efeito, quanto mais as pessoas fumam, aumenta a frequência,
 pouco, mas aumenta 1% por categoria. 

 E nesse caso, NULL é quem não fuma, portanto da pra ver a diferença com quem não fuma 
 ou pelo menos diz não fumar.
 */
SELECT 
SMOKDAY2,
CASE 
	WHEN SMOKDAY2 = 1 THEN 'Every day'
	WHEN SMOKDAY2 = 2 THEN 'Some days'
	WHEN SMOKDAY2 = 3 THEN 'Not at all'
	ELSE NULL END AS SMOKDAY2_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY SMOKDAY2)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY SMOKDAY2,ASTHMS1
ORDER BY SMOKDAY2,ASTHMS1;

/*USENOW3 - Uso de produtos sem fumo(smokeless) que tem tabaco no meio
Nese caso, acho que da pra confundir, pois a pessoa pode usar um produto 
sem fumo e pode fumar ao mesmo tempo, por isso talvez a proporção maior de pessoas que
não usam produtos de tabaco e tem asma. Portanto, vou fazer tanto a sem o filtro de que 
não fuma e a com filtro que não fumou 100 cigarros ( WHERE SMOKE100 = 2)

Apesar do N ser baixo, parece que quanto maior o uso de smokeless products de tabaco,
menor a proporção de ter asma atualmente. 
Lembrando que ainda não podemos afimar nada categoricamente pois não estamos 
fazendo teste de hipótese nenhum, apenas explorando os dados.
*/
SELECT 
USENOW3,
CASE 
	WHEN USENOW3 = 1 THEN 'Every day'
	WHEN USENOW3 = 2 THEN 'Some days'
	WHEN USENOW3 = 3 THEN 'Not at all'
	ELSE NULL END AS USENOW3_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY USENOW3)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY USENOW3,ASTHMS1
ORDER BY USENOW3,ASTHMS1;

SELECT 
USENOW3,
CASE 
	WHEN USENOW3 = 1 THEN 'Every day'
	WHEN USENOW3 = 2 THEN 'Some days'
	WHEN USENOW3 = 3 THEN 'Not at all'
	ELSE NULL END AS SMOKE100_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY USENOW3)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND SMOKE100 = 2
GROUP BY USENOW3,ASTHMS1
ORDER BY USENOW3,ASTHMS1;

SELECT 
USENOW3,
CASE 
	WHEN USENOW3 = 1 THEN 'Every day'
	WHEN USENOW3 = 2 THEN 'Some days'
	WHEN USENOW3 = 3 THEN 'Not at all'
	ELSE NULL END AS SMOKE100_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY USENOW3)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND SMOKE100 = 1
GROUP BY USENOW3,ASTHMS1
ORDER BY USENOW3,ASTHMS1;

/* ECIGNOW1-  frequencia de uso de e-cigaretes

Vou fazer Igual ao do USENOW3, fazer o uso geral e depois comparar com quem nunca
fumou mais de 100 cigarros e quem já fumou.

Parece que no combinado e pra quem usar alguns dias  tem uma maior proporção que todos( aparentemente signficiativa)

Já para quem nunca fumou mais de 100 cigarros, quanto maior a frequência de uso, maior a proporção de pessoas que tem asma.

Algo que seria uma hipótese, seria que quem fuma ,as vezes usa os e-cigsm e portanto tem um risco combinado de ter asma 
correlacionado a esses fatores.

Já quem só usa o e-cig só vê o risco elevado conforme a frequência de uso do e-cig aumenta.
*/
---  Geral
SELECT 
ECIGNOW1,
CASE 
	WHEN ECIGNOW1 = 1 THEN 'Every day'
	WHEN ECIGNOW1 = 2 THEN 'Some days'
	WHEN ECIGNOW1 = 3 THEN 'Not at all'
	WHEN ECIGNOW1 = 4 THEN 'Never used e-cigs'

	ELSE NULL END AS ECIGNOW1_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY ECIGNOW1)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY ECIGNOW1,ASTHMS1
ORDER BY ECIGNOW1,ASTHMS1;
--- Nunca fumou mais de 100 cigarros a vida toda
SELECT 
ECIGNOW1,
CASE 
	WHEN ECIGNOW1 = 1 THEN 'Every day'
	WHEN ECIGNOW1 = 2 THEN 'Some days'
	WHEN ECIGNOW1 = 3 THEN 'Not at all'
	WHEN ECIGNOW1 = 4 THEN 'Never used e-cigs'
	ELSE NULL END AS ECIGNOW1_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY ECIGNOW1)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND SMOKE100 = 2
GROUP BY ECIGNOW1,ASTHMS1
ORDER BY ECIGNOW1,ASTHMS1;

--- Fumou mais de 100 cigarros a vida toda
SELECT 
ECIGNOW1,
CASE 
	WHEN ECIGNOW1 = 1 THEN 'Every day'
	WHEN ECIGNOW1 = 2 THEN 'Some days'
	WHEN ECIGNOW1 = 3 THEN 'Not at all'
	WHEN ECIGNOW1 = 4 THEN 'Never used e-cigs'
	ELSE NULL END AS ECIGNOW1_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,

COUNT(ASTHMS1) AS COUNT,
COUNT(ASTHMS1) * 100.0 / SUM(COUNT(ASTHMS1)) OVER(PARTITION BY ECIGNOW1)

FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND SMOKE100 = 1
GROUP BY ECIGNOW1,ASTHMS1
ORDER BY ECIGNOW1,ASTHMS1;