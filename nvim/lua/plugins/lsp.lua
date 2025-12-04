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
                ensure_installed = {
                    -- PHP
                    "phpactor",
                    "intelephense",

                    -- JavaScript/TypeScript
                    "ts_ls",

                    -- Vue
                    "volar",

                    -- HTML/CSS/SCSS
                    "html",
                    "cssls",
                    "cssmodules_ls",

                    -- Shell scripting
                    "bashls",
                },
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Neovim 0.11+ uses vim.lsp.enable() with vim.lsp.config
            -- Define LSP servers to enable
            local servers = {
                "phpactor",
                "intelephense",
                "ts_ls",
                "volar",
                "html",
                "cssls",
                "cssmodules_ls",
                "bashls",
            }

            -- Enable all configured servers
            vim.lsp.enable(servers)
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
