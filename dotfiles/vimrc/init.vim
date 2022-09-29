
" note: circularity protection
" Use w:_init_loaded to prevent circular load
if !exists("w:_init_loaded")
  let w:_init_loaded=1

  " Initialization
  "
  " note: need to get s:scriptpath first for the original path of this script.
  " In particular, not a symlink path, but the original.
  let s:scriptpath=resolve(expand("<sfile>:p"))
  let g:yt_vimrc_path=fnamemodify(s:scriptpath, ":h")
  let g:yt_dotfiles_path=fnamemodify(s:scriptpath, ":h:h")
  exec "set runtimepath+=" . g:yt_dotfiles_path

  " Load enabled scripts
  set runtimepath+=~/.vim/vimrc.d
  execute 'runtime!' 'conf.d/*'
else
  echo "Vim settings already loaded. 'unlet w:_init_loaded' to reload."
  finish
endif

" Keep background transparent.
" To avoid conflict with background of vim and the terminal
hi Normal guibg=NONE ctermbg=NONE
