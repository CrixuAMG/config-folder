return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { "abeldekat/harpoonline", version = "*" },
    },
    config = function()
        local Harpoonline = require("harpoonline").setup() -- using default config
        local lualine_c = { Harpoonline.format, "filename" }
        require('lualine').setup({
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_c = lualine_c
            }
        })
    end
}
