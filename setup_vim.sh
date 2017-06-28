#!/bin/bash
set -o pipefail
set -o errexit
set -o nounset

declare TOOLSDIR
declare IS_MAC
declare VIMDIR
declare VIMRCDIR

TOOLSDIR="$HOME/.tools_yui"
IS_MAC=$([[ -z $(uname | grep Darwin) ]]; echo $?)
VIMDIR="$HOME/.vim"
VIMRCDIR="$VIMDIR/vimrc.d"

main() {
	setupNeoBundle
	setupDefaultPlugins
	setupVimrc
}

setupNeoBundle() {
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install_neobundle.sh
	bash install_neobundle.sh || true
	# Cleanup
	rm -f install_neobundle.sh
}

setupDefaultPlugins() {
	if [[ ! -d "$VIMDIR" ]]; then mkdir "$VIMDIR"; fi
	rsync -r "$TOOLSDIR/vim/" "$HOME/.vim" 
}

setupVimrc() {
	mkdir -p "$VIMRCDIR/conf.d"

	# Link available vimrcs
	# -f=force
	# -h=do not follow target if target is symbolic link (mac only)
	LINKOPT=""
	if [[ $IS_MAC == 1 ]]; then LINKOPT="-s -f -h"; else LINKOPT="-s -f"; fi
	ln $LINKOPT "$TOOLSDIR/dotfiles/vimrc" "$VIMRCDIR/avail.d"


	# Copy initial set of enabled vimrcs
	pushd "$VIMRCDIR/conf.d"
	ln -sf "../avail.d/00_sensible.vim" .
	ln -sf "../avail.d/10_base.vim"
	ln -sf "../avail.d/10_mappings.vim"
	ln -sf "../avail.d/10_language.vim"
	ln -sf "../avail.d/20_neobundle.vim"
	ln -sf "../avail.d/30_plugin_settings.vim"
	ln -sf "../avail.d/30_plugin_syntastic.vim"
	ln -sf "../avail.d/30_plugin_tern.vim"
	ln -sf "../avail.d/30_plugin_taglist.vim"
	ln -sf "../avail.d/90_highlights.vim"
	ln -sf "../avail.d/99_custom_vimrc.vim"
	popd

	# cp -P -f "$TOOLSDIR/vim/vimrc.d/conf.d"/vim_* "$VIMRCDIR/conf.d"
}

main
