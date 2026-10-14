SELECT
  a.event_day,
  a.os_name,
  b.sid,
  a.result,
  COUNT(a.cuid) AS pv,
  COUNT(DISTINCT a.cuid) AS uv,
  ROUND(PERCENTILE(a.pmain, 0.8), 4) AS pmain_p80,
  ROUND(PERCENTILE(a.plite, 0.8), 4) AS plite_p80,
  ROUND(PERCENTILE(a.bhv_dura, 0.8), 4) AS total_cost_p80,
  ROUND(PERCENTILE(a.p1, 0.8), 4) AS p1_p80,
  ROUND(PERCENTILE(a.p2, 0.8), 4) AS p2_p80,
  ROUND(PERCENTILE(a.p3, 0.8), 4) AS p3_p80,
  ROUND(PERCENTILE(a.p4, 0.8), 4) AS p4_p80,
  ROUND(PERCENTILE(a.p5, 0.8), 4) AS p5_p80,
  ROUND(
    COALESCE(PERCENTILE(a.p1, 0.8), 0) + COALESCE(PERCENTILE(a.p2, 0.8), 0) + COALESCE(PERCENTILE(a.p3, 0.8), 0) + COALESCE(PERCENTILE(a.p4, 0.8), 0) + COALESCE(PERCENTILE(a.p5, 0.8), 0),
    4
  ) AS sum_cost_p80
FROM
  (
    SELECT
      event_day,
      os_name,
      cuid,
      bhv_dura,
      app_version,
      get_json_object(bhv_ext, '$.result') as result,
      cast(
        get_json_object(bhv_ext, '$.part.P1_StartCheck') as double
      ) as p1,
      case
        when get_json_object(bhv_ext, '$.biz.extra_time_cost') is not null
        and get_json_object(bhv_ext, '$.biz.extra_time_cost') != ''
        and get_json_object(bhv_ext, '$.biz.extra_time_cost') != '{}' then cast(
          get_json_object(bhv_ext, '$.part.P2_NetDiskStatusCheck') as double
        ) - (
          coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.ad_time_cost') as double
            ),
            0
          ) + coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.vip_time_cost') as double
            ),
            0
          ) + coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.login_time_cost') as double
            ),
            0
          )
        )
        else cast(
          get_json_object(bhv_ext, '$.part.P2_NetDiskStatusCheck') as double
        )
      end as p2,
      cast(
        get_json_object(bhv_ext, '$.part.P3_AddToNetDisk') as double
      ) as p3,
      cast(
        get_json_object(bhv_ext, '$.part.P4_GetPlayableUrl') as double
      ) as p4,
      cast(
        get_json_object(bhv_ext, '$.part.P5_PlayAndShowFirstFrame') as double
      ) as p5,
      cast(
        get_json_object(bhv_ext, '$.part.P_MainAppRange') as double
      ) as pmain,
      case
        when get_json_object(bhv_ext, '$.biz.extra_time_cost') is not null
        and get_json_object(bhv_ext, '$.biz.extra_time_cost') != ''
        and get_json_object(bhv_ext, '$.biz.extra_time_cost') != '{}' then cast(
          get_json_object(bhv_ext, '$.part.P_LiteRange') as double
        ) - (
          coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.ad_time_cost') as double
            ),
            0
          ) + coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.vip_time_cost') as double
            ),
            0
          ) + coalesce(
            cast(
              get_json_object(bhv_ext, '$.biz.extra_time_cost.login_time_cost') as double
            ),
            0
          )
        )
        else cast(
          get_json_object(bhv_ext, '$.part.P_LiteRange') as double
        )
      end as plite
    FROM
      ubs_baiduapp.baiduapp_dwd_log_mix_hi
    WHERE
      event_day = '20251021'
      AND appid = '10001'
      AND bhv_id = '8238'
      AND event_action in ('searchbox_mobile_app_operate')
      AND event_module in ('tcbox_12')
      AND event_unit in ('dura_other')
      AND size(split(app_version, '\\.')) >= 2
      AND (
        cast(split(app_version, '\\.') [0] as int) * 100 + cast(split(app_version, '\\.') [1] as int)
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
WHERE
  result = 'play_suc'
GROUP BY
  1,
  2,
  3,
  4