return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
            shortcut_type = "number",
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
