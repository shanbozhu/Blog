select
  a.event_day,
  a.os_name,
  a.bhv_page,
  a.play_resource,
  count(a.cuid) as pv,
  count(distinct a.cuid) as uv,
  sum(a.dura) / 60 as dura_mins,
  sum(a.dura) / 60 / count(distinct a.cuid) as dura_avg
from
  (
    select
      event_day,
      os_name,
      bhv_page,
      play_resource,
      cuid,
      bhv_dura as dura
    from
      ubs_baiduapp.baiduapp_dwd_log_mix_hi lateral view explode(
        array(
          get_json_object(bhv_ext, '$.play_resource'),
          'all'
        )
      ) tmp as play_resource
    where
      event_day = '20251021'
      AND appid = '10001'
      AND bhv_id = '485'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('485')
      and bhv_from = 'search'
      and bhv_page = 'search_h5_outside'
      and bhv_dura > 0
  ) a
group by
  1,
  2,
  3,
  4