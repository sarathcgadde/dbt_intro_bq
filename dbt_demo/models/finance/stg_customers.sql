{{ config(materialized='table',
        labels = {"env": "prd", "cost_centre": "analytics"}, tags = ["pii"]) }}
{{ config (schema = 'finance_stg') }}
{{ config (tags = ["daily"]) }}
{{ config (persist_docs={"relation": true, "columns": true}) }}

        -- incremental_strategy = "merge",
        -- on_schema_change = "fail", 
select
    id as customer_id,
    first_name,
    last_name

from {{ source('jaffle_shop', 'customers') }}