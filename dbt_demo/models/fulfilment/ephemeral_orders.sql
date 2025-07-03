{{ config(materialized='ephemeral') }}

select * from {{ source('jaffle_shop', 'orders') }} where status in ('return_pending', 'returned')