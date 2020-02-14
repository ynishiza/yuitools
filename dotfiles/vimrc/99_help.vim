function! PrintMyHelp()
  if has("nvim")
    let l:nvim = "yes"
  else
    let l:nvim = "no"
  endif

  echo "version: " . v:version . "\n"
  echo "nvim?: " . l:nvim . "\n\n"

  echo "\n
\ Helps:\n
\:help 'tabstop'		Option help\n
\:help :retab		Command help\n
\:help abs()		Function help\n
\:help CTRL-R		Mapping help\n
\:help i_CTRL-R		Mapping help by mode\n
\\n
\ Mappings:\n
\ === General ===\n
\ <space>?    Print this help\n
\ <space>ra   Reload $MYVIMRC\n
\ <space>r.   Reload current vim script file\n
\ <space>d    Redraw\n
\ <space>h    History\n
\ <space>.    Repeat last command\n
\ <c-k>     Escape
\ \n
\ === Windows ===\n
\ <space>s    Save\n
\ <c-s>     Save\n
\ <space>w    Close window/tab\n
\ <space>q    Quit\n
\ <space>Q    Force quit\n
\ === Tabs ===\n
\ <space>tn   Create new tab\n
\ <space>t%   Open current window in new tab\n
\ <space>tq   Close tab\n
\ \n
\ === Buffers ===\n
\ <space>bo   Open buffer\n
\ <space>ba   Add buffer\n
\ <space>bd   Delete buffer\n
\ <space>bs   List buffers\n
\ <space>bS   List buffers\n
\ <space>bn   Next buffer\n
\ <space>bp   Previous buffer\n
\ <space>bf   First buffer\n
\ <space>bl   Last buffer\n
\ \n
\ === Location list ===\n
\ e.g. linter errors \n
\ <space>lw   Open location window (:lwindow)\n
\ <space>lc   Close location window (:lclose)\n
\ <space>ll   Current location (:ll)\n
\ <space>ln   Next location (:lnext)\n
\ <space>lp   Previous location (:lprevious)\n
\ \n
\ === Quickfix list ===\n
\ e.g. grep results \n
\ <space>cw   Open quickfix list window (:cwindow)\n
\ <space>cc   Close quickfix list window (:close)\n
\ <space>cl   Current quickfix (:clist)\n
\ <space>cn   Next quickfix (:cnext)\n
\ <space>cp   Previous quickfix (:cprevious)\n
\ \n
\ === Search ===\n
\ <space>f/   Search term under cursor\n
\ <space>ff   Reset search highlight\n
\ <space>fs   Search and replace term under cursor\n
\ <space>fg   Grep term under cursor\n
\ \n
\ === Clipboard ===\n
\ <space>c    Copy visual selection to clipboard\n
\ <space>v    Paste clipboard after cursor\n
\ <space>V    Paste clipboard under cursor\n
\ \n
\ === Extensions ===\n
\ gc          Toggle comments on visual selection (vim-commentary)\n
\ \n
\ <leader>fz  FZF (fzf)\n
\ <leader>n   Toggle NERDTree (nerdtree)\n
\ <F8>        Toggle Taglist (Taglist)\n
\ <F9>        Toggle Undotree (undotree)\n
\ \n
\ <leader>tm  Toggle table mode (vim-table-mode)\n
\ <leader>T   Tableize with delimiter (vim-table-mode)\n
\ \n
\ <leader>tE  tern enable \n
\ <leader>tD  tern disable \n
\ \n
\ :SyntasticDebugEnable     Enable debug. Use :messages to see messages.\n
\ :SyntasticDebugDisable    Disable debug\n
\ :call SyntasticDebugSetLevel(1) \n
\ \n
\ \n
\ Commands:\n
\ :Asciitable\n
\ :DiffTwo						Open two diff buffers.\n
\ :DiffN						Open N diff buffers.\n
\ :DiffNew PATH				  	Open a new diff buffer in current panel.\n
\ :RemoveTrailingWhitespace\n
\ :EditWithTabs N\n
\ :EditWithSpaces N\n
\ :ArgSubstitute PATTERN NEW      Search for PATTERN and replace with NEW in args files. See :args.\n
\ :ArgRename OLD NEW              Search and rename OLD with NEW in args files. See :args.\n
\ :CSubstitute PATTERN NEW        Search for PATTERN and replace with NEW in quickfix list. See :cw.\n
\ :CRename OLD NEW                Search and rename OLD with NEW in quickfix list. See :cw.\n
\ "
endfunction

command! -nargs=0 PrintHelp call PrintMyHelp()
map <leader>? :call PrintMyHelp()<cr>
