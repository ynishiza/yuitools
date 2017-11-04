#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

declare MACTRASH=~/.Trash
declare TRASH=/tmp

if [[ -d "$MACTRASH" ]]; then TRASH="$MACTRASH"; fi

PrintUsage() {
	cat <<EOL
Moves files to the trash

trash.sh src [src ..]
EOL
}

PrintUsageAndExit() {
	PrintUsage
	exit 1
}

PrintError() {
	echo "$@" 1>&2
}

PrintLog() {
	echo "$@" 1>&2
}

PrintErrorAndExit() {
	PrintError "$@"
	exit 1
}

ResolvePathConflictIfAny() {
	local destpath=$1
	local dir=
	local filename=
	local resolved_destpath="$destpath"
	local -i index=1

	dir=$(dirname "$destpath")
	filename=$(basename "$destpath")

	while [[ -f "$resolved_destpath" ]]
	do
		resolved_destpath="${dir}/${filename}_$index"
		index=$((index + 1))
	done

	echo "$resolved_destpath"
}


if [[ $# == 0 ]]; then PrintUsage; fi

for sourcepath in "$@"
do
	if [[ ! -e "$sourcepath" ]]
	then
		PrintErrorAndExit "No such file: $sourcepath"
	fi

	sourcename=$(basename "$sourcepath")
	destpath="${TRASH}/${sourcename}"
	destpath=$(ResolvePathConflictIfAny "$destpath")

	# -n: Do not overwrite existing
	mv -n "$sourcepath" "$destpath"
	PrintLog "Trashed $sourcepath to $destpath"
done
