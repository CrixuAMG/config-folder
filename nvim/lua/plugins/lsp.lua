local servers = {
    "phpactor",
    "intelephense",
    "html",
    "cssls",
    "cssmodules_ls",
    "bashls",
}

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable(servers)
        end
    },
    {
        'owallb/mason-auto-install.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            packages = { 'stylua', 'prettier' }
        },
    }
}
