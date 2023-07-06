/*
Agora vamos analisar a seguinte pergunta
" O uso de alcool parece ter alguma associa��o com ter
asma, ter tido ou nunca ter tido asma?"

Vamos come�ar com o n�mero de drink que a pessoa
afirma ter bebido em m�dia durante os 30 dias anteriores
a entrevista
heheh vamos fazer a m�dia da m�dia.
Parece n�o ter efeito, mas vamos olhar sem o 0.
*/
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(AVEDRNK3 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND AVEDRNK3 IS NOT NULL
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
-- sem o 0
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(AVEDRNK3 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND AVEDRNK3 IS NOT NULL
AND AVEDRNK3 <> 0
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
/*Realmente n�o tem muita diferen�a,
n�o parece ter uma associa��o

Vamos ver se beber alcool no ultimos 30 dias tem.
Parece at� que ter, uma menor propor��o de pessoas 
que beberam tem asma.
*/

SELECT 
DRNKANY5,
CASE 
	WHEN DRNKANY5 = 1  THEN 'Yes'
	WHEN DRNKANY5 = 2  THEN 'No'
	ELSE NULL END AS  SEXVAR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY DRNKANY5),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND DRNKANY5 IS NOT NULL
GROUP BY DRNKANY5,ASTHMS1
ORDER BY DRNKANY5,ASTHMS1;

/* Vamos ver se a pessoa ser uma binge drinker tem alguma associa��o.
Binge drinker = males having five or more drinks on one occasion, females having four or more drinks on one occasion)

N�o parece ter uma associa��o
*/
SELECT 
RFBING5,
CASE 
	WHEN RFBING5 =  1  THEN 'No'
	WHEN RFBING5 = 2  THEN 'Yes'
	ELSE NULL END AS  SEXVAR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY RFBING5),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND RFBING5 IS NOT NULL
GROUP BY RFBING5,ASTHMS1
ORDER BY RFBING5,ASTHMS1;

/*
Agora para heavy drinkers:(adult men having more than 14 drinks per week and adult women having more than 7 drinks per week)
N�o parece ter associa��o.
*/
SELECT 
RFDRHV7,
CASE 
	WHEN RFDRHV7 =  1  THEN 'No'
	WHEN RFDRHV7 = 2  THEN 'Yes'
	ELSE NULL END AS  RFDRHV7_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY RFDRHV7),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND RFDRHV7 IS NOT NULL
GROUP BY RFDRHV7,ASTHMS1
ORDER BY RFDRHV7,ASTHMS1;


/*
Vamos olhar o n�mero de ocasi�es de beber alcool  por dia.
Parece que  tem  asma bebe menos ocasi�es de beber alcool  por dia
*/
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(DROCDY3 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND DROCDY3 IS NOT NULL
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
-- sem o 0
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(DROCDY3 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN AlcoholConsu
ON AsthmaStatus.ID = AlcoholConsu.ID
WHERE ASTHMS1 IS NOT NULL
AND DROCDY3 IS NOT NULL
AND DROCDY3 <> 0
GROUP BY ASTHMS1
ORDER BY ASTHMS1;

/* 
Agora vamos para uma variavel chatinha de fazer conta
ALCDAY5
Ela mede tanto numero de bebidas por semana
quanto por m�s.
Se o n�mero for entre 101 e 107, os ultimos dois algarismos
representam os n�mero de dias
Se for entre 201 e 230, a mesma coisa s� que para dias do m�s.

N�o parece ter uma associa��o.
*/
WITH Days_of_drinking (ID,ALCDAY5,Days_of_drinking_per_week,Days_of_drinking_per_month) AS(
SELECT ID, ALCDAY5,
CASE WHEN ALCDAY5 >= 101 AND ALCDAY5 <=107 THEN ALCDAY5 - 100
	 WHEN ALCDAY5 = 0 THEN 0
	 ELSE NULL END AS Days_of_drinking_per_week,
CASE WHEN ALCDAY5 >= 201 AND ALCDAY5 <= 230 THEN ALCDAY5 - 200
	 WHEN ALCDAY5 = 0 THEN 0
	 ELSE NULL END AS Days_of_drinking_per_month
FROM AlcoholConsu

)
		
SELECT ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(Days_of_drinking_per_week AS FLOAT)),2) AS Mean_Per_week,
ROUND(AVG(CAST(Days_of_drinking_per_month AS FLOAT)),2) AS Mean_Per_month
FROM Days_of_drinking 
INNER JOIN AsthmaStatus
ON AsthmaStatus.ID = Days_of_drinking.ID
WHERE ASTHMS1 IS NOT NULL
AND ALCDAY5 IS NOT NULL
AND ALCDAY5 <> 0
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
