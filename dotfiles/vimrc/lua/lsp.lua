-- ====== Base ======
-- trace, debug, info, warn, error
vim.lsp.set_log_level("warn")


-- ====== LSP default keybindings + settings ======
--
-- See: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
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


---- ====== LSP language settings ======
--
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local nvim_lsp = require('lspconfig')

-- note: global yt_lsp_server_settings
-- To allow it to be overwritten in a local vimrc
yt_lsp_server_settings = {
   -- Home: https://github.com/haskell/haskell-language-server
   -- Installation
   --  $ brew install haskell-language-server
   hls = { filetypes={"haskell", "lhaskell" } },

   -- Home: https://github.com/facebook/flow
   -- Installation
   --  $ npm install -g flow-bin
   flow = { filetypes={"javascript"} }, 

   -- Home: https://github.com/mads-hartmann/bash-language-server
   -- Installation
   --  $ npm install -g bash-language-server
   bashls = { filetypes={"sh"} },

   -- Home: https://github.com/hrsh7th/vscode-langservers-extracted
   -- Installation
   --  $ npm install -g vscode-langservers-extracted
   jsonls = { filetypes={"json"} },

   -- Home: https://github.com/hrsh7th/vscode-langservers-extracted
   -- Installation
   --  $ npm install -g vim-language-server
   vimls = { filetypes={"vim"} },

   -- Home: https://github.com/theia-ide/typescript-language-server
   -- Installation
   --  $ npm install -g typescript-language-server
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
