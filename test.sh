#!/usr/bin/env bash
set -eu -o pipefail

# shellcheck disable=SC2034
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC2034
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"

# Usage
usage() {
	cat <<END
Test
END
}

DOCKERFILE="$__dir/templates/docker/Dockerfile.ubuntu_dev"
IMAGENAME="yuitoolstest"

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
		echo "Done"
	elif [[ "$code" -ne "$USAGE_EXITCODE" ]]
	then
		# case: error other than usage message
		onError
	fi
	exit "$code"
}
onError() {
	echo "Error"
}
# cleanup: on script exit
# Both success and fail
trap cleanup EXIT RETURN

main() {
	# step: parse options
	while [[ $# -gt 0 ]]
	do
		echo "a $1 b"
		case "$1" in
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

	runTest
}

runTest() {
	cd "$__dir"
	docker build -f "$DOCKERFILE" -t "$IMAGENAME" .

	# note: using '( expr ) || true'
	# To
	docker run -ti  \
		-v "$__dir":"/home/guest/.yui_tools" \
		"$IMAGENAME" \
		bash -c "( bash /home/guest/.yui_tools/test_content.sh; ) || true \
			&& bash"
}

(main "$@")
