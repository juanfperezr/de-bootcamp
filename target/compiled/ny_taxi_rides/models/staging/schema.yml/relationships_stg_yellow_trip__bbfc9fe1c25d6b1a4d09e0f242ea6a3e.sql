
    
    

with child as (
    select Pickup_locationid as from_field
    from `clear-shadow-351220`.`dbt_jperezramirez`.`stg_yellow_trip_data`
    where Pickup_locationid is not null
),

parent as (
    select locationid as to_field
    from `clear-shadow-351220`.`dbt_jperezramirez`.`taxi_zone_lookup`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


