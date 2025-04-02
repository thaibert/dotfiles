#!/usr/bin/env bash

function epoch_to_iso8601() {
  local epoch="$1"
  yyyy_mm_dd_hh_mm_ss="$(date --date @"${epoch:0:10}" --utc --iso-8601=seconds | awk --field-separator=+ '{print $1}')"
  millis_micros_nanos="${epoch:10}"

  printf "%s" "${yyyy_mm_dd_hh_mm_ss}"

  if [[ -n "${millis_micros_nanos}" ]]; then
    printf "%s" ".${millis_micros_nanos}"
  fi

  printf "Z\n"
}

function date_to_epoch() {
  local date="$1"

  date --date "${date}" +%s%3N
}

function is_epoch_like() {
  local input="$1"

  echo "${input}" | grep --extended-regexp "^[0-9]+$" > /dev/null
  return $?
}

if [[ -z "$*" ]]; then
  date +%s%3N
  exit 0
fi

if is_epoch_like "$*"; then
  epoch_to_iso8601 "$*"
else
  date_to_epoch "$*"
fi

