-- Create Observation Trends Mart
CREATE TABLE ObservationTrendsMart (
    ObservationDate DATE,
    ObservationType VARCHAR(50),
    TotalObservations INT,
    AverageNumericValue FLOAT,
    MedianNumericValue FLOAT,
    MostCommonTextValue VARCHAR(100),
    PatientCount INT
);

-- Populate Observation Trends Mart
INSERT INTO ObservationTrendsMart
SELECT 
    CAST(o.ObservationDate AS DATE) AS ObservationDate,
    o.ObservationType,
    COUNT(*) AS TotalObservations,
    AVG(TRY_CAST(o.ObservationValue AS FLOAT)) AS AverageNumericValue,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TRY_CAST(o.ObservationValue AS FLOAT)) OVER (PARTITION BY CAST(o.ObservationDate AS DATE), o.ObservationType) AS MedianNumericValue,
    MAX(o.ObservationValue) AS MostCommonTextValue,
    COUNT(DISTINCT e.PatientID) AS PatientCount
FROM 
    Observations o
    JOIN Encounters e ON o.EncounterID = e.EncounterID
GROUP BY 
    CAST(o.ObservationDate AS DATE), o.ObservationType;

-- Create index for improved query performance
CREATE INDEX IX_ObservationTrendsMart_ObservationDate ON ObservationTrendsMart(ObservationDate);
CREATE INDEX IX_ObservationTrendsMart_ObservationType ON ObservationTrendsMart(ObservationType);

-- Create a view for easy trend analysis
CREATE VIEW vw_ObservationTrends AS
SELECT
    ObservationDate,
    ObservationType,
    TotalObservations,
    AverageNumericValue,
    MedianNumericValue,
    MostCommonTextValue,
    PatientCount,
    TotalObservations - LAG(TotalObservations) OVER (PARTITION BY ObservationType ORDER BY ObservationDate) AS DailyChange,
    (TotalObservations - LAG(TotalObservations) OVER (PARTITION BY ObservationType ORDER BY ObservationDate)) / 
        NULLIF(LAG(TotalObservations) OVER (PARTITION BY ObservationType ORDER BY ObservationDate), 0) * 100 AS DailyChangePercentage
FROM 
    ObservationTrendsMart;