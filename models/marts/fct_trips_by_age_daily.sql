select
    "date",
    age,
    count(*) as trips,
    sum(price_rub) as revenue_rub
from
    {{ ref("int_trips_users") }}
group by
    1,
    2
