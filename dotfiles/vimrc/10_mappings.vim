"
" Basic keys:
"  <ESC> = escape
"  <Tab> = tab
"  <Space> = space
"  <CR> = return
"
"  <F1> = F1
"  <F2> = F2
"
"  <S-A> = Shift-A
"  <C-A> = Control-A (control on Mac)
"  <M-A> = Meta-A (alt/option on Mac)
"  <D-A> = Command-A (Mac only)
"
" See :help-keycodes for keys


"" Idiomatic
"
" Command history: by default, <c-n> and <c-p> does traverse the history.
" However, it does not filter the commands like <Up> and <Down>.
cnoremap <c-n> <Down>
cnoremap <c-p> <Up>


" Leaders
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


"" Buffers
map <leader>bo :ls<cr>:b
map <leader>bd :ls!<cr>:bd
map <leader>bs :ls<cr>
map <leader>bS :ls!<cr>
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bf :bf<cr>
map <leader>bl :bl<cr>


"" Tabs
map <leader>tn :tabedit<cr>
" Current buffer in new tab
map <leader>t% :tabedit %<cr>
map <leader>t# :tabedit #<cr>
map <leader>tq :tabclose<cr>


" Reload
map <leader>r :so $MYVIMRC<cr>


" Search
" Search for word under cursor.
map <leader>f/ /<c-r>=expand("<cword>")<cr>
" Search and replace word under cursor.
map <leader>fs :%s/\v(<<c-r>=expand("<cword>")<cr>>)/
map <leader>fg :grep "\<<c-r>=expand("<cword>")<cr>\>"
" Clear search highlights
nmap <leader>ff :nohlsearch<cr>


"" location list
map <leader>ll :ll<cr>
map <leader>ln :lnext<cr>
map <leader>lp :lprevious<cr>
map <leader>lw :lwindow<cr>
map <leader>lc :lclose<cr>


"" Clipboard
" - mac only? + registry is clipboard
" copy/paste
vmap <leader>c "+y
map <leader>v <ESC>"+p
map <leader>V <ESC>"+P
" select all
nmap <c-a> gg^vGG$


" Repeat last command
nmap <leader>. @:


" Escape shortcut
imap <c-c> <ESC>
imap <c-k> <ESC>
