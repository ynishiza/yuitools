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

function! ArgdoMacro(x)
  argdo execute "normal @" . a:x | update
endfunction

function! ArgRename(old, new)
  call ArgSubstitute("\\v(<" . a:old . ">)", a:new)
endfunction

function! ArgSubstitute(old, new)
  argdo call Substitute("%", a:old, a:new, "gce") | update
endfunction

function! CRename(old, new)
  call CSubstitute("\\v(<" . a:old . ">)", a:new)
endfunction

function! CSubstitute(old, new)
  cdo call Substitute("%", a:old, a:new, "cge") | update
endfunction

" commands
command! -nargs=0 RemoveTrailingWhitespace call RemoveTrailingWhitespace()
command! -nargs=1 EditWithTabs call EditWithTabs(<f-args>)
command! -nargs=1 EditWithSpaces call EditWithSpaces(<f-args>)
command! -nargs=1 ArgdoMacro call ArgdoMacro(<f-args>)
command! -nargs=+ ArgRename call ArgRename(<f-args>)
command! -nargs=+ ArgSubstitute call ArgSubstitute(<f-args>)
command! -nargs=+ CSubstitute call CSubstitute(<f-args>)
command! -nargs=+ CRename call CRename(<f-args>)

