select
  appid,
  os_name as os,
  app_version as soft_version,
  cuid,
  uid,
  bhv_id,
  bhv_from,
  bhv_page,
  bhv_type,
  bhv_src as bhv_source,
  bhv_value,
  bhv_dura,
  bhv_ext,
  ip_str as ip,
  city,
  net_code as net_type,
  time,
  opts as bhv_ts,
  action_info
from
  ubs_baiduapp.baiduapp_dwd_log_mix_hi
where
  event_day = '20251102'
  and appid = '10001'
  and event_action in (
    'searchbox_mobile_app_operate',
    'baiduapp_mobile_app_all'
  )
  and event_module in ('tcbox_12', 'tcbox_other', 'server')
  and event_unit is not null
  and cuid in (
    'F128F8AC5FE1DED1218977097D22B7F61082C7BDCFSSBPQORNE',
    'F395352BCE7C10DAD652C4823B3E1DBEF86B65164OIGHMMJSPD',
    'F09C160F2B8CADE46895F651625B5469E3E6800D0OLHKKGGJJA',
    '282C8E181E442368A9E039E6120C95C31C767174DOIDANGCCFP'
  )