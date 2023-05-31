

/*Nessa Seção vou tranformar algumas colunas que estão com números errados(Ex: Peso está errado ou quando há uma contagem
é colocado o numero 88 em vez de 0)
e adicionar NULLs para os que deixarem de responder ou se recusaram.
*/


-- Asthma Status DONE

-- ASTHMS1 = 9  DEVE SER =  3558 OK OK DONE
UPDATE AsthmaAnalysis
SET ASTHMS1 = NULL
WHERE ASTHMS1 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE ASTHMS1 IS NULL;

-- LTASTH1 = 9 deve ser = 1746 OK OK DONE

UPDATE AsthmaAnalysis
SET LTASTH1 = NULL
WHERE LTASTH1 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE LTASTH1 IS NULL;

-- CASTHM1 = 9 deve ser = 3,558 OK OK DONE

UPDATE AsthmaAnalysis
SET CASTHM1 = NULL
WHERE CASTHM1 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE CASTHM1 IS NULL;

-- Demographics DONE

-- INCOME3 = 77 OR INCOME3 = 99 OR ALREADY NULL deve ser = 94,413 OK OK DONE

UPDATE AsthmaAnalysis
SET INCOME3 = NULL
WHERE INCOME3 = 77
OR INCOME3 = 99;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE INCOME3 IS NULL;

-- AGEG5YR = 14 deve ser = 9,607 OK OK DONE

UPDATE AsthmaAnalysis
SET AGEG5YR = NULL
WHERE AGEG5YR = 14;


SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE AGEG5YR IS NULL

/*Essa é uma parte mais legal em que além de mudarmos os nulls, 
vamos mudar a coluna inteira pois os decimais não estão sendo representados
*/
/* WTKG3 = 777 OR WTKG3 = 999 OR ALREADY NULL deve ser = 40588 Já feito pelos donos dos dados OK OK DONE

Uma coisa a se notar é que na tabela ele não diz que os valores 777 e 999 foram transformados para  NULL.
Veja abaixo que a contagem com os 777 e 999 dão a mesma coisa.
A gente só sabe que ele fez o tratamento disso pois na coluna de BMI ele diz que está blank caso
WTKG3 = 777 OR 999 ( E a mesma coisa para a altura).
*/

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE WTKG3 IS NULL;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE WTKG3 IS NULL
OR  WTKG3 = 777
OR WTKG3 = 999;

-- Veja como a coluna não está certa. Da pra ver que faltam as duas casas decimais, portanto vamos dividir por 100. OK

SELECT WTKG3
FROM AsthmaAnalysis
ORDER BY WTKG3 DESC;

SELECT AVG(WTKG3)
FROM AsthmaAnalysis;

--Colocamos 100.0 para garantir que a divisão seja feita decimalmente(Existe essa palavra?) OK OK DONE

UPDATE AsthmaAnalysis
SET WTKG3 = WTKG3/100.0;

SELECT WTKG3
FROM AsthmaAnalysis
ORDER BY WTKG3 DESC;

SELECT AVG(WTKG3)
FROM AsthmaAnalysis;

-- Irei fazer a mesma coisa para a altura (HTM4) OK OK DONE

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE HTM4 IS NULL;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE HTM4 IS NULL
OR  HTM4 = 777
OR HTM4 = 999;

-- Dividindo a altura por 100. OK OK DONE

SELECT HTM4
FROM AsthmaAnalysis
ORDER BY HTM4 DESC;

SELECT AVG(HTM4)
FROM AsthmaAnalysis;

UPDATE AsthmaAnalysis
SET HTM4 = HTM4/100.0;

SELECT HTM4
FROM AsthmaAnalysis
ORDER BY HTM4 DESC;

SELECT AVG(HTM4)
FROM AsthmaAnalysis;

-- Irei fazer também a mesma coisa com o IMC(BMI5) OK OK DONE

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE BMI5 IS NULL;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE BMI5 IS NULL
OR BMI5 = 9999
OR BMI5 = 7777;

-- Dividindo o BMI por 100.0 OK OK DONE

SELECT BMI5
FROM AsthmaAnalysis
ORDER BY BMI5 DESC;

SELECT AVG(BMI5)
FROM AsthmaAnalysis;

UPDATE AsthmaAnalysis
SET BMI5 = BMI5/100.0;

