return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { "abeldekat/harpoonline", version = "*" },
--        'ThePrimeagen/harpoon',
    },
    config = function()
        -- local Harpoonline = require("harpoonline").setup() -- using default config
        -- local lualine_c = { Harpoonline.format, "filename" }
        local lazy_status = require("lazy.status")

        require('lualine').setup({
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" }
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                }
            }
            -- sections = {
            --     lualine_c = lualine_c
            -- }
        })

--        vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file, {})
    end
}
