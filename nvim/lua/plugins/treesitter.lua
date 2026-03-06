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
                "css",
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
                "scss",
                "tsx",
                "typescript",
                "vim",
                "vue",
                "yaml",
                "twig",
            },
        },
    }
}
