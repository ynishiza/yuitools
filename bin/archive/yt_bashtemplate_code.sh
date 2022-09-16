#!/bin/bash
set -eu -o pipefail

# shellcheck disable=SC2034
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC2034
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"

# Usage
usage() {
	cat <<END
 $0 [-d|--debug] [-f|--file NAME] [-] [ARG]
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
		echo "success"
	elif [[ "$code" -ne "$USAGE_EXITCODE" ]]
	then
		# case: error other than usage message
		onError
	fi
	exit "$code"
}
onError() {
	echo "error"
}
# cleanup: on script exit
# Both success and fail
trap cleanup EXIT RETURN

main() {
	if [[ $# = 0 ]]; then usageAndExit; fi

	# step: parse options
	local filename=
	while [[ $# -gt 0 ]]
	do
		echo "a $1 b"
		case "$1" in
			# case: option with value
			-f|--file)
				filename="$2"
				shift
				;;
			-d|--debug)
				set -x
				ddd
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
				echo "Unknown option $1" >&2
				usageAndExit
				;;
			# case: implicit start of positional argument
			*)
				break
				;;
			esac
		shift
	done

	echo "filename=$filename"
	echo "positional: $*"
}

(main "$@")
