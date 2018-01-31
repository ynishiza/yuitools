#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

SCRIPTNAME=$(basename "$0")
TOOLS_BACKUP="$HOME/.tools_yui.tar"
echo "Creating $TOOLS_BACKUP"

if [[ ! -f "$SCRIPTNAME" ]]
then
	echo "You must be in the tools directory."
	exit 1
fi

TOOLS_SRC=$(pwd -P)
cd "$(dirname "$TOOLS_SRC")"
rm -f "$TOOLS_BACKUP"
tar cf "$TOOLS_BACKUP" "$(basename "$TOOLS_SRC")"
