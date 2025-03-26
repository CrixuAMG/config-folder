-- Automatically load all lua files in the config directory
local config_path = vim.fn.stdpath('config') .. '/lua/config'
for _, file in ipairs(vim.fn.readdir(config_path, [[v:val =~ '\.lua$']])) do
    if file ~= "lazy.lua" then
        require('config.' .. file:gsub('%.lua$', ''))
    end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
