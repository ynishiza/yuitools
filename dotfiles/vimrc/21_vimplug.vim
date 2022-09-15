let s:is_neovim_05 = has('nvim-0.5')
call plug#begin('~/.vim/plugged')
  " solarized: color scheme
  Plug 'altercation/vim-colors-solarized'

  " gpg editing
  Plug 'jamessan/vim-gnupg'

  " NERDTREE: file explorer
  Plug 'scrooloose/nerdtree'

  " airline: vim powerline
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Commentary: easy commenting out
  Plug 'tpope/vim-commentary'

  " vim-unimpaired: bracket mapping
  Plug 'tpope/vim-unimpaired'

  " vim-surround: quoting/parenthesizing tool
  Plug 'tpope/vim-surround'

  " YouCompleteMe: autocompletion
  "
  " NOTE: conflicts with neovim LSP?
  if !s:is_neovim_05
  " if 1
    Plug 'Valloric/YouCompleteMe'
  endif

  " coc: another autocompletion?
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

  """"""""""""""""""""""""""" Syntastic """""""""""""""""""""""""""

  " syntactic: syntax check
  Plug 'scrooloose/syntastic'

  " TypeScript syntastic plugin
  Plug 'Quramy/tsuquyomi'

  " taglist: ctags sidebar
  Plug 'vim-scripts/taglist.vim'

  """"""""""""""""""""""""""" neovim 0.5: Treesitter """""""""""""""""""""""""""

  if s:is_neovim_05
    " treesitter: Better syntax-related features
    " e.g. highlighting
    " e.g. folding
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Twilight: highlight current code
    " https://github.com/folke/twilight.nvim
    Plug 'folke/twilight.nvim'
  endif 


  """"""""""""""""""""""""""" neovim 0.5: LSP """""""""""""""""""""""""""

  if s:is_neovim_05
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

  " haskell-vim: syntax highlighting for haskell
  " https://github.com/neovimhaskell/haskell-vim
  if s:is_neovim_05
    Plug 'neovimhaskell/haskell-vim'
  endif

  " vim-terraform
  " Official Terraform util
  " Syntax highlighting + indent
  Plug 'hashivim/vim-terraform'

  " groovy
  " Apache Groovy
  Plug 'vim-scripts/groovy.vim'

  " javascript-indenter: more smart indenting of JavaScript
  " - Need when indents are spaces.
  " - brief mode: minimal indenting.
  Plug 'jiangmiao/simple-javascript-indenter'
  Plug 'pangloss/vim-javascript'

  " emmet: HTML plugin
  Plug 'mattn/emmet-vim'

  " vimtex: Comprehensive LaTeX filetype plugin.
  Plug 'lervag/vimtex'

  " TypeScript syntax file
  Plug 'leafgarland/typescript-vim'

  call YT_devWriteLog("loaded vim-plugged")
call plug#end()

" neovim 0.5 only vimplug settings
if s:is_neovim_05
  set runtimepath+=~/.vim/vimrc.d
  runtime! avail.d/21_vimplug_neovim.vim
endif

function! YT_PlugInstalled(name)
  return !empty(glob('~/.vim/plugged/' . a:name))
endfunction
