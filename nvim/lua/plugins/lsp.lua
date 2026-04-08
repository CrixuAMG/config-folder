local M = {}

local servers = {
    "phpactor",
    "intelephense",
    "html",
    "cssls",
    "cssmodules_ls",
    "bashls",
    "ts_ls",
    "volar",
    "tailwindcss",
}

function M.setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
    })
    
    -- Configure mason-auto-install
    require("mason-auto-install").setup({
        packages = { 'stylua', 'prettier' }
    })

    -- nvim-lspconfig
    vim.lsp.enable(servers)
    
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
        desc = "Rename symbol (all references)",
        noremap = true,
    })
    
    vim.keymap.set("n", "<leader>cR", function()
        local new_name = vim.fn.input("New filename: ", vim.fn.expand("%:t"))
        if new_name and new_name ~= "" then
            local old_path = vim.fn.expand("%:p")
            local new_path = vim.fn.fnamemodify(old_path, ":h") .. "/" .. new_name
            vim.cmd.rename({ args = { new_path }, bang = true })
        end
    end, {
        desc = "Rename current file",
        noremap = true,
    })
end

return M
