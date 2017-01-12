if neobundle#is_installed('Nvim-R')
	function! _initNvimR()
		" omnicomplete: show the arguments of a function.
		let R_show_args = 1
	endfunction
	au Filetype r call _initNvimR()
endif


if neobundle#is_installed('lintr')
	function! _InitLintr()
		" note: check only passively, since lintr is a bit slow.
"		SyntasticToggleMode
"		nmap <leader>e :SyntasticCheck<cr>:Errors<cr>
		let g:syntastic_enable_r_lintr_checker = 1

		" note: 
		" object_usage_inter disabled. Complains about variables outside of scope.
		" let g:syntastic_r_lintr_linters = "with_defaults(camel_case_linter = NULL, object_usage_linter = NULL,  line_length_linter(120))"
	endfunction
	call _InitLintr()
endif


if neobundle#is_installed('simple-javascript-indenter')
	let g:SimpleJsIndenter_BriefMode = 1
endif


if neobundle#is_installed('vim-colors-solarized')
	function! _EnableSolarizedForiTerm2()
"		set t_Co=256
"		let g:solarized_term_colors=256
"
		set background=dark
		let g:solarized_visibility = "high"
		let g:solarized_contrast = "high"
		colorscheme solarized
	endfunction
	" On Mac, use the terminal's color
	au VimEnter * call _EnableSolarizedForiTerm2()
endif


if neobundle#is_installed('vim-airline')
	" Off for now until configured properly
	function! _EnableAirline()
		"set guifont=Droid_Sans_Mono_for_Powerline:h10
		"let g:airline_powerline_fonts = 1
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif

		" unicode symbols
		let g:airline_left_sep = '»'
		let g:airline_left_sep = '▶'
		let g:airline_right_sep = '«'
		let g:airline_right_sep = '◀'
		let g:airline_symbols.linenr = '␊'
		let g:airline_symbols.linenr = '␤'
		let g:airline_symbols.linenr = '¶'
		let g:airline_symbols.branch = '⎇'
		let g:airline_symbols.paste = 'ρ'
		let g:airline_symbols.paste = 'Þ'
		let g:airline_symbols.paste = '∥'
		let g:airline_symbols.whitespace ='Ξ'

		" See ~/.vim/bundle/vim-airline/autoload/airline/themes
		" For some reason,
		"
		AirlineTheme hybrid
		AirlineRefresh
	endfunction
"	autocmd VimEnter * AirlineToggle
"	autocmd VimEnter * call _EnableAirline()
endif
