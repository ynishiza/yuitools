#!/bin/bash

############## Setup ##############

# Source
TOOLS_SRC=$(pwd -P)
TOOLS_DIRNAME=$(dirname $TOOLS_SRC)
TOOLS_BASENAME=$(basename $TOOLS_SRC)
DOTFILES_SRC="${TOOLS_SRC}/dotfiles"
IS_MAC=`[[ -z $(uname | grep Darwin) ]]; echo $?`

# Link
TOOLS_LINK="$HOME/.tools_yui"
DOTFILES_LINK="$HOME/.dotfiles_yui"
#
TIMESTAMP=`date '+%m%d%y_%H%M%S'`

# Move to real path, not link.
cd "$TOOLS_SRC"

#
# Validate
#
if [[ ! -d "$DOTFILES_SRC" ]]
then
	echo "Bad directory. Could not find dotfiles."
	exit 1
fi

############## Main ##############

function installBrew() {
	if [[ $IS_MAC && -z $(which brew) ]]
	then
		echo "Installing brew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

function createLink() {
	# Option: prep
	# Reset. Otherwise, they get carried over from previous call.
	OPTIND=""
	OPTNAME=""
	FORCE=""

	# Option: force
	getopts f OPTNAME
	if [[ $OPTNAME == "f" ]]; then FORCE="1"; shift 1; fi

	SRC=$1
	DEST=$2

	if [[ -e "$DEST" || -L "$DEST" ]]
	then
		if [[ $FORCE ]]
		then
			echo "createLink: $DEST already exists. Removing."
			rm -f $DEST
		else
			echo "createLink: $DEST already exists. Skipping."
			return
		fi
		# Do nothing if it already exists.
#		BACKUPDEST="${DEST}_bak_$TIMESTAMP"
#		echo "$DEST exists. Moving to backup."
#		mv -f "$DEST" "$BACKUPDEST"
	fi

	ln -s "$SRC" "$DEST"
}

#
# Tools
#
installBrew


#
# Links
#
createLink -f "$TOOLS_SRC" "${TOOLS_LINK}"
createLink -f "$DOTFILES_SRC" "$DOTFILES_LINK"
createLink -f "${TOOLS_LINK}/bin" "$HOME/.bin_yui"

#
# Scripts
#
# Dotfile dirs
# createLink -f "${DOTFILES_LINK}/screenrc" "$HOME/.screenrc_yui"
# createLink -f "${DOTFILES_LINK}/bashrc" "$HOME/.bashrc_yui"
# createLink -f "${DOTFILES_LINK}/tmux" "$HOME/.tmux_yui"


# Common dotfiles
# - create link only if it doesn't exist yet.
#   Don't want to overwrite. This is for safety.
cp -i "${DOTFILES_LINK}/bashrc/bashrc_base" "$HOME/.bashrc"
cp -i "${DOTFILES_LINK}/vimrc/init.vim" "$HOME/.vimrc"
cp -i "${DOTFILES_LINK}/screenrc/screenrc_base" "$HOME/.screenrc"
cp -i "${DOTFILES_LINK}/ctags/ctags_base" "$HOME/.ctags"
cp -i "${DOTFILES_LINK}/git/git-credentials" "$HOME/.git-credentials"
cp -i "${DOTFILES_LINK}/vimperatorrc" "$HOME/.vimperatorrc"
cp -i "${DOTFILES_LINK}/npmrc" "$HOME/.npmrc"
cp -i "${DOTFILES_LINK}/git/gitconfig" "$HOME/.gitconfig"


#
# Vim
#
bash "${TOOLS_LINK}/setup_vim.sh"

#
# Backup
#
TOOLS_BACKUP="$HOME/.tools_yui.tar"
echo "Creating $TOOLS_BACKUP"

cd "$(dirname "$TOOLS_SRC")"
rm -rf "$TOOLS_BACKUP"
tar cf "$TOOLS_BACKUP" "$(basename "$TOOLS_SRC")"
cd "$TOOLS_SRC"
