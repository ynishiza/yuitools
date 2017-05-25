#!/bin/bash
EXPR=$1

printUsage() {
    echo "getpid EREGEXP"
    echo "Gets the PID of processes matching the given extended regular expression"
}

if [[ -z $EXPR ]]; then printUsage; exit 1; fi

ps ax -o pid,command | \
    grep -E "$EXPR" | \
    grep -v grep | \
    grep -v $0 | \
    sed -n -E "s/^ *([0-9]+) .*$/\1/p"
