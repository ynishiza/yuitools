#!/bin/bash

PAT=$1
if [[ -z $PAT ]]; then echo "No pattern"; exit 1; fi


# Search for processes
#
PID=$(ps aux | \
    grep -E "$PAT" | \
    grep -v grep | \
    grep -v "$0" | \
    awk '{print $2}')
PROCESS=$(ps aux | \
    grep -E "$PAT" | \
    grep -v grep | \
    grep -v "$0")

# case: nothing to kill
if [[ ! $PID ]]; then exit 0; fi


# Ask if kill
echo "Kill these processes? (y/n)"
echo "$PROCESS"
read -r A
if [[ "$A" != "y" ]]; then exit 1; fi


# Kill
kill -9 "$PID"
