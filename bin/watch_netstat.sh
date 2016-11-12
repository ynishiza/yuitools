#!/bin/bash
echo $@
watch.sh -n 2 "netstat $@"
