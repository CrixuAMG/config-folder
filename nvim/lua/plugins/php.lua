return {
    {
        "gbprod/phpactor.nvim",
        build = function()
            require("phpactor.handler.update")()
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig"
        },
        opts = {
            -- you're options coes here
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function()
            ---@type conform.setupOpts
            local opts = {
                log_level = vim.log.levels.DEBUG,
                -- add your config here
                format_on_save = {
                    -- phpcbf is slow.
                    timeout_ms = 1000,
                    lsp_fallback = true,
                },
                default_format_opts = {
                    timeout_ms = 3000,
                    async = false,           -- not recommended to change
                    quiet = false,           -- not recommended to change
                    lsp_format = "fallback", -- not recommended to change
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    fish = { "fish_indent" },
                    sh = { "shfmt" },
                    php = { "phpcbf" },
                },
                -- The options you set here will be merged with the builtin formatters.
                -- You can also define any custom formatters here.
                ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
                formatters = {
                    injected = { options = { ignore_errors = true } },
                    phpcbf = {
                        command = "phpcbf",
                        args = {
                            "--standard=PSR12",
                            "-" -- Read from stdin
                        },
                        stdin = true,
                    },
                    -- # Example of using dprint only when a dprint.json file is present
                    -- dprint = {
                    --   condition = function(ctx)
                    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                    --   end,
                    -- },
                    --
                    -- # Example of using shfmt with extra args
                    -- shfmt = {
                    --   prepend_args = { "-i", "2", "-ci" },
                    -- },
                },
            }
            return opts
        end
    },
    -- {
    --     'stephpy/vim-php-cs-fixer',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = function()
    --         -- Add an autocmd to execute a function when a PHP file is written
    --         vim.cmd([[
    --         augroup php_autocmds
    --         autocmd!
    --         autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
    --         augroup END
    --         ]])
    --     end
    -- },
    -- {
    --     'beanworks/vim-phpfmt',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = function()
    --         vim.cmd([[
    --         let g:phpfmt_standard = '/var/www/html/brand-websites/phpcs/ruleset.xml'
    --         echo g:phpfmt_standard
    --         ]])
    --     end
    -- },
    -- { -- lazy
    --     'ccaglak/phptools.nvim',
    --     event = "VeryLazy",
    --     keys = {
    --         { "<leader>pm",  "<cmd>PhpMethod<cr>" },
    --         { "<leader>pcc", "<cmd>PhpClass<cr>" },
    --         { "<leader>ps",  "<cmd>PhpScripts<cr>" },
    --         { "<leader>pn",  "<cmd>PhpNamespace<cr>" },
    --         { "<leader>pg",  "<cmd>PhpGetSet<cr>" },
    --         { "<leader>pf",  "<cmd>PhpCreate<cr>" },
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "stevearc/dressing.nvim",
    --     },
    --     config = function()
    --         require('phptools').setup({
    --             ui = false, -- if you have stevearc/dressing.nvim or something similar keep it false or else true
    --         })
    --         vim.keymap.set('v', '<leader>lr', ':PhpRefactor<cr>')
    --     end
    -- },
}
