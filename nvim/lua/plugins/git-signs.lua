return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()

        vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', {
            desc = 'Preview hunk'
        })
    end,
}
