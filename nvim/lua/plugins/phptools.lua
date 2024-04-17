return {
    {  -- lazy
        'ccaglak/phptools.nvim',
        event = "VeryLazy",
        keys = {
            { "<leader>lm", "<cmd>PhpMethod<cr>"},
            { "<leader>lc", "<cmd>PhpClass<cr>"},
            { "<leader>ls", "<cmd>PhpScripts<cr>"},
            { "<leader>ln", "<cmd>PhpNamespace<cr>"},
            { "<leader>lg", "<cmd>PhpGetSet<cr>"},
            { "<leader>lf", "<cmd>PhpCreate<cr>"},
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require('phptools').setup({
                ui = false, -- if you have stevearc/dressing.nvim or something similar keep it false or else true
            })
            vim.keymap.set('v','<leader>lr',':PhpRefactor<cr>')
        end
    },
    {
        'phpactor/phpactor',
        run = 'composer install',
        ft = 'php',
        cmd = 'Phpactor',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'ncm2/ncm2',
            'roxma/nvim-yarp',
            'phpactor/ncm2-phpactor',
        },
        
    }
}
