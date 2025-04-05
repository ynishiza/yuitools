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
--
-- See editor.lua for default highlights
-- https://github.com/craftzdog/solarized-osaka.nvim/blob/main/lua/solarized-osaka/groups/editor.lua
require("solarized-osaka").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings

  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  --
  -- Available colors: https://github.com/craftzdog/solarized-osaka.nvim/blob/main/lua/solarized-osaka/colors.lua
  -- Available highlights: https://github.com/craftzdog/solarized-osaka.nvim/tree/main/lua/solarized-osaka/groups
  --
  -- e.g. in editor.lua
  --
  --       highlights.diffAdded = { fg = colors.green500 },
  --
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    -- editor.lua: https://github.com/craftzdog/solarized-osaka.nvim/blob/main/lua/solarized-osaka/groups/editor.lua
    highlights.Visual = {
      -- NOTE: original is colors.base02
      -- Hard to see with solarized dark
      bg = colors.base1
    }
  end,
}
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
