select
  a.event_day,
  a.os_name,
  a.bhv_page,
  a.bhv_type,
  count(a.cuid) as pv,
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
      cuid
    from
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    where
      event_day = '20251021'
      AND appid = '10001'
      AND bhv_id = '7985'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('event_other', 'dura_other')
      AND bhv_type in (
        'get_video_info',
        'can_lcb',
        'lcb_smooth_check',
        'lcb_start_up',
        'lcb_task_start',
        'lcb_task_suc',
        'lcb_task_fail',
        'lcb_start_play',
        'lcb_play_suc',
        'lcb_play_fail',
        'lcb_exit_page'
      )
      AND size(split(app_version, '\\.')) >= 2
      AND (
        cast(split(app_version, '\\.') [0] as int) * 100 + cast(split(app_version, '\\.') [1] as int)
      ) >= 676
  ) a
group by
  1,
  2,
  3,
  4
ORDER BY
  CASE
    a.bhv_type
    WHEN 'get_video_info' THEN 1
    WHEN 'can_lcb' THEN 2
    WHEN 'lcb_smooth_check' THEN 3
    WHEN 'lcb_start_up' THEN 4
    WHEN 'lcb_task_start' THEN 5
    WHEN 'lcb_task_suc' THEN 6
    WHEN 'lcb_start_play' THEN 7
    WHEN 'lcb_play_suc' THEN 8
    WHEN 'lcb_play_fail' THEN 9
    WHEN 'exit_page' THEN 10
  END