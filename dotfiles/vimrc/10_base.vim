"
" My vimrc file
"

" Filetype options
"
" - plugin
" - indent
filetype plugin on 
filetype indent on

"
"set background=dark

"  omni complete
set omnifunc=syntaxcomplete#Complete

" Tabs
set smarttab
set autoindent
set tabstop=4
set shiftwidth=4

" Backspace
" - use backspace to delete eol, indents, and start of an insert.
set backspace=eol,indent,start

" Timeout
" - ttimeout: timeout on key code
set ttimeout
set ttimeoutlen=100

" list (invisibile characters)
" - Using sensible.vim
" set listchars=tab:>-,eol:$,nbsp:»

" wildmenu
" - smarter tab completion in commandline
set wildmenu


" Display line numbers in editor.
set number


" Indent automatically on new line.
set autoindent

"
" Status
"
" show status bar.
set laststatus=2
set statusline=""
" show line and column number.
set ruler

" Fold			
"set foldmethod=syntax
set foldmethod=manual
"let javaScript_fold=1

" History
if &history < 1000
	set history=1000
endif

" Scrolloff
" - minimal lines to keep visible
if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=1
endif


"
" Ctags
"
" Where to look for tag files
set tags=./tags,./ctags


" Syntax highlighting.
syntax enable 


"
" Search
"
" Highlight matches.
set hlsearch
" Highlight as I type.
set incsearch
"set ignorecase
