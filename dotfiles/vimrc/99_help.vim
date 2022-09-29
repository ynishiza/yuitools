function! YT_PrintMyHelp()
  " doc: state
  let l:state = [
        \"version: " . v:version,
        \"nvim?: " . (has("nvim") ? "yes" : "no"),
        \"log enabled: " . (g:yt_log_enabled ? "yes" : "no"),
        \"log path: " . g:yt_logpath,
        \]

  let l:text = readfile(g:yt_vimrc_path . "/text_YT_PrintMyHelp")
  echo join(l:state, "\n")
  echo join(l:text, "\n")


  " case: neovim only features
  if has('nvim')
    call input("\nHit enter to show neovim only help")
    " Clear window
    redraw
    let l:text = readfile(g:yt_vimrc_path . "/text_YT_PrintMyHelpNeovim")
    echon join(l:text, "\n")
  endif
endfunction

function! YT_PrintMyCheatsheet()
  let l:text = readfile(g:yt_vimrc_path . "/text_YT_PrintMyCheatsheet")
  echo join(l:text, "\n")
endfunction

command! -nargs=0 YTPrintMyHelp call YT_PrintMyHelp()
map <leader>? :call YT_PrintMyHelp()<cr>
map <leader>/ :call YT_PrintMyCheatsheet()<cr>
