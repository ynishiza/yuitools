" ************** NOT WORKING YET ***********************
" ************** NOT WORKING YET ***********************
" ************** NOT WORKING YET ***********************
" ************** NOT WORKING YET ***********************
" ************** NOT WORKING YET ***********************
" ************** NOT WORKING YET ***********************
" Needs Vim 8.0 or Neovim
"

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

function DeinInstalled()
  return dein#load_state('~/.cache/dein')
endfunction

if DeinInstalled()
" if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
 
  " solarized: color scheme
  call dein#add('altercation/vim-colors-solarized')

  " NERDTREE: file explorer
  call dein#add('scrooloose/nerdtree')

  " airline: vim powerline
  call dein#add('bling/vim-airline')

  " ack: grep replacement
  call dein#add('mileszs/ack.vim')

  " YouCompleteMe: autocompletion
  call dein#add('Valloric/YouCompleteMe')

  " vim-unimpaired: bracket mapping
  call dein#add('tpope/vim-unimpaired')

  " vim-surround: quoting/parenthesizing tool
  call dein#add('tpope/vim-surround')

  " undotree: undo tree
  call dein#add('mbbill/undotree')

  " fzf: fuzzy find plugin
  call dein#add('junegunn/fzf')

  " Commentary: easy commenting out
  call dein#add('tpope/vim-commentary')

  " vim-table-mode: creating tables
  call dein#add('dhruvasagar/vim-table-mode')


  """"""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""

  " syntactic: syntax check
  call dein#add('scrooloose/syntastic')

  " TypeScript syntastic plugin
  call dein#add('Quramy/tsuquyomi')


  """"""""""""""""""""""""""" HTML """""""""""""""""""""""""""
  " emmet: HTML plugin
  call dein#add('mattn/emmet-vim')


  """"""""""""""""""""""""""" R """""""""""""""""""""""""""
  " Nvim-R: R plugin. Provides omnicompletion
  call dein#add('jalvesaq/Nvim-R')


  " lintr: Lint R
  call dein#add('jimhester/lintr')
  

  """"""""""""""""""""""""""" JavaScript """""""""""""""""""""""""""

  " TypeScript Syntax file
  "call dein#add('leafgarland/typescript-vim')


  " ternjs: syntax completion for JavaScript.
  call dein#add('ternjs/tern_for_vim')
  "   \ { 'build' : { 'others': 'npm install' } }


  " javascript-indenter: more smart indenting of JavaScript
  " - Need when indents are spaces.
  " - brief mode: minimal indenting.
  call dein#add('jiangmiao/simple-javascript-indenter')


  " JavaScript syntax file.
  " NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
  " au FileType javascript call JavaScriptFold()
  " au FileType javascript set foldmethod=syntax

  call dein#add('pangloss/vim-javascript')

  " TypeScript syntax file
  call dein#add('leafgarland/typescript-vim')

  """"""""""""""""""""""""""" Haskell """""""""""""""""""""""""""

  " neco-ghc: omnicomplete for haskell
  " not working?
  call dein#add('eagletmt/neco-ghc')
  au FileType haskell setlocal omnifunc=necoghc#omnifunc

  "
  call dein#add('lukerandall/haskellmode-vim')
  let g:haddock_browser="abc"


  """"""""""""""""""""""""""" PHP """""""""""""""""""""""""""
  
  " vdebug: debug plugin for PHP's XDebugger
  call dein#add('joonty/vdebug')


  """"""""""""""""""""""""""" Disabled """""""""""""""""""""""""""

  "call dein#add('majutsushi/tagbar')


  " Color status bar:
  " Doesn't work well with Mac.
  "call dein#add('itchyny/lightline.vim')


  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
