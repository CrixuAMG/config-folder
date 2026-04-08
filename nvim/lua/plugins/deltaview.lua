local M = {}

function M.setup()
    require("deltaview").setup({
        use_nerdfonts = false,
        show_verbose_nav = true,
    })

    vim.keymap.set("n", "<leader>dm", function()
        vim.cmd("DeltaMenu master...HEAD")
    end, { desc = "DeltaMenu compare current branch with master" })

    vim.keymap.set("n", "<leader>dv", function()
        vim.cmd("DeltaView master...HEAD")
    end, { desc = "DeltaView compare current file with master" })
end

return M
