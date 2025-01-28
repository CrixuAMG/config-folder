return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = "frappe",
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
