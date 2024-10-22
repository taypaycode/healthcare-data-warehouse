-- Patient Demographics View
CREATE OR ALTER VIEW vw_PatientDemographics AS
SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    p.DateOfBirth,
    p.Gender,
    DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) AS Age,
    COUNT(e.EncounterID) AS TotalEncounters,
    MAX(e.EncounterDate) AS LastEncounterDate
FROM
    Patients p
    LEFT JOIN Encounters e ON p.PatientID = e.PatientID
GROUP BY
    p.PatientID, p.FirstName, p.LastName, p.DateOfBirth, p.Gender;

-- Encounter Summary View
CREATE OR ALTER VIEW vw_EncounterSummary AS
SELECT
    e.EncounterID,
    e.PatientID,
    e.EncounterDate,
    e.EncounterType,
    COUNT(o.ObservationID) AS TotalObservations,
    STRING_AGG(o.ObservationType, ', ') AS ObservationTypes
FROM
    Encounters e
    LEFT JOIN Observations o ON e.EncounterID = o.EncounterID
GROUP BY
    e.EncounterID, e.PatientID, e.EncounterDate, e.EncounterType;

-- Patient Observation History View
CREATE OR ALTER VIEW vw_PatientObservationHistory AS
SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    o.ObservationType,
    o.ObservationValue,
    o.ObservationDate,
    ROW_NUMBER() OVER (PARTITION BY p.PatientID, o.ObservationType ORDER BY o.ObservationDate DESC) AS ObservationRank
FROM
    Patients p
    JOIN Encounters e ON p.PatientID = e.PatientID
    JOIN Observations o ON e.EncounterID = o.EncounterID;

-- Encounter Trends View
CREATE OR ALTER VIEW vw_EncounterTrends AS
SELECT
    DATEADD(MONTH, DATEDIFF(MONTH, 0, e.EncounterDate), 0) AS MonthStart,
    e.EncounterType,
    COUNT(*) AS EncounterCount
FROM
    Encounters e
GROUP BY
    DATEADD(MONTH, DATEDIFF(MONTH, 0, e.EncounterDate), 0),
    e.EncounterType;

-- Patient Risk Score View (example using arbitrary scoring)
CREATE OR ALTER VIEW vw_PatientRiskScore AS
SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    COUNT(DISTINCT e.EncounterID) AS TotalEncounters,
    AVG(CASE 
        WHEN o.ObservationType = 'Blood Pressure' THEN 
            CAST(SUBSTRING(o.ObservationValue, 1, CHARINDEX('/', o.ObservationValue) - 1) AS INT)
        ELSE NULL 
    END) AS AvgSystolicBP,
    MAX(CASE WHEN o.ObservationType = 'BMI' THEN CAST(o.ObservationValue AS FLOAT) ELSE NULL END) AS MaxBMI,
    CASE 
        WHEN COUNT(DISTINCT e.EncounterID) > 10 THEN 3
        WHEN COUNT(DISTINCT e.EncounterID) > 5 THEN 2
        ELSE 1
    END +
    CASE 
        WHEN AVG(CASE WHEN o.ObservationType = 'Blood Pressure' THEN CAST(SUBSTRING(o.ObservationValue, 1, CHARINDEX('/', o.ObservationValue) - 1) AS INT) ELSE NULL END) > 140 THEN 2
        WHEN AVG(CASE WHEN o.ObservationType = 'Blood Pressure' THEN CAST(SUBSTRING(o.ObservationValue, 1, CHARINDEX('/', o.ObservationValue) - 1) AS INT) ELSE NULL END) > 120 THEN 1
        ELSE 0
    END +
    CASE 
        WHEN MAX(CASE WHEN o.ObservationType = 'BMI' THEN CAST(o.ObservationValue AS FLOAT) ELSE NULL END) > 30 THEN 2
        WHEN MAX(CASE WHEN o.ObservationType = 'BMI' THEN CAST(o.ObservationValue AS FLOAT) ELSE NULL END) > 25 THEN 1
        ELSE 0
    END AS RiskScore
FROM
    Patients p
    LEFT JOIN Encounters e ON p.PatientID = e.PatientID
    LEFT JOIN Observations o ON e.EncounterID = o.EncounterID
GROUP BY
    p.PatientID, p.FirstName, p.LastName;