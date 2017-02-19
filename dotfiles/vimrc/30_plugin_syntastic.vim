"
if !empty(glob('~/.vim/bundle/syntastic'))
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	" Loc: location-list
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_loc_list_height = 5

	" note: don't automatically populate location list.
	" Conflicts with vimgrep
	"let g:syntastic_check_on_open = 1
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_wq = 0

	nmap <leader>e :Errors<cr>
	nmap <leader>n :lnext<cr>

	" note: disabled custom symbols.
	" Error if symbol not available?
	" let g:syntastic_error_symbol = "✗"
	" let g:syntastic_warning_symbol = "⚠"
	let g:syntastic_error_symbol = "x"
	let g:syntastic_warning_symbol = "w"

	" Default checkers
	" let g:syntastic_python_checkers = ["pyflakes", "pep8", "flake8"]
	let g:syntastic_python_checkers = ["flake8"]
	let g:syntastic_javascript_checkers = ["jshint", "eslint"]
	let g:syntastic_r_checkers = ["lintr"]

	function! JSDisableSyntastic()
		let g:syntastic_javascript_checkers = []
	endfunction
	function! JSEnableJshint()
		let g:syntastic_javascript_checkers = ["jshint"]
	endfunction
	function! JSEnableEslint()
		let g:syntastic_javascript_checkers = ["eslint"]
	endfunction
endif
