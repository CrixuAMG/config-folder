return {
    {
        "sschleemilch/slimline.nvim",
        opts = {
            components = {
                left = {
                    "mode",
                    "path",
                    "git",
                    function()
                        return require("pathfinder").statusline()
                    end,
                },
                center = {},
                right = {
                    "diagnostics",
                    "filetype_lsp",
                    "progress",
                },
            },
            spaces = {
                components = "",
                left = "",
                right = "",
            },
            sep = {
                hide = {
                    first = true,
                    last = true,
                },
                left = "",
                right = "",
            },
        },
    },
}
