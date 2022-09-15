"" utils
lua <<EOF
-- Reference: https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
table.copy = function(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end
EOF

"" config: nvim-treesitter
"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = "maintained",
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "css",
    "javascript",
    "typescript",
    "json",
    "html",
    "python",
    "regex",
    "vim"
  },
  -- List of parsers to ignore installing
  ignore_install = {},

  -- highlight module
  highlight = {
    enable = true,
    -- enable = false,

    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Incremental selection module
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>S",
      node_incremental = "J",     -- up
      node_decremental = "K",     -- down
      scope_incremental = "U",    -- parent
    }
  },

  -- Indent module
  indent = {
    -- note: disable for now since indent is still experimental and behaves weird sometimes.
    -- See: https://github.com/nvim-treesitter/nvim-treesitter#indentation
    enable = false,
    disable = { }
  }
}
EOF


" config: twilight (treesitter plugin)
"
lua <<EOF
require("twilight").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
}
EOF

" config: trouble (LSP plugin)
lua <<EOF
require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

EOF


" config: nvim-cmp (completion plugin)
" Set keybindings
lua <<EOF
-- Completion settings
local luasnip = require'luasnip'
local cmp = require'cmp'

-- see: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-c>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    --{ name = 'vsnip', max_item_count = 0 },
    { name = 'nvim_lsp', max_item_count = 10 },
    { name = 'treesitter', max_item_count = 10 },
    { name = 'buffer', max_item_count = 10 },
    { name = 'path', max_item_count = 10 },
    { name = 'luasnip' },
  }
})
EOF


" config:  LSP 
"
lua <<EOF
-- trace, debug, info, warn, error
vim.lsp.set_log_level("warn")
EOF

" LSP default keybindings + settings
" See: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
lua <<EOF
local nvim_lsp = require('lspconfig')    

-- Initialization:
-- Set buffer settings
-- e.g. set omnifunc for completion
-- e.g. define key mappings to lsp functions
yt_lsp_default_bindings = function(client, bufnr)    
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end    
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end    

  -- note: indicator 
  -- exists('yt_lspconfig') to check if initialized
  vim.api.nvim_buf_set_var(bufnr, 'yt_lspconfig', 1)

  -- note: completion
  -- i.e. manually triggered by <c-x><c-o>    
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')    

  -- note: mappings
  local opts = { noremap=true, silent=true }    
  buf_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)    
  buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)    
  buf_set_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)    
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)    
  buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)    
  buf_set_keymap('n', '<leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)    
  buf_set_keymap('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)    
  buf_set_keymap('n', '<leader>gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)    
  buf_set_keymap('n', '<leader>gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)    
  buf_set_keymap('n', '<leader>gws', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)    
  buf_set_keymap('n', '<leader>grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)    
  buf_set_keymap('n', '<leader>gca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)    
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)    
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)    
  buf_set_keymap('n', '<leader>gel', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)    
  buf_set_keymap('n', '<leader>ges', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)    
  buf_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)    

end    
EOF


" LSP language settings
" See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lua<<EOF
local nvim_lsp = require('lspconfig')    

-- note: global yt_lsp_server_settings
-- To allow it to be overwritten in a local vimrc
yt_lsp_server_settings = { 
  flow = { filetypes={"javascript"} },
   bashls = { filetypes={"sh"} },
   jsonls = { filetypes={"json"} },
   vimls = { filetypes={"vim"} },
   tsserver = { 
     filetypes={"typescript","typescriptreact","typescript.tsx"},
     cmd = { "typescript-language-server", "--stdio", "--log-level", "4", "--tsserver-log-file", "/tmp/tsserver.txt" },
  }
}    

-- note: nvim_cmp capabilities
-- See: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for name, settings in pairs(yt_lsp_server_settings) do    
  settings.capabilities = capabilities
  settings.autostart = true
  settings.on_attach = yt_lsp_default_bindings
  settings.flags = {
    debounce_text_changes = 150
  }
  nvim_lsp[name].setup(settings)
end    
EOF

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
