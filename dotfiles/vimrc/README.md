# Overview

The numerical prefix in the filename indicates load order.
Small numbers are loaded first.
e.g. `00_0debug.vim` is loaded first.
e.g. `99_info.vim` is loaded last.

A selection of vimrcs are loaded through entry point `init.vim`.
vimrc files to be loaded are symlinked in `~/.vim/vimrc.d/conf.d`
