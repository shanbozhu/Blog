select
  a.event_day,
  a.os_name,
  a.bhv_page,
  a.result,
  COALESCE(NULLIF(a.end_reason, ''), 'NULL_or_Empty') as end_reason,
  COALESCE(NULLIF(a.rapid_download, ''), 'NULL_or_Empty') as rapid_download,
  COALESCE(
    NULLIF(a.add_task_finish_rapid, ''),
    'NULL_or_Empty'
  ) as add_task_finish_rapid,
  case
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 1
    ) then '1'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 2
    ) then '2'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 3
    ) then '3'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 4
    ) then '4'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
    ) then '5'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 6
    ) then '6'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 7
    ) then '7'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 8
    ) then '8'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 9
    ) then '9'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 10
    ) then '10'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 11
    ) then '11'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 12
    ) then '12'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 13
    ) then '13'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 14
    ) then '14'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 15
    ) then '15'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 16
    ) then '16'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 17
    ) then '17'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 18
    ) then '18'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 19
    ) then '19'
    WHEN (
      COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 20
    ) then '20'
    else '21'
  END as duration,
  COUNT(
    case
      WHEN (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      ) then a.cuid
    END
  ) AS quickly_pv,
  COUNT(
    DISTINCT case
      WHEN (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) < 5
      ) then a.cuid
    END
  ) AS quickly_uv,
  COUNT(
    case
      WHEN (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) >= 5
      ) then a.cuid
    END
  ) AS slowly_pv,
  COUNT(
    DISTINCT case
      WHEN (
        COALESCE(NULLIF(p3, ''), 0) + COALESCE(NULLIF(p4, ''), 0) + COALESCE(NULLIF(p5, ''), 0) >= 5
      ) then a.cuid
    END
  ) AS slowly_uv,
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
  5,
  6,
  7,
  8