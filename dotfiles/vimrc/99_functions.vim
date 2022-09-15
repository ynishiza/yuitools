" YT_DiffN(n)
" diff n buffers
function! YT_DiffN(n) abort
  let l:time = substitute(system("date +%s"), "\n", "", "")
  for i in range(a:n)
    if i != 0
      vsplit
    endif
    let l:name = "diff_" . l:time . "_" . i . ""
    call YT_DiffNew(l:name)
  endfor
endfunction

function! YT_DiffNew(buffer_name) abort
  execute "badd " . a:buffer_name
  execute "buffer " . a:buffer_name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  diffthis
endfunction

function! YT_GenerateUuid4()
  let @u=system("python3 -c 'import uuid;print(uuid.uuid4(), end=\"\")'")
  echo 'UUID stored in registry u=' . @u
endfunction

command! -nargs=1 YTDiffNew call YT_DiffNew(<q-args>)
command! -nargs=1 YTDiffN call YT_DiffN(<args>)
command! -nargs=0 YTDiffTwo call YT_DiffN(2)
command! -nargs=0 YTGenerateUuid4 call YT_GenerateUuid4()
