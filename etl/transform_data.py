def transform_patients(df):
    # Example transformation: capitalize names
    df['FirstName'] = df['FirstName'].str.capitalize()
    df['LastName'] = df['LastName'].str.capitalize()
    return df

def transform_encounters(df):
    # Example transformation: standardize encounter types
    df['EncounterType'] = df['EncounterType'].str.upper()
    return df

def transform_observations(df):
    # Example transformation: convert observation values to float where possible
    df['ObservationValue'] = pd.to_numeric(df['ObservationValue'], errors='ignore')
    return df