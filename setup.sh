#!/bin/bash
# shellcheck disable=SC1090
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"
############## Setup ##############

# Source
DOTFILES_SRC="${TOOLS_SRC}/dotfiles"

# Link
DOTFILES_LINK="${TOOLS_BASE}/dotfiles"

# Move to real path, not link.
pushd "$TOOLS_SRC"


#
# Validate
#
if [[ ! -d "$DOTFILES_SRC" ]]
then
	echo "Bad directory. Could not find dotfiles."
	exit 1
fi


############## Main ##############

function createLink() {
	# Option: prep
	# Reset. Otherwise, they get carried over from previous call.
	OPTIND=""
	OPTNAME=""
	FORCE=""

	# Option: force
	getopts f OPTNAME || true
	if [[ $OPTNAME == "f" ]]; then FORCE="1"; shift 1; fi

	SRC=$1
	DEST=$2

	if [[ -e "$DEST" || -L "$DEST" ]]
	then
		if [[ $FORCE ]]
		then
			echo "createLink: $DEST already exists. Replacing."
			rm -f "$DEST"
		else
			echo "createLink: $DEST already exists. Skipping."
			return
		fi
	fi

	ln -s "$SRC" "$DEST"
}


#
# Links
#
createLink -f "$TOOLS_SRC" "${TOOLS_BASE}"
createLink -f "${TOOLS_BASE}/bin" "$HOME/.bin_yui"


# Common dotfiles
# - create link only if it doesn't exist yet.
#   Don't want to overwrite. This is for safety.
createLink "${DOTFILES_LINK}/bashrc/bashrc_base" "$HOME/.bashrc"
createLink "${DOTFILES_LINK}/vimrc/init.vim" "$HOME/.vimrc"
createLink "${DOTFILES_LINK}/ctags/ctags_base" "$HOME/.ctags"
createLink "${DOTFILES_LINK}/git/git-credentials" "$HOME/.git-credentials"
createLink "${DOTFILES_LINK}/vimperatorrc" "$HOME/.vimperatorrc"
createLink "${DOTFILES_LINK}/npmrc" "$HOME/.npmrc"
createLink "${DOTFILES_LINK}/git/gitconfig" "$HOME/.gitconfig"


popd

# Other setup
bash "${TOOLS_BASE}/setup_vim.sh"
bash "${TOOLS_BASE}/setup_tools.sh"
bash "${TOOLS_BASE}/create_backup.sh"
