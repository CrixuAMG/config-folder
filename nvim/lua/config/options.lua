vim.cmd("set autowrite")
vim.cmd("set autoread")

vim.cmd("set expandtab")
vim.cmd("set shiftround")
vim.cmd("set rnu")
vim.cmd("set number")
vim.cmd("set cursorline")

vim.cmd("set noswapfile")
vim.cmd("set termguicolors")

vim.cmd("set title")

-- tpope/commentary
vim.cmd("filetype plugin indent on")

vim.g.mapleader = " "

-- Disable netrw to use nvim neotree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({
  virtual_lines = true,
})

local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

-- Keep the cursor at the vertical center part of the screen
opt.scrolloff = 999

opt.inccommand = 'split'

opt.nrformats = 'bin,hex,alpha'

opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

