{{ config(materialized='materialized_view',
    on_configuration_change = 'apply',
    enable_refresh = True,
    refresh_interval_minutes = 1440,
    max_staleness = 'INTERVAL "48:0:0" HOUR TO SECOND') }}
{{ config (schema = 'fulfilment_stg') }}
{{ config (tags = ["hourly"]) }}
{{ config (persist_docs={"relation": true, "columns": true}) }}

with 
payments as (
    select * from {{ ref('stg_payments') }}
),
orders as (

    select *, {{ compute_date_diff("orders.order_date", "payments.payment_date") }} as delay_days from {{ ref('stg_orders') }} orders
    left join payments using (order_id)

)
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        avg(delay_days) as average_delay_days,
        sum(amount) as total_order_amount
    from orders
    group by 1