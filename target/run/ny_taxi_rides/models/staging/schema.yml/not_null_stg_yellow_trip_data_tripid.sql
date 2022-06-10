select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from `clear-shadow-351220`.`dbt_jperezramirez`.`stg_yellow_trip_data`
where tripid is null



      
    ) dbt_internal_test