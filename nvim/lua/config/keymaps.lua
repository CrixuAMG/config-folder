local set = vim.keymap.set

set("n", "<M-j>", "<cmd>cnext<CR>", {
    desc = "Next quickfix item"
})
set("n", "<M-k>", "<cmd>cprev<CR>", {
    desc = "Previous quickfix item"
})

set("n", "<leader>so", ":write<CR> :source<CR>", {
    desc = "Write and source current file"
})

set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

