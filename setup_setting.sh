#!/bin/bash
# shellcheck disable=1,SC2034
[[ ! -f 'setup_setting.sh' ]] && echo "Need to be in tools file" && exit 1

TOOLS_SRC=$(pwd -P)
TOOLS_BASE="$HOME/.yui_tools"
TIMESTAMP=$(date '+%m%d%y_%H%M%S')

# use [[ -n $IS_MAC ]] if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )


# _yt_setup_createLink [-f] SRC DST
#
# Create link if it does not exist
# -f = force replace link
_yt_setup_createLink() {
	# Option: prep
	# Reset. Otherwise, they get carried over from previous call.
	local OPTIND=""
	local OPTNAME=""
	local FORCE=""

	# Option: force
	getopts f OPTNAME || true
	if [[ $OPTNAME == "f" ]]; then FORCE="1"; shift 1; fi

	SRC=$1
	DEST=$2

	# step: make sure parent dir exists
	if [[ -f "$SRC" ]]
	then
		mkdir -p "$(dirname "$(realpath "$SRC")")"
	fi

	# step: $DEST exists
	# NOTE: -L since -e does not include links
	if [[ -e "$DEST" || -L "$DEST" ]]
	then
		if [[ $FORCE ]]
		then
			# case: force option

			# case: force only for links
			if [[ ! -L "$DEST" ]]
			then
				echo "_yt_setup_createLink: Force not supported. $DEST is not a link. "
				exit 1
			fi
			echo "_yt_createLink: $DEST already exists. Replacing."
			rm -f "$DEST"
		else
			# case: otherwise skip
			echo "_yt_createLink: $DEST already exists. Skipping."
			return
		fi
	fi

	ln -s "$SRC" "$DEST"
}

