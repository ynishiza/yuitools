#!/usr/bin/env bash
set -eu -o pipefail

# shellcheck disable=SC2034
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC2034
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
# use [[ -n $IS_MAC ]] if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )
LOG="/tmp/log_$(date +%Y%m%d_%H_%M_%S).txt"

# Usage
usage() {
	cat <<END
 $0 [-d|--dir NAME] [-] [ARG]
END
}

USAGE_EXITCODE=200
# shellcheck disable=SC2120
usageAndExit() {
	usage
	if [[ $# = 1 ]]; then exit "$1"; else exit "$USAGE_EXITCODE"; fi
}

cleanup() {
	code="$?"
	if [[ "$code" -eq 0 ]]
	then
		echo "success" | tee -a "$LOG"
	elif [[ "$code" -ne "$USAGE_EXITCODE" ]]
	then
		# case: error other than usage message
		onError
	fi
	exit "$code"
}
onError() {
	echo "error" | tee -a "$LOG" >&2
}
# cleanup: on script exit
# Both success and fail
trap cleanup EXIT RETURN

main() {
	if [[ $# = 0 ]]; then usageAndExit; fi
	echo "Logs in $LOG"
	touch "$LOG"

	# step: parse options
	local dirname=
	while [[ $# -gt 0 ]]
	do
		echo "a $1 b"
		case "$1" in
			# case: option with value
			-d|--dir)
				dirname="$2"
				shift
				;;
			# case: explicit start of positional arguments
			# e.g. script.sh - a b
			- )
				shift
				break
				;;
			# case: error handling
			-*)
				echo "Unknown option $1" | tee -a "$LOG" >&2
				usageAndExit
				;;
			# case: implicit start of positional argument
			*)
				break
				;;
			esac
		shift
	done

	echo "dirname=$dirname"
	echo "positional: $*"

	[[ ! -d "$dirname" ]] && echo "$dirname" && usageAndExit

	# Array
	local -a array
	# shellcheck disable=SC2207
	array=($(ls "$dirname"))
	for v in "${array[@]}"
	do
		echo "file: $v" | tee -a "$LOG"
	done
}

(main "$@")
