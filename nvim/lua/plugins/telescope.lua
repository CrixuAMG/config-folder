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
            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<C-o>"] = function(prompt_bufnr) require("telescope.actions").select_default(prompt_bufnr) require("telescope.builtin").resume() end,
                            ["<C-q>"] = actions.send_to_qflist,
                        }
                    }
                }
            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Fuzzy find text" })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Find occurrences of string" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Display open buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Show previous fuzzy searches" })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fuzzy find recent files" })

            vim.cmd([[
                function!   QuickFixOpenAll()
                    if empty(getqflist())
                        return
                    endif
                    let s:prev_val = ""
                    for d in getqflist()
                        let s:curr_val = bufname(d.bufnr)
                        if (s:curr_val != s:prev_val)
                            exec "edit " . s:curr_val
                        endif
                        let s:prev_val = s:curr_val
                    endfor
                endfunction
            ]])

            vim.api.nvim_set_keymap('n', '<leader>ka' , ':call QuickFixOpenAll()<CR>', { noremap=true, silent=false })
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
