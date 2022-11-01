#!/usr/bin/env bash
# shellcheck disable=SC1090
set -eu -o pipefail
#set -x

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$__dir/setup_setting.sh"

LOG="/tmp/setup_vimlog.txt"
declare VIMDIR="$HOME/.vim"
declare VIMRCDIR="$VIMDIR/vimrc.d"
declare DOTFILES_LINK="${TOOLS_BASE}/dotfiles"

declare NVIMDIR="$HOME/.config/nvim"


main() {
	read -r -p "Run vim setup? (y/n)" response && [[ "$response" != "y" ]] && return

	echo "" > "$LOG"
	_yt_setupVimplug
	_yt_setupNeoBundle
	_yt_setupDefaultPlugins
	_yt_setupVimrc

	# neovim
	_yt_setupNvimConfig
	echo "logs in ${LOG}"
}

# New plugin manager
_yt_setupVimplug() {
	# vim-plug: https://github.com/junegunn/vim-plug
	# Installation for vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Installation for neovim
	# shellcheck disable=SC1004
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
			 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

# DEPRECATE: old plugin manager
_yt_setupNeoBundle() {
	# neobundle installation: https://github.com/Shougo/neobundle.vim#1-install-neobundle
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install_neobundle.sh 2>>"$LOG"
	bash install_neobundle.sh  >>"$LOG"|| true
	# Cleanup
	rm -f install_neobundle.sh
}

_yt_setupDefaultPlugins() {
	mkdir -p "$VIMDIR"
	rsync -r "$TOOLS_BASE/resources/vim/" "$VIMDIR"
}

_yt_setupNvimConfig() {
	# Setup neovim
	mkdir -p "$NVIMDIR"
	_yt_setup_createLink "${DOTFILES_LINK}/vimrc/init.vim" "$NVIMDIR/init.vim"
}

_yt_setupVimrc() {
	mkdir -p "$VIMRCDIR/conf.d"

	# Link available vimrcs
	# -f=force
	# -h=do not follow target if target is symbolic link (mac only)
	LINKOPT=""
	if [[ -n $IS_MAC ]]; then LINKOPT="-s -f -h"; else LINKOPT="-s -f"; fi
	eval "ln $LINKOPT \"$TOOLS_BASE/dotfiles/vimrc\" \"$VIMRCDIR/avail.d\""


	# Copy initial set of enabled vimrcs
	(
	cd "$VIMRCDIR/conf.d"
	ln -sf "../avail.d/00_sensible.vim" .
	# shellcheck disable=SC2226
	ln -sf "../avail.d/00_0debug.vim" .
	# shellcheck disable=SC2226
	ln -sf "../avail.d/10_base.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/10_editing.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/10_mappings.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/10_language.vim"
	# shellcheck disable=SC2226
	# ln -sf "../avail.d/20_neobundle.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/21_vimplug.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/30_plugin_settings.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/30_plugin_syntastic.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/30_plugin_tern.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/30_plugin_taglist.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/30_plugin_fzf.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/90_highlights.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/99_custom_vimrc.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/99_asciitable.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/99_functions.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/99_help.vim"
	# shellcheck disable=SC2226
	ln -sf "../avail.d/99_info.vim"
	)
}

main
