"
" YT_LoadCustomVim : 
"
" Starts from the current directory and traverses up the directory.
" Loads the first .vimrc it finds
"
" g:yt_custom_vimrc    The path of the vimrc loaded
"
" case: define and run YT_LoadCustomVim exactly once.
" Need to check this explicitly, especially with neovim.
if !exists("*YT_LoadCustomVim")
  function YT_LoadCustomVim() 
    " case: loaded already
    if exists('g:yt_custom_vimrc') 
      call YT_devWriteLog("YT_LoadCustomVim: already loaded. Exit.")
      return
    endif

    let l:dir = getcwd()

    " Default vimrc.
    let myvimrc = resolve(expand("$MYVIMRC"))
    let homevimrc = resolve(expand("$HOME") . "/.vimrc")
    let g:yt_custom_vimrc = ""

    while l:dir != "/" 
      let l:file = l:dir . "/.vimrc"

      " Expand to full path
      let l:fullfile = resolve(expand(l:file))
      call YT_devWriteLog("YT_LoadCustomVim: check for " . l:fullfile)

      " Found vimrc.
      " - Ignore loaded vimrcs: $MYVIMRC, ~/.vimrc
      if filereadable(l:file) && l:fullfile != myvimrc && l:fullfile != homevimrc
        let g:yt_custom_vimrc=l:file
        execute "so " l:file ""
        call YT_devWriteLog("YT_LoadCustomVim: loaded " . l:file)
        break
      endif

      let l:dir = resolve(l:dir . "/..")
    endwhile

    if g:yt_custom_vimrc == ""
      call YT_devWriteLog("YT_LoadCustomVim: No custom vimrc found")
    endif
  endfunction

  call YT_LoadCustomVim()
endif
