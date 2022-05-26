# -*- coding: utf-8 -*-
"""
Created on Wed May 18 08:18:47 2022

@author: juan.perez
"""

import argparse
import os
from time import time
import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    parquet_name = "yellow_taxi_trips.parquet"
    
    os.system(f"curl {url} -o {parquet_name}")

    print(f"postgresql://{user}:{password}@{host}:{port}/{db}")
    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")

    trips = pq.read_table(f"{parquet_name}")
    trips = trips.to_pandas()
    pd.to_datetime(trips.tpep_pickup_datetime,trips.tpep_dropoff_datetime)
    
    print(pd.io.sql.get_schema(trips, name="yellow_taxi_data", con=engine))

    trips.head(n=0).to_sql(name = table_name,con = engine, if_exists='replace')
    trips.to_sql(name = table_name,con = engine, if_exists='append')


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Ingest CSV data to PostrgreSQL')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='pwd for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres', type=int)
    parser.add_argument('--db', help='database for postgres')
    parser.add_argument('--table_name', help='table name where results will be ingested')
    parser.add_argument('--url', help='url of the csv file')


    args = parser.parse_args()

    main(args)


