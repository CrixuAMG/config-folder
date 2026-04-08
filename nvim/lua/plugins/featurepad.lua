local M = {}

function M.setup()
    require("featurepad").setup({
        base_dir = "~/features",
    })
end

return M
