#!/bin/bash
EXPR=$1
ps ax -o pid,command | grep -E "$EXPR" | grep -v grep | grep -v $0 | sed -n -E "s/^ *([0-9]+) .*$/\1/p"
