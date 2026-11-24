local languages = {
    "bash",
    "css",
    "html",
    "go",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "regex",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "twig",
}

return {
    {
        'nelsyeung/twig.vim',
        ft = "twig",
        config = function()
            vim.filetype.add({
                pattern = {
                    [".*%.twig"] = "twig",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })
            treesitter.install(languages)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = languages,
                callback = function(args)
                    -- Installation is asynchronous, so a parser may not be ready yet.
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    }
}
