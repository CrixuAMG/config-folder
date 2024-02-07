return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
            config = {
                week_header = {
                    enable = true
                },
                shortcut = {
                    { desc = '[  Christian Kaal]', group = 'DashboardShortCut' },
                }
            }
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
