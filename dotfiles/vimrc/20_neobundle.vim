if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

function _BundleInstalled(name)
	return !empty(glob('~/.vim/bundle/' . a:name))
endfunction

" Check: Is neobundle installed?
if !empty(glob('~/.vim/bundle/'))


	call neobundle#begin(expand('~/.vim/bundle/'))

	" Plugins
	NeoBundleFetch "Shougo/neobundle.vim"

	"
	" Commentary
	"
	NeoBundle 'tpope/vim-commentary'


	"
	" emmet: HTML plugin
	"
	NeoBundle 'mattn/emmet-vim'

	"
	" syntactic
	"
	" - see vimrc_syntastic for settings.
	NeoBundle 'scrooloose/syntastic'

	"
	" Nvim-R: R plugin. Provides omnicompletion
	"
	NeoBundle 'jalvesaq/Nvim-R'
	function! _initNvimR()
		" omnicomplete: show the arguments of a function.
		let R_show_args = 1
	endfunction
	au Filetype r call _initNvimR()


	"
	" lintr: Lint R
	"
	NeoBundle 'jimhester/lintr'
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
 

	"
	" solarized
	"
	NeoBundle "altercation/vim-colors-solarized"
	function! _EnableSolarizedForiTerm2()
		if !_BundleInstalled('vim-colors-solarized') 
			return
		endif
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


	"
	" TypeScript Syntax file
	"
	"NeoBundle 'leafgarland/typescript-vim'


	"
	" vdebug: debug plugin for PHP's XDebugger
	"
	NeoBundle 'joonty/vdebug'


	"
	" ternjs: syntax completion for JavaScript.
	"
	NeoBundle 'ternjs/tern_for_vim',
		\ { 'build' : { 'others': 'npm install' } }
	let g:tern_show_argument_hints="on_hold"
	function! InitTern()
		" Tern
		map <leader>td :TernDoc<cr>
		map <leader>td :TernDef<cr>
		map <leader>tb :TernDocBrowse<cr>
		map <leader>tpd :TernDefPreview<cr>
		map <leader>tt :TernType<cr>
		map <leader>tr :TernRefs<cr>
		map <leader>tR :TernRename<cr>
	endfunction
	au FileType javascript call InitTern()


	"
	" javascript-indenter: more smart indenting of JavaScript
	"
	" - Need when indents are spaces.
	" - brief mode: minimal indenting.
	NeoBundle 'jiangmiao/simple-javascript-indenter'
	let g:SimpleJsIndenter_BriefMode = 1


	"
	" neco-ghc: omnicomplete for haskell
	"
	" not working?
	NeoBundle 'eagletmt/neco-ghc'
	au FileType haskell setlocal omnifunc=necoghc#omnifunc

	"
	NeoBundle 'lukerandall/haskellmode-vim'
	let g:haddock_browser="abc"

	""""""""""""""""""""""""""" Disabled """""""""""""""""""""""""""

	"NeoBundle 'majutsushi/tagbar'

	" airline:
	NeoBundle 'bling/vim-airline'
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

	" Color status bar:
	" Doesn't work well with Mac.
	"NeoBundle 'itchyny/lightline.vim'

	" JavaScript syntax file.
	" NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
	" au FileType javascript call JavaScriptFold()
	" au FileType javascript set foldmethod=syntax

	"
	filetype plugin indent on

	call neobundle#end()

	NeoBundleCheck

endif