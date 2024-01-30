return {
    "CrixuAMG/bento.nvim",
    config = function()
        require("bento").setup({
            ui = {
                floating = {
                    relative = "win", -- Position relative to active window instead of editor
                    position = "middle-top", -- Position within the active pane
                },
            },
        })
    end,
}

