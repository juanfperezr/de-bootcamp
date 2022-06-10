

  create or replace table `clear-shadow-351220`.`dbt_jperezramirez`.`dim_zones`
  
  
  OPTIONS()
  as (
    

SELECT locationid,
        borough,
        zone,
        replace(service_zone,'Boro','Yellow') as service_zone
FROM `clear-shadow-351220`.`dbt_jperezramirez`.`taxi_zone_lookup`
  );
  