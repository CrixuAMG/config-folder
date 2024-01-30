return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
        local db = require("dashboard")

        db.setup({
            theme = "hyper",
            config = {
                header = {
                    "",
                    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                    "",
                },
                shortcut = {
                    {
                        desc = "  New file",
                        group = "DashboardShortCut",
                        action = "enew",
                        key = "e",
                    },
                    {
                        desc = "  Files",
                        group = "DashboardShortCut",
                        action = "Oil",
                        key = "f",
                    },
                    {
                        desc = "󰊢  Git",
                        group = "DashboardShortCut",
                        action = "lua Snacks.lazygit()",
                        key = "g",
                    },
                    {
                        desc = "󰒲  Lazy",
                        group = "DashboardShortCut",
                        action = "Lazy",
                        key = "l",
                    },
                    {
                        desc = "󰗼  Quit",
                        group = "DashboardShortCut",
                        action = "qa",
                        key = "q",
                    },
                },
                project = {
                    enable = false,
                },
                mru = {
                    limit = 8,
                    icon = " ",
                    label = " Recent Files",
                    cwd_only = false,
                },
            },
        })
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
