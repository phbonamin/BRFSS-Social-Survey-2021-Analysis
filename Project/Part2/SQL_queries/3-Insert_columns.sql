-- Asthma Status Ok ok
INSERT INTO AsthmaStatus(ID, ASTHMS1, LTASTH1, CASTHM1)
SELECT ID, 
	    ASTHMS1, 
		LTASTH1,
		CASTHM1
FROM LLCP2021;

SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE Table_name ='AsthmaStatus';

SELECT  ori.ID,
ori.ASTHMS1,
ori.LTASTH1,
ori.CASTHM1
FROM LLCP2021 AS ori
INNER JOIN AsthmaStatus AS new
ON  ori.ID = new.ID
WHERE ori.ASTHMS1 <> new.ASTHMS1 
	 OR ori.LTASTH1 <> new.LTASTH1
	 OR ori.CASTHM1 <> new.CASTHM1;




--Demographics OK ok

INSERT INTO Demographics( ID, 
       SEXVAR, 
	   INCOME3,
	   AGEG5YR,
	   WTKG3,
	   HTM4,
	   BMI5,
	   BMI5CAT,
	   RFBMI5)
SELECT ID, 
       SEXVAR, 
	   INCOME3,
	   AGEG5YR,
	   WTKG3,
	   HTM4,
	   BMI5,
	   BMI5CAT,
	   RFBMI5
FROM LLCP2021;

SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE Table_name ='Demographics';


SELECT  ori.ID,
ori.SEXVAR,
ori.INCOME3,
ori.AGEG5YR,
ori.WTKG3,
ori.HTM4,
ori.BMI5,
ori.BMI5CAT,
ori.RFBMI5
FROM LLCP2021 AS ori
INNER JOIN Demographics AS new
ON  ori.ID = new.ID
WHERE ori.SEXVAR <> new.SEXVAR 
	 OR ori.INCOME3 <> new.INCOME3
	 OR ori.AGEG5YR <> new.AGEG5YR
	 OR ori.WTKG3 <> new.WTKG3
	 OR ori.HTM4 <> new.HTM4
	 OR ori.BMI5 <> new.BMI5
	 OR ori.BMI5CAT <> new.BMI5CAT
	 OR ori.RFBMI5 <> new.RFBMI5;




-- Exercise Status OK ok
INSERT INTO ExerciseStatus( ID,
	   EXERANY2,
	   TOTINDA)
SELECT  ID,
	   EXERANY2,
	   TOTINDA
FROM LLCP2021;

SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE Table_name ='ExerciseStatus';

SELECT  ori.ID,
ori.EXERANY2,
ori.TOTINDA
FROM LLCP2021 AS ori
INNER JOIN ExerciseStatus AS new
ON  ori.ID = new.ID
WHERE ori.EXERANY2 <> new.EXERANY2 
	 OR ori.TOTINDA <> new.TOTINDA;

--Health Status OK OK

INSERT INTO HealthStatus(ID,
	   GENHLTH,
	   PHYSHLTH,
	   PHYS14D,
	   DIFFWALK,
	   DIFFALON,
	   RFHLTH)
SELECT ID,
	   GENHLTH,
	   PHYSHLTH,
	   PHYS14D,
	   DIFFWALK,
	   DIFFALON,
	   RFHLTH
FROM LLCP2021;

SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE Table_name ='HealthStatus';

SELECT  ori.ID,
ori.GENHLTH,
ori.PHYSHLTH,
ori.PHYS14D,
ori.DIFFWALK,
ori.DIFFALON,
ori.RFHLTH
FROM LLCP2021 AS ori
INNER JOIN HealthStatus AS new
ON  ori.ID = new.ID
WHERE ori.GENHLTH <> new.GENHLTH 
	 OR ori.PHYSHLTH <> new.PHYSHLTH
	 OR ori.PHYS14D <> new.PHYS14D 
	 OR ori.DIFFWALK <> new.DIFFWALK
	 OR ori.DIFFALON <> new.DIFFALON 
	 OR ori.RFHLTH <> new.RFHLTH;




--Tobbaco Use OK OK
INSERT INTO TobbacoUse(
        ID,
	    SMOKE100,
	    SMOKDAY2,
	   USENOW3,
	   ECIGNOW1,
	   SMOKER3,
	   RFSMOK3,
	   CURECI1,
	   LCSFIRST,
	   LCSLAST,
	   LCSNUMCG,
	   LASTSMK2,
	   STOPSMK2
)
SELECT ID,
	    SMOKE100,
	    SMOKDAY2,
	   USENOW3,
	   ECIGNOW1,
	   SMOKER3,
	   RFSMOK3,
	   CURECI1,
	   LCSFIRST,
	   LCSLAST,
	   LCSNUMCG,
	   LASTSMK2,
	   STOPSMK2

FROM LLCP2021;

SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE Table_name ='TobbacoUse';

