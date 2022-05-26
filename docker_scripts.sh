services:
  pgdatabase:
    image: postgres:13
    environment:
      POSTGRES_USER: root
      POSTGRES_PASSWORD: root
      POSTGRES_DB: ny_taxi
    volumes:
      postgres-db-volume:/var/lib/postresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      intervals: 5s
      retries: 5
    restart: always
  
    
docker run \ 
  -e POSTGRES_USER = "root" \
  -e POSTGRES_PASSWORD = "root" \
  -e POSTGRES_DB = "ny_taxi" \
  -v c:/Users/juan.perez/Repository/data-engineering-bootcamp/DockerSQL/ny_taxi_postgresql_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

docker run \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v c:/Users/juan.perez/Repository/data-engineering-bootcamp/DockerSQL/ny_taxi_postgresql_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13


docker run -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" -e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 dpage/pgadmin4

docker run \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4

URL="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.parquet"
python ingest_data.py --user=root --pwd=root --host=localhost --port=5432 --db=ny_taxi --table_name=yellow_taxi_trips --url="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.parquet"


python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}

  
docker build -t taxi_ingest:v001
  

docker run --network=pg-network \
  taxi_ingest:v001 \
  --user=root \
  --password=root \
  --host=pg-database \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}
 

  