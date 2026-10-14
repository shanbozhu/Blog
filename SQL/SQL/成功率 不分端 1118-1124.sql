SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251118'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251119'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251120'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251121'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251122'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      ) >= 661
  ) a
GROUP BY
  1,
  2 --- 
union
all
SELECT
  event_day,
  bhv_page,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS uv_numerator,
  COUNT(
    DISTINCT CASE
      WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
    END
  ) AS uv_denominator,
  ROUND(
    COUNT(
      DISTINCT CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        DISTINCT CASE
          WHEN bhv_type IN ('lcb_task_start', 'lcb_start_play') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS uv_success_rate,
  COUNT(
    CASE
      WHEN bhv_type = 'lcb_play_suc' THEN cuid
    END
  ) AS pv_numerator,
  COUNT(
    CASE
      WHEN bhv_type IN ('lcb_start_up') THEN cuid
    END
  ) AS pv_denominator,
  ROUND(
    COUNT(
      CASE
        WHEN bhv_type = 'lcb_play_suc' THEN cuid
      END
    ) / NULLIF(
      COUNT(
        CASE
          WHEN bhv_type IN ('lcb_start_up') THEN cuid
        END
      ),
      0
    ),
    4
  ) AS pv_success_rate
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
      event_day = '20251124'
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
      ) >= 661
  ) a
GROUP BY
  1,
  2