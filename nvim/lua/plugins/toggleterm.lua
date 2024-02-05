return {
        "akinsho/toggleterm.nvim",
        lazy = false,
        enabled = false,
        init = function()
        end,
        opts = {
                size = 30,
                open_mapping = [[<c-\>]],
                autochdir = true,
                autoscroll = false,
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = "-30",
                start_in_insert = false,
                insert_mappings = true,
                persist_size = true,
                direction = "float",
                float_opts = {
                        border = "curved",
                },
                close_on_exit = true,
                shell = vim.o.shell,
        },
        config = function()
                require('toggleterm').setup({})
                local Terminal  = require('toggleterm.terminal').Terminal

                local lazygit = Terminal:new({
                        cmd = "lazygit",
                        dir = "git_dir",
                        direction = "float",
                        float_opts = {
                                border = "double",
                        },
                        -- function to run on opening the terminal
                        on_open = function(term)
                                vim.cmd("startinsert!")
                                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
                        end,
                        -- function to run on closing the terminal
                        on_close = function()
                                vim.cmd("startinsert!")
                        end,
                })

                function _lazygit_toggle()
                        lazygit:toggle()
                end

                vim.api.nvim_set_keymap("n", "<leader>\\", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
                function _G.set_terminal_keymaps()
                        local opts = {buffer = 0}
                        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
                end

                -- if you only want these mappings for toggle term use term://*toggleterm#* instead
                vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
        end
}
