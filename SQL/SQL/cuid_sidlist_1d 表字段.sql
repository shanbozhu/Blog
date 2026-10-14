SELECT
  event_day,
  cuid,
  sid_list,
  appid,
  is_feed_dau,
  is_baiduapp_dau
FROM
  ubs_baiduapp.baiduapp_dim_cuid_sidlist_1d
WHERE
  appid = '10001'
  AND event_day = '20250824'
LIMIT
  2