select
    date_trunc('month', started_at)::date as month,
    coalesce(sex, 'Unknown') as sex,
    coalesce(ag.group, 'Unknown') as age_group,
    count(*) as trips_count,
    count(is_free or null) as free_trips_count,
    round(
        count(is_free or null)::numeric / nullif(count(*), 0),
        4
    ) as free_trip_share,
    round(avg(price_rub)::numeric, 2) as avg_trip_revenue_rub,
    round(avg(duration_s / 60.0)::numeric, 2) as avg_duration_min,
    round(sum(price_rub)::numeric, 2) as revenue_rub
from {{ ref("int_trips_users") }} as tu
left join {{ ref("age_groups") }} as ag
    on tu.age between ag.age_start and ag.age_end
group by 1, 2, 3
