#!/bin/bash
TOOLSDIR="$HOME/.tools_yui"
VIMDIR="$HOME/.vim"

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install_neobundle.sh
bash -x install_neobundle.sh

# Default tools
if [[ ! -d $VIMDIR ]]; then mkdir $VIMDIR; fi
cp -ri $TOOLSDIR/vim/* "$HOME/.vim" 

# Cleanup
rm -f install_neobundle.sh
