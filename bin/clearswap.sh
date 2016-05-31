#!/bin/bash

DIR=$1
if [[ ! $DIR ]]; then echo "No directory provided"; exit 1; fi
if [[ ! -d $DIR ]]; then echo "$1 is not a directory"; exit 1; fi

delete_swap() {
	local regex=$1
	local cmd="find $DIR -type f -iregex \"$regex\""
	local files=$(eval $cmd)

	if [[ ! $files ]]; then return; fi
	echo "$files"
	echo "Delete these files? (y/n)"

	read ANSWER
	if [[ $ANSWER == "y" ]]; then echo "Remove"; rm -f $files; fi
}

SWPREGEX="s[uvw][n-z]"
DIRSWP_REGEX=".*/\.${SWPREGEX}$"
FILESWP_REGEX=".*/\.[a-zA-Z0-9_ \.]*\.${SWPREGEX}$"


delete_swap "$DIRSWP_REGEX"
delete_swap "$FILESWP_REGEX"
