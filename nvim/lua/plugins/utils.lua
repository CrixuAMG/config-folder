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
            position = "top-right",
        },
        config = function(_, opts)
            require("showkeys").setup(opts)

            -- Open showkeys on startup
            vim.schedule(function()
                require("showkeys").open()
            end)
        end
    },
    {
        "miversen33/sunglasses.nvim",
        event = "UIEnter",
        config = function()
            require("sunglasses").setup({
                filter_type = "SHADE",
                filter_percent = .15
            })
        end
    },
}
