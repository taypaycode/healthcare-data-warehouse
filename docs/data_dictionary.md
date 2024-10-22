# Data Dictionary

## Source Tables

### Patients
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| PatientID   | INT       | Unique identifier for each patient |
| FirstName   | VARCHAR(50) | Patient's first name |
| LastName    | VARCHAR(50) | Patient's last name |
| DateOfBirth | DATE      | Patient's date of birth |
| Gender      | CHAR(1)   | Patient's gender (M/F/O) |

### Encounters
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EncounterID | INT       | Unique identifier for each encounter |
| PatientID   | INT       | Foreign key to Patients table |
| EncounterDate | DATE    | Date of the encounter |
| EncounterType | VARCHAR(50) | Type of encounter (e.g., Inpatient, Outpatient, Emergency) |

### Observations
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| ObservationID | INT     | Unique identifier for each observation |
| EncounterID | INT       | Foreign key to Encounters table |
| ObservationDate | DATE  | Date of the observation |
| ObservationType | VARCHAR(50) | Type of observation (e.g., Blood Pressure, Temperature) |
| ObservationValue | VARCHAR(100) | Value of the observation |

## Data Marts

### EncounterAnalysisMart
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EncounterID | INT       | Unique identifier for each encounter |
| PatientID   | INT       | Patient identifier |
| EncounterDate | DATE    | Date of the encounter |
| EncounterType | VARCHAR(50) | Type of encounter |
| PatientAge  | INT       | Age of the patient at the time of encounter |
| PatientGender | CHAR(1) | Gender of the patient |
| TotalObservations | INT | Total number of observations during the encounter |
| HasFollowUp | BIT       | Indicates if there was a follow-up encounter within 30 days |
| LengthOfStay | INT      | Number of days for inpatient encounters |
| ReadmissionWithin30Days | BIT | Indicates if patient was readmitted within 30 days |

### ObservationTrendsMart
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| ObservationDate | DATE  | Date of the observation |
| ObservationType | VARCHAR(50) | Type of observation |
| TotalObservations | INT | Total number of observations of this type on this date |
| AverageNumericValue | FLOAT | Average value for numeric observations |
| MedianNumericValue | FLOAT | Median value for numeric observations |
| MostCommonTextValue | VARCHAR(100) | Most common value for text observations |
| PatientCount | INT    | Number of unique patients with this observation type on this date |

## Views

### vw_PatientDemographics
Provides a summary of patient information, including age and encounter history.

### vw_EncounterSummary
Summarizes each encounter, including the number and types of observations made.

### vw_PatientObservationHistory
Shows the history of observations for each patient, with a rank to easily retrieve the most recent observations.

### vw_EncounterTrends
Aggregates encounters by month and type, useful for trend analysis.

### vw_PatientRiskScore
Calculates a simple risk score for patients based on their encounter frequency and certain observation values.

### vw_ObservationTrends
Provides daily trends of observations, including daily changes and percentage changes.