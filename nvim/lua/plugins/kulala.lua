local M = {}

function M.setup()
    require('kulala').setup({
        -- your configuration comes here
        global_keymaps = true,
        default_env = 'dev',
    })
end

return M
