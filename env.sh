#!/bin/bash

whereami="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
bin_dir="${whereami}/bin"
etc_dir="${whereami}/etc"
include_dir="${whereami}/include"
credentials_dir="${etc_dir}/credentials"

if echo "$PATH" | grep -q "${bin_dir}"; then
  echo bin_dir already on PATH
else
  echo adding bin_dir to PATH
  export PATH="${PATH}":"${bin_dir}"
fi
