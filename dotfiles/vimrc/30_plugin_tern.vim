function! InitTern()
	let g:tern_request_timeout = 2
	let g:tern_show_argument_hints="on_hold"

	" Tern
	map <leader>td :TernDoc<cr>
	map <leader>td :TernDef<cr>
	map <leader>tb :TernDocBrowse<cr>
	map <leader>tpd :TernDefPreview<cr>
	map <leader>tt :TernType<cr>
	map <leader>tr :TernRefs<cr>
	map <leader>tR :TernRename<cr>
	map <leader>te :call tern#Enable()<cr>
endfunction

au FileType javascript call InitTern()
