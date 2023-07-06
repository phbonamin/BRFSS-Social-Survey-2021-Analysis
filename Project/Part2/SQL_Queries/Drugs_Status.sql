/*
Vamos analisar a seguinte pergunta:
"O uso de drogas e Marijuana(pois, Marijuana é legal nos EUA)
tem algum associação com ter asma ou não?"

*/
-- média de  dias usando Marijuana
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(MARIJAN1 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN DrugsUse
ON AsthmaStatus.ID = DrugsUse.ID
WHERE ASTHMS1 IS NOT NULL
AND MARIJAN1 IS NOT NULL
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
-- média de  dias usando Marijuana, vou tirar o 0 só ver só quem usa
SELECT
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(MARIJAN1 AS FLOAT)),2) AS Mean
FROM AsthmaStatus 
INNER JOIN DrugsUse
ON AsthmaStatus.ID = DrugsUse.ID
WHERE ASTHMS1 IS NOT NULL
AND MARIJAN1 IS NOT NULL
AND MARIJAN1 <> 0
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
/* Parece ter pouca ou nenhuma asssociação entre as duas variaveis
Vamos ver se morar com alguém que use drogas tem algum efeito ou
abuse de prescrições.

Agora vamos ver 
Que surpresa, parecem sim ter alguma associação.
*/

SELECT 
ACEDRUGS,
CASE 
	WHEN ACEDRUGS = 1  THEN 'Yes'
	WHEN ACEDRUGS = 2  THEN 'No'
	ELSE NULL END AS  SEXVAR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY ACEDRUGS),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN DrugsUse
ON AsthmaStatus.ID = DrugsUse.ID
WHERE ASTHMS1 IS NOT NULL
AND ACEDRUGS IS NOT NULL
GROUP BY ACEDRUGS,ASTHMS1
ORDER BY ACEDRUGS,ASTHMS1;