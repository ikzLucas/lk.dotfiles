-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        -- If enabled, hidden files will be visible, but grayed out
        -- You can show and hide hidden files with shift + h (H)
        -- visible = true,
        show_hidden_count = true,
        -- dotfiles will be fully visible
        hide_dotfiles = false,
        hide_gitignored = true,
        -- always hide files with certain names
        hide_by_name = {
          '.git',
          '.github',
          '.DS_Store',
        },
      },
    },
  },
}
