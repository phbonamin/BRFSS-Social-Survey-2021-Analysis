--Vamos testar 10 variaveis para ver se deu tudo certo na convers�o.
-- Vou contar 10 variaveis e comparar com os resultados do codebook

--SEXVAR --- 1 = 203,810 E 2 = 234,883 = RIGHT
SELECT SEXVAR, COUNT(*)
FROM dbo.LLCP2021
GROUP BY SEXVAR
ORDER BY SEXVAR;

-- _DUALUSE 1 = 99,960 E 2 = 73,768 E 9 = 264,965 = RIGHT
SELECT DUALUSE, COUNT(*)
FROM LLCP2021
GROUP BY DUALUSE
ORDER BY DUALUSE;

--ASTHMS1 RIGHT
SELECT ASTHMS1, COUNT(*)
FROM LLCP2021
GROUP BY ASTHMS1
ORDER BY ASTHMS1;
--LTASTH1 RIGHT
SELECT LTASTH1, COUNT(*)
FROM LLCP2021
GROUP BY LTASTH1
ORDER BY LTASTH1;

--CASTHM1 RIGHT
SELECT CASTHM1, COUNT(*)
FROM LLCP2021
GROUP BY CASTHM1
ORDER BY CASTHM1;

--SMOKER3 RIGHT
SELECT SMOKER3, COUNT(*)
FROM LLCP2021
GROUP BY SMOKER3
ORDER BY SMOKER3;

--CURECI1 RIGHT
SELECT CURECI1, COUNT(*)
FROM LLCP2021
GROUP BY CURECI1
ORDER BY CURECI1;

--USENOW3 RIGHT
SELECT USENOW3, COUNT(*)
FROM LLCP2021
GROUP BY USENOW3
ORDER BY USENOW3;

--ACEDRUGS RIGHT
SELECT ACEDRUGS, COUNT(*)
FROM LLCP2021
GROUP BY ACEDRUGS
ORDER BY ACEDRUGS;

--URBSTAT RIGHT
SELECT URBSTAT, COUNT(*)
FROM LLCP2021
GROUP BY URBSTAT
ORDER BY URBSTAT;

--10/10