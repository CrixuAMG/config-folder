return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-tree/nvim-web-devicons',
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = {"tpope/vim-fugitive"}
            }
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Fuzzy find text" })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Find occurrences of string" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Display open buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Show previous fuzzy searches" })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fuzzy find recent files" })
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {

                        }
                    }
                },
                defaults = {
                    file_ignore_patterns = {
                        "yarn.lock",
                        "composer.lock",
                        "symfony.lock",
                        "node_modules",
                        "vendor",
                    }
                }
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("git_file_history")
        end
    }
}
