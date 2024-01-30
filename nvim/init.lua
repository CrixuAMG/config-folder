local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require("vim-options")
require("lazy").setup("plugins", opts)

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<leader><esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<leader><C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<leader><C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<leader><C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<leader><C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

require("toggleterm").setup({})

