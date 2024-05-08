-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd("set autowrite")
vim.cmd("set autoread")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set shiftround")
vim.cmd("set rnu")
vim.cmd("set number")

vim.cmd("set noswapfile")
vim.cmd("set termguicolors")

vim.cmd("set title")

-- tpope/commentary
vim.cmd("filetype plugin indent on")

vim.g.mapleader = " "

-- Disable netrw to use nvim neotree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

