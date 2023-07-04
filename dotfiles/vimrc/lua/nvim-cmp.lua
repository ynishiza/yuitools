---- Set keybindings
--
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
    { name = 'nvim_lsp', max_item_count = 20 },
    { name = 'treesitter', max_item_count = 20 },
    { name = 'buffer', max_item_count = 20 },
    { name = 'path', max_item_count = 20 },
    { name = 'luasnip' },
  }
})
