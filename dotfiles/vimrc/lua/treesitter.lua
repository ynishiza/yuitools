-- ========== Start v0.9.3 configs ==========
-- require'nvim-treesitter.configs'.setup {
--   -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   -- ensure_installed = "maintained",
--   ensure_installed = {
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

--   -- List of parsers to ignore installing
--   ignore_install = {},

--   -- highlight module
--   highlight = {
--     enable = true,
--     -- enable = false,

--     -- list of language that will be disabled
--     --
--     -- default
--     -- disable = { "c", "rust" },
--     disable = function(lang, bufnr)
--         if lang == "go" then
--           -- Commenting object blocks in a large file is slow.
--           return vim.api.nvim_buf_line_count(bufnr) > 10000
--         end
--         return false
--     end,

--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },

--   -- Incremental selection module
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<leader>S",
--       node_incremental = "J",     -- up
--       node_decremental = "K",     -- down
--       scope_incremental = "U",    -- parent
--     }
--   },

--   -- Indent module
--   indent = {
--     -- note: disable for now since indent is still experimental and behaves weird sometimes.
--     -- See: https://github.com/nvim-treesitter/nvim-treesitter#indentation
--     enable = false,
--     disable = { }
--   }

-- }

-- Fold: use treesitter to fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--
-- ========== END v0.9.3 configs ==========

-- v0.10 configs
--
local ts = require('nvim-treesitter')
ts.install(
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = "maintained",
  {
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
  -- Do not print summary, as this will run at startup always, all the time.
  { summary = false }
):wait(30000)

-- Reference: https://minerva.mamansoft.net/Notes/%F0%9F%93%9Dnvim-treesitter%E3%82%92main%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B%E3%81%A8%E8%B5%B7%E5%8B%95%E6%99%82%E3%81%AB%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%AB%E3%81%AA%E3%82%8B
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('ui.treesitter', { clear = true }),
  pattern = "*",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

