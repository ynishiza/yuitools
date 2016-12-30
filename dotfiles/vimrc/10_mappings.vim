imap <c-c> <ESC>
imap <c-k> <ESC>

" Save with <c-s>
map <c-s> :w<CR>
imap <c-s> <ESC>:w<CR>
" Close with <c-q>
" Doesn't work?
"map <c-w> :tabc<CR>
"imap <c-w> <ESC>:tabc<CR>

" My commands
"
" - Leader
let mapleader="\<space>"
let maplocalleader=","
map <leader>s :w<CR>
map <leader>w :tabclose<CR>
map <leader>l :so $MYVIMRC<cr>
" Search for word under cursor.
map <leader>f /<c-r>=expand("<cword>")<cr>
" Search and replace word under cursor.
map <leader>r :%s/\<<c-r>=expand("<cword>")<cr>\>
map <leader>g :vimgrep /\<<c-r>=expand("<cword>")<cr>\>/ 
" Shortcuts for my functions
" map <leader>c :call CommentInsert()<cr>
" map <leader>C :call CommentRemove()<cr>


" Clipboard
"
" - mac only? + registry is clipboard
" copy/paste
vmap <leader>c "+y
map <leader>v <ESC>"+p
" select all
nmap <c-a> gg^vGG$		
