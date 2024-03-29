"
" OLD: neobundle
" if !empty(glob('~/.vim/bundle/syntastic')) || !empty(glob('~/.vim/plugged/syntastic'))
if YT_PlugInstalled('syntastic')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  " Loc: location-list
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_loc_list_height = 5

  " note: don't automatically populate location list.
  " Conflicts with vimgrep
  "let g:syntastic_check_on_open = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_wq = 0

  nmap <leader>E :Errors<cr>

  " note: disabled custom symbols.
  " Error if symbol not available?
  " let g:syntastic_error_symbol = "✗"
  " let g:syntastic_warning_symbol = "⚠"
  let g:syntastic_error_symbol = "x"
  let g:syntastic_warning_symbol = "w"

  " Default checkers
  " let g:syntastic_python_checkers = ["pyflakes", "pep8", "flake8"]
  let g:syntastic_python_checkers = ["flake8"]
  let g:syntastic_javascript_checkers = ["jshint", "eslint"]
  let g:syntastic_r_checkers = ["lintr"]
  let g:syntastic_tex_checkers = ["chktex"]
  " No checkers for haskell since it conflicts with the language server
  let g:syntastic_haskell_checkers=[]

  function! SyntasticDebugSetLevel(level)
    let g:syntastic_debug=a:level
  endfunction
  command! -nargs=0 SyntasticDebugEnable call SyntasticDebugSetLevel(1)
  command! -nargs=0 SyntasticDebugDisable call SyntasticDebugSetLevel(0)

  function! JSDisableSyntastic()
    let g:syntastic_javascript_checkers = []
  endfunction
  function! JSEnableJshint()
    let g:syntastic_javascript_checkers = ["jshint"]
  endfunction
  function! JSEnableEslint()
    let g:syntastic_javascript_checkers = ["eslint"]
  endfunction
endif
