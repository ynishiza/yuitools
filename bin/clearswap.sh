#!/bin/bash

delete_swap() {
	local dir=$1
	local regex=$2
	local cmd="find $dir -type f -iregex \"$regex\" -not -iregex \"\.svg$\""
	local files=
	files=$(eval "$cmd")
	files=($files)

	if [[ ! $dir ]]; then echo "No directory provided"; exit 1; fi
	if [[ ! -d $dir ]]; then echo "$1 is not a directory"; exit 1; fi

	if [[ ${#files} = 0 ]]; then return; fi
	(IFS=$'\n' && echo "${files[*]}")
	echo "Delete these files? (y/n)"

	read -r ANSWER
	if [[ $ANSWER == "y" ]]; then
		remove_files "${files[@]}"
	else
		echo "Cancelled"
	fi
}

remove_files() {
	for file in "$@"
	do
		rm -f "$file"
	done
}

SWPREGEX="s[uvw][a-z]"
DIRSWP_REGEX=".*/\.${SWPREGEX}$"
FILESWP_REGEX=".*/\.[a-zA-Z0-9_ \.]*\.${SWPREGEX}$"


for dir in "$@"
do
	delete_swap "$dir" "$DIRSWP_REGEX"
	delete_swap "$dir" "$FILESWP_REGEX"
done
