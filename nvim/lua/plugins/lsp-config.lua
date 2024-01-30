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
                                auto_install = true
                        })
                end
        },
        {
                "neovim/nvim-lspconfig",
                config = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup({})
                        lspconfig.phpactor.setup({})
                        lspconfig.html.setup({})
                        lspconfig.cssls.setup({})
                        lspconfig.volar.setup({
                                filetypes = { 'vue', 'typescript', 'javascript' }
                        })

                        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                        vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
                end
        }
}
