return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<leader>a",
        function()
          local harpoon = require("harpoon")
          harpoon:list():add()
        end,
        desc = "Add to Harpoon",
      },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Toggle Harpoon Quick Menu",
      },
      {
        "<C-1>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(1)
        end,
        desc = "which_key_ignore",
      },
      {
        "<C-2>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(2)
        end,
        desc = "which_key_ignore",
      },
      {
        "<C-3>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(3)
        end,
        desc = "which_key_ignore",
      },
      {
        "<C-4>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(4)
        end,
        desc = "which_key_ignore",
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
}

