select
    row_number() over (
        order by net_outflow_trips desc, start_trips desc, finish_trips desc
    ) as hex_id,
    st_x(st_centroid(geom)) as lon,
    st_y(st_centroid(geom)) as lat,
    start_trips,
    finish_trips,
    net_outflow_trips,
    imbalance_index
from {{ ref("rpt_geo_demand_supply_imbalance") }}
