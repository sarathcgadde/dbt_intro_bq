
select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    status_group

from {{ source('jaffle_shop', 'orders') }}
left join {{ ref('order_status') }} using (status)

{% if is_incremental() %}

where order_date >= (select coalesce(max(order_date),'1900-01-01') from {{ this }} )

{% endif %}