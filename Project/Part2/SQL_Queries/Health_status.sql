/* Bem semelhante ao que fizemos durante o  Urbna rural, vamos
agora só olhar para o estado de saúde de pessoas que tem asma ou não
*/
-- Estado de saúde geral, pessoas com asma tendem a reportar um pior quadro.
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
RFHLTH,
CASE
	WHEN RFHLTH = 1  THEN 'Good or Better Health'
	WHEN RFHLTH = 2  THEN 'Fair or Poor Health'
	ELSE NULL END AS  RFHLTH_Categories,	
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY ASTHMS1),2) AS Percentage
FROM  HealthStatus 
INNER JOIN AsthmaStatus 
ON  HealthStatus.ID = AsthmaStatus.ID
WHERE RFHLTH IS NOT NULL
AND ASTHMS1  IS NOT NULL
GROUP BY ASTHMS1,RFHLTH
ORDER BY ASTHMS1,RFHLTH
/*Média de dias de não se sentir bem fisicamente 
Pessoas com asma tendem a reportar piores quadros
*/
SELECT  
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
ROUND(AVG(CAST(PHYSHLTH AS FLOAT)),2) AS Mean
FROM  HealthStatus 
INNER JOIN AsthmaStatus 
ON  HealthStatus.ID = AsthmaStatus.ID
WHERE ASTHMS1  IS NOT NULL
AND PHYSHLTH IS NOT NULL
GROUP BY ASTHMS1
ORDER BY ASTHMS1;

/*
Agora vamos olhar na dificuldade de fazer coisas.
Vamos começar como dificuldade de andar  ou de subir escadas
*/
/* Dificuldade de andar ou subir escadas, 
pessoas com asma ou que já tiveram tem mais dificuldade do que pessoas
que nunca tiveram.

Parece ter uma associação.
*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
DIFFWALK,
CASE
	WHEN DIFFWALK= 1  THEN 'Yes'
	WHEN DIFFWALK = 2  THEN 'No'
	ELSE NULL END AS  DIFFWALK_Categories,	
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY DIFFWALK),2) AS Percentage
FROM  HealthStatus 
INNER JOIN AsthmaStatus 
ON  HealthStatus.ID = AsthmaStatus.ID
WHERE DIFFWALK IS NOT NULL
AND ASTHMS1  IS NOT NULL
GROUP BY DIFFWALK,ASTHMS1
ORDER BY DIFFWALK,ASTHMS1
/*Vamos olhar para fazer qualquer coisa como ir ao shopping ou médico.
Vemos a mesma tendência do anterior, pessoas com asma ou que já tiveram
tem mais dificuldade do que as que nunca tiveram.
*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
DIFFALON,
CASE
	WHEN DIFFALON= 1  THEN 'Yes'
	WHEN DIFFALON = 2  THEN 'No'
	ELSE NULL END AS  DIFFWALK_Categories,	
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY ASTHMS1),2) AS Percentage
FROM  HealthStatus 
INNER JOIN AsthmaStatus 
ON  HealthStatus.ID = AsthmaStatus.ID
WHERE DIFFALON IS NOT NULL
AND ASTHMS1  IS NOT NULL
GROUP BY ASTHMS1,DIFFALON
ORDER BY ASTHMS1,DIFFALON