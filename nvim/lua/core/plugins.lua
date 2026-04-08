local plugins = {
    -- Core & Libraries
    { repo = "nvim-lua/plenary.nvim", type = "start" },
    { repo = "nvim-tree/nvim-web-devicons", type = "start" },
    { repo = "catppuccin/nvim", name = "catppuccin", type = "start" },
    { repo = "nvim-neotest/nvim-nio", type = "start" },
    { repo = "antoinemadec/FixCursorHold.nvim", type = "start" },
    { repo = "kokusenz/delta.lua", type = "start" },

    -- LSP & Completion
    { repo = "neovim/nvim-lspconfig", type = "start" },
    { repo = "williamboman/mason.nvim", type = "start" },
    { repo = "williamboman/mason-lspconfig.nvim", type = "start" },
    { repo = "owallb/mason-auto-install.nvim", type = "start" },
    { repo = "saghen/blink.cmp", type = "start" },
    { repo = "rafamadriz/friendly-snippets", type = "start" },
    { repo = "L3MON4D3/LuaSnip", type = "start" },

    -- Treesitter
    { repo = "nvim-treesitter/nvim-treesitter", type = "start" },

    -- UI & UX
    { repo = "nvim-lualine/lualine.nvim", type = "start" },
    { repo = "sschleemilch/slimline.nvim", type = "start" },
    { repo = "stevearc/oil.nvim", type = "start" },
    { repo = "JezerM/oil-lsp-diagnostics.nvim", type = "start" },
    { repo = "malewicz1337/oil-git.nvim", type = "start" },
    { repo = "echasnovski/mini.icons", type = "start" },
    { repo = "lewis6991/gitsigns.nvim", type = "start" },
    { repo = "stevearc/aerial.nvim", type = "start" },
    { repo = "echasnovski/mini.align", type = "start" },
    { repo = "CrixuAMG/bento.nvim", type = "start" },
    { repo = "mistricky/codesnap.nvim", type = "start" },
    { repo = "akinsho/bufferline.nvim", type = "start" },
    { repo = "OXY2DEV/helpview.nvim", type = "start" },

    -- Folke's plugins
    { repo = "folke/snacks.nvim", type = "start" },
    { repo = "RileyGabrielson/inspire.nvim", type = "start" },
    { repo = "folke/which-key.nvim", type = "start" },
    { repo = "folke/noice.nvim", type = "start" },
    { repo = "MunifTanjim/nui.nvim", type = "start" },
    { repo = "rcarriga/nvim-notify", type = "start" },

    -- Tools
    { repo = "stevearc/conform.nvim", type = "start" },
    { repo = "mfussenegger/nvim-dap", type = "start" },
    { repo = "rcarriga/nvim-dap-ui", type = "start" },
    { repo = "nvim-neotest/neotest", type = "start" },
    { repo = "olimorris/neotest-phpunit", type = "start" },
    { repo = "stevearc/overseer.nvim", type = "start" },
    { repo = "stevearc/quicker.nvim", type = "start" },
    { repo = "AndrewRadev/splitjoin.vim", type = "start" },
    { repo = "kokusenz/deltaview.nvim", type = "start" },
    { repo = "WilliamHsieh/overlook.nvim", type = "start" },
    { repo = "yarospace/dev-tools.nvim", type = "start" },
    { repo = "ThePrimeagen/refactoring.nvim", type = "start" },
    { repo = "crixuamg/cron-readable.nvim", type = "start" },
    { repo = "crixuamg/featurepad.nvim", type = "start" },
    { repo = "crixuamg/visual-complexity.nvim", type = "start" },
    { repo = "CrixuAMG/packui.nvim", type = "start" },

    -- Optional / Lazy Loaded
    { repo = "tpope/vim-fugitive", type = "opt", cmd = "Git" },
    { repo = "nelsyeung/twig.vim", type = "opt", ft = "twig" },
    { repo = "augmentcode/augment.vim", type = "opt", event = { "BufReadPre", "BufNewFile" } },
    { repo = "windwp/nvim-autopairs", type = "opt", event = "InsertEnter" },
    { repo = "catgoose/nvim-colorizer.lua", type = "opt", event = "BufReadPre" },
    { repo = "mfussenegger/nvim-lint", type = "opt", event = { "BufReadPost", "BufWritePre", "BufNewFile" } },
    { repo = "tpope/vim-dadbod", type = "opt", cmd = "DB" },
    { repo = "kristijanhusak/vim-dadbod-ui", type = "opt", cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" } },
    { repo = "kristijanhusak/vim-dadbod-completion", type = "opt", ft = { "sql", "mysql", "plsql" } },
    { repo = "sindrets/diffview.nvim", type = "opt", event = "VeryLazy" },
    { repo = "mistweaverco/kulala.nvim", type = "opt", ft = { "http", "rest" } },
    { repo = "yousefhadder/markdown-plus.nvim", type = "opt", ft = "markdown" },
    { repo = "rachartier/tiny-code-action.nvim", type = "opt", event = "LspAttach" },
}

return plugins
