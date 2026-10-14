select
  b.event_day,
  b.os_name,
  b.bhv_src,
  b.bhv_type,
  b.uv,
  b.pv,
  round(
    sum(
      case
        when b.bhv_type = 'click' then b.pv
      end
    ) over(partition by b.os_name) / NULLIF(
      sum(
        case
          when b.bhv_type = 'show' then b.pv
        end
      ) over(partition by b.os_name),
      0
    ),
    2
  ) as click_show_ratio
from
  (
    select
      a.event_day,
      a.appid,
      a.os_name,
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
        From
          ubs_baiduapp.baiduapp_dwd_log_mix_hi
        WHERE
          event_day = '20250907'
          AND appid = '10001'
          AND bhv_id = '1079'
          AND event_action in ('searchbox_mobile_app_operate')
          AND event_module in ('tcbox_12')
          AND event_unit in ('large_other')
      ) a
    WHERE
      a.bhv_src = 'smooth_play_save_success'
    group by
      a.event_day,
      a.appid,
      a.os_name,
      a.bhv_from,
      a.bhv_page,
      a.bhv_value,
      a.bhv_src,
      a.bhv_type
  ) b