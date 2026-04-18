select
    user_id,
    date(date_trunc('month', "date")) as "month",
    sum(price_rub) as revenue_total
from
    {{ ref("int_trips_users") }}
where
    not is_free
group by
    1,
    2
