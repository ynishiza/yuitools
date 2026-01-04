-- ========== Start v0.9.3 configs ==========
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = "maintained",
  ensure_installed = {
    "vimdoc",
    "luadoc",
    "lua",
    "bash",
    "c",
    "comment",
    "css",
    "go",
    "gomod",
    "gosum",
    "javascript",
    "typescript",
    "markdown",
    "json",
    "html",
    "python",
    "regex",
    "vim",

    -- Known issue
    -- May produce errors like: https://github.com/nvim-treesitter/nvim-treesitter/issues/626
    "haskell"
  },

  -- List of parsers to ignore installing
  ignore_install = {},

  -- highlight module
  highlight = {
    enable = true,
    -- enable = false,

    -- list of language that will be disabled
    --
    -- default
    -- disable = { "c", "rust" },
    disable = function(lang, bufnr)
        if lang == "go" then
          -- Commenting object blocks in a large file is slow.
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end
        return false
    end,

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

-- Fold: use treesitter to fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--
-- ========== END v0.9.3 configs ==========

-- v0.10 configs
--
-- 2026/01 NOT WORKING CURRENTLY
--
-- local ts = require('nvim-treesitter')
-- ts.install(
--   -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   -- ensure_installed = "maintained",
--   {
--     "vimdoc",
--     "luadoc",
--     "lua",
--     "bash",
--     "c",
--     "comment",
--     "css",
--     "go",
--     "gomod",
--     "gosum",
--     "javascript",
--     "typescript",
--     "markdown",
--     "json",
--     "html",
--     "python",
--     "regex",
--     "vim",

--     -- Known issue
--     -- May produce errors like: https://github.com/nvim-treesitter/nvim-treesitter/issues/626
--     "haskell"
--   },
--   -- Do not print summary, as this will run at startup always, all the time.
--   { summary = false }
-- ):wait(30000)

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo[0][0].foldmethod = 'expr'

-- -- TODO: not working
-- vim.api.nvim_create_autocmd('FileType', {
--   group = vim.api.nvim_create_augroup('ui.treesitter', { clear = true }),
--   pattern = {
--     "vimdoc",
--     "luadoc",
--     "lua",
--     "bash",
--     "sh",
--     "c",
--     "comment",
--     "css",
--     "go",
--     "gomod",
--     "gosum",
--     "javascript",
--     "typescript",
--     "markdown",
--     "json",
--     "html",
--     "python",
--     "regex",
--     "vim",
--     "haskell"
--   },
--   callback = function()
--     print("hello")
--     -- syntax highlighting, provided by Neovim
--     -- vim.treesitter.start()

--     -- folds, provided by Neovim
--     vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--     vim.wo.foldmethod = 'expr'
--     vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--     vim.wo[0][0].foldmethod = 'expr'
--     -- indentation, provided by nvim-treesitter
--     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   end,
-- })

-- Fold: use treesitter to fold
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo[0][0].foldmethod = 'expr'
--

