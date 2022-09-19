#!/bin/bash
# shellcheck disable=1,SC2034
[[ ! -f 'setup_setting.sh' ]] && echo "Need to be in tools file" && exit 1

TOOLS_SRC=$(pwd -P)
TOOLS_BASE="$HOME/.yui_tools"
TIMESTAMP=$(date '+%m%d%y_%H%M%S')

# use [[ -n $IS_MAC ]] if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )

_yt_setup_appendtext() {
	local pattern=
	local filepath=
	local content=

	filepath="$1"
	if [[ $# == 3 ]]
	then
		pattern="$2"
		content="$3"
	elif [[ $# == 2 ]]
	then
		pattern="$2"
		content="$2"
	else
		echo "Invalid number of arguments"
		exit 1
	fi

	touch "$filepath"
	# note: NOT grep
	# grep does not work very well with blocks of text
	# e.g.
	#		pattern = "
	#			Hello
	#			World
	#		"
	# 	if ! grep "$pattern" "$filepath"			NO. Almost always matches. It only matches the first line? i.e. empty in this case
	#
	# Ref: https://stackoverflow.com/questions/25627442/bash-check-for-block-of-text
	if [[ ! "$(<"$filepath")" = *"$pattern"* ]]
	then
		echo "$content" >> "$filepath"
	fi
}


# _yt_setup_createLink [-f] SRC DST
#
# Create link if it does not exist
# -f = force replace link
_yt_setup_createLink() {
	# Option: prep
	# Reset. Otherwise, they get carried over from previous call.
	local optname=""
	local force=""

	# Option: force
	getopts f optname || true
	if [[ $optname == "f" ]]; then force="1"; shift 1; fi

	# Safety check
	[[ $# != 2 && $# != 3 ]] && echo "Invalid number of arguments" && exit 1

	local linksrc=$1
	local linkdst=$2

	# step: make sure parent dir exists
	if [[ -f "$linksrc" ]]
	then
		mkdir -p "$(dirname "$(realpath "$linksrc")")"
	fi

	# step: $DEST exists
	# NOTE: -L since -e does not include links
	if [[ -e "$linkdst" || -L "$linkdst" ]]
	then
		if [[ $force ]]
		then
			# case: force option

			# case: force only for links
			if [[ ! -L "$linkdst" ]]
			then
				echo "_yt_setup_createLink: Force not supported. $linkdst is not a link. "
				exit 1
			fi
			echo "_yt_createLink: $linkdst already exists. Replacing."
			rm -f "$linkdst"
		else
			# case: otherwise skip
			echo "_yt_createLink: $linkdst already exists. Skipping."
			return
		fi
	fi

	ln -s "$linksrc" "$linkdst"
}

