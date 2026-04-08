local M = {}

function M.setup()
    require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text          = true,
            virt_text_pos      = 'eol',
            delay              = 100,
            ignore_whitespace  = false,
            virt_text_priority = 100,
            use_focus          = true,
        },
    })

    vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', {
        desc = 'Preview hunk'
    })
end

return M
