let s:scriptpath=resolve(expand("<sfile>:p"))
let s:scriptdir=fnamemodify(s:scriptpath, ":h")

"---------------------------------------------------------------
"          Language specific
"

" Comment term in the script
let t:comment_term="//"
let t:comment_term_end=""

function! YT_InitVim()
  let t:comment_term="\""
  call YT_EditWithSpaces(2)
  set undofile
endfunction

function! YT_InitPython()
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
  call YT_EditWithSpaces(4)
  set undofile
endfunction

function! YT_InitPHP()
  let g:myvar="php"
  let t:comment_term="//"
  set undofile
endfunction

function! YT_InitJs()
  let t:comment_term="//"
  call YT_JSWithSpaces(2)
  set undofile
endfunction

function! YT_InitCss()
  let t:comment_term="/\\* "
  let t:comment_term_end=" \\*/"
  set undofile
endfunction

function! YT_InitShell()
  let t:comment_term="#"
  set undofile
  call YT_EditWithTabs(2)
endfunction

function! YT_InitR()
  let t:comment_term="#"
  set expandtab
  set tabstop=2
  set shiftwidth=0
  set textwidth=80
  set undofile
endfunction

function! YT_InitMakefile()
  let t:comment_term="#"
  set undofile
endfunction

function! YT_InitGitmerge()
  " local
  nmap <leader>dl :diffget 1<cr>
  " remote
  nmap <leader>dr :diffget 3<cr>
endfunction

"
function! YT_CommentInsert()
  "execute "'<,'>s=^=" . t:comment_term . "="
  if exists("t:comment_term")
    execute "s=^=" . t:comment_term . "="
  endif
  if exists("t:comment_term_end")
    execute "s=\\(.*\\)=\\1" . t:comment_term_end . "="
  endif
endfunction
function! YT_CommentRemove()
  if exists("t:comment_term")
    execute "s=^" . t:comment_term . "=="
  endif
  "execute "'<,'>s=^" . t:comment_term . "=="
  if exists("t:comment_term_end")
    execute "s=" . t:comment_term_end . "$=="
  endif
endfunction

function! YT_InitMarkdown()
  :YTEditWithSpaces 2
  set textwidth=0
  set undofile
endfunction

function! YT_LatexInit()
  let g:tex_flavor="latex"

  " -n option: disable warnings
  " Documentation: https://www.ctan.org/pkg/chktex?lang=en
  "  1 = Command terminated with space.
  "  8 = Wrong length of dash may have been used.
  let g:syntastic_tex_chktex_args="-n 8 -n 1"

  if ! g:yt_is_nvim
    " tex files very slow in original vim
    " Ref: https://stackoverflow.com/questions/8300982/vim-running-slow-with-latex-files
    set norelativenumber
    set nocursorline
    :NoMatchParen

    " Too slow
    set foldmethod=manual
    set nofoldenable
    let g:syntastic_tex_checkers=[]
    set undofile
  endif
endfunction

function! YT_BashTemplate()
  let s:template=readfile(s:scriptdir . "/text_YT_BashTemplate.sh")

  " note: need to ESC to prevent indents
  exec 'normal i' . join(s:template, "\<ESC>:normal o\<ESC>i")

  " Ensure appropriate tabs 
  call YT_EditWithTabs(2)
  retab!
endfunction

function! MyTestFunct()
  s/abc/ABC/gc
endfunction

aug yuitools
  autocmd FileType vim call YT_InitVim()
  autocmd FileType python call YT_InitPython()
  autocmd FileType php call YT_InitPHP()
  autocmd FileType javascript call YT_InitJs()
  autocmd FileType r call YT_InitR()
  autocmd FileType sh call YT_InitShell()
  autocmd FileType make call YT_InitMakefile()
  autocmd FileType markdown call YT_InitMarkdown()
  autocmd Filetype css call YT_InitCss()
  autocmd Filetype json call YT_JSWithSpaces(2)
  autocmd BufRead *.tex call YT_LatexInit()
  autocmd BufRead *.conf call YT_EditWithTabs(2)
aug END

aug yuitools_trailingwhitespace
autocmd yuitools_trailingwhitespace BufWrite
      \ *.sh,
      \*.py,*.r,*.php,
      \*.json,*.js,*vimrc,
      \*.ts,
      \*.md,*.markdown,
      \*.yml,*.cfg
      \*.css,*.scss
      \*.lua
      \*.tex
      \*.vim
      \ :YTRemoveTrailingWhitespace
aug END

function! YT_DisableRemoveTrailingWhiteSpace(filetype)
  exec "autocmd! yuitools_trailingwhitespace BufWrite " . a:filetype
endfunction

aug yuitools_filetype
  " Manually recognize filetypes
  autocmd BufRead *.md set filetype=markdown
  autocmd BufRead *.json set filetype=json
  autocmd BufRead *.rst set filetype=markdown
  autocmd BufRead *.conf set filetype=conf
aug END

  " JSON
aug yuitools_json
  autocmd BufRead .eslintrc set filetype=json
  autocmd BufRead .jshintrc set filetype=json
  autocmd BufRead Jenkinsfile set filetype=groovy
aug END

"
" Language specific settings
"

" JavaScript
function! YT_JSWithSpaces(x)
  call YT_EditWithSpaces(a:x)
endfunction
function! YT_JSWithTabs()
  call YT_EditWithTabs(4)
endfunction
function! YT_EslintDisableNextLine(rule) 
  exec "normal O// eslint-disable-next-line " . a:rule
endfunction
function! YT_ShellCheckDisableNextLine(rule) 
  exec "normal O# shellcheck disable=" . a:rule
endfunction

command! -nargs=1 YTESlintDisableNextLine call YT_EslintDisableNextLine(<f-args>)
command! -nargs=1 YTShellCheckDisableNextLine call YT_ShellCheckDisableNextLine(<f-args>)
command! -nargs=0 YTBashTemplate call YT_BashTemplate()
