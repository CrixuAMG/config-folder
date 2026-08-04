local set = vim.keymap.set

local function copy(value)
    vim.fn.setreg("+", value)
    vim.notify("Copied: " .. value)
end

set("n", "<leader>fy", function()
    copy(vim.fn.expand("%:."))
end, { desc = "Copy relative path" })

set("n", "<leader>fY", function()
    copy(vim.fn.expand("%:p"))
end, { desc = "Copy full path" })

set("n", "<leader>fN", function()
    copy(vim.fn.expand("%:t"))
end, { desc = "Copy filename" })

set("n", "<leader>fl", function()
    copy(vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))
end, { desc = "Copy path and line" })

set("n", "<M-j>", "<cmd>cnext<CR>", {
    desc = "Next quickfix item"
})
set("n", "<M-k>", "<cmd>cprev<CR>", {
    desc = "Previous quickfix item"
})
set("n", "dg", "<cmd>diffget<CR>", {
    desc = "Diff get"
})
set("n", "dg", "<cmd>diffput<CR>", {
    desc = "Diff put"
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

-- Add named arguments for PHP function calls
vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    callback = function(args)
        vim.keymap.set("n", "<leader>pa", function()
            require("php_named_args").add_named_args()
        end, {
            buffer = args.buf,
            desc = "Add PHP named arguments",
            noremap = true,
            silent = true,
        })
    end,
})
