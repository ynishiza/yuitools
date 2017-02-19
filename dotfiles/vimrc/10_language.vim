"---------------------------------------------------------------
"					 Language specific 
"

" Comment term in the script
let t:comment_term="//"
let t:comment_term_end=""

function! InitVim()
	let t:comment_term="\""
endfunction

function! InitPython()
    "echo "python"
	let t:comment_term="#"
    set autoindent
    " Use spaces instead of tabs
	" set expandtab
    " 4 spaces
    set tabstop=4
    set shiftwidth=4
	set softtabstop=4
	" set textwidth=79
	call EditWithSpaces(4)
endfunction

function! InitPHP()
	let g:myvar="php"
	let t:comment_term="//"
endfunction

function! InitJs()
	let t:comment_term="//"
	call JSWithTabs()
endfunction

function! InitCss() 
	let t:comment_term="/\\* "
	let t:comment_term_end=" \\*/"
endfunction

function! InitBash()
	let t:comment_term="#"
endfunction

function! InitR()
	let t:comment_term="#"
	set expandtab
	set tabstop=2
	set shiftwidth=2
endfunction

function! InitMakefile()
	let t:comment_term="#"
endfunction

function! InitGitmerge()
	" local
	nmap <leader>dl :diffget 1<cr>
	" remote
	nmap <leader>dr :diffget 3<cr>
endfunction

"
function! CommentInsert()
	"execute "'<,'>s=^=" . t:comment_term . "="
	if exists("t:comment_term")
		execute "s=^=" . t:comment_term . "="
	endif
	if exists("t:comment_term_end")
		execute "s=\\(.*\\)=\\1" . t:comment_term_end . "=" 
	endif
endfunction
function! CommentRemove()
	if exists("t:comment_term")
		execute "s=^" . t:comment_term . "=="
	endif
	"execute "'<,'>s=^" . t:comment_term . "=="
	if exists("t:comment_term_end")
		execute "s=" . t:comment_term_end . "$=="
	endif
endfunction

function! InitMarkdown()
	set expandtab
	set tabstop=2
	set shiftwidth=2
endfunction

function! MyTestFunct()
	s/abc/ABC/gc
endfunction

autocmd FileType vim call InitVim()
autocmd FileType python call InitPython()
autocmd FileType php call InitPHP()
autocmd FileType javascript call InitJs()
autocmd FileType r call InitR()
autocmd FileType sh call InitBash()
autocmd FileType make call InitMakefile()
autocmd FileType markdown call InitMarkdown()
autocmd Filetype css call InitCss()
autocmd Filetype json call JSWithSpaces(2)

" Manually recognize filetypes
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.json set filetype=json
autocmd BufRead *.rst set filetype=markdown

"
autocmd BufRead .eslintrc set filetype=json
autocmd BufRead .jshintrc set filetype=json

"
" Language specific settings
"

" JavaScript 
function! JSWithSpaces(x)
	call EditWithSpaces(a:x)
endfunction
function! JSWithTabs()
	call EditWithTabs(4)
endfunction

function! EditWithSpaces(x)
	set expandtab
	let &tabstop=a:x
	let &shiftwidth=a:x
endfunction

function! EditWithTabs(x)
	set noexpandtab
	let &tabstop=a:x
	let &shiftwidth=a:x
endfunction

function! RemoveTrailingWhitespace()
	execute "%s/\\s\\+$//g"
endfunction

function! SpacesToTabs()
	execute "%s/^\\(\\(  \\)*\\)  /\\1\\t/g"
endfunction


