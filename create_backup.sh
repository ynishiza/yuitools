#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"

SCRIPTNAME=$(basename "$0")
TOOLS_BACKUP="$HOME/.yui_tools.tar"

if [[ ! -f "$SCRIPTNAME" ]]
then
	echo "You must be in the tools directory."
	exit 1
fi

echo "Backingup $TOOLS_SRC as $TOOLS_BACKUP"

cd "$(dirname "$TOOLS_SRC")"
rm -f "$TOOLS_BACKUP"
tar cf "$TOOLS_BACKUP" "$(basename "$TOOLS_SRC")"
