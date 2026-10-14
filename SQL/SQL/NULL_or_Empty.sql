select
  a.event_day,
  a.os_name,
  a.result,
  COALESCE(NULLIF(a.end_reason, ''), 'NULL_or_Empty') as end_reason,
  COUNT(a.cuid) AS pv,
  COUNT(DISTINCT a.cuid) AS uv
from
  (
    SELECT
      event_day,
      appid,
      os_name,
      cuid,
      bhv_dura,
      app_version,
      get_json_object(bhv_ext, '$.result') as result,
      get_json_object(bhv_ext, '$.end_reason') as end_reason
    FROM
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    WHERE
      event_day = '20250815'
      AND appid = '10001'
      AND bhv_id = '8238'
      AND event_action IN ('searchbox_mobile_app_operate')
      AND event_module IN ('tcbox_12', 'tcbox_other')
      AND event_unit IN ('dura_other')
      AND os_name = 'iphone'
      AND size(split(app_version, '\\.')) >= 2
      AND (
        cast(split(app_version, '\\.') [0] as int) * 100 + cast(split(app_version, '\\.') [1] as int)
      ) >= 662
  ) a
WHERE
  result = 'exit_page'
GROUP BY
  1,
  2,
  3,
  4