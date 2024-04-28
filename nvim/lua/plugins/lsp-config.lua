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
                'php',
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
                php = function(config)
                    config.configurations = {
                        {
                            type = "php",
                            request = "launch",
                            name = "Listen for Xdebug",
                            port = 9003,
                            pathMappings = {
                                -- For some reason xdebug sometimes fails for me, depending on me
                                -- using herd or docker. To get it to work, change the order of the mappings.
                                -- The first mapping should be the one that you are actively using.
                                -- This only started recently, so I don't know what changed.
                                ["${workspaceFolder}"] = "${workspaceFolder}",
                                ["/var/www/html"] = "${workspaceFolder}",
                            },
                        },
                    }
                    require("mason-nvim-dap").default_setup(config) -- don't forget this!
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
    },
    {
        "neovim/nvim-lspconfig",
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
