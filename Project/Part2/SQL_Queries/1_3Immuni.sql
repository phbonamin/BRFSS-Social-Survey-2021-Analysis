
/*Immunization
1-	Como � o perfil de imuniza��o das pessoas  que tem asma
j� tiveram ou nunca tiveram?

Flushot, da pra ver que as pessoas que tem asma s�o mais imunizadas. 
Por�m, � interessante que as pessoas que eram asmaticas s�o menos que 
as pessoas que nunca tiveram asma.


*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
FLUSHOT7,
CASE 
	WHEN FLUSHOT7 = 1 THEN 'Yes'
	WHEN FLUSHOT7 = 2 Then 'No'
	ELSE NULL END AS FLUSHOT7_Categories,
COUNT(*) AS Count,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY ASTHMS1) AS Percentage
FROM AsthmaStatus 
INNER JOIN Immunization
ON AsthmaStatus.ID = Immunization.ID
WHERE ASTHMS1 IS NOT NULL
AND FLUSHOT7 IS NOT NULL
GROUP BY ASTHMS1,FLUSHOT7
ORDER BY ASTHMS1,FLUSHOT7;

/*
pneumococcal vaccine agora

A mesma coisa, s� que dessa vez a diferen�a � BEM mais significativa.
E tamb�m as pessoas que j� tiveram asma tem uma propor��o maior das pessoas que 
nunca tiveram.

*/
SELECT 
ASTHMS1,
CASE 
	WHEN ASTHMS1  =  1 THEN  'Current'
	WHEN ASTHMS1  =  2 THEN  'Former'
	WHEN ASTHMS1 = 3  THEN 'Never'
	ELSE NULL END AS ASTHMS1_Categories,
PNEUVAC4,
CASE 
	WHEN PNEUVAC4 = 1 THEN 'Yes'
	WHEN PNEUVAC4 = 2 Then 'No'
	ELSE NULL END AS PNEUVAC4_Categories,
COUNT(*) AS Count,
count(*) * 100.0 / sum(count(*)) OVER(PARTITION BY ASTHMS1) AS Percentage
FROM AsthmaStatus 
INNER JOIN Immunization
ON AsthmaStatus.ID = Immunization.ID
WHERE ASTHMS1 IS NOT NULL
AND PNEUVAC4 IS NOT NULL
GROUP BY ASTHMS1,PNEUVAC4
ORDER BY ASTHMS1,PNEUVAC4;