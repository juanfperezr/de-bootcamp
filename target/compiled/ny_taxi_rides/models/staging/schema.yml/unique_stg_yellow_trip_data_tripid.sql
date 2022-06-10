
    
    

with dbt_test__target as (
  
  select tripid as unique_field
  from `clear-shadow-351220`.`dbt_jperezramirez`.`stg_yellow_trip_data`
  where tripid is not null
  
)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


