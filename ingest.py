# required libraries
import sys
import pandas as pd
import numpy as np
import random
from random import choice
from sqlalchemy import create_engine
from datetime import datetime

# https://pandas.pydata.org/docs/reference/api/pandas.date_range.html
# https://pandas.pydata.org/docs/user_guide/timeseries.html#timeseries-offset-aliases
# https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_sql.html


# helper functions
def create_sample_df(nsize: int, ids: list, ts_start: str, ts_freq: str = '1S',
                     upper_bound: int = 30, lower_bound: int = 10):
    """
    Function to create a sample data frame with 3 columns: `id`, `time`, and `value`.

    Parameters
    ----------
    nsize: int
        Number of rows the df will have.
    ids : list
        List of ids, which will be chosen randomly when generating the `time` column.
    ts_start : str
        Initial timestamp for the `time` column. To be specified in the format: 'yyyy-MM-dd hh:mm:ss'
    ts_freq : str
        Frecuency for the generated time serie (default is 1 second).
    upper_bound: int
        Upper bound for the `value` column (default is 30).
    lower_bound: int
        Lower bound for the `value` column (default is 10).

    Returns
    ----------
    df : pandas dataframe
    """

    # ids
    lst_ids = [choice(ids) for i in range(0, nsize)]

    # time
    ts_range = pd.date_range(start=ts_start, periods=nsize, freq=ts_freq)

    # value
    # generate nsize random numbers between lower_bound and lower_bound
    lst_values = np.random.randint(low=lower_bound, high=upper_bound, size=nsize)

    # create data frame
    df = pd.DataFrame(data=list(zip(lst_ids, ts_range, lst_values)), columns=['id', 'time', 'value'])

    return df



def send_df_to_postgres(df: pd.DataFrame, chunksize: int, user: str = 'root', password: str = 'root', host: str = 'localhost', 
                        port: int = 5432, db: str = 'sql_times', table_name: str = 'table_name'):
    """
    Function to send a pandas dataframe to Postgres database.

    Parameters
    ----------
    df : pandas dataframe
        Pandas dataframe to send to Postgres.
    chunksize: int
        Specify the number of rows in each batch to be written at a time.
    user : str
        User name for Postgres (default is `root`).
    password : str
        Password for Postgres (default is `root`).
    host: str
        Host for Postgres (default is `localhost`).
    port: int
        Port for Postgres (default is 5432).
    db: str
        Database name for Postgres (default is `sql_times`).
    table_name: str
        Name of the table where the results will be written (default is `table_name`).
    """

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    df.to_sql(name=table_name, index=False, con=engine, if_exists='replace', chunksize=chunksize, method=None)



def main():
    # read nsize from the first parameter passed to script call
    nsize = int(sys.argv[1])

    # create the df
    df = create_sample_df(nsize = nsize, ids = ['ABC', 'XYZ'], ts_start = '1970-01-01 00:00:00', 
                            upper_bound = 30, lower_bound = 10)

    # send the df to Postgres
    send_df_to_postgres(df, table_name='atable', chunksize=50000)



if __name__ == "__main__":
    main() 
