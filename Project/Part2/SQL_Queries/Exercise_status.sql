/*
Nesta querie vamos analisar a seguinte pergunta:
"Exercicio físico tem algum impacto nas pessoas com a asma?"
Primeiro, vamos ver qual a proporção de pessoas que se exercita, particionado 
por pessoas que tem asma, já tiveram ou nunca tiveram.

Vemos que há uma maior proporção de pessoas que não se exercitam com asma do que as 
que se exercitam. Talvez a asma seja um fator limitante.
*/

-- EXERANY2
SELECT 
EXERANY2,
CASE 
	WHEN EXERANY2 = 1  THEN 'Yes'
	WHEN EXERANY2 = 2  THEN 'No'
	ELSE NULL END AS  SEXVAR_Categories,
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY EXERANY2),2) AS Percentage
FROM AsthmaStatus 
INNER JOIN ExerciseStatus
ON AsthmaStatus.ID = ExerciseStatus.ID
WHERE ASTHMS1 IS NOT NULL
AND EXERANY2 IS NOT NULL
GROUP BY EXERANY2,ASTHMS1
ORDER BY EXERANY2,ASTHMS1;

