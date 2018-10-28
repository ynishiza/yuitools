#!/bin/bash
# shellcheck disable=1,SC2034
if [[ $(basename "$(pwd)") != '.yui_tools' ]]; then echo "Need to be in tools file"; exit 1; fi

TOOLS_SRC=$(pwd -P)
TOOLS_BASE="$HOME/.yui_tools"
TIMESTAMP=$(date '+%m%d%y_%H%M%S')

# [[ -n $IS_MAC ]] if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )
