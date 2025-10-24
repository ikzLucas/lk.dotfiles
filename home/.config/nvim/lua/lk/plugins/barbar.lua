-- barbar adds a clickable tab bar similar to the one in editors such as VSCode

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- Optional, Show git status
    'nvim-tree/nvim-web-devicons', -- Optional, Show file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    insert_at_start = true,
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    local map = vim.api.nvim_set_keymap
    local keymap_opts = { noremap = true, silent = true }

    map('n', '<A-.>', '<Cmd>BufferNext<CR>', keymap_opts)
    map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', keymap_opts)

    --- Switch tabs with Ctrl + Tab and Ctrl + Shift + Tab
    --- may not work depending on terminal and/or OS support
    map('n', '<C-Tab>', '<Cmd>BufferNext<CR>', keymap_opts)
    map('n', '<C-S-Tab>', '<Cmd>BufferPrevious<CR>', keymap_opts)

    map('n', '<A-c>', '<Cmd>BufferClose<CR>', keymap_opts)
    map('n', '<A-s-c>', '<Cmd>BufferRestore<CR>', keymap_opts)
  end,
}
