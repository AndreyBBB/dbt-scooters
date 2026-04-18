with start_hexes as (
    select
        st_transform(hex.geom, 4326) as geom,
        count(*) as start_trips
    from {{ ref("int_trips_geom") }} as tg
    cross join st_hexagongrid(500, st_transform(tg.start_point, 3857)) as hex
    where st_intersects(st_transform(tg.start_point, 3857), hex.geom)
    group by 1
),

finish_hexes as (
    select
        st_transform(hex.geom, 4326) as geom,
        count(*) as finish_trips
    from {{ ref("int_trips_geom") }} as tg
    cross join st_hexagongrid(500, st_transform(tg.finish_point, 3857)) as hex
    where st_intersects(st_transform(tg.finish_point, 3857), hex.geom)
    group by 1
),

joined as (
    select
        coalesce(s.geom, f.geom) as geom,
        coalesce(s.start_trips, 0) as start_trips,
        coalesce(f.finish_trips, 0) as finish_trips
    from start_hexes as s
    full outer join finish_hexes as f
        on st_astext(s.geom) = st_astext(f.geom)
)

select
    geom,
    start_trips,
    finish_trips,
    start_trips - finish_trips as net_outflow_trips,
    round(
        (start_trips - finish_trips)::numeric
        / nullif(start_trips + finish_trips, 0),
        4
    ) as imbalance_index
from joined
