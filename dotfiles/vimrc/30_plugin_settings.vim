if YT_PlugInstalled('Nvim-R')
  function! _initNvimR()
    " omnicomplete: show the arguments of a function.
    let R_show_args = 1
  endfunction
  au Filetype r call _initNvimR()
endif

if YT_PlugInstalled('nerdtree')
  map <leader>n :NERDTreeToggle<cr>
  map <leader>N :NERDTree<cr>
endif

if YT_PlugInstalled('undotree')
  map <F9> :UndotreeToggle<cr>
endif

if YT_PlugInstalled('lintr')
  function! _YT_InitLintr()
    " note: check only passively, since lintr is a bit slow.
"   SyntasticToggleMode
"   nmap <leader>e :SyntasticCheck<cr>:Errors<cr>
    let g:syntastic_enable_r_lintr_checker = 1

    " note:
    " object_usage_inter disabled. Complains about variables outside of scope.
    " let g:syntastic_r_lintr_linters = "with_defaults(camel_case_linter = NULL, object_usage_linter = NULL,  line_length_linter(120))"
  endfunction
  call _YT_InitLintr()
endif

if YT_PlugInstalled('vim-airline')
  call YT_devWriteLog("loaded vim-airline settings")
endif

if YT_PlugInstalled('simple-javascript-indenter')
" if YT_PlugInstalled('simple-javascript-indenter')
  let g:SimpleJsIndenter_BriefMode = 1
endif


if YT_PlugInstalled('vim-colors-solarized')
  function! _EnableSolarizedForiTerm2()
"   set t_Co=256
"   let g:solarized_term_colors=256
"
    set background=dark
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    colorscheme solarized
  endfunction

  " On Mac, use the terminal's color
  call _EnableSolarizedForiTerm2()

  call YT_devWriteLog("loaded vim-colors-solarized settings")
endif


if YT_PlugInstalled('vim-airline')
  " Off for now until configured properly
  function! _EnableAirline()
    "set guifont=Droid_Sans_Mono_for_Powerline:h10
    "let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    " unicode symbols
    " let g:airline_left_sep = '»'
    " let g:airline_left_sep = '▶'
    " let g:airline_right_sep = '«'
    " let g:airline_right_sep = '◀'
    " let g:airline_symbols.linenr = '␊'
    " let g:airline_symbols.linenr = '␤'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.branch = '⎇'
    " let g:airline_symbols.paste = 'ρ'
    " let g:airline_symbols.paste = 'Þ'
    " let g:airline_symbols.paste = '∥'
    " let g:airline_symbols.whitespace ='Ξ'

    " See ~/.vim/bundle/vim-airline/autoload/airline/themes
    " For some reason,
    "
    AirlineRefresh
  endfunction

  "" Theme selection
  " See https://github.com/vim-airline/vim-airline-themes/tree/master/autoload/airline/themes
  " let g:airline_theme = "solarized"

  " autocmd VimEnter * call _EnableAirline()
endif

if YT_PlugInstalled('im_control.vim')
  " Reference: https://qiita.com/2no/items/7c9c6ab60275fd865b02
  "
  " Trigger input source (English/Japanese) from vim
  "
  " IMPORTANT: need to set Accessibility permission to allow osascript to emit
  " keystroke events
  "    System Preferences -> Privacy & Security -> Accessibility -> iTerm
  if has('mac')
    let IM_CtrlMode = 1

    function! IMCtrl(cmd)
      let cmd = a:cmd
      if cmd == 'On'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
      elseif cmd == 'Off'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
      elseif cmd == 'Toggle'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
      endif
      return ''
    endfunction

    " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
    let IM_CtrlMacVimKaoriya = 0

    " ctrl+jで日本語入力固定モードをOnOff
    inoremap <silent> <C-n> <C-^><C-r>=IMState('FixMode')<CR>
  endif
endif
