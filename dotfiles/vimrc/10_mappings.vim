imap <c-c> <ESC>
imap <c-k> <ESC>

"" Idiomatic
"
" Command history: by default, <c-n> and <c-p> does traverse the history.
" However, it does not filter the commands like <Up> and <Down>.
cnoremap <c-n> <Down>
cnoremap <c-p> <Up>


"" My commands
"
" - Leader
let mapleader="\<space>"
let maplocalleader=","
" Save
noremap <leader>s :w<CR>
noremap <c-s> :w<CR>
inoremap <c-s> <esc>:w<CR>
" Close window
map <leader>w :q<CR>
" Quit (close all windows)
map <leader>q :qa<CR>
" Reload
map <leader>l :so $MYVIMRC<cr>

" == Search ==
" Search for word under cursor.
map <leader>f/ /<c-r>=expand("<cword>")<cr>
" Search and replace word under cursor.
map <leader>fs :%s/\<<c-r>=expand("<cword>")<cr>\>
map <leader>fg :grep "\<<c-r>=expand("<cword>")<cr>\>"

" == Tabs ==
map <leader>tn :tabedit<cr>
" Current buffer in new tab
map <leader>t% :tabedit %<cr>
map <leader>t# :tabedit #<cr>
map <leader>tq :tabclose<cr>

" == Clipboard ==
" - mac only? + registry is clipboard
" copy/paste
vmap <leader>c "+y
map <leader>v <ESC>"+p
map <leader>V <ESC>"+P
" select all
nmap <c-a> gg^vGG$		

