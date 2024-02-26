return {
    'vague2k/huez.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim'
    },
    opts = {
        picker = 'telescope'
    },
    config = function()
        require('huez').setup({})

        local colorscheme = require('huez.api').get_colorscheme()
        vim.cmd("colorscheme " .. colorscheme)

        vim.keymap.set("n", "<leader>co", "<cmd>Huez<CR>", {})
    end
}

