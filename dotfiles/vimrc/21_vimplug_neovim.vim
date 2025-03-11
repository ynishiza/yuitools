"" utils
exec "luafile " . g:yt_vimrc_path . "/lua/utils.lua"

"" config: nvim-treesitter
exec "luafile " . g:yt_vimrc_path . "/lua/treesitter.lua"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" config: nvim-cmp (completion plugin)
exec "luafile " . g:yt_vimrc_path . "/lua/nvim-cmp.lua"

" config:  LSP
exec "luafile " . g:yt_vimrc_path . "/lua/lsp.lua"

" config: firenvim
exec "luafile " . g:yt_vimrc_path . "/lua/firenvim.lua"
set guifont=Fira_Code:h14


" Inline simple configs
lua<<EOF
-- config: solarized
vim.cmd[[colorscheme solarized-osaka]]

-- config: trouble (LSP plugin)
require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

-- config: twilight (treesitter plugin)
require("twilight").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
}
EOF

function! YT_LspRestart()
  LspStop
  call YT_BufferGarbageCollect()
  LspStart
endfunction
map <leader><leader>R :call YT_LspRestart()<cr>
command! -nargs=0 YTLspConfigured echo (exists('b:yt_lspconfig') ? 'attached' : 'not attached')
command! -nargs=0 YTLspGetLogPath lua vim.cmd('echo "'..vim.lsp.get_log_path()..'"')
command! -nargs=0 YTLspGetLogLevel lua print(vim.lsp.log_levels[vim.lsp.log.get_level()])
command! -nargs=0 YTLspSetLogWarn lua vim.lsp.set_log_level(3))
command! -nargs=0 YTLspSetLogDebug lua vim.lsp.set_log_level(1))
command! -nargs=0 YTLspShowLogs lua vim.cmd('tabedit'..vim.lsp.get_log_path())

map <leader>LI :LspInfo<CR>
