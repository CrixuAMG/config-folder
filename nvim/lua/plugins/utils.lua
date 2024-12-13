return {
    {
        "vim-scripts/copypath.vim",
        config = function()
            vim.cmd([[
            let g:copypath_copy_to_unnamed_register = 1
            ]])
        end,
    },
    {
        "OXY2DEV/helpview.nvim",
        lazy = false, -- Recommended

        -- In case you still want to lazy load
        -- ft = "help",

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "stevearc/quicker.nvim",
        config = function()
            require("quicker").setup({})
        end,
    },
    {
        "nvchad/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            timeout = 1,
            maxkeys = 5,
            position = "top-center",
        },
    },
    -- {
    --     "miversen33/sunglasses.nvim",
    --     event = "UIEnter",
    --     config = function()
    --         require("sunglasses").setup({
    --             filter_type = "SHADE",
    --             filter_percent = .65
    --         })
    --     end
    -- },
    {
        "atiladefreitas/lazyclip",
        config = function()
            require("lazyclip").setup({
                -- your custom config here (optional)
            })
        end,
        keys = {
            { "Cw", desc = "Open Clipboard Manager" },
        },
        -- Optional: Load plugin when yanking text
        event = { "TextYankPost" },
    }
}
