return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs")
                .setup({
            ensure_installed = { "vim", "lua", "javascript", "php", "html", "css", "vue" },
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
            sync_install = true,
        })
    end
}
