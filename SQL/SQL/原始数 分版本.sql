select
  a.event_day,
  a.appid,
  a.os_name,
  a.bhv_from,
  a.bhv_page,
  a.bhv_value,
  a.bhv_src,
  a.bhv_type,
  -- a.os_version,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1200 then a.cuid
    end
  ) as 12_down_pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1200
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1300 then a.cuid
    end
  ) as 12pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1300
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1400 then a.cuid
    end
  ) as 13pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1400
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1500 then a.cuid
    end
  ) as 14pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1500
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1600 then a.cuid
    end
  ) as 15pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1600
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1700 then a.cuid
    end
  ) as 16pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1700
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1800 then a.cuid
    end
  ) as 17pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1800
      AND (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) < 1900 then a.cuid
    end
  ) as 18pv,
  count(
    case
      when (
        cast(split(a.os_version, '\\.') [0] as int) * 100 + cast(split(a.os_version, '\\.') [1] as int)
      ) >= 1900 then a.cuid
    end
  ) as 26pv,
  count(distinct a.cuid) as uv
from
  (
    select
      event_day,
      appid,
      os_name,
      app_version,
      bhv_from,
      bhv_page,
      bhv_value,
      bhv_src,
      bhv_type,
      cuid,
      os_version
    from
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    where
      event_day = '20251016'
      AND appid = '10001'
      AND bhv_id = '533'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('event_other')
  ) a
group by
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8