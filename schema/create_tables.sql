-- Create dimension table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1)
);

-- Create fact tables
CREATE TABLE Encounters (
    EncounterID INT PRIMARY KEY,
    PatientID INT,
    EncounterDate DATE,
    EncounterType VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Observations (
    ObservationID INT PRIMARY KEY,
    EncounterID INT,
    ObservationDate DATE,
    ObservationType VARCHAR(50),
    ObservationValue VARCHAR(100),
    FOREIGN KEY (EncounterID) REFERENCES Encounters(EncounterID)
);