#!/bin/bash
# shellcheck disable=1,SC2034
if [[ $(basename "$(pwd)") != '.tools_yui' ]]; then echo "Need to be in tools file"; exit 1; fi

TOOLS_SRC=$(pwd -P)
TOOLS_BASE="$HOME/.tools_yui"
TIMESTAMP=$(date '+%m%d%y_%H%M%S')

# [[ -n $IS_MAC ]] if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )
