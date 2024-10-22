CREATE TABLE PatientDemographicsMart (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Gender CHAR(1),
    TotalEncounters INT,
    LastEncounterDate DATE
);

INSERT INTO PatientDemographicsMart
SELECT 
    p.PatientID,
    p.FirstName,
    p.LastName,
    DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) AS Age,
    p.Gender,
    COUNT(e.EncounterID) AS TotalEncounters,
    MAX(e.EncounterDate) AS LastEncounterDate
FROM 
    Patients p
    LEFT JOIN Encounters e ON p.PatientID = e.PatientID
GROUP BY 
    p.PatientID, p.FirstName, p.LastName, p.DateOfBirth, p.Gender;