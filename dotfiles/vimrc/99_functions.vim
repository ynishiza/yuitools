" DiffN(n)
" diff n buffers
function! DiffN(n) abort
	let l:time = substitute(system("date +%s"), "\n", "", "")
	for i in range(a:n)
		if i != 0
			vsplit
		endif
		let l:name = "diff_" . l:time . "_" . i . ""
		call DiffNew(l:name)
	endfor
endfunction

function! DiffNew(buffer_name) abort
	execute "badd " . a:buffer_name
	execute "buffer " . a:buffer_name
	setlocal buftype=nofile
	setlocal bufhidden=hide
	diffthis
endfunction

command! -nargs=1 DiffNew call DiffNew(<q-args>)
command! -nargs=1 DiffN call DiffN(<args>)
command! -nargs=0 DiffTwo call DiffN(2)
