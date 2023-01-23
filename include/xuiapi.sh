#!/bin/bash
function authenticate_request() {
  providerurl="$1"
  username="$2"
  password="$3"
  player_api_request "${providerurl}" "${username}" "${password}" ""
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
function get_credentials_providerurl() { cat "${credentials_dir}/providerurl"; }
function get_credentials_username() { cat "${credentials_dir}/username"; }
function get_credentials_password() { cat "${credentials_dir}/password"; }
