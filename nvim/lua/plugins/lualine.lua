local M = {}

function M.setup()
    -- Choose between lualine or slimline (current config has slimline enabled)
    -- require('lualine').setup()
    
    require("slimline").setup({
        spaces = {
            components = "",
            left = "",
            right = "",
        },
        sep = {
            hide = {
                first = true,
                last = true,
            },
            left = "",
            right = "",
        },
    })
end

return M
