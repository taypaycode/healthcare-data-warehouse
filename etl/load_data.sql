-- Load data into Patients table
BULK INSERT Patients
FROM 'C:\path\to\transformed_patients.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Load data into Encounters table
BULK INSERT Encounters
FROM 'C:\path\to\transformed_encounters.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Load data into Observations table
BULK INSERT Observations
FROM 'C:\path\to\transformed_observations.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);