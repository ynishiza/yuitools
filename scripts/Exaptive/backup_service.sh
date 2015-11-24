#!/bin/bash

# 1 hour
SLEEP=$((60*60))
COMMAND="bash backup.sh"

# Check if running
PID=$$
NEXTPID=$(($$+1))
# grep -v $PID: exclude this process
# grep -v $NEXTPID: exclude child process (why do we need this?)
PIDS=`ps ax -o pid,command | grep "$0" | grep -v $PID | grep -v $NEXTPID | grep -v grep | tr -s ' ' | cut -f2 -d' ' | tr -d ' '`
PIDLIST=(${PIDS// /})
if [[ ${#PIDLIST[@]} > 0 ]] 
then 
	echo "Service already running at pid: $PIDS" 
	exit 1
fi

while :
do
	eval $COMMAND
	sleep $SLEEP
done
