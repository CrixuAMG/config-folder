return {
    {
        'SirVer/ultisnips',
        event = 'VeryLazy',
        config = function()
            vim.g.UltiSnipsExpandTrigger = "<tab>"
            vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
            vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
            vim.g.UltiSnipsEditSplit = "vertical"
        end,
        keys = {"<tab>", "<c-b>", "<c-z>"}
    },
    {
        'honza/vim-snippets',
        after = 'SirVer/ultisnips'
    }
}