SELECT BMI5
FROM AsthmaAnalysis
ORDER BY BMI5 DESC;

SELECT AVG(BMI5)
FROM AsthmaAnalysis;

-- BMICAT CHECK Deve ser = 46852 OK OK DONE

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE BMI5CAT IS NULL;

-- RFBMI5 = 9 deve ser = 46,852 OK OK DONE

UPDATE AsthmaAnalysis
SET RFBMI5 = NULL
WHERE RFBMI5 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RFBMI5 IS NULL;

-- Exercise Status DONE

--- EXERANY2 = 9 OR EXERANY2 = 7 OR ALREADY NULL deve ser = 928 OK OK DONE

UPDATE AsthmaAnalysis
SET EXERANY2 = NULL
WHERE EXERANY2 = 9
OR EXERANY2 = 7 ;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE EXERANY2 IS NULL;

--- TOTINDA = 9 deve ser = 928 OK OK DONE

UPDATE AsthmaAnalysis
SET TOTINDA = NULL
WHERE TOTINDA = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE TOTINDA IS NULL;

-- Health Status

--- GENHLTH = 9 OR GENHLTH = 7  OR ALREADY NULL deve ser = 1161 OK OK DONE

UPDATE AsthmaAnalysis
SET GENHLTH = NULL
WHERE GENHLTH = 9
OR GENHLTH = 7;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE GENHLTH IS NULL;

--- PHYSHLTH


/* Esse é um caso interessante de que por algum motivo eles colocam um 88
em vez de um 0 para quando não há nenhum dia. Vamos mudar para 0 em vez de 88.

Do resto é parecido 77 para Não sabe e 99 para se recusou. Que vão virar nulls

*/

---- PHYSHLTH = 77 OR PHYSHLTH = 99 OR ALREADY NULL deve ser = 9,494 OK OK DONE


UPDATE AsthmaAnalysis
SET PHYSHLTH = NULL
WHERE PHYSHLTH = 99
OR PHYSHLTH = 77;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE PHYSHLTH IS NULL;

---- PHYSHLTH = 88 deve ser = 287796 OK OK DONE

UPDATE AsthmaAnalysis
SET PHYSHLTH = 0
WHERE PHYSHLTH = 88;

---- Aqui não devemos contar os nulls

SELECT COUNT(PHYSHLTH)
FROM AsthmaAnalysis
WHERE PHYSHLTH = 0;

--- DIFFWALK = 7 or DIFFWALK = 9 OR ALREADY NULL deve ser = 19,830 OK OK DONE

UPDATE AsthmaAnalysis
SET DIFFWALK = NULL
WHERE DIFFWALK = 9
OR DIFFWALK = 7;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE DIFFWALK IS NULL;

--- DIFFALON = 7 or DIFFALON = 9 OR ALREADY NULL deve ser = 21,425 OK OK DONE

UPDATE AsthmaAnalysis
SET DIFFALON = NULL
WHERE DIFFALON = 9
OR DIFFALON = 7;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE DIFFALON IS NULL;

--- RFHLTH = 9 deve ser = 1,161 OK OK DONE

UPDATE AsthmaAnalysis
SET RFHLTH = NULL
WHERE RFHLTH = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RFHLTH IS NULL;


--- PHYS14D = 9 deve ser = 9,494  OK OK DONE

UPDATE AsthmaAnalysis
SET PHYS14D = NULL
WHERE PHYS14D = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE PHYS14D IS NULL;

-- Tobbaco Use

--- SMOKE100 = 7 OR SMOKE100 = 9 OR ALREADY NULL deve ser =  24,461 OK OK DONE

UPDATE AsthmaAnalysis
SET SMOKE100 = NULL
WHERE SMOKE100 = 7
OR SMOKE100 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE SMOKE100 IS NULL;

--- SMOKDAY2 = 7 OR SMOKDAY2 = 9 OR ALREADY NULL deve ser =  271,614 OK OK DONE

UPDATE AsthmaAnalysis
SET SMOKDAY2 = NULL
WHERE SMOKDAY2 = 7
OR SMOKDAY2 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE SMOKDAY2 IS NULL;

--- USENOW3 = 7 OR USENOW3 = 9 OR ALREADY NULL deve ser =  22,882 OK OK DONE

