local M = {}

function M.setup()
    -- Twig filetype
    vim.filetype.add({
        pattern = {
            [".*%.twig"] = "twig",
        },
    })

    -- Treesitter
    vim.schedule(function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
            return
        end

        configs.setup({
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
        highlight = {
            enable = true,
        },
    })
end

return M
