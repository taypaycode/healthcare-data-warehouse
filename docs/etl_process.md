# ETL Process Documentation

## Overview
This document outlines the Extract, Transform, Load (ETL) process for the Healthcare Data Warehouse. The process involves extracting data from source systems, transforming it to fit our data model, and loading it into our data warehouse.

## Extract

### Source Systems
- Electronic Health Record (EHR) system
- Laboratory Information System (LIS)
- Pharmacy Management System

### Extraction Method
Data is extracted using SQL queries against the source databases. The `extract_data` function in `extract_source_data.py` is used to perform the extractions.

### Frequency
- Patient data: Daily incremental load
- Encounter data: Daily full load
- Observation data: Hourly incremental load

## Transform

Transformation logic is implemented in `transform_data.py`. Key transformations include:

1. Data type conversions
2. Handling of NULL values
3. Standardization of codes and terms
4. Calculation of derived fields (e.g., patient age, length of stay)

### Key Transformations
- `transform_patients`: Capitalizes patient names
- `transform_encounters`: Standardizes encounter types
- `transform_observations`: Converts observation values to appropriate data types

## Load

Data is loaded into the warehouse using SQL Server's bulk insert functionality. The process is implemented in `load_data.sql`.

### Loading Order
1. Patients
2. Encounters
3. Observations

### Post-Load Processing
After the main tables are loaded, we populate the data marts:
1. EncounterAnalysisMart
2. ObservationTrendsMart

## Error Handling and Logging

- Failed extractions are logged and retried up to 3 times
- Transformation errors are logged, and the erroneous records are written to an error table for review
- Load errors trigger an alert to the ETL team

## Data Quality Checks

1. Referential integrity checks between Patients, Encounters, and Observations
2. Check for duplicate records
3. Validation of date ranges (e.g., birth dates, encounter dates)
4. Verification of required fields

## Performance Considerations

- Indexes are updated nightly after the ETL process completes
- Large tables are partitioned by date for improved query performance
- Parallel processing is used for transformation of large datasets

## Security and Compliance

- All data transfers use encrypted connections
- Sensitive data is masked in non-production environments
- Access to the data warehouse is restricted and audited

## Maintenance and Monitoring

- ETL job status is monitored using SQL Server Agent
- A dashboard provides real-time visibility into ETL process status
- Monthly review of ETL performance and optimization opportunities

## Disaster Recovery

- Full backups are taken daily
- Transaction log backups are taken every 15 minutes
- A standby server is maintained for failover in case of primary