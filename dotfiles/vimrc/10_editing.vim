function! YT_EditWithSpaces(x)
  set expandtab
  let &tabstop=a:x
  let &shiftwidth=a:x
endfunction

function! YT_EditWithTabs(x)
  set noexpandtab
  let &tabstop=a:x
  let &shiftwidth=a:x
endfunction

function! YT_RemoveTrailingWhitespace()
  if search(' $', 'n') == 0
    return 0
  endif
  normal ma
  %s/\s\+$//ge
  normal 'a
endfunction

function! Substitute(range, pattern, new, flags)
  let l:command = a:range . "s/" . a:pattern . "/" . a:new . "/" . a:flags
  execute l:command
endfunction

function! YT_ArgdoMacro(x)
  argdo execute "normal @" . a:x | update
endfunction

function! YT_ArgRename(old, new)
  call YT_ArgSubstitute("\\v(<" . a:old . ">)", a:new)
endfunction

function! YT_ArgSubstitute(old, new)
  argdo call Substitute("%", a:old, a:new, "gce") | update
endfunction

function! YT_CRename(old, new)
  call YT_CSubstitute("\\v(<" . a:old . ">)", a:new)
endfunction

function! YT_CSubstitute(old, new)
  cdo call Substitute("%", a:old, a:new, "cge") | update
endfunction

" commands
" NOTE: command name != function name because command cannot contain '_'
" character
command! -nargs=0 YTRemoveTrailingWhitespace call YT_RemoveTrailingWhitespace()
command! -nargs=1 YTEditWithTabs call YT_EditWithTabs(<f-args>)
command! -nargs=1 YTEditWithSpaces call YT_EditWithSpaces(<f-args>)
command! -nargs=1 YTArgdoMacro call YT_ArgdoMacro(<f-args>)
command! -nargs=+ YTArgRename call YT_ArgRename(<f-args>)
command! -nargs=+ YTArgSubstitute call YT_ArgSubstitute(<f-args>)
command! -nargs=+ YTCSubstitute call YT_CSubstitute(<f-args>)
command! -nargs=+ YTCRename call YT_CRename(<f-args>)

" Default
call YT_EditWithSpaces(2)
