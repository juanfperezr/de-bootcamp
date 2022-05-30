from airflow import DAG
from datetime import datetime
from airflow.operators.python import PythonOperator

def hello_world():
    print("Hello world")

with DAG(dag_id = "hello_world_dag",
        start_date = datetime(2022,5,30),
        schedule_interval = "@hourly",
        catchup = False) as dag:

        task1 = PythonOperator(
            task_id = "hello_world",
            python_callable = hello_world
        )

task1


