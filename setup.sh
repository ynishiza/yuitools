#!/bin/bash
set -eu -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$__dir/setup_setting.sh"

############## Setup ##############

# Source
DOTFILES_SRC="${TOOLS_SRC}/dotfiles"

# Link
DOTFILES_LINK="${TOOLS_BASE}/dotfiles"

############## Main ##############

__yt_setup_main() {
	(__yt_setup_runSetup)

	# Other setup
	bash "${TOOLS_BASE}/setup_vim.sh"
	bash "${TOOLS_BASE}/setup_tools.sh"
	bash "${TOOLS_BASE}/create_backup.sh"

	echo "Setup done"
}

__yt_setup_runSetup() {
	# step: confirm
	echo "Run setup? (y/n)" && read -r response
	[[ "$response" != "y" ]] && return

	# Move to real path, not link.
	cd "$TOOLS_SRC"


	## Validate
	#
	[[ ! -d "$DOTFILES_SRC" ]] \
		&& echo "Bad directory. Could not find dotfiles." \
		&& exit 1

	## Links
	#
	_yt_setup_createLink "$TOOLS_SRC" "${TOOLS_BASE}"
	_yt_setup_createLink -f "${TOOLS_BASE}/bin" "$HOME/.yui_bin"
	_yt_setup_createLink -f "${TOOLS_BASE}/dotfiles" "$HOME/.yui_dotfiles"


	## Common dotfiles
	# - create link only if it doesn't exist yet.
	#		Don't want to overwrite. This is for safety.
	_yt_setup_createLink "${DOTFILES_LINK}/bashrc/bashrc_base" "$HOME/.bashrc"
	_yt_setup_createLink "${DOTFILES_LINK}/vimrc/init.vim" "$HOME/.vimrc"
	_yt_setup_createLink "${DOTFILES_LINK}/ctags/ctags_base" "$HOME/.ctags"
	_yt_setup_createLink "${DOTFILES_LINK}/npmrc" "$HOME/.npmrc"
	_yt_setup_createLink "${DOTFILES_LINK}/git/gitconfig" "$HOME/.gitconfig"
	_yt_setup_createLink "${DOTFILES_LINK}/tmux/tmux_base.conf" "$HOME/.tmux.conf"
}

__yt_setup_main
