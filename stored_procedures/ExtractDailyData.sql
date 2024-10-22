CREATE PROCEDURE ExtractDailyData
    @ExtractDate DATE
AS
BEGIN
    SELECT 
        p.PatientID,
        p.FirstName,
        p.LastName,
        p.DateOfBirth,
        p.Gender,
        e.EncounterID,
        e.EncounterDate,
        e.EncounterType,
        o.ObservationID,
        o.ObservationDate,
        o.ObservationType,
        o.ObservationValue
    FROM 
        Patients p
        INNER JOIN Encounters e ON p.PatientID = e.PatientID
        INNER JOIN Observations o ON e.EncounterID = o.EncounterID
    WHERE 
        e.EncounterDate = @ExtractDate
        OR o.ObservationDate = @ExtractDate;
END;