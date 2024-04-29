return {
    'dj95/adr-nvim',
    opts = {},
    config = function()
        require('adr').setup({})

        vim.keymap.set("n", "<leader>na", function() require('adr').create_from_template() end)
    end
}

