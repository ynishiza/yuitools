#!/usr/bin/env bash
set -eu -o pipefail

# Prevent expansion of * address
set -f
# set -x

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AWK_PROGRAM="$__dir/monitor_tcp_program.awk"
SLEEP=10
IGNORE_LOCALHOST=

declare -A HOSTS=()

monitor() {
  stats=$(netstat -p tcp -n | awk -v OFS=',' 'NR > 2 { print $4,$5,$6 }')
  echo ""
  printf "Source\tTarget\tState\n"
  for line in $stats
  do
    source=$(echo "$line" | cut -f 1 -d,)
    target=$(echo "$line" | cut -f 2 -d,)
    state=$(echo "$line" | cut -f 3 -d,)
    targetIP=$(echo "$target" | cut -f 1,2,3,4 -d.)
    host=$(dig -x "$targetIP" +short)
    if [[ -z $host ]]; then host=NA; fi
    echo "$source $target ($host)  $state"
  done
  # netstat -p tcp -n |
  #   awk -f "$AWK_PROGRAM"
}

monitor2() {
  stats=$(macGetStats)

  echo ""
  IFS=$'\n'
  for line in $stats
  do
	  source "$__dir/monitor_tcp_known_hosts.sh"
    IFS=' '
    local -a fields
    fields=($(macParseStats "$line"))

    if [[ ${#fields[*]} -ne 4 ]]; then continue; fi

    HOSTS["${fields[1]}"]=${fields[2]}
    printf "%s (%s) <==> %s \t %s\n" "${fields[1]}" "${fields[2]}" "${fields[0]}" "${fields[3]}"
  done
}

macGetStats() {
  netstat -p tcp -n | awk 'NR > 2 { print $4,$5,$6 }' | sort -k2 -r
}

macParseStats() {
  IFS=' '
  local -a fields
  fields=($(echo "$@" | tr -s ' '))
  source="${fields[0]}"
  target="${fields[1]}"
  state="${fields[2]}"

  # Remove the port portion
  targetIP=$(echo "$target" | sed -E 's/\.[0-9 ]+$//')

  # Skip localhost
  if [[ $IGNORE_LOCALHOST && $targetIP == "127.0.0.1" ]]; then return; fi

  host=$(get_host "$target")
  if [[ ! $host ]]
	  then

	  if [[ ! ${HOSTS["$target"]+isset} ]]
	  then
		host=$(dig -x "$targetIP" +short)
		if [[ $targetIP == 127.0.0.1 ]]; then host=localhost; fi
		if [[ -z $host ]]; then host=NA; fi
	  else
		host=${HOSTS["$target"]}
	  fi
  fi

  echo "$source" "$target" "$host" "$state"
}

createKey() {
  echo "$@" | sed -e 's/[\. ]//g'
}

while true
do
  monitor2
  sleep $SLEEP
done
