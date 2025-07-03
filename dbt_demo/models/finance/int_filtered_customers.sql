{{ config(materialized='table') }}
{{ config (schema = 'finance_stg') }}
{{ config (tags = ["hourly"]) }}
{{ config (persist_docs={"relation": true, "columns": true}) }}

select *
from {{ ref('int_customers') }}
where customer_id = 1
