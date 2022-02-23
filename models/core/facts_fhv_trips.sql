{{ config(materialized='table') }}

with table_1 as (
    select *,
        'FHV' as service_type
    from {{ ref('stg_fhv_tripdata')  }}
),

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    table_1.pickup_datetime as pickup_datetime,
    table_1.dropoff_datetime as dropoff_datetime,
    table_1.dispatching_base_num as dispatching_base_num,
    table_1.pickup_locationid as pickup_locationid,
    table_1.dropoff_locationid as dropoff_locationid,
    table_1.sr_flag as sr_flag
from table_1
inner join dim_zones as pickup_zone
on table_1.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on table_1.dropoff_locationid = dropoff_zone.locationid