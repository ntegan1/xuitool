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
  echo "${providerurl}/live/${username}/${password}/${stream_id}"
}
function get_credentials_providerurl() { cat "${credentials_dir}/providerurl"; }
function get_credentials_username() { cat "${credentials_dir}/username"; }
function get_credentials_password() { cat "${credentials_dir}/password"; }
