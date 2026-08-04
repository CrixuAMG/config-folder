return {
    {
        "OXY2DEV/helpview.nvim",
        ft = { "help", "markdown" },

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
}
