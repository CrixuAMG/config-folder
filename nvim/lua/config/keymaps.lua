-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.cmd([[
    nnoremap <silent> go" vi"<Esc><Cmd>Sort<CR>
    nnoremap <silent> go' vi'<Esc><Cmd>Sort<CR>
    nnoremap <silent> go( vi(<Esc><Cmd>Sort<CR>
    nnoremap <silent> go[ vi[<Esc><Cmd>Sort<CR>
    nnoremap <silent> gop vip<Esc><Cmd>Sort<CR>
    nnoremap <silent> go{ vi{<Esc><Cmd>Sort<CR>
]])
