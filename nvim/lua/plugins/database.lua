return {
    {
        'tpope/vim-dadbod',
        event = 'VeryLazy'
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        after = 'tpope/vim-dadbod',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1

            vim.keymap.set("n", '<leader>db', ':DBUI<CR>', { desc = 'Open Database' })
        end
    },
    {
        'napisani/nvim-dadbod-bg',
        after = 'tpope/vim-dadbod',
        build = './install.sh',
        -- (optional) the default port is 4546
        -- (optional) the log file will be created in the system's temp directory
        -- config = function()
        --     vim.cmd([[
        --         let g:nvim_dadbod_bg_port = '4546'
        --         leg g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
        --     ]])
        -- end
    }
}
