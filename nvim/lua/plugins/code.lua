return {
    {
        'junegunn/vim-easy-align',
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                -- Open relative to window, not pinned to the far left/right
                placement_editor_edge = false,
                close_automatic_events = {
                    "unfocus",
                },
                -- open_automatic = true,
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            })
            -- You probably also want to set a keymap to toggle aerial
            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
        end
    },
    {
        'stevearc/stickybuf.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function() 
            require("stickybuf").setup()
        end
    }
}
