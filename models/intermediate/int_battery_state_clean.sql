select *
from
    {{ ref('stg_battery_state') }}
where
    battery_percent is not null
