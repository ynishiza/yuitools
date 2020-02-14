"
" LoadCustomVim : 
"
" Starts from the current directory and traverses up the directory.
" Loads the first .vimrc it finds
"
" g:custom_vimrc    The path of the vimrc loaded
"
" case: define and run LoadCustomVim exactly once.
" Need to check this explicitly, especially with neovim.
if !exists("*LoadCustomVim")
  function LoadCustomVim() 
    " case: loaded already
    if exists('g:custom_vimrc') 
      return
    endif

    let l:mod = ":h"
    let l:dir = expand("%:p" . l:mod)

    " Default vimrc.
    let myvimrc = resolve(expand("$MYVIMRC"))
    let g:custom_vimrc = ""
    "echo myvimrc
    "
    while l:dir != "/" 
      let l:file = l:dir . "/.vimrc"

      " Expand to full path
      let l:fullfile = resolve(expand(l:file))

      " Found vimrc.
      " - Ignore default vimrc.
      if filereadable(l:file) && l:fullfile != myvimrc
        "echo "Found custom vim: " . l:file
        let g:custom_vimrc=l:file
        execute "so " l:file ""
        break
      endif

      let l:mod = l:mod . ":h"
      let l:dir = expand("%:p" . l:mod)
    endwhile
  endfunction

  call LoadCustomVim()
endif
