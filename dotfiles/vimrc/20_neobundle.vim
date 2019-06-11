if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

function! _BundleInstalled(name)
  return !empty(glob('~/.vim/bundle/' . a:name))
endfunction

" Returns true if NeoBundle is installed
function! NeoBundleInstalled()
  return !empty(glob('~/.vim/bundle'))
endfunction

if NeoBundleInstalled()
  " Note: Skip initialization for vim-tiny or vim-small.
  if 0 | endif

  if has('vim_starting')
    if &compatible
      set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  call neobundle#begin(expand('~/.vim/bundle/'))

  " Plugins
  NeoBundleFetch "Shougo/neobundle.vim"

  " solarized: color scheme
  NeoBundle "altercation/vim-colors-solarized"

  " gpg editing
  NeoBundle "jamessan/vim-gnupg"

  " NERDTREE: file explorer
  NeoBundle 'scrooloose/nerdtree'

  " airline: vim powerline
  NeoBundle 'bling/vim-airline'

  " ack: grep replacement
  NeoBundle 'mileszs/ack.vim'

  " YouCompleteMe: autocompletion
  NeoBundle 'Valloric/YouCompleteMe'

  " vim-unimpaired: bracket mapping
  NeoBundle 'tpope/vim-unimpaired'

  " vim-surround: quoting/parenthesizing tool
  NeoBundle 'tpope/vim-surround'

  " undotree: undo tree visualization
  NeoBundle 'mbbill/undotree'

  " fzf: fuzzy find plugin
  NeoBundle 'junegunn/fzf'

  " Commentary: easy commenting out
  NeoBundle 'tpope/vim-commentary'

  " vim-table-mode: creating tables
  NeoBundle 'dhruvasagar/vim-table-mode'

  " undotree:
  NeoBundle 'mbbill/undotree'

  """"""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""

  " syntactic: syntax check
  NeoBundle 'scrooloose/syntastic'

  " TypeScript syntastic plugin
  NeoBundle 'Quramy/tsuquyomi'


  """"""""""""""""""""""""""" HTML """""""""""""""""""""""""""
  " emmet: HTML plugin
  NeoBundle 'mattn/emmet-vim'


  """"""""""""""""""""""""""" R """""""""""""""""""""""""""
  " Nvim-R: R plugin. Provides omnicompletion
  NeoBundle 'jalvesaq/Nvim-R'


  " lintr: Lint R
  NeoBundle 'jimhester/lintr'

  """"""""""""""""""""""""""" LaTeX """""""""""""""""""""""""""

  " vimtex: Comprehensive LaTeX filetype plugin.
  NeoBundle 'lervag/vimtex'

  """"""""""""""""""""""""""" JavaScript """""""""""""""""""""""""""

  " TypeScript Syntax file
  "NeoBundle 'leafgarland/typescript-vim'


  " ternjs: syntax completion for JavaScript.
  NeoBundle 'ternjs/tern_for_vim',
    \ { 'build' : { 'others': 'npm install' } }


  " javascript-indenter: more smart indenting of JavaScript
  " - Need when indents are spaces.
  " - brief mode: minimal indenting.
  NeoBundle 'jiangmiao/simple-javascript-indenter'


  " JavaScript syntax file.
  " NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
  " au FileType javascript call JavaScriptFold()
  " au FileType javascript set foldmethod=syntax

  NeoBundle 'pangloss/vim-javascript'

  " TypeScript syntax file
  NeoBundle 'leafgarland/typescript-vim'

  """"""""""""""""""""""""""" Haskell """""""""""""""""""""""""""

  " neco-ghc: omnicomplete for haskell
  " not working?
  NeoBundle 'eagletmt/neco-ghc'
  au FileType haskell setlocal omnifunc=necoghc#omnifunc

  "
  NeoBundle 'lukerandall/haskellmode-vim'
  let g:haddock_browser="abc"


  """"""""""""""""""""""""""" PHP """""""""""""""""""""""""""

  " vdebug: debug plugin for PHP's XDebugger
  NeoBundle 'joonty/vdebug'


  """"""""""""""""""""""""""" Disabled """""""""""""""""""""""""""

  "NeoBundle 'majutsushi/tagbar'


  " Color status bar:
  " Doesn't work well with Mac.
  "NeoBundle 'itchyny/lightline.vim'

  "
  filetype plugin indent on

  call neobundle#end()

  NeoBundleCheck
endif
