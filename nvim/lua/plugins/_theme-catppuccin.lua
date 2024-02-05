return {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        enabled = false,
        config = function()
                require('catppuccin').setup({
                        integrations = {
                                cmp = true,
                                gitsigns = true,
                                nvimtree = true,
                                treesitter = true,
                                notify = true,
                                markdown = true,
                                dashboard = true,
                                mini = {
                                        enabled = true,
                                        indentscope_color = "",
                                },
                        }
                })

                vim.cmd.colorscheme "catppuccin"
        end
}