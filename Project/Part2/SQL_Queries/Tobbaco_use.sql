/*
Vamos dar uma olhada se o uso do tabaco tem algum efeito em ter asma.

Vou olhar tanto o uso cl�ssico(Ou seja, cigarro), quanto o uso apenas
das substancias (Smokeless tobbaco productos) e de cigarros eletronicos.

Primeiros vamos para uma abordagem mais geral, pessoas que s�o fumantes 
vs n�o fumantes.

Aparentemente uma maior propor��o  de pessoas que fumam s�o asm�ticas.
*/
SELECT 
RFSMOK3,
CASE 
	WHEN RFSMOK3= 1  THEN 'No'
	WHEN RFSMOK3 = 2  THEN 'Yes'
	ELSE NULL END AS  TobaccoUse_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY RFSMOK3)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND RFSMOK3 IS NOT NULL
GROUP BY RFSMOK3,ASTHMS1
ORDER BY RFSMOK3,ASTHMS1;
/* 
Vamos inverter um pouco, das pessoas que tem asma
qual a propor��o que fumam?

Hmm aparentemente, pessoas que tem asma ou j� tiveram
tendem a fumar menos do que as pessoas que nunca tiveram.

Por�m, as pessoas que j� fumam, tem mais asma do que as 
que nunca fumaram.

Interessante, aparentemente pode haver uma dependencia 
entre fumar e ter asma.
*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
RFSMOK3,
CASE 
	WHEN RFSMOK3= 1  THEN 'No'
	WHEN RFSMOK3 = 2  THEN 'Yes'
	ELSE NULL END AS  TobaccoUse_Categories,

COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY ASTHMS1)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND RFSMOK3 IS NOT NULL
GROUP BY ASTHMS1,RFSMOK3
ORDER BY ASTHMS1,RFSMOK3;

/* 
Olhamos apenas para as pessoas que fumam ou n�o,
mas ser� que a frequ�ncia de fumo afeta esse ponto?


Aparentemente, a tend�ncia �:
Quanto maior a frequ�ncia de fumo maior a propor��o de pessoas
com asma. � importante at� diferenciar, que pessoas que j�
fumaram tem uma propor��o diferente de pessoas que nunca fumaram.
*/
SELECT 
SMOKER3,
CASE 
	WHEN SMOKER3= 1  THEN 'Current smoker -now smokes every day'
	WHEN SMOKER3 = 2  THEN 'Current smoker -now smokes some days'
	WHEN SMOKER3 = 3  THEN 'Former smoker'
	WHEN SMOKER3 = 4 THEN 'Never smoked'
	ELSE NULL END AS  SMOKER3_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY SMOKER3)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND SMOKER3 IS NOT NULL
GROUP BY SMOKER3,ASTHMS1
ORDER BY SMOKER3,ASTHMS1;

/*
Agora vamos olhar para apenas o uso de 
cigarros eletronicos.

Como o anterior, vamos primeiro olhar para quem usa
vs quem n�o usa.

Hmm da mesma forma que o cigarro, parece que 
as pessoas que utilizam cigarros eletronicos tem uma maior 
propor��o de pessoas que tem asma ou j� tiveram.
*/

SELECT 
CURECI1,
CASE 
	WHEN CURECI1= 1  THEN 'No'
	WHEN CURECI1 = 2  THEN 'Yes'
	ELSE NULL END AS  TobaccoUse_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY CURECI1)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND CURECI1 IS NOT NULL
GROUP BY CURECI1,ASTHMS1
ORDER BY CURECI1,ASTHMS1;

/*
Vamos inverter novamente.

Nessa caso vemos um uso ainda menor do 
cigarros eletr�nicos por parte das pessoas que tem asma.

Por�m � importante notar a diferen�a entre as pessoas que j� tiveram asma
em rela��o as que nunca tiveram.

As que j� tiveram asma usam mais do que as pessoas que nunca 
tiveram.


*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
CURECI1,
CASE 
	WHEN CURECI1= 1  THEN 'No'
	WHEN CURECI1 = 2  THEN 'Yes'
	ELSE NULL END AS  TobaccoUse_Categories,

COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY ASTHMS1)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND CURECI1 IS NOT NULL
GROUP BY ASTHMS1,CURECI1
ORDER BY ASTHMS1,CURECI1;

/*
Agora vamos olhar a frequ�ncia de uso dos cigarros 
eletr�nicos.
Olha que interessante.

Aparentemente, quem utiliza dentro das pessoas que utilizam
os cigarros eletr�nicos h� uma maior propor��o de pessoas com asma
para as pessoas que utilizam as vezes do que as pessoas que sempre usam!
*/
SELECT 
ECIGNOW1,
CASE 
	WHEN ECIGNOW1= 1  THEN 'Every day'
	WHEN ECIGNOW1 = 2  THEN 'Some days'
	WHEN ECIGNOW1 = 3  THEN 'Not at all'
	WHEN ECIGNOW1 = 4 THEN 'Never used e-cigs'
	ELSE NULL END AS  SMOKER3_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY ECIGNOW1)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND ECIGNOW1 IS NOT NULL
GROUP BY ECIGNOW1,ASTHMS1
ORDER BY ECIGNOW1,ASTHMS1;

/*
Agora vamos para o uso de produtos de tabaco
mas que n�o produzem fuma�a, ou seja, n�o s�o consumidos 
atrav�s do fumo.

Aqui n�o temos uma categoria para sim ou n�o, ent�o vamos
direto para as frequ�ncias.

Interessante, as pessoas que usam smokeless products 
tem uma menor propor��o pessoas que tem asma.
*/
SELECT 
USENOW3,
CASE 
	WHEN USENOW3= 1  THEN 'Every day'
	WHEN USENOW3 = 2  THEN 'Some days'
	WHEN USENOW3 = 3  THEN 'Not at all'
	ELSE NULL END AS  ECIGNOW1_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY USENOW3)
FROM AsthmaStatus 
INNER JOIN TobaccoUse
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE ASTHMS1 IS NOT NULL
AND USENOW3 IS NOT NULL
GROUP BY USENOW3,ASTHMS1
ORDER BY USENOW3,ASTHMS1;

/* Ser� que o uso combinado de algumas dessas variaveis
tem um efeito maior?

Vamos combinar primeiro cigarros eletr�nicos e 
cigarro

Aparentemente os dois juntos tem ume efeito maior sobre a propor��o de
pessoas com asma. Importante notar por�m, que aparentemente o cigarro
normal tem um maior efeito do que s� o e-cig na propor��o de asm�ticos
( Lembrando que esse � um 
estudo observacional, n�o podemos falar sobre causa aqui). 
*/

WITH Combined_Vape_Smoke(ID,Combined_status) AS (
SELECT ID,
CASE 
	WHEN RFSMOK3 = 1 AND CURECI1 = 1 THEN 'Neither'
	WHEN RFSMOK3 = 2 AND CURECI1 = 1 THEN 'Only smokes cigaretes'
	WHEN RFSMOK3 = 1 AND CURECI1 = 2 THEN 'Only smokes e-cigs'
	WHEN RFSMOK3 = 2 AND CURECI1 = 2 THEN 'Smokes both'
	ELSE NULL END AS Combined_status
FROM TobaccoUse
WHERE RFSMOK3 IS NOT NULL
AND CURECI1 IS NOT NULL
)

SELECT 
Combined_status,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Combined_status) AS Percentage
FROM Combined_Vape_Smoke
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = Combined_Vape_Smoke.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY Combined_status,ASTHMS1
ORDER BY Combined_status,ASTHMS1;

/*
Agora vamos combinar os 3.
Nesse caso como temos s� a frequ�ncia vamos ter que usar os dois statuss
de frequencia como "utiliza".

Olha que interessante. Enquanto fumar tanto cigarros eletronicos quanto
cigarros normais tem o efeito de aumentar a propor��o de pessoas que tem asma
usar smokeless products, tem o efeito de diminuir, mesmo quando os outros dois 
est�o presentes.
*/

WITH Combined_Vape_Smoke_Smokeless(ID,Combined_status) AS (
SELECT ID,
CASE 
	WHEN RFSMOK3 = 1 AND CURECI1 = 1 AND USENOW3 = 3 THEN '1 Neither'

	WHEN RFSMOK3 = 2 AND CURECI1 = 1 AND USENOW3 = 3 THEN '2 Only smokes cigaretes'
	WHEN RFSMOK3 = 1 AND CURECI1 = 2 AND USENOW3 = 3 THEN '3 Only smokes e-cigs'
	WHEN RFSMOK3 = 1 AND CURECI1 = 1 AND USENOW3 IN (1,2) THEN '4 Only uses smokeless products'

	WHEN RFSMOK3 = 1 AND CURECI1 = 2 AND USENOW3 IN (1,2)THEN '5 Only uses e-cig and smokeless'
	WHEN RFSMOK3 = 2 AND CURECI1 = 1 AND USENOW3 IN (1,2)THEN '6 Only uses cigarete and smokeless'
	WHEN RFSMOK3 = 2 AND CURECI1 = 2 AND USENOW3 = 3 THEN '7 Only uses e-cig and cigarete'

	WHEN RFSMOK3 = 2 AND CURECI1 = 2 AND USENOW3 IN (1,2)THEN '8Uses all productts'
	ELSE NULL END AS Combined_status
FROM TobaccoUse
WHERE RFSMOK3 IS NOT NULL
AND CURECI1 IS NOT NULL
AND USENOW3 IS NOT NULL
)

SELECT 
Combined_status,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS COUNT,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Combined_status) AS Percentage
FROM Combined_Vape_Smoke_Smokeless
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = Combined_Vape_Smoke_Smokeless.ID
WHERE ASTHMS1 IS NOT NULL
GROUP BY Combined_status,ASTHMS1
ORDER BY Combined_status,ASTHMS1;

/* Vamos dar uma olhada no n�mero de dias que pessoas que pessoam que fumam particionado
se a pessoa tem asma ou n�o.

Aparentemente a m�dia se mant�m, independente se a pessoa tem asma ou n�o.
*/

SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(LCSNUMCG AS FLOAT)),2) AS Mean
FROM TobaccoUse
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = TobaccoUse.ID
WHERE RFSMOK3 = 2 
AND ASTHMS1 IS NOT NULL
GROUP BY ASTHMS1
ORDER BY ASTHMS1;

