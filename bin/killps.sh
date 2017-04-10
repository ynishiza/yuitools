#!/bin/bash

PAT=$1
if [[ -z $PAT ]]; then echo "No pattern"; exit 1; fi

PID=$(ps aux | egrep "$PAT" | grep -v grep | grep -v $0 | tr -s ' ' | cut -f2 -d' ')
PROCESS=$(ps aux | egrep "$PAT" | grep -v grep | grep -v $0)

if [[ ! $PID ]]; then exit 0; fi

echo "Kill these processes? (y/n)"
echo "$PROCESS"
read A
if [[ "$A" != "y" ]]; then exit 1; fi
kill -9 $PID
