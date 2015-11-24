#!/bin/bash
TOOLS_SRC=`pwd -P`
DOTFILES_SRC="${TOOLS_SRC}/dotfiles"
TOOLS_LINK="$HOME/.tools_yui"
DOTFILES_LINK="$HOME/.dotfiles_yui"
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
# Links
#
createLink -f "$TOOLS_SRC" "${TOOLS_LINK}"
createLink -f "$DOTFILES_SRC" "$DOTFILES_LINK"
createLink -f "${TOOLS_LINK}/bin" "$HOME/.bin_yui"

#
# Scripts
# 
# Dotfile dirs
createLink -f "${DOTFILES_LINK}/screenrc" "$HOME/.screenrc_yui"
createLink -f "${DOTFILES_LINK}/bashrc" "$HOME/.bashrc_yui"
createLink -f "${DOTFILES_LINK}/vimrc" "$HOME/.vimrc_yui"

# Common dotfiles
# - create link only if it doesn't exist yet. Don't want to overwrite someone else's
createLink "${DOTFILES_LINK}/bashrc/bashrc_base" "$HOME/.bashrc"
createLink "${DOTFILES_LINK}/ctags/ctags_base" "$HOME/.ctags"
createLink "${DOTFILES_LINK}/vimrc/vimrc_base" "$HOME/.vimrc"
createLink "${DOTFILES_LINK}/screenrc/screenrc_base" "$HOME/.screenrc"
createLink "${DOTFILES_LINK}/npmrc" "$HOME/.npmrc"
createLink "${DOTFILES_LINK}/git/gitconfig" "$HOME/.gitconfig"
createLink "${DOTFILES_LINK}/git/git-credentials" "$HOME/.git-credentials"
# Shortcuts to some dotfiles.
createLink -f "${DOTFILES_LINK}/bashrc/bashrc_base" "$HOME/.bashrc_base"
createLink -f "${DOTFILES_LINK}/vimrc/vimrc_base" "$HOME/.vimrc_base"
createLink -f "${DOTFILES_LINK}/vimrc/vimrc_neobundle" "$HOME/.vimrc_neobundle"
createLink -f "${DOTFILES_LINK}/screenrc/screenrc_base" "$HOME/.screenrc_base"

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
tar cf "$TOOLS_BACKUP" "Tools"
cd "$TOOLS_SRC"
