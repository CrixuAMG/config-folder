local source = debug.getinfo(1, "S").source:sub(2)
local nvim_dir = vim.fs.dirname(vim.fs.dirname(source))
local kulala_repo = dofile(vim.fs.joinpath(nvim_dir, "lua", "plugins", "kulala.lua"))[1]

assert(
    kulala_repo == "dont-be-evil-company/kulala.nvim",
    "Kulala should use its current repository; got " .. vim.inspect(kulala_repo)
)

print("Kulala config test passed")
