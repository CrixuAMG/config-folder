return {
    'dj95/adr-nvim',
    opts = {},
    config = function()
        require('adr').setup({
            doc_dir = "/doc/adr",
        })

        vim.keymap.set("n", "<leader>na", function() require('adr').create_from_template() end)
    end
}
