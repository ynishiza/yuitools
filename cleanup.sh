#!/bin/bash

############## Setup ##############

# Source
TOOLS_SRC=$(pwd -P)
DOTFILES_SRC="${TOOLS_SRC}/dotfiles"
# Link
DOTFILES_LINK="$HOME/.dotfiles_yui"

# Move to real path, not link.
cd "$TOOLS_SRC"

#
# Validate
#
[[ ! -d "$DOTFILES_SRC" ]] \
	&& echo "Bad directory. Could not find dotfiles." \
	&& exit 1

############## Main ##############

IS_MAC=$([[ -z $(uname | grep Darwin) ]]; echo $?)
if [[ $IS_MAC ]]; then READLINK="readlink"
else READLINK="readlink -f"; fi

cleanupLink() {
	local link=$1
	local linkpath
	local srcpath=$2
	linkpath=$($READLINK "$link")

	# Validate
	if [[ ! "$srcpath" ]]; then echo "Bad source=$srcpath"; return; fi
	if [[ ! "$linkpath" ]]; then echo "No link for source=$srcpath"; return; fi
	if [[ "$srcpath" != "$linkpath" ]]; then return; fi

	echo "Removing link=$link"
	rm -f "$link"
}

# Dirs
cleanupLink "$HOME/.yui_dotfiles" "${DOTFILES_LINK}/screenrc"

# Files
cleanupLink "$HOME/.vimrc" "${DOTFILES_LINK}/vimrc/vimrc_base"
cleanupLink "$HOME/.bashrc" "${DOTFILES_LINK}/bashrc/bashrc_base"
cleanupLink "$HOME/.screenrc" "${DOTFILES_LINK}/screenrc/screenrc_base"
cleanupLink "$HOME/.ctags" "${DOTFILES_LINK}/ctags/ctags_base"
cleanupLink "$HOME/.gitconfig" "${DOTFILES_LINK}/git/gitconfig"
cleanupLink "$HOME/.npmrc" "${DOTFILES_LINK}/npmrc"

