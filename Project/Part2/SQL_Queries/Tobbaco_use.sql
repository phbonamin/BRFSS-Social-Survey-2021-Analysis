-- Pergunta 3	Fumar afeta est� relacionado de alguma forma com  asma? 
-- SMOKE 100 fumar pele menos 100 cigarros na vida toda - N�o parece ter nenhuma diferen�a muito significativa.
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

/* SMOKEDAY2 das pessoas que j� fumaram 100 cigarros na vida toda, qual a frequ�ncia 
de fumo hoje em dia. 
 Parece ter algum efeito, quanto mais as pessoas fumam, aumenta a frequ�ncia,
 pouco, mas aumenta 1% por categoria. 

 E nesse caso, NULL � quem n�o fuma, portanto da pra ver a diferen�a com quem n�o fuma 
 ou pelo menos diz n�o fumar.
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
sem fumo e pode fumar ao mesmo tempo, por isso talvez a propor��o maior de pessoas que
n�o usam produtos de tabaco e tem asma. Portanto, vou fazer tanto a sem o filtro de que 
n�o fuma e a com filtro que n�o fumou 100 cigarros ( WHERE SMOKE100 = 2)

Apesar do N ser baixo, parece que quanto maior o uso de smokeless products de tabaco,
menor a propor��o de ter asma atualmente. 
Lembrando que ainda n�o podemos afimar nada categoricamente pois n�o estamos 
fazendo teste de hip�tese nenhum, apenas explorando os dados.
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
fumou mais de 100 cigarros e quem j� fumou.

Parece que no combinado e pra quem usar alguns dias  tem uma maior propor��o que todos( aparentemente signficiativa)

J� para quem nunca fumou mais de 100 cigarros, quanto maior a frequ�ncia de uso, maior a propor��o de pessoas que tem asma.

Algo que seria uma hip�tese, seria que quem fuma ,as vezes usa os e-cigsm e portanto tem um risco combinado de ter asma 
correlacionado a esses fatores.

J� quem s� usa o e-cig s� v� o risco elevado conforme a frequ�ncia de uso do e-cig aumenta.
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



