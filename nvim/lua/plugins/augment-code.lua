return {
    'augmentcode/augment.vim',
    -- Ensure plugin only loads when needed
    lazy = true,
    -- Load on specific commands or events
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        -- Workspace configuration
        vim.g.augment_workspace_folders = {
            "/var/www/html/brand-websites/",
            "/var/www/html/artemis/",
            "/var/www/html/oracle/",
            "/var/www/html/Hermes/",
            "/var/www/html/visymo-scraper",
        }

        -- Additional Augment settings
        vim.g.augment_auto_completion = true    -- Enable auto-completion
        vim.g.augment_inline_suggestions = true -- Show inline suggestions
        vim.g.augment_format_on_save = true     -- Format code on save
        vim.g.augment_diagnostics = true        -- Show diagnostics

        -- Configure file type associations
        vim.g.augment_file_types = {
            typescript = true,
            javascript = true,
            php = true,
            vue = true,
            lua = true
        }

        -- Configure ignored directories
        vim.g.augment_ignore_patterns = {
            "node_modules",
            "vendor",
            "dist",
            ".git"
        }

        -- Keybindings
        local opts = { noremap = true, silent = true }

        -- Code assistance
        vim.keymap.set('n', '<leader>aa', '<cmd>AugmentAssist<CR>', { desc = 'Open Augment assistant', unpack(opts) })
        vim.keymap.set('n', '<leader>ae', '<cmd>AugmentExplain<CR>', { desc = 'Explain code', unpack(opts) })
        vim.keymap.set('n', '<leader>ar', '<cmd>AugmentRefactor<CR>', { desc = 'Refactor code', unpack(opts) })
        vim.keymap.set('v', '<leader>ae', '<cmd>AugmentExplainSelection<CR>',
            { desc = 'Explain selected code', unpack(opts) })

        -- Documentation
        vim.keymap.set('n', '<leader>ad', '<cmd>AugmentDoc<CR>', { desc = 'Generate documentation', unpack(opts) })
        vim.keymap.set('n', '<leader>at', '<cmd>AugmentTest<CR>', { desc = 'Generate test', unpack(opts) })

        -- Code actions
        vim.keymap.set('n', '<leader>af', '<cmd>AugmentFix<CR>', { desc = 'Quick fix', unpack(opts) })
        vim.keymap.set('n', '<leader>ai', '<cmd>AugmentImplement<CR>',
            { desc = 'Implement interface/abstract', unpack(opts) })

        -- Navigation
        vim.keymap.set('n', '<leader>ag', '<cmd>AugmentGoto<CR>', { desc = 'Go to definition', unpack(opts) })
        vim.keymap.set('n', '<leader>ar', '<cmd>AugmentReferences<CR>', { desc = 'Find references', unpack(opts) })

        -- Inline assistance
        vim.keymap.set('i', '<C-a>', '<cmd>AugmentComplete<CR>', { desc = 'Trigger completion', unpack(opts) })
        vim.keymap.set('i', '<C-l>', '<cmd>AugmentAcceptSuggestion<CR>',
            { desc = 'Accept inline suggestion', unpack(opts) })
    end,

    -- Dependencies
    dependencies = {
        'nvim-lua/plenary.nvim' -- Common Lua functions
    }
}
