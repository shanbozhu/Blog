select
  a.event_day,
  a.appid,
  a.os_name,
  b.sid,
  a.bhv_from,
  a.bhv_page,
  a.bhv_value,
  a.bhv_src,
  a.bhv_type,
  count(distinct a.cuid) as uv,
  count(a.cuid) as pv
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
      cuid
    from
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    where
      event_day = '20251021'
      AND appid = '10001'
      AND bhv_id = '1079'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('large_other')
      and get_json_object(bhv_ext, '$.change') = 'clarity'
      AND SIZE(SPLIT(app_version, '\\.')) >= 2
      AND (
        CAST(SPLIT(app_version, '\\.') [0] AS INT) * 100 + CAST(SPLIT(app_version, '\\.') [1] AS INT)
      ) >= 676
  ) a
  INNER JOIN (
    SELECT
      event_day,
      cuid,
      sid
    FROM
      ubs_baiduapp.baiduapp_dim_cuid_sidlist_1d LATERAL VIEW EXPLODE(sid_list) tmp AS sid
    WHERE
      event_day = '20251021'
      AND sid IN ('185387_1', '185387_2', '185382_1', '185382_2')
  ) b ON a.cuid = b.cuid
  AND a.event_day = b.event_day
group by
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9