#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$__dir/setup_setting.sh"

SCRIPTNAME=$(basename "$0")
TOOLS_BACKUP="$HOME/.yui_tools.tar.gz"

if [[ ! -f "$SCRIPTNAME" ]]
then
	echo "You must be in the tools directory."
	exit 1
fi

echo "Backingup $TOOLS_SRC as $TOOLS_BACKUP"

cd "$(dirname "$TOOLS_SRC")"

# step: cleanup old backup
rm -f "$TOOLS_BACKUP"

# step: create backup
# exclude large files like .git and local
tar -c -v -z \
	--exclude ".git" --exclude "local*" \
	-f "$TOOLS_BACKUP" \
	"$(basename "$TOOLS_SRC")"
