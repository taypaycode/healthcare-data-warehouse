# Healthcare Data Warehouse

This repository contains the database schema, ETL pipelines, and stored procedures for a healthcare data warehouse system. The system manages patient information, encounters, and observations, providing a robust foundation for analytics and reporting.

## Project Overview

- SQL Server-based data warehouse
- ETL pipelines for data integration
- Optimized T-SQL queries for data manipulation and reporting
- Data mart implementations following Kimball methodology

## Database Schema

The database consists of three main tables:
- Patients (Dimension)
- Encounters (Fact)
- Observations (Fact)

### Relationships
- Each Patient can have multiple Encounters
- Each Encounter can have multiple Observations

## ETL Pipelines

The `etl` directory contains scripts for:
- Extracting data from source systems
- Transforming data to fit the data warehouse schema
- Loading data into the appropriate tables

## Stored Procedures

The `stored_procedures` directory includes:
- `ExtractDailyData`: Extracts patient, encounter, and observation data for a given date

## Data Marts

The `data_marts` directory contains scripts for creating and populating data marts, including:
- Patient Demographics Mart
- Encounter Analysis Mart
- Observation Trends Mart

## Reporting

The `reporting` directory includes sample queries and views for common reporting needs.

## Tools and Technologies

- SQL Server
- T-SQL
- Python (for ETL scripting)
- Azure Data Factory (for cloud-based ETL)
- Power BI (for reporting and visualization)

## Getting Started

1. Clone this repository
2. Set up a SQL Server instance
3. Run the schema creation scripts in the `schema` directory
4. Execute the ETL pipelines in the `etl` directory
5. Use the stored procedures and reporting queries as needed

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Setup

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/healthcare-data-warehouse.git
   cd healthcare-data-warehouse
   ```

2. Create and activate a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
   ```

3. Install the package and its dependencies:
   ```
   pip install -e .
   ```

4. Run the tests:
   ```
   python -m unittest discover tests
   ```
