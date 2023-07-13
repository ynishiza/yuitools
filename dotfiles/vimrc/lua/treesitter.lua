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
    "markdown",
    "json",
    "html",
    "python",
    "regex",
    "vim",
    -- "haskell",     NOT working. Error like: https://github.com/nvim-treesitter/nvim-treesitter/issues/626
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

-- Fold: use treesitter to fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
