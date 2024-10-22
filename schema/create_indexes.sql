-- Create indexes for improved query performance
CREATE INDEX IX_Encounters_PatientID ON Encounters(PatientID);
CREATE INDEX IX_Observations_EncounterID ON Observations(EncounterID);
CREATE INDEX IX_Encounters_EncounterDate ON Encounters(EncounterDate);
CREATE INDEX IX_Observations_ObservationDate ON Observations(ObservationDate);