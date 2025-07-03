select
    customer_id,
    first_name,
    last_name,
    order_id,
    order_date,
    amount,
    sum(amount) over (partition by customer_id order by order_date rows unbounded preceding)

from {{ ref('stg_orders') }} orders
left join {{ ref('stg_customers') }} customers using (customer_id)
left join {{ ref('stg_payments') }} payments using (order_id)
where orders.status = "completed"
