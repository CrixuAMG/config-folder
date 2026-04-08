local M = {}

function M.setup()
    require("cron-readable").setup({
        pattern = { "*.yaml", "*.yml" }, -- File patterns to match
        filename = nil,                 -- Optional: specific filename to match
    })
end

return M
