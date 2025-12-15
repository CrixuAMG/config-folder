return {
    {
        'nvim-lualine/lualine.nvim',
        enabled = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
            require('lualine').setup()
        end
    },
    {
        "sschleemilch/slimline.nvim",
        opts = {
            spaces = {
                components = "",
                left = "",
                right = "",
            },
            sep = {
                hide = {
                    first = true,
                    last = true,
                },
                left = "",
                right = "",
            },
        }
    },
}