UPDATE AsthmaAnalysis
SET USENOW3 = NULL
WHERE USENOW3 = 7
OR USENOW3 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE USENOW3 IS NULL;

---  ECIGNOW1 = 7 OR ECIGNOW1 = 9 OR ALREADY NULL deve ser =  23,938 OK OK DONE

UPDATE AsthmaAnalysis
SET ECIGNOW1 = NULL
WHERE ECIGNOW1 = 7
OR ECIGNOW1 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE ECIGNOW1 IS NULL;

--- SMOKER3 = 9  deve ser = 24,970 OK OK DONE

UPDATE AsthmaAnalysis
SET SMOKER3 = NULL
WHERE SMOKER3 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE SMOKER3 IS NULL;

--- RFSMOK3 = 9  deve ser = 24,970 OK OK DONE

UPDATE AsthmaAnalysis
SET RFSMOK3 = NULL
WHERE RFSMOK3 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RFSMOK3 IS NULL;

--- CURECI1 = 9  deve ser = 23,938 OK OK DONE

UPDATE AsthmaAnalysis
SET CURECI1 = NULL
WHERE CURECI1 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE CURECI1 IS NULL;

--- LCSFIRST = 777 OR LCSFIRST = 999 OR ALREADY NULL deve ser = 426,463 OK OK DONE

UPDATE AsthmaAnalysis
SET LCSFIRST = NULL
WHERE LCSFIRST = 777
OR LCSFIRST = 999;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE LCSFIRST IS NULL;

--- LCSLAST = 777 OR LCSLAST = 999 OR ALREADY NULL deve ser =  427,257  OK OK DONE

UPDATE AsthmaAnalysis
SET LCSLAST = NULL
WHERE LCSLAST = 777
OR LCSLAST = 999;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE LCSLAST IS NULL;

--- LCSNUMCG = 777 OR LCSNUMCG = 999 OR ALREADY NULL deve ser =  427,037 OK OK DONE

UPDATE AsthmaAnalysis
SET LCSNUMCG = NULL
WHERE LCSNUMCG = 777
OR LCSNUMCG = 999;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE LCSNUMCG IS NULL;

--- LASTSMK2 = 77 OR LCSNUMCG = 99 OR ALREADY NULL deve ser = 387,374 OK OK DONE

UPDATE AsthmaAnalysis
SET LASTSMK2 = NULL
WHERE LASTSMK2 = 77
OR LASTSMK2 = 99;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE LASTSMK2 IS NULL;

--- STOPSMK2  = 7 OR LCSNUMCG = 9 OR ALREADY NULL deve ser = 414,746 OK  OK DONE

 UPDATE AsthmaAnalysis
SET STOPSMK2 = NULL
WHERE STOPSMK2 = 7
OR STOPSMK2 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE STOPSMK2 IS NULL;

-- Alcohol Consumption
--- ALCDAY5

/*
Apesar de ser meio esquisito o jeito dessa variavel, os números que começam com 1, os dois
digítios quem vem em seguida são dias por semana, e o que começam com 2 são dias por mês
como outras variáveis capturam algumas essencias dessa variavel, vamos deixar como está,
por enquanto. Se precisarmos da informação contida nela, criaremos outras colunas.
*/

--- ALCDAY5 = 777 OR  ALCDAY5 = 555 OR ALREADY NULL deve ser = 30,589 OK OK DONE
 UPDATE AsthmaAnalysis
SET ALCDAY5 = NULL
WHERE ALCDAY5 = 777
OR ALCDAY5 = 999;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE ALCDAY5 IS NULL;

--- ALCDAY5 = 888 deve ser = 196,872 OK OK DONE

 UPDATE AsthmaAnalysis
SET ALCDAY5 = 0
WHERE ALCDAY5 = 888;


SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE ALCDAY5 = 0;

--- AVEDRNK3 = 77 OR AVEDRNK3 = 99 OR ALREADY NULL deve ser = 231,865 OK OK DONE

 UPDATE AsthmaAnalysis
SET AVEDRNK3 = NULL
WHERE AVEDRNK3 = 77
OR AVEDRNK3 = 99;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE AVEDRNK3 IS NULL;

--- AVEDRNK3 = 88 deve ser = 1,471 OK OK DONE

 UPDATE AsthmaAnalysis
