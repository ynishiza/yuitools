#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

clearOrig() {
	local DIR=$1
	local ORIGFILES

	if [[ ! -d "$DIR" ]]; then echo "No directory $DIR"; exit 1; fi
	ORIGFILES=$(find "$DIR" -name "*.orig")

	if [[ -z "$ORIGFILES" ]]; then exit 0; fi

	echo "Remove these files? (y/n)"
	echo "$ORIGFILES"
	read -r ANSWER
	if [[ $ANSWER == "y" ]]
	then
		for file in $ORIGFILES
		do
			rm -f "$file"
		done
	fi
}

for dir in "$@"
do
	clearOrig "$dir"
done
