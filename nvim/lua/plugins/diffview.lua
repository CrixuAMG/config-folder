local M = {}

function M.setup()
    -- diffview.nvim doesn't strictly need a setup call if using defaults,
    -- but we provide the module structure.
    require('diffview').setup({})
end

return M
