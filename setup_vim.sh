#!/bin/bash
TOOLSDIR="$HOME/.tools_yui"
IS_MAC=`[[ -z $(uname | grep Darwin) ]]; echo $?`
VIMDIR="$HOME/.vim"
VIMRCDIR="$VIMDIR/vimrc.d"

#
# Neobundle
#
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install_neobundle.sh
bash -x install_neobundle.sh
# Cleanup
rm -f install_neobundle.sh

#
# Default tools
#
if [[ ! -d $VIMDIR ]]; then mkdir $VIMDIR; fi
cp -ri $TOOLSDIR/vim/* "$HOME/.vim" 


#
# Vimrcs
#
mkdir -p "$VIMRCDIR/conf.d"

# Link available vimrcs
# -F=force  -h=do not follow target if target is symbolic link (mac only)
LINKOPT=""
if [[ $IS_MAC == 1 ]]; then LINKOPT="-s -F -h"; else LINKOPT="-s -F"; fi
ln $LINKOPT "$TOOLSDIR/dotfiles/vimrc" "$VIMRCDIR/avail.d"

# Copy initial set of enabled vimrcs
pushd "$VIMRCDIR/conf.d"
ln -s "../avail.d/00_sensible.vim" .
ln -s "../avail.d/10_base.vim"
ln -s "../avail.d/10_mappings.vim"
ln -s "../avail.d/10_language.vim"
ln -s "../avail.d/20_neobundle.vim"
ln -s "../avail.d/30_plugin_settings.vim"
ln -s "../avail.d/30_plugin_syntastic.vim"
ln -s "../avail.d/30_plugin_tern.vim"
ln -s "../avail.d/30_plugin_taglist.vim"
ln -s "../avail.d/99_custom_vimrc.vim"
popd
# cp -P -f "$TOOLSDIR/vim/vimrc.d/conf.d"/vim_* "$VIMRCDIR/conf.d"
