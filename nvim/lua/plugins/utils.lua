return {
    {
        'vim-scripts/copypath.vim',
        config = function()
            vim.cmd([[
            let g:copypath_copy_to_unnamed_register = 1
            ]])
        end
    }
}
