return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup{}

        vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', {
            desc = 'Close all other buffers'
        })
        vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', {
            desc = 'Pick buffer to jump to'
        })
        vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', {
            desc = 'Pick buffer to close'
        })

        -- Move buffers
        vim.keymap.set('n', '<leader>bl', ':BufferLineMoveNext<CR>', {
            desc = 'Move buffer right'
        })
        vim.keymap.set('n', '<leader>bh', ':BufferLineMovePrev<CR>', {
            desc = 'Move buffer left'
        })

        -- Quick navigation
        vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', {
            desc = 'Next buffer'
        })
        vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', {
            desc = 'Previous buffer'
        })

        -- Sort buffers
        vim.keymap.set('n', '<leader>bd', ':BufferLineSortByDirectory<CR>', {
            desc = 'Sort buffers by directory'
        })
        vim.keymap.set('n', '<leader>bL', ':BufferLineSortByExtension<CR>', {
            desc = 'Sort buffers by language'
        })
    end
}
