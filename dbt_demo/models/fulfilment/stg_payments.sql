{{ config(materialized='table',
        labels = {"env": "prd", "cost_centre": "analytics"}, tags = ["pii"]) }}
{{ config (schema = 'fulfilment_stg') }}
{{ config (tags = ["daily"]) }}
{{ config (persist_docs={"relation": true, "columns": true}) }}

select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount,
    created as payment_date
from {{ source('stripe', 'payment') }}