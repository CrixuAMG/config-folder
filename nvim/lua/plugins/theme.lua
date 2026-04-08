local M = {}

function M.setup()
    require('catppuccin').setup({
        flavour = "mocha",
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

return M
