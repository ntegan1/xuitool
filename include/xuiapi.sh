function authenticate_request() {
  providerurl="$1"
  username="$2"
  password="$3"
  player_api_request "${providerurl}" "${username}" "${password}" ""
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
