set runtimepath+=~/.vim/vimrc.d

" note: circularity protection
" Use w:_init_loaded to prevent circular load
if !exists("w:_init_loaded")
  let w:_init_loaded=1
  execute 'runtime!' 'conf.d/*'
else
  echo "Vim settings already loaded. 'unlet w:_init_loaded' to reload."
  finish
endif

" Keep background transparent.
" To avoid conflict with background of vim and the terminal
hi Normal guibg=NONE ctermbg=NONE

