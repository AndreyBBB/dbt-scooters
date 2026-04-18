with classified_users as (
    select
        uc.user_id,
        coalesce(uc.to_work, false) as to_work,
        coalesce(uc.regular, false) as regular,
        coalesce(uc.fan, false) as fan,
        coalesce(uc.rare, false) as rare,
        coalesce(uc.no_class, false) as no_class,
        up.sex,
        extract(year from current_date) - extract(year from up.birth_date) as age
    from {{ ref("int_users_class") }} as uc
    left join {{ source("scooters_raw", "users") }} as up
        on uc.user_id = up.id
),

age_bands as (
    select
        cu.*,
        ag.group as age_group
    from classified_users as cu
    left join {{ ref("age_groups") }} as ag
        on cu.age between ag.age_start and ag.age_end
),

monthly_paid_revenue as (
    select
        user_id,
        avg(revenue_total) as avg_monthly_revenue_rub
    from {{ ref("fct_user_revenue_monthly") }}
    group by 1
),

trip_activity as (
    select
        user_id,
        count(*) as trips_total,
        avg(price_rub) as avg_trip_revenue_rub,
        count(is_free or null)::numeric / count(*) as free_trip_share
    from {{ ref("int_trips_users") }}
    group by 1
)

select
    ab.sex,
    coalesce(ab.age_group, 'Unknown') as age_group,
    count(*) as users_count,
    count(ab.to_work or null) as commuter_users,
    count(ab.regular or null) as regular_users,
    count(ab.fan or null) as fan_users,
    count(ab.rare or null) as rare_users,
    round(
        count(ab.to_work or null)::numeric / nullif(count(*), 0),
        4
    ) as commuter_share,
    round(avg(mr.avg_monthly_revenue_rub)::numeric, 2) as avg_monthly_revenue_rub,
    round(avg(ta.trips_total)::numeric, 2) as avg_trips_total,
    round(avg(ta.avg_trip_revenue_rub)::numeric, 2) as avg_trip_revenue_rub,
    round(avg(ta.free_trip_share)::numeric, 4) as avg_free_trip_share
from age_bands as ab
left join monthly_paid_revenue as mr
    on ab.user_id = mr.user_id
left join trip_activity as ta
    on ab.user_id = ta.user_id
group by 1, 2
