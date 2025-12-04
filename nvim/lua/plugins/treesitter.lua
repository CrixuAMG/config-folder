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
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "php",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "twig",
            },
        },
    }
}
