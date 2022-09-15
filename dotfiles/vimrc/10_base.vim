" == Filetype options ==
"
" - plugin
" - indent: allow autoindent based on file type
filetype plugin on
filetype indent on


" Encoding 
"
" write encoding
" utf-8 for default encoding. Sometimes, vim uses latin.
set encoding=utf-8


" keys
" 
" backspace option: 
" Backspace to delete eol, indents, and start of an insert.
set backspace=eol,indent,start
" ttimeout option: timeout on key code
set ttimeout
set ttimeoutlen=100

" invisible characters
"
" list option
" - Using sensible.vim
" set listchars=tab:>-,eol:$,nbsp:»

" display option
" uhex = show invisible characters as hex instead of caret notation
" e.g. <Esc> character
"   hex  <b1>
"   caret ^[
set display+=uhex

" wildmenu option
" smarter tab completion in commandline
set wildmenu


" == Editor appearance ==
"

" Gutter
"
" show line number
set number


" Footer
" 
" show status bar.
set laststatus=2
set statusline=""
" show line and column number.
set ruler

" Scrolloff
" minimal lines to keep visible
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=1
endif


" == Editing content ==
" Indenting
"
set smarttab
set autoindent
set tabstop=4
set shiftwidth=0
" Indent automatically on new line.
set autoindent

" Text wrap
"
" t = autowrap at textwidth
" c = autowrap comments at text width
" q = allow formatting text with gq
" r = automatically continue comment on new line
set formatoptions=tcqr


" == Buffer ==
"
" newtab: open new buffer from Quickfix list in a new tab
" usetab: option for newtab. If the same buffer has already been opened in a
" newtab, use the same tab instead of opening a new one.
set switchbuf+=newtab


" == Fold ==

" syntax=defined by syntax file
" manual=create folds manually
"set foldmethod=syntax
set foldmethod=manual
"let javaScript_fold=1


" == History ==
"
" max history to keep
if &history < 1000
  set history=1000
endif


" == Spelling ==
set spell
set spelllang=en
" highlight spelling mistakes
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
"
