#!/usr/local/bin/bash
#
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/serverConnectSettings.sh"

set -o errexit
set -o pipefail

# Uncomment to debug
# set -x

# Not set due to optional parameters
# set -o nounset

echo "Bash version: $BASH_VERSION"

main() {
	if [[ $# == 0 ]]; then _print_usage; exit 1; fi

	local COMMAND=$1
	shift 1

	case "$COMMAND" in
	"list") _print_servers;;
	"edit")
		vim settings.sh;;
	"ssh")
		if [[ $# != 1 ]];then echo "$0 ssh SERVER_NAME"; exit 1; fi
		_connect_to_server "$@";;
	"upload")
		if [[ $# != 3 ]]; then echo "$0 upload SERVER_NAME SRC(local path) DEST(remote directory)"; exit 1; fi
		_scp_server "upload" "$1" "$2" "$3";;
	"tunnel")
		if [[ $# != 2 ]]; then _print_tunnelusasge; exit; fi
		OPTIONS="-N -L $2"
		_connect_to_server "$1" "$OPTIONS";;
	"download")
		if [[ $# != 3 ]]; then echo "$0 download SERVER_NAME SRC(remote path) DEST(dest directory)"; exit 1; fi
		_scp_server "download" "$1" "$3" "$2";;
	*)
		_print_usage
		;;
	esac
}

#
# Print list of available servers
#
_print_servers() {
	echo "NAME, ADDRESS"
	echo "---------------------------------------------------------------"
	for key in "${!SERVER_HOSTS[@]}"
	do
		echo "$key:"$'\t\t'"${SERVER_USERS[$key]}@${SERVER_HOSTS[$key]}"
	done
}

_print_usage() {
	cat <<END
$(basename "$0") list|ssh|upload|download|tunnel
END
}
_print_tunnelusasge() {
	cat <<END
tunnel SPEC

where SPEC is of the form

	LOCALPORT:REMOTEHOST:REMOTEPORT
END
}


#
# SSH to server
#
_connect_to_server() {
	#
	# Variables
	#
	local SERVER_NAME=$1
	local OPTIONS=$2

	local HOST="${SERVER_HOSTS[$SERVER_NAME]}"
	local USER="${SERVER_USERS[$SERVER_NAME]}"
	local OPTIONS="${SSH_OPTIONS[$SERVER_NAME]} $OPTIONS"

	if [[ ! $HOST ]]; then echo "Missing host for '$SERVER_NAME'"; exit 1; fi
	if [[ ! $USER ]]; then echo "Missing user name for '$SERVER_NAME'"; exit 1; fi

	#
	# Options
	#
	local PEM="${SSH_IDENTITY[$SERVER_NAME]}"
	if [[ $PEM ]]
	then
		OPTIONS="-i \"$PEM\" $OPTIONS"
	fi

	#
	# Execute
	#
	local COMMAND="ssh $OPTIONS $USER@$HOST"
	echo "$COMMAND"
	eval "$COMMAND"
	# This does not work if paths have spaces.
	#ssh "$OPTIONS" $USER@$HOST
}

_scp_server() {
	#
	# Variables
	#
	local SCP_TYPE=$1
	local SERVER_NAME=$2
	local LOCAL_PATH=$3
	local REMOTE_PATH=$4

	local HOST="${SERVER_HOSTS[$SERVER_NAME]}"
	local USER="${SERVER_USERS[$SERVER_NAME]}"
	local OPTIONS="${SSH_OPTIONS[$SERVER_NAME]}"

	#
	# Validate
	#
	if [[ ! $HOST ]]; then echo "Missing host for '$SERVER_NAME'"; exit 1; fi
	if [[ ! $USER ]]; then echo "Missing user name for '$SERVER_NAME'"; exit 1; fi

	#
	# Options
	#
	local PEM="${SSH_IDENTITY[$SERVER_NAME]}"
	if [[ $PEM ]]
	then
		OPTIONS="-i \"$PEM\" $OPTIONS"
	fi

	#
	# Execute
	#
	# - To reduce the possibility of overwriting an existing file, use the same file name.
	if [[ $SCP_TYPE == "upload" ]]
	then
		FILENAME=$(basename "$LOCAL_PATH")
		COMMAND="scp $OPTIONS \"$LOCAL_PATH\" $USER@$HOST:\"$REMOTE_PATH/$FILENAME\""
	else
		FILENAME=$(basename "$REMOTE_PATH")
		COMMAND="scp $OPTIONS $USER@$HOST:\"$REMOTE_PATH\" \"$LOCAL_PATH/$FILENAME\""
	fi
	echo "$COMMAND"
	eval "$COMMAND"
}

main "$@"
