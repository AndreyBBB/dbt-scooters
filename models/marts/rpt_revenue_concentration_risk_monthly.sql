with revenue_ranked as (
    select
        month,
        user_id,
        revenue_total,
        ntile(20) over (
            partition by month
            order by revenue_total desc
        ) as revenue_tile
    from {{ ref("fct_user_revenue_monthly") }}
),

top_5_pct as (
    select
        month,
        sum(revenue_total) as top_5_pct_revenue_rub
    from revenue_ranked
    where revenue_tile = 1
    group by 1
)

select
    rm.month,
    rm.users,
    rm.revenue_total,
    rm.revenue_median,
    rm.revenue_95,
    rm.revenue_max,
    t.top_5_pct_revenue_rub,
    round(
        (rm.revenue_95 / nullif(rm.revenue_median, 0))::numeric,
        4
    ) as revenue_95_to_median_ratio,
    round(
        (t.top_5_pct_revenue_rub / nullif(rm.revenue_total, 0))::numeric,
        4
    ) as top_5_pct_revenue_share,
    round(
        (rm.revenue_total / nullif(rm.users, 0))::numeric,
        2
    ) as revenue_per_paying_user_rub
from {{ ref("fct_revenue_monthly") }} as rm
left join top_5_pct as t
    on rm.month = t.month
