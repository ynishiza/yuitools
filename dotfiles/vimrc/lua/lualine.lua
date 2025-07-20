-- config: lualine
--
-- See https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = 'auto',
    -- theme = 'ayu_mirage',
    -- theme = 'ayu_dark',
    theme = 'solarized_light',
    -- theme = 'ayu_light',
    -- theme = 'iceberg_light',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    -- See 'help statusline'
    --
    -- '%F'  full path
    lualine_a = {'mode'},
    -- lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_b = {'encoding', 'fileformat', 'filetype'},
    lualine_c = {'%F'},
    lualine_x = {'searchcount', 'selectioncount'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'%F'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
