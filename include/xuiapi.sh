#!/bin/bash
function authenticate_request() {
  providerurl="$1"
  username="$2"
  password="$3"
  player_api_request "${providerurl}" "${username}" "${password}" ""
}
function download_streams_for_stream_type_and_category_id() {
  # untested
  providerurl="$1"
  username="$2"
  password="$3"
  stream_type="$4"
  category_id="$5"
  extraparams="&action="
  action=""
  test "${stream_type}" = "live" && action="get_live_streams"
  test "${stream_type}" = "vod" && action="get_vod_streams"
  test "${stream_type}" = "series" && action="get_series"
  test "${action}" = "" && echo invalid stream type $stream_type && return
  extraparams="${extraparams}${action}&category_id=${category_id}"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_streams_for_stream_type() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_type="$4"
  extraparams="&action="
  action=""
  test "${stream_type}" = "live" && action="get_live_streams"
  test "${stream_type}" = "vod" && action="get_vod_streams"
  test "${stream_type}" = "series" && action="get_series"
  test "${action}" = "" && echo invalid stream type $stream_type && return
  extraparams="${extraparams}${action}"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"

}
function download_series_info_for_stream_id() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  extraparams="&action=get_series_info&series_id=${stream_id}"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_vod_info_for_stream_id() {
  #untested
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  extraparams="&action=get_vod_info&vod_id=${stream_id}"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_categories_for_stream_type() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_type="$4"
  extraparams="&action=get_${stream_type}_categories"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_epg_for_live_stream() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  extraparams="&action=get_short_epg&stream_id=${stream_id}"
  #extraparams="&action=get_short_epg&stream_id=${stream_id}&limit=10"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_all_epg_for_live_stream() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  extraparams="&action=get_simple_data_table&stream_id=${stream_id}"
  player_api_request "${providerurl}" "${username}" "${password}" "${extraparams}"
}
function download_all_epg_for_all_live_streams() {
  providerurl="$1"
  username="$2"
  password="$3"
  xml_tv_request "${providerurl}" "${username}" "${password}"
}
function player_api_request() {
  numparams="$#"
  providerurl="$1"
  username="$2"
  password="$3"
  extraparams=""
  test "${numparams}" -gt "3" && extraparams="$4"
  url="${providerurl}"
  url+="/player_api.php"
  url+="?username=${username}"
  url+="&password=${password}"
  url+="${extraparams}"
  curl "${url}"
}
function panel_api_request() {
  numparams="$#"
  providerurl="$1"
  username="$2"
  password="$3"
  url="${providerurl}"
  url+="/panel_api.php"
  url+="?username=${username}"
  url+="&password=${password}"
  curl "${url}"
}
function xml_tv_request() {
  providerurl="$1"
  username="$2"
  password="$3"
  url="${providerurl}"
  url+="/xmltv.php"
  url+="?username=${username}"
  url+="&password=${password}"
  curl "${url}"
}
function get_vod_stream_link_for_id() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  container_extension="$5"
  echo "${providerurl}/movie/${username}/${password}/${stream_id}.${container_extension}"
}
function get_live_stream_link_for_id() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  echo "${providerurl}/live/${username}/${password}/${stream_id}.ts"
}
function get_timeshift_stream_link_for_id() {
  providerurl="$1"
  username="$2"
  password="$3"
  stream_id="$4"
  # timeshift
  # http://host:port/streaming/timeshift.php?username=User&password=Pass&stream=StreamID&start=year-month-day:hour-minutes&duration=in_minutes
  #http://host:port/streaming/timeshift.php?username=User&password=Pass&stream=1234&start=2020-12-06:08-00&duration=120

  #2023-01-25 07:59:15
  echo "${providerurl}/streaming/timeshift.php?username=${username}&password=${password}&stream=226642&start=2023-01-25:07-59&start=&duration=120"
}
function get_credentials_providerurl() { cat "${credentials_dir}/providerurl"; }
function get_credentials_username() { cat "${credentials_dir}/username"; }
function get_credentials_password() { cat "${credentials_dir}/password"; }

