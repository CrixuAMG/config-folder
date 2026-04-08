local M = {}

function M.setup()
    require("bento").setup({
        ui = {
            floating = {
                relative = "win", -- Position relative to active window instead of editor
                position = "middle-top", -- Position within the active pane
            },
        },
    })
end

return M
