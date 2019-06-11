" == Filetype options ==
"
" - plugin
" - indent
filetype plugin on 
filetype indent on

" utf-8 for default encoding. Sometimes, vim uses latin.
set encoding=utf-8

" - use backspace to delete eol, indents, and start of an insert.
set backspace=eol,indent,start


" - ttimeout: timeout on key code
set ttimeout
set ttimeoutlen=100


" list (invisibile characters)
" - Using sensible.vim
" set listchars=tab:>-,eol:$,nbsp:»

" wildmenu
" - smarter tab completion in commandline
set wildmenu


" == Editor appearance ==
"

" Display line numbers in editor.
set number

" show status bar.
set laststatus=2
set statusline=""
" show line and column number.
set ruler

" Scrolloff
" - minimal lines to keep visible
if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=1
endif


" == Editing content ==
set smarttab
set autoindent
set tabstop=4
set shiftwidth=0
" Indent automatically on new line.
set autoindent
" t = autowrap at textwidth
" c = autowrap comments at text width
" q = allow formatting text with gq
" r = automatically continue comment on new line
set formatoptions=tcqr


" == Fold ==
"set foldmethod=syntax
set foldmethod=manual
"let javaScript_fold=1


" == History ==
"
if &history < 1000
	set history=1000
endif


" == Spelling ==
set spell
set spelllang=en
hi clear SpellBad


" == Completion ==
"  omni complete
set omnifunc=syntaxcomplete#Complete


" == Ctags ==
"
" Where to look for tag files
set tags=./tags,./ctags


" == Syntax ==
" Syntax highlighting.
syntax enable 


" == Search ==
"
" Highlight matches.
set hlsearch
" Highlight as I type.
set incsearch
"set ignorecase


