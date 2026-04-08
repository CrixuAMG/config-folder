local M = {}

function M.setup()
    require("codesnap").setup({
        mac_window_bar = false,
        has_breadcrumbs = true,
        has_line_number = true,
        bg_theme = "peach"
    })

    vim.keymap.set("x", "<leader>ss", ":CodeSnap<cr>", { desc = "Take a Codesnap screenshot", silent = true })
end

return M
