
-- Há varios GOs para evitar o erro "CREATE VIEW must be the only statement in the batch"
--Asthma Status
CREATE VIEW AsthmaStatus AS 
SELECT ID,
ASTHMS1,
LTASTH1,
CASTHM1
FROM dbo.AsthmaAnalysis;

GO
SELECT * FROM AsthmaStatus;

-- Demographics
GO
CREATE VIEW Demographics AS 
SELECT ID,
SEXVAR,
INCOME3,
AGEG5YR,
WTKG3,
HTM4,
BMI5 ,
BMI5CAT,
RFBMI5
FROM dbo.AsthmaAnalysis
GO
SELECT * FROM Demographics;

-- ExerciseStatus
GO
CREATE VIEW ExerciseStatus AS 
SELECT ID,
EXERANY2,
TOTINDA
FROM dbo.AsthmaAnalysis

GO
SELECT * FROM ExerciseStatus;

-- HealthStatus
GO
CREATE VIEW HealthStatus AS 
SELECT ID,
GENHLTH,
PHYSHLTH,
DIFFWALK,
DIFFALON,
RFHLTH,
PHYS14D
FROM dbo.AsthmaAnalysis;

GO
SELECT * FROM HealthStatus;


-- Tobacco Use
GO 
CREATE VIEW TobaccoUse AS
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
FROM dbo.AsthmaAnalysis;

GO
SELECT * FROM TobaccoUse;

--Alcohol Consumption
GO 
CREATE VIEW AlcoholConsu AS
SELECT ID,
ALCDAY5,
AVEDRNK3,
DRNKANY5,
DROCDY3,
RFBING5,
DRNKWK1,
RFDRHV7
FROM  dbo.AsthmaAnalysis;

GO
SELECT * FROM AlcoholConsu;

-- Drugs Use

GO 
CREATE VIEW DrugsUse AS
SELECT ID,
ACEDRUGS,
MARIJAN1,
RSNMRJN2
FROM  dbo.AsthmaAnalysis;

GO
SELECT * FROM DrugsUse;


-- Imunization
GO 
CREATE VIEW Immunization AS
SELECT ID,
FLUSHOT7,
PNEUVAC4,
FLSHOT7,
PNEUMO3

FROM  dbo.AsthmaAnalysis;

GO
SELECT * FROM Immunization;

--Urban Status
GO
CREATE VIEW UrbanStatus AS
SELECT ID, 
METSTAT,
URBSTAT
FROM dbo.AsthmaAnalysis;

GO 
SELECT * FROM UrbanStatus;

