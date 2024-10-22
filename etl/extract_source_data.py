import pandas as pd

def extract_data(connection_function, query):
    with connection_function() as conn:
        df = pd.read_sql(query, conn)
    return df

# Example usage (for demonstration purposes only)
if __name__ == "__main__":
    from sqlalchemy import create_engine

    def example_connection_function():
        return create_engine('sqlite:///:memory:')

    example_query = "SELECT 1 as dummy"
    result_df = extract_data(example_connection_function, example_query)
    print(result_df)