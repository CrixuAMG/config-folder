return {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function ()
                require('lualine').setup {
                        options = {
                                -- ... your lualine config
                                theme = 'tokyonight'
                                -- ... your lualine config
                        }
                }


                vim.cmd.colorscheme "tokyonight"
        end
}
