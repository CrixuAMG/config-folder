local servers = {
    "phpactor",
    "html",
    "cssls",
    "cssmodules_ls",
    "bashls",
    "ts_ls",
    "tailwindcss",
    "vue_ls",
}

-- Mason-lspconfig doesn't recognize "vue_ls", so exclude it from ensure_installed
local mason_servers = {
    "phpactor",
    "html",
    "cssls",
    "cssmodules_ls",
    "bashls",
    "ts_ls",
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
                ensure_installed = mason_servers,
                automatic_installation = true,
                automatic_enable = false,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("phpactor", {
                capabilities = capabilities,
                filetypes = { "php" },
                init_options = {
                    ["language_server_worse_reflection.inlay_hints.enable"] = false,
                    ["language_server_configuration.auto_config"] = false,
                },
            })

            vim.lsp.config("html", {
                capabilities = capabilities,
                filetypes = { "html", "twig", "blade" },
            })

            vim.lsp.config("cssls", {
                capabilities = capabilities,
            })

            vim.lsp.config("cssmodules_ls", {
                capabilities = capabilities,
            })

            vim.lsp.config("bashls", {
                capabilities = capabilities,
            })

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
            })

            vim.lsp.config("tailwindcss", {
                capabilities = capabilities,
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "twig", "php", "phtml" },
            })

            vim.lsp.config("vue_ls", {
                capabilities = capabilities,
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            })

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end

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

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, noremap = true, silent = true }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
                    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
                end,
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
            packages = { 'stylua', 'prettier', 'vue-language-server' }
        },
    }
}
