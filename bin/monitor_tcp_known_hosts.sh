#!/bin/bash
declare -A KNOWN_HOSTS=()
KNOWN_HOSTS["^17\."]="Apple"
KNOWN_HOSTS["^162\.125"]="Dropbox"
KNOWN_HOSTS["^216.58."]="Google"		# 216.58.192.0/19
KNOWN_HOSTS["^151.101."]="Google" 		# 151.101.0.0/16
KNOWN_HOSTS["^35.(18[4-9]|19[0-1])."]="Google"  # 35.184.0.0/13

get_host() {
  host=$1
  for pattern in "${!KNOWN_HOSTS[@]}"
  do
    if egrep -e "$pattern" < <(echo "$host") >/dev/null 2>&1
    then
      printf "%s" ${KNOWN_HOSTS["$pattern"]}
    fi
  done
}

