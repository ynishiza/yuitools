#!/bin/bash
TEMP="/tmp/$(date +%s)"
echo $@ > $TEMP
sed -e 's/\(.*\)/"\1"\n/' < $TEMP