SELECT  ori.ID,
ori.SMOKE100,
ori.SMOKDAY2,
ori.USENOW3,
ori.ECIGNOW1,
ori.SMOKER3,
ori.RFSMOK3,
ori.CURECI1,
ori.LCSFIRST,
ori.LCSLAST,
ori.LCSNUMCG,
ori.LASTSMK2,
ori.STOPSMK2
FROM LLCP2021 AS ori
INNER JOIN TobbacoUse AS new
ON  ori.ID = new.ID
WHERE ori.SMOKE100 <> new.SMOKE100 
	 OR ori.SMOKDAY2 <> new.SMOKDAY2
	 OR ori.USENOW3 <> new.USENOW3 
	 OR ori.ECIGNOW1 <> new.ECIGNOW1
	 OR ori.SMOKER3 <> new.SMOKER3 
	 OR ori.RFSMOK3 <> new.RFSMOK3
	 OR ori.CURECI1 <> new.CURECI1 
	 OR ori.LCSFIRST <> new.LCSFIRST
	 OR ori.LCSLAST <> new.LCSLAST 
	 OR ori.LCSNUMCG <> new.LCSNUMCG
	 OR ori.LASTSMK2 <> new.LASTSMK2 
	 OR ori.STOPSMK2 <> new.STOPSMK2;



--Alcohol Consumption OK OK
INSERT INTO  AlcoholConsu(ID,
	   ALCDAY5,
	   AVEDRNK3,
	   DRNKANY5,
	   DROCDY3,
	   RFBING5,
	   DRNKWK1,
	   RFDRHV7)
SELECT ID,
	   ALCDAY5,
	   AVEDRNK3,
	   DRNKANY5,
	   DROCDY3,
	   RFBING5,
	   DRNKWK1,
	   RFDRHV7
FROM LLCP2021;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE Table_name ='AlcoholConsu';

SELECT  ori.ID,
ori.ALCDAY5,
ori.AVEDRNK3,
ori.DRNKANY5,
ori.DROCDY3,
ori.RFBING5,
ori.DRNKWK1,
ori.RFDRHV7
FROM LLCP2021 AS ori
INNER JOIN AlcoholConsu AS new
ON  ori.ID = new.ID
WHERE ori.ALCDAY5 <> new.ALCDAY5 
	 OR ori.AVEDRNK3 <> new.AVEDRNK3
	 OR ori.DRNKANY5 <> new.DRNKANY5 
	 OR ori.DROCDY3 <> new.DROCDY3
	 OR ori.RFBING5 <> new.RFBING5 
	 OR ori.DRNKWK1 <> new.DRNKWK1
	 OR ori.RFDRHV7 <> new.RFDRHV7;



--Drugs and Marijuana Use OK
INSERT INTO DrugsUse(ID,
	   ACEDRUGS,
	   MARIJAN1,
	   RSNMRJN2)
SELECT ID,
	   ACEDRUGS,
	   MARIJAN1,
	   RSNMRJN2
FROM LLCP2021;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE Table_name ='DrugsUse';

SELECT  ori.ID,
ori.ACEDRUGS,
ori.MARIJAN1,
ori.RSNMRJN2
FROM LLCP2021 AS ori
INNER JOIN DrugsUse AS new
ON  ori.ID = new.ID
WHERE ori.ACEDRUGS <> new.ACEDRUGS 
	 OR ori.MARIJAN1 <> new.MARIJAN1
	 OR ori.RSNMRJN2 <> new.RSNMRJN2;	

--Immunization OK OK 
INSERT INTO Immuni(ID,
	   FLUSHOT7,
	   PNEUVAC4,
	   FLSHOT7,
	   PNEUMO3)
SELECT ID,
	   FLUSHOT7,
	   PNEUVAC4,
	   FLSHOT7,
	   PNEUMO3
FROM LLCP2021;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE Table_name ='Immuni';

SELECT  ori.ID,
ori.FLUSHOT7,
ori.PNEUVAC4,
ori.FLSHOT7,
ori.PNEUMO3
FROM LLCP2021 AS ori
INNER JOIN Immuni AS new
ON  ori.ID = new.ID
WHERE ori.FLUSHOT7 <> new.FLUSHOT7 
	 OR ori.PNEUVAC4 <> new.PNEUVAC4
	 OR ori.FLSHOT7 <> new.FLSHOT7
	 OR ori.PNEUMO3 <> new.PNEUMO3;	

--Urban Rural ok ok
INSERT INTO UrbanRural(ID,
	   METSTAT,
	   URBSTAT)
SELECT ID,
	   METSTAT,
	   URBSTAT
FROM LLCP2021;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE Table_name ='UrbanRural';

SELECT  ori.ID,
ori.METSTAT,
ori.URBSTAT
FROM LLCP2021 AS ori
INNER JOIN UrbanRural AS new
ON  ori.ID = new.ID
WHERE ori.METSTAT <> new.METSTAT 
	 OR ori.URBSTAT <> new.URBSTAT;
