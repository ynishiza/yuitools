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
	read -r -p "Run setup? (y/n)" response && [[ "$response" != "y" ]] && return

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


	echo "Setting up base configs for: bash, vim, tmux, gitconfig
For other settings (e.g. gnupg, npm), copy the templates in ${TOOLS_BASE}/templates/ instead"
	read -n 1 -s -r
	## Common configs
	# Add code to load config.
	_yt_setup_appendtext "$HOME/.bashrc" "bashrc/bashrc_base.sh" "# Load base"$'\n'"source \"${DOTFILES_LINK}/bashrc/bashrc_base.sh\""
	_yt_setup_appendtext "$HOME/.vimrc" "vimrc/init.vim" "source \"${DOTFILES_LINK}/vimrc/init.vim\""
	_yt_setup_appendtext "$HOME/.gitconfig" "git/gitconfig_init.gitconfig" "[include]"$'\n'"   path=${DOTFILES_LINK}/git/gitconfig_init.gitconfig"
	_yt_setup_appendtext "$HOME/.tmux.conf" "tmux/tmux_base.conf" "source-file ${DOTFILES_LINK}/tmux/tmux_base.conf"

}

__yt_setup_main
