select
  a.event_day,
  a.os_name,
  a.bhv_page,
  a.result,
  COALESCE(NULLIF(a.end_reason, ''), 'NULL_or_Empty') as end_reason,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      ) then a.cuid
    END
  ) AS exit_page_quickly_pv,
  COUNT(
    DISTINCT case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      ) then a.cuid
    END
  ) AS exit_page_quickly_uv,
  COUNT(
    case
      WHEN result = 'exit_page' then a.cuid
    END
  ) AS exit_page_pv,
  COUNT(
    DISTINCT case
      WHEN result = 'exit_page' then a.cuid
    END
  ) AS exit_page_uv,
  COUNT(
    case
      WHEN result = 'play_suc' then a.cuid
    END
  ) AS play_suc_pv,
  COUNT(
    DISTINCT case
      WHEN result = 'play_suc' then a.cuid
    END
  ) AS play_suc_uv,
  COUNT(
    case
      WHEN result = 'fail' then a.cuid
    END
  ) AS fail_pv,
  COUNT(
    DISTINCT case
      WHEN result = 'fail' then a.cuid
    END
  ) AS fail_uv,
  COUNT(a.cuid) AS pv,
  COUNT(DISTINCT a.cuid) AS uv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      )
      AND (
        (
          a.os_name = 'android'
          AND COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = 'NULL_or_Empty'
        )
        OR (
          a.os_name = 'iphone'
          AND COALESCE(
            NULLIF(a.add_task_finish_rapid, ''),
            'NULL_or_Empty'
          ) = 'NULL_or_Empty'
        )
      ) then a.cuid
    END
  ) AS exit_page_quickly_not_addtask_pv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      )
      AND (
        COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = '1'
        OR COALESCE(
          NULLIF(a.add_task_finish_rapid, ''),
          'NULL_or_Empty'
        ) = '1'
      ) then a.cuid
    END
  ) AS exit_page_quickly_addtask_rapid_pv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      )
      AND (
        COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = '0'
        OR COALESCE(
          NULLIF(a.add_task_finish_rapid, ''),
          'NULL_or_Empty'
        ) = '0'
      ) then a.cuid
    END
  ) AS exit_page_quickly_addtask_not_rapid_pv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        (
          a.os_name = 'android'
          AND COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = 'NULL_or_Empty'
        )
        OR (
          a.os_name = 'iphone'
          AND COALESCE(
            NULLIF(a.add_task_finish_rapid, ''),
            'NULL_or_Empty'
          ) = 'NULL_or_Empty'
        )
      ) then a.cuid
    END
  ) AS exit_page_not_addtask_pv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = '1'
        OR COALESCE(
          NULLIF(a.add_task_finish_rapid, ''),
          'NULL_or_Empty'
        ) = '1'
      ) then a.cuid
    END
  ) AS exit_page_addtask_rapid_pv,
  COUNT(
    case
      WHEN result = 'exit_page'
      AND (
        COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') = '0'
        OR COALESCE(
          NULLIF(a.add_task_finish_rapid, ''),
          'NULL_or_Empty'
        ) = '0'
      ) then a.cuid
    END
  ) AS exit_page_addtask_not_rapid_pv
from
  (
    SELECT
      event_day,
      appid,
      os_name,
      cuid,
      bhv_dura,
      app_version,
      bhv_page,
      get_json_object(bhv_ext, '$.result') as result,
      get_json_object(bhv_ext, '$.end_reason') as end_reason,
      get_json_object(bhv_ext, '$.biz.p3_detail_info.rapid_download') as rapid_download,
      get_json_object(bhv_ext, '$.biz.add_task_finish_rapid') as add_task_finish_rapid,
      cast(
        get_json_object(bhv_ext, '$.part.P3_AddToNetDisk') as double
      ) as p3,
      cast(
        get_json_object(bhv_ext, '$.part.P4_GetPlayableUrl') as double
      ) as p4,
      cast(
        get_json_object(bhv_ext, '$.part.P5_PlayAndShowFirstFrame') as double
      ) as p5
    FROM
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    WHERE
      event_day = '20251102'
      AND appid = '10001'
      AND bhv_id = '8238'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('dura_other')
      AND bhv_page = 'transNa'
      AND size(split(app_version, '\\.')) >= 2
      AND (
        cast(split(app_version, '\\.') [0] as int) * 100 + cast(split(app_version, '\\.') [1] as int)
      ) >= 678
  ) a
WHERE
  (
    COALESCE(NULLIF(p3, ''), 0) > 0
    OR COALESCE(NULLIF(p4, ''), 0) > 0
  )
GROUP BY
  1,
  2,
  3,
  4,
  5