let g:yt_logdir='/tmp'
let g:yt_logpath=yt_logdir . '/yt.log'
let g:yt_is_nvim =has('nvim')

" Log enabling:
" Debug logging may affect performance, especially on startup time when many
" scripts are read.
"
" nvim: enabled by default
" vim: disabled by default because slow
" $YT_VIM_DEBUG: 1=enable 0=disable
let g:yt_log_enabled=g:yt_is_nvim ? 1 : 0
if $YT_VIM_DEBUG != ''
  let g:yt_log_enabled=$YT_VIM_DEBUG == '1'
endif

" note: write to log
function! YT_devWriteLog(message)
  if g:yt_log_enabled
    call writefile([strftime('%c') . ' - ' . a:message], g:yt_logpath, 'a')
  endif
endfunction

" note: initialize log file
" writefile() fails if the file does not exist
function! YT_devInitLog()
  call system('mkdir -p ' . g:yt_logdir . ' && touch ' . g:yt_logpath)
endfunction

function! YT_devShowLog()
  exec 'tabedit ' . g:yt_logpath
endfunction

call YT_devInitLog()
call YT_devWriteLog("vim open cwd=" . getcwd() . " file=" . expand("%:p"))

" Log scripts/files opened
au SourcePost * call YT_devWriteLog("sourced script " . expand("<afile>"))
au BufReadPost * call YT_devWriteLog("read buffer " . expand("%:p"))
