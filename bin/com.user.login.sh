#!/bin/bash

# Test
STARTUPLOG=$HOME/.bin_yui/startuplog.txt
echo "Started at "$(date) | tee "$STARTUPLOG"

$HOME/.tools_yui/scripts/Exaptive/backup_service.sh
