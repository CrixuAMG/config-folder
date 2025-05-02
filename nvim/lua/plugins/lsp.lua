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

                    -- Lua
                    "lua_ls",
                },
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- PHP
            lspconfig.phpactor.setup{}
            lspconfig.intelephense.setup{}

            -- JavaScript/TypeScript
            lspconfig.ts_ls.setup{}

            -- Vue
            lspconfig.volar.setup{}

            -- HTML/CSS/SCSS
            lspconfig.html.setup{}
            lspconfig.cssls.setup{}
            lspconfig.cssmodules_ls.setup{}

            -- Shell scripting
            lspconfig.bashls.setup{}

            -- Lua
            lspconfig.lua_ls.setup{
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                };

                vim.keymap.set("n", "K", vim.lsp.buf.hover, {});
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {});
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {});
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {});
                vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {});
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {});
            }
        end
    }
}
