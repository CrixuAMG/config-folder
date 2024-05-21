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
        'stephpy/vim-php-cs-fixer',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            -- Add an autocmd to execute a function when a PHP file is written
            vim.cmd([[
            augroup php_autocmds
            autocmd!
            autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
            augroup END
            ]])
        end
    },
    {
        'beanworks/vim-phpfmt',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.cmd([[
            let g:phpfmt_standard = '/var/www/html/brand-websites/phpcs/ruleset.xml'
            echo g:phpfmt_standard
            ]])
        end
    },
    { -- lazy
        'ccaglak/phptools.nvim',
        event = "VeryLazy",
        keys = {
            { "<leader>pm",  "<cmd>PhpMethod<cr>" },
            { "<leader>pcc", "<cmd>PhpClass<cr>" },
            { "<leader>ps",  "<cmd>PhpScripts<cr>" },
            { "<leader>pn",  "<cmd>PhpNamespace<cr>" },
            { "<leader>pg",  "<cmd>PhpGetSet<cr>" },
            { "<leader>pf",  "<cmd>PhpCreate<cr>" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require('phptools').setup({
                ui = false, -- if you have stevearc/dressing.nvim or something similar keep it false or else true
            })
            vim.keymap.set('v', '<leader>lr', ':PhpRefactor<cr>')
        end
    },
}
