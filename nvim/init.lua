-- 1. Leader key must be set before plugins are loaded
vim.g.mapleader = " "

-- 2. Bootstrap native package management
-- This will clone plugins to pack/plugins/start or pack/plugins/opt if missing
local bootstrap = require("core.bootstrap")
bootstrap.bootstrap()

-- 3. Load basic configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.terminal")
require("config.macros")

-- 4. Setup Plugins
-- Helper to safely load and setup plugin modules
local function safe_setup(module_path)
    local ok, module = pcall(require, module_path)
    if ok and module.setup then
        module.setup()
    end
end

-- UI Components
safe_setup("plugins.theme")
safe_setup("plugins.folke")

safe_setup("plugins.lsp")
safe_setup("plugins.treesitter")
safe_setup("plugins.lualine")
safe_setup("plugins.oil")
safe_setup("plugins.gitsigns")

-- Setup small plugins directly if they don't have a dedicated file in lua/plugins/
if pcall(require, "mini.icons") then
    require("mini.icons").setup()
end

-- 5. Finalize
-- (Add any final configuration here)
