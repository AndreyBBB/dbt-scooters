with trips_cte as (
    select
        company,
        count(*) as trips
    from
        {{ ref("stg_trips") }} as t
    inner join {{ ref("scooters") }} as s
        on t.scooter_hw_id = s.hardware_id
    group by
        1
)

select
    company,
    t.trips,
    c.scooters,
    t.trips / cast(c.scooters as float) as trips_per_scooter
from
    trips_cte as t
inner join {{ ref("int_companies") }} as c
    using (company)
