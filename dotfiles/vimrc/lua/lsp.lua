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
  buf_set_keymap('n', '<leader><leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- mapping: workspace
  buf_set_keymap('n', '<leader><leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>ws', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- mapping: code manipulation
  buf_set_keymap('n', '<leader><leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>C', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- mapping : diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
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
   hls = {
    filetypes={"haskell", "lhaskell" },
    cmd={ "haskell-language-server-wrapper", "--logfile", "/tmp/hls.log", "--lsp" },
    root_dir = function (filepath)
      return (
        nvim_lsp.util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
        or nvim_lsp.util.root_pattern('*.cabal', 'package.yaml')(filepath)
      )
    end,
    settings = {
      haskell = {
        formattingProvider = "ormolu"
      }
    }
   },

   -- Home: https://github.com/hrsh7th/vscode-langservers-extracted
   -- Installation
   --  $ npm install -g vscode-langservers-extracted
   cssls = { filetypes={ "css", "scss" } },

   -- Home: https://github.com/hrsh7th/vscode-langservers-extracted
   -- Installation
   --  $ npm install -g vscode-langservers-extracted
   html = { filetypes={ "html" } },

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
  },

  -- Home: https://github.com/apple/sourcekit-lsp
  -- LSP for Swift
  -- Installation
  --    NA. Already installed for macos.
  sourcekit = {
    cmd = { "sourcekit-lsp", "--log-level", "debug" },
    root_pattern = nvim_lsp.util.root_pattern("Package.swift", ".git")
  }
}

-- note: nvim_cmp capabilities
-- See: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- note: global function for updating LSP settings
-- e.g. set custom settings in a project.
yt_lsp_update_settings = function(name, settings)
  settings.capabilities = capabilities
  settings.autostart = true
  settings.on_attach = yt_lsp_default_bindings
  settings.flags = {
    debounce_text_changes = 150
  }
  nvim_lsp[name].setup(settings)
end

for name, settings in pairs(yt_lsp_server_settings) do
  yt_lsp_update_settings(name, settings)
end
