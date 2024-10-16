return {
    {
        'vim-scripts/copypath.vim',
        config = function()
            vim.cmd([[
            let g:copypath_copy_to_unnamed_register = 1
            ]])
        end
    },
    {
        "OXY2DEV/helpview.nvim",
        lazy = false, -- Recommended

        -- In case you still want to lazy load
        -- ft = "help",

        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    }
}
