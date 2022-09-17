let s:scriptpath=resolve(expand("<sfile>:p"))
let s:scriptdir=fnamemodify(s:scriptpath, ":h")
"" utils
exec "luafile " . s:scriptdir . "/lua/utils.lua"

"" config: nvim-treesitter
exec "luafile " . s:scriptdir . "/lua/treesitter.lua"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


" config: twilight (treesitter plugin)
exec "luafile " . s:scriptdir . "/lua/twilight.lua"

" config: trouble (LSP plugin)
exec "luafile " . s:scriptdir . "/lua/trouble.lua"


" config: nvim-cmp (completion plugin)
exec "luafile " . s:scriptdir . "/lua/nvim-cmp.lua"


" config:  LSP 
exec "luafile " . s:scriptdir . "/lua/lsp.lua"

function! YT_LspRestart() 
  LspStop
  call YT_BufferGarbageCollect()
  LspStart
endfunction
map <leader>gR :call YT_LspRestart()<cr>
command! -nargs=0 YTLspConfigured echo (exists('b:yt_lspconfig') ? 'attached' : 'not attached')
command! -nargs=0 YTLspGetLogPath lua vim.cmd('echo "'..vim.lsp.get_log_path()..'"')
command! -nargs=0 YTLspShowLogs lua vim.cmd('tabedit'..vim.lsp.get_log_path()) 

map <leader>LI :LspInfo<CR>
