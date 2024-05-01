return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            automatic_setup = true,
            auto_install = true,
            ensure_installed = {
                "intelephense",
                'phpactor',
                'intelephense',
            },
            handlers = {
                function(server_name)
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()

                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
        end,
        opts = {
            -- @type lspconfig.options
            servers = {
                intelephense = {
                    filetypes = { "php", "blade" },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                            },
                        },
                    },
                },
            },
        },
    },
}
