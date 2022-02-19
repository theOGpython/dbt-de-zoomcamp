{{ config(materialized='view') }}

select * from {{ source('source', 'fhv_tripdata') }}
limit 100