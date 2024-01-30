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

---@diagnostic disable-next-line: duplicate-set-field
function _G.set_terminal_keymaps()
    local terminal_opts = { buffer = 0 }
    vim.keymap.set('t', '<leader><esc>', [[<C-\><C-n>]], terminal_opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], terminal_opts)
    vim.keymap.set('t', '<leader><C-h>', [[<Cmd>wincmd h<CR>]], terminal_opts)
    vim.keymap.set('t', '<leader><C-j>', [[<Cmd>wincmd j<CR>]], terminal_opts)
    vim.keymap.set('t', '<leader><C-k>', [[<Cmd>wincmd k<CR>]], terminal_opts)
    vim.keymap.set('t', '<leader><C-l>', [[<Cmd>wincmd l<CR>]], terminal_opts)
end

require("toggleterm").setup({})