SET AVEDRNK3 = 0
WHERE AVEDRNK3 = 88;


SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE AVEDRNK3 = 0;

---DRNKANY5 = 7 OR DRNKANY5 = 9 OR ALREADY NULL deve ser = 30,589 OK OK DONE

UPDATE AsthmaAnalysis
SET DRNKANY5 = NULL
WHERE DRNKANY5 = 7
OR DRNKANY5 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE DRNKANY5 IS NULL;

--- DROCDY3 = 900 deve ser = 30,589 OK OK DONE

UPDATE AsthmaAnalysis
SET DROCDY3 = NULL
WHERE DROCDY3 = 900;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE DROCDY3 IS NULL;

--- RFBING5 = 9  deve ser = 35,322 OK OK DONE

UPDATE AsthmaAnalysis
SET RFBING5 = NULL
WHERE RFBING5 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RFBING5 IS NULL;

--- DRNKWK1 = 99900 deve ser = 34,993 OK OK DONE


UPDATE AsthmaAnalysis
SET DRNKWK1 = NULL
WHERE DRNKWK1 = 99900;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE DRNKWK1 IS NULL;

--- RFDRHV7 = 9  deve ser = 34,993 OK OK DONE

UPDATE AsthmaAnalysis
SET RFDRHV7 = NULL
WHERE RFDRHV7 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RFDRHV7 IS NULL;


-- Drugs and Marijuana Use
 
--- ACEDRUGS =7 OR ACEDRUGS = 9 OR ALREADY NULL deve ser = 381,274 OK OK DONE

UPDATE AsthmaAnalysis
SET ACEDRUGS = NULL
WHERE ACEDRUGS = 7
OR ACEDRUGS = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE ACEDRUGS IS NULL;

--- MARIJAN1 = 77 OR MARIJAN1 = 99 OR ALREADY NULL deve ser = 302,612 OK OK DONE
 
 UPDATE AsthmaAnalysis
SET MARIJAN1 = NULL
WHERE MARIJAN1 = 77
OR MARIJAN1 = 99;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE MARIJAN1 IS NULL;

--- MARIJAN1 = 88 deve ser = 122,516 OK OK DONE

 UPDATE AsthmaAnalysis
SET MARIJAN1 = 0
WHERE MARIJAN1 = 88;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE MARIJAN1 = 0 ;

--- RSNMRJN2 = 7 OR RSNMRJN2 = 9 OR ALREADY NULL deve ser = 425,290 OK OK DONE

UPDATE AsthmaAnalysis
SET RSNMRJN2 = NULL
WHERE RSNMRJN2 = 7
OR RSNMRJN2 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis
WHERE RSNMRJN2 IS NULL;

-- Immunization

--- FLUSHOT7 = 7 OR FLUSHOT7 = 9 OR ALREADY NULL deve ser = 31,392 OK OK DONE


UPDATE AsthmaAnalysis
SET FLUSHOT7 = NULL
WHERE FLUSHOT7 = 7
OR FLUSHOT7 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE FLUSHOT7 IS NULL;

--- PNEUVAC4 = 7 OR PNEUVAC4 = 9 OR ALREADY NULL deve ser =  62,801 OK OK DONE


UPDATE AsthmaAnalysis
SET PNEUVAC4 = NULL
WHERE PNEUVAC4 = 7
OR PNEUVAC4 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE PNEUVAC4 IS NULL;

--- FLSHOT7 = 9 OR ALREADY NULL deve ser = 294,842 OK OK DONE


UPDATE AsthmaAnalysis
SET FLSHOT7 = NULL
WHERE FLSHOT7 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE FLSHOT7 IS NULL;

--- PNEUMO3 = 9 OR ALREADY NULL deve ser = 299,269 OK OK DONE

UPDATE AsthmaAnalysis
SET PNEUMO3 = NULL
WHERE PNEUMO3 = 9;

SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE PNEUMO3 IS NULL;

--- Urban and Rural Status

---Não precisa mas vou checar só pelo fato de eu ter checado todos


-- METSTAT deve ser = 7,054 OK OK DONE
SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE METSTAT IS NULL;

--URBSTAT deve ser = 7,054 OK OK DONE
SELECT COUNT(*)
FROM AsthmaAnalysis 
WHERE URBSTAT IS NULL;

