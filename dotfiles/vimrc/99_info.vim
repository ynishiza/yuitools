function! YT_PrintMyInfo()
  " doc: state
  let l:state = [
        \"version: " . v:version,
        \"nvim?: " . (has("nvim") ? "yes" : "no"),
        \"cwd: " . getcwd(),
        \"log enabled: " . (g:yt_log_enabled ? "yes" : "no"),
        \"log path: " . g:yt_logpath,
        \"custom vimrc: " . (exists("g:yt_custom_vimrc") && g:yt_custom_vimrc != "" ? g:yt_custom_vimrc : "NA"),
        \"omnifunc: " . &omnifunc,
        \"",
        \"File:",
        \"filetype: " . &filetype,
        \"fileformat: " . &fileformat,
        \"encoding: " . &encoding,
        \"indenting: " . (&expandtab ? 'space' : 'tab') . ", " . &shiftwidth . " units",
        \"foldenabled: " . (&foldenable == 1 ? 'yes' : 'no'),
        \"foldmethod: " . &foldmethod,
        \]
  
  echo join(l:state, "\n")
  if g:yt_is_nvim
    echo "\n"
    if input(":checkhealth? (y/n)") == "y"
      checkhealth
    endif
  endif
endfunction

command! -nargs=0 YTPrintMyInfo call YT_PrintMyInfo()
map <leader>! :call YT_PrintMyInfo()<cr>
