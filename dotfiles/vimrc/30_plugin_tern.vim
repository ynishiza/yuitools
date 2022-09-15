function! YT_InitTern()
  let g:tern_request_timeout = 2
  let g:tern_show_argument_hints="on_hold"

  " Tern
  map <leader>Td :TernDoc<cr>
  map <leader>Td :TernDef<cr>
  map <leader>Tb :TernDocBrowse<cr>
  map <leader>Tpd :TernDefPreview<cr>
  map <leader>Tt :TernType<cr>
  map <leader>Tr :TernRefs<cr>
  map <leader>TR :TernRename<cr>
  map <leader>TE :call tern#Enable()<cr>
  map <leader>TD :call tern#Disable()<cr>
endfunction

au FileType javascript call YT_InitTern()
