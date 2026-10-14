SELECT
  a.event_day,
  bhv_page,
  sid,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc'
      and os_name = 'iphone' THEN a.cuid
    END
  ) AS iphone_uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play')
      and os_name = 'iphone' THEN a.cuid
    END
  ) AS iphone_uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc'
        and os_name = 'iphone' THEN a.cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play')
          and os_name = 'iphone' THEN a.cuid
        END
      ),
      0
    ),
    4
  ) AS iphone_uv_success_rate,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc'
      and os_name = 'android' THEN a.cuid
    END
  ) AS android_uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play')
      and os_name = 'android' THEN a.cuid
    END
  ) AS android_uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc'
        and os_name = 'android' THEN a.cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play')
          and os_name = 'android' THEN a.cuid
        END
      ),
      0
    ),
    4
  ) AS android_uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc'
      And os_name = 'iphone' THEN a.cuid
    END
  ) AS iphone_pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up')
      And os_name = 'iphone' THEN a.cuid
    END
  ) AS iphone_pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc'
        And os_name = 'iphone' THEN a.cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up')
          And os_name = 'iphone' THEN a.cuid
        END
      ),
      0
    ),
    4
  ) AS iphone_pv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc'
      And os_name = 'android' THEN a.cuid
    END
  ) AS android_pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up')
      And os_name = 'android' THEN a.cuid
    END
  ) AS android_pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc'
        And os_name = 'android' THEN a.cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up')
          And os_name = 'android' THEN a.cuid
        END
      ),
      0
    ),
    4
  ) AS android_pv_success_rate
FROM
  (
    SELECT
      event_day,
      os_name,
      bhv_page,
      bhv_type,
      cuid,
      app_version
    FROM
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    WHERE
      event_day = '20251123'
      AND appid = '10001'
      AND bhv_id = '7985'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('event_other', 'dura_other')
      AND bhv_page = 'transNa'
      AND bhv_type IN (
        'lcb_play_suc',
        'lcb_task_start',
        'lcb_start_play',
        'lcb_start_up'
      )
      AND size(split(app_version, '\\.')) >= 2
      AND (
        cast(split(app_version, '\\.') [0] as int) * 100 + cast(split(app_version, '\\.') [1] as int)
      ) >= 680
  ) a
  INNER JOIN (
    SELECT
      event_day,
      cuid,
      sid
    FROM
      ubs_baiduapp.baiduapp_dim_cuid_sidlist_1d LATERAL VIEW EXPLODE(sid_list) tmp AS sid
    WHERE
      event_day = '20251123'
      AND sid IN ('194747_1', '194747_2', '194747_3', '194747_4')
  ) b ON a.cuid = b.cuid
  AND a.event_day = b.event_day
GROUP BY
  1,
  2,
  3