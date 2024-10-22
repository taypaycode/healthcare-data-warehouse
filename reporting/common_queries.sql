-- Query 1: Patient encounter count by gender
SELECT 
    p.Gender,
    COUNT(DISTINCT e.EncounterID) AS TotalEncounters
FROM 
    Patients p
    JOIN Encounters e ON p.PatientID = e.PatientID
GROUP BY 
    p.Gender;

-- Query 2: Most common observation types
SELECT TOP 10
    ObservationType,
    COUNT(*) AS ObservationCount
FROM 
    Observations
GROUP BY 
    ObservationType
ORDER BY 
    ObservationCount DESC;

-- Query 3: Patients with multiple encounters in the last 30 days
SELECT 
    p.PatientID,
    p.FirstName,
    p.LastName,
    COUNT(e.EncounterID) AS RecentEncounterCount
FROM 
    Patients p
    JOIN Encounters e ON p.PatientID = e.PatientID
WHERE 
    e.EncounterDate >= DATEADD(DAY, -30, GETDATE())
GROUP BY 
    p.PatientID, p.FirstName, p.LastName
HAVING 
    COUNT(e.EncounterID) > 1
ORDER BY 
    RecentEncounterCount DESC;