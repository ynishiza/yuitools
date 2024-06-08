"  nvim-0.5
let s:lua_support = has('nvim-0.5')

call plug#begin('~/.vim/plugged')

  " solarized: color scheme
  if s:lua_support
    Plug 'craftzdog/solarized-osaka.nvim'
  else
    " Note: no longer working on neovim 0.10
    " Check :colorscheme
    Plug 'altercation/vim-colors-solarized'
  endif

  " gpg editing
  Plug 'jamessan/vim-gnupg'

  " NERDTREE: file explorer
  Plug 'scrooloose/nerdtree'

  " airline: vim powerline
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Commentary: easy commenting out
  Plug 'tpope/vim-commentary'

  " Abolish: name format conversion
  " e.g. camel case <-> underscore
  Plug 'tpope/vim-abolish'

  " vim-unimpaired: bracket mapping
  Plug 'tpope/vim-unimpaired'

  " vim-surround: quoting/parenthesizing tool
  Plug 'tpope/vim-surround'

  " YouCompleteMe: autocompletion
  "
  " NOTE: conflicts with neovim LSP?
  if !s:lua_support
  " if 1
    Plug 'Valloric/YouCompleteMe'
  endif

  " fzf: fuzzy find plugin
  Plug 'junegunn/fzf'

  " undotree: undo tree visualization
  Plug 'mbbill/undotree'

  " ack: grep replacement
  Plug 'mileszs/ack.vim'

  " Spellcheck: Quickfix window for spelling
  Plug 'inkarkat/vim-ingo-library'     " dependency
  Plug 'inkarkat/vim-SpellCheck'

  " vim-table-mode: creating tables
  Plug 'dhruvasagar/vim-table-mode'

  " taglist: ctags sidebar
  Plug 'vim-scripts/taglist.vim'

  if s:lua_support
    "" [Neovim only] firenvim: use neovim in Firefox
    " github: https://github.com/glacambre/firenvim
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  endif

  " im_control: easy switching in Japanese keyboard
  " e.g. Japanese keyboard automatically disabled when not editing
  Plug 'fuenor/im_control.vim'

  """"""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""

  " syntactic: syntax check
  Plug 'scrooloose/syntastic'

  """"""""""""""""""""""""""" neovim 0.5: Treesitter """""""""""""""""""""""""""

  if s:lua_support
    " treesitter: Better syntax-related features
    " e.g. highlighting
    " e.g. folding
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Twilight: highlight current code
    " https://github.com/folke/twilight.nvim
    Plug 'folke/twilight.nvim'
  endif


  """"""""""""""""""""""""""" neovim 0.5: LSP """""""""""""""""""""""""""

  if s:lua_support
    Plug 'neovim/nvim-lspconfig'

    " Not needed?
    " Plug 'glepnir/lspsaga.nvim'
    " Plug 'kyazdani42/nvim-web-devicons'

    " LSP diagnostic
    Plug 'folke/trouble.nvim'

    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'

    " Autocompletion: snippet engine for nvim-cmp
    " i.e. dropdown menu engine
    " This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
    " Default snippet is vim-vsnip
    " Plug 'hrsh7th/vim-vsnip'
    " LauSnip: Snippet engine in lua
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

    " Autocompletion: completion sources
    " i.e. what to use in completion suggestion
    " cmp-buffer: buffer suggestions
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    " cmp-nvim-lsp: lsp suggestions
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'ray-x/cmp-treesitter'
  endif


  """"""""""""""""""""""""""" Language """""""""""""""""""""""""""

  "" Haskell
  "
  if s:lua_support
    " haskell-vim: syntax highlighting for haskell
    " https://github.com/neovimhaskell/haskell-vim
    Plug 'neovimhaskell/haskell-vim'

    " DISABLED: Not working? Better to use LSP anyway
    " Plug 'eagletmt/neco-ghc'
    " au FileType haskell setlocal omnifunc=necoghc#omnifunc
  endif


  "" Terraform
  "
  " vim-terraform
  " Official Terraform util
  " Syntax highlighting + indent
  Plug 'hashivim/vim-terraform'


  "" groovy
  "
  " Apache Groovy
  Plug 'vim-scripts/groovy.vim'


  "" JS
  "
  " javascript-indenter: more smart indenting of JavaScript
  " - Need when indents are spaces.
  " - brief mode: minimal indenting.
  Plug 'jiangmiao/simple-javascript-indenter'
  Plug 'pangloss/vim-javascript'


  "" HTML
  " emmet: HTML plugin
  Plug 'mattn/emmet-vim'


  "" LaTeX
  "
  " vimtex: Comprehensive LaTeX filetype plugin.
  Plug 'lervag/vimtex'


  "" TypeScript syntax file
  "
  Plug 'leafgarland/typescript-vim'

  "" [NOT NEEDED NOW] R
  "
  " Nvim-R: R plugin. Provides omnicompletion
  " Plug 'jalvesaq/Nvim-R'
  "
  " lintr: Lint R
  " Plug 'jimhester/lintr'


  "" [NOT NEEDED NOW] PHP
  " vdebug: debug plugin for PHP's XDebugger
  " Plug 'joonty/vdebug'

  call YT_devWriteLog("loaded vim-plugged")
call plug#end()

" neovim 0.5 only vimplug settings
if s:lua_support
  " note: assumes runtimepath contains the dotfiles dir. See ./init.vim.
  runtime! vimrc/21_vimplug_neovim.vim
endif

function! YT_PlugInstalled(name)
  return has_key(g:plugs, a:name)
  " return !empty(glob('~/.vim/plugged/' . a:name))
endfunction
