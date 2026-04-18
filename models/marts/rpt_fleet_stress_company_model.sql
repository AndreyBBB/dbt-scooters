with company_model_trips as (
    select
        s.company,
        s.model,
        s.scooters,
        count(*) as trips_count,
        sum(t.distance_m) / 1000.0 as total_distance_km,
        avg(t.distance_m) / 1000.0 as avg_trip_distance_km,
        avg(t.duration_s) / 60.0 as avg_trip_duration_min,
        max(t.date) - min(t.date) + 1 as active_days
    from {{ ref("int_trips_users") }} as t
    inner join {{ ref("scooters") }} as s
        on t.scooter_hw_id = s.hardware_id
    group by 1, 2, 3
),

policies as (
    select *
    from {{ ref("maintenance_policies") }}
    where service_code in ('TIRE_CHECK', 'BRAKE_CHECK', 'SAFETY_INSPECT')
),

stress_base as (
    select
        cmt.*,
        cmt.trips_count::numeric / nullif(cmt.scooters, 0) as trips_per_scooter,
        cmt.total_distance_km / nullif(cmt.scooters, 0) as distance_km_per_scooter,
        cmt.total_distance_km / nullif(cmt.active_days, 0) as fleet_km_per_day,
        cmt.total_distance_km / nullif(cmt.scooters * cmt.active_days, 0) as km_per_scooter_per_day
    from company_model_trips as cmt
)

select
    sb.company,
    sb.model,
    sb.scooters,
    sb.trips_count,
    round(sb.trips_per_scooter, 2) as trips_per_scooter,
    round(sb.total_distance_km, 2) as total_distance_km,
    round(sb.distance_km_per_scooter, 2) as distance_km_per_scooter,
    round(sb.avg_trip_distance_km, 2) as avg_trip_distance_km,
    round(sb.avg_trip_duration_min, 2) as avg_trip_duration_min,
    sb.active_days,
    p.service_code,
    p.interval_km,
    round(sb.distance_km_per_scooter / nullif(p.interval_km, 0), 2) as maintenance_cycle_utilization
from stress_base as sb
cross join policies as p
