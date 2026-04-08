local M = {}

function M.setup()
    require('dev-tools').setup({
        ---@type Action[]|fun():Action[]
        actions = {},

        filetypes = { -- filetypes for which to attach the LSP
            include = {}, -- {} to include all, except for special buftypes, e.g. nofile|help|terminal|prompt
            exclude = {},
        },
    })
end

return M
