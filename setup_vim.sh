#!/bin/bash
# shellcheck disable=SC1090
set -o pipefail
set -o errexit
set -o nounset
#set -x

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"

declare VIMDIR
declare VIMRCDIR

LOG="/tmp/setup_vimlog.txt"
declare VIMDIR="$HOME/.vim"
VIMRCDIR="$VIMDIR/vimrc.d"

declare NVIMDIR="$HOME/.config/nvim"


main() {
	echo "" > "$LOG"
	# setupNeoBundle
	# setupDein # Disabled
	setupDefaultPlugins
	# setupVimrc
	echo "logs in ${LOG}"
}

setupNeoBundle() {
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install_neobundle.sh 2>>"$LOG"
	bash install_neobundle.sh  >>"$LOG"|| true
	# Cleanup
	rm -f install_neobundle.sh
}

setupDein() {
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	# For example, we just use `~/.cache/dein` as installation directory
	sh ./installer.sh ~/.cache/dein
}

setupDefaultPlugins() {
	mkdir -p "$VIMDIR"
	rsync -r "$TOOLS_BASE/vim/" "$VIMDIR"

	# Setup neovim
	mkdir -p "$NVIMDIR"
	rsync -r "$TOOLS_BASE/nvim/" "$NVIMDIR"
}

setupVimrc() {
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
	ln -sf "../avail.d/10_base.vim"
	ln -sf "../avail.d/10_editing.vim"
	ln -sf "../avail.d/10_mappings.vim"
	ln -sf "../avail.d/10_language.vim"
	ln -sf "../avail.d/20_neobundle.vim"
	# ln -sf "../avail.d/20_dein.vim"  Not working yet
	ln -sf "../avail.d/30_plugin_settings.vim"
	ln -sf "../avail.d/30_plugin_syntastic.vim"
	ln -sf "../avail.d/30_plugin_tern.vim"
	ln -sf "../avail.d/30_plugin_taglist.vim"
	ln -sf "../avail.d/30_plugin_fzf.vim"
	ln -sf "../avail.d/90_highlights.vim"
	ln -sf "../avail.d/99_custom_vimrc.vim"
	ln -sf "../avail.d/99_asciitable.vim"
	ln -sf "../avail.d/99_functions.vim"
	ln -sf "../avail.d/99_help.vim"
	)

	# cp -P -f "$TOOLS_BASE/vim/vimrc.d/conf.d"/vim_* "$VIMRCDIR/conf.d"
}

main
