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

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
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
    },
    {
        'owallb/mason-auto-install.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            packages = { 'stylua', 'prettier' }
        },
    }
}
