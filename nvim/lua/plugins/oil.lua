local M = {}

function M.setup()
    require("oil").setup({})
    
    -- Optional extras found in the original file
    -- require("oil-lsp-diagnostics").setup({})
    -- require("oil-git").setup({})

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
