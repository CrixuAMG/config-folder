
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    -- Key mappings
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
    vim.keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { silent = true })
  end,
}
