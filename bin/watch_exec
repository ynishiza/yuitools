#!/bin/bash

SRC=$1
CMD=$2
shift 2
ARGS=$@

# Validate
#
if [[ ! -e $SRC ]]; then echo "No such file=$1"; exit 1; fi
if [[ ! $CMD ]]; then echo "Missing command"; exit 1; fi

# File
#
watchfile() {
	local file=$1
	local chsum=""

	while [[ true ]]
	do
		chsum2=$(md5 "$file")
		if [[ $chsum != $chsum2 ]]
		then
			chsum=$chsum2
			cmd="$CMD $file $ARGS"
			eval $cmd
		fi
		sleep 1
	done
}
watchdir() {
	files=$(find $SRC -type f)
	for f in $files
	do
		watchfile $f
	done
}
ishidden() {
	x=$(echo $1 | grep -e "^\.")
}

if [[ -d $SRC ]]
then 
	watchdir $SRC
else
	watchfile $SRC
fi

# Cleanup
#
onExit() {
	kill $(jobs -p)
}

trap 'onExit' KILL
wait
