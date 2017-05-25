#!/bin/bash
#
# watch command
#

printUsage() {
	echo "watch [-n SLEEP ] COMMAND"
}

if [[ $# == 0 ]]
then
	printUsage
	exit 1
fi

getopts n: OPTNAME
if [[ $OPTNAME == "n" ]]
then
	SLEEP=$OPTARG
	shift 2
else
	SLEEP=2
fi

COMMAND=$@
echo "$COMMAND"

while :
do
	clear
	echo "$COMMAND [${SLEEP} s]"
	echo ""
	eval "$COMMAND"
	sleep $SLEEP
done
