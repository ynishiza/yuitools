"
" LoadCustomVim : 
"
" Starts from the current directory and traverses up the directory.
" Loads the first .vimrc it finds
"
" g:custom_vimrc 		The path of the vimrc loaded
"
function! LoadCustomVim() 
	let mod = ":h"
	let dir = expand("%:p" . mod)

	" Default vimrc.
	let myvimrc = resolve(expand("$MYVIMRC"))
	"echo myvimrc
	"
	while dir != "/" 
		let file = dir . "/.vimrc"

		" Expand to full path
		let fullfile = resolve(expand(file))

		" Found vimrc.
		" - Ignore default vimrc.
		if filereadable(file) && fullfile != myvimrc
			"echo "Found custom vim: " . file
			let g:custom_vimrc=file
			execute "so " file ""
			break
		endif

		let mod = mod . ":h"
		let dir = expand("%:p" . mod)
	endwhile
endfunction

call LoadCustomVim()
