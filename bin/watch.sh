#!/bin/bash
#
# watch command
#
COMMAND=$1
SLEEP=$2

printUsage() {
	echo "watch COMMAND [SLEEP]"
}

if [[ $# == 0 ]]
then
	printUsage
	exit 1
fi

if [[ ! "$SLEEP" ]]
then
	SLEEP=2
fi

while :
do
	clear
	echo "$COMMAND [${SLEEP} s]"
	echo ""
	eval "$COMMAND"
	sleep $SLEEP
done
