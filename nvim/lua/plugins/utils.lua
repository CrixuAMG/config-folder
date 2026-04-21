return {
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
        "hong4rc/copy-path.nvim",
        event = "VeryLazy",
        opts = {
            keymaps = {
                relative    = "<leader>fy",     -- src/foo/Bar.tsx
                full        = "<leader>fY",     -- /home/user/project/src/foo/Bar.tsx
                filename    = "<leader>fN",     -- Bar.tsx
                line        = "<leader>fl",     -- src/foo/Bar.tsx:42
                github_line = false,     -- https://github.com/.../Bar.tsx#L42
                line_full   = false,            -- disabled by default
                stem        = false,            -- disabled by default
                extension   = false,            -- disabled by default
                dir_full    = false,            -- disabled by default
                dir_rel     = false,            -- disabled by default
                github      = false,            -- disabled by default
            },
        },
    },
}
