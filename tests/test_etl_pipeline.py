import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest
import pandas as pd
from unittest.mock import Mock
from sqlalchemy import create_engine
from etl.extract_source_data import extract_data
from etl.transform_data import transform_patients, transform_encounters, transform_observations

class TestETLPipeline(unittest.TestCase):
    def test_extract_data(self):
        # Create a mock SQLAlchemy engine
        mock_engine = create_engine('sqlite:///:memory:')
        
        # Create a test dataframe and save it to the mock database
        test_df = pd.DataFrame({'FirstName': ['John', 'Jane'], 'LastName': ['Doe', 'Smith']})
        test_df.to_sql('MockTable', mock_engine, index=False)

        def mock_connection_function():
            return mock_engine.connect()

        # Test query
        query = "SELECT FirstName, LastName FROM MockTable"
        
        # Test that the function returns a DataFrame
        result = extract_data(mock_connection_function, query)
        self.assertIsInstance(result, pd.DataFrame)
        self.assertEqual(list(result.columns), ['FirstName', 'LastName'])
        self.assertEqual(len(result), 2)

    def test_transform_patients(self):
        # Create a sample DataFrame
        df = pd.DataFrame({
            'FirstName': ['john', 'jane'],
            'LastName': ['doe', 'smith']
        })
        
        # Test the transformation
        result = transform_patients(df)
        self.assertEqual(result['FirstName'].tolist(), ['John', 'Jane'])
        self.assertEqual(result['LastName'].tolist(), ['Doe', 'Smith'])

    # Add more tests for transform_encounters and transform_observations

if __name__ == '__main__':
    unittest.main()