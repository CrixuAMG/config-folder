return {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePre', 'BufNewFile' },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            javascript = { 'eslint' },
            typescript = { 'eslint' },
            php = { 'phpcs' },
            lua = { 'luacheck' },
            css = { 'stylelint' },
            scss = { 'stylelint' },
        }

        -- Create an autocommand to trigger linting
        -- vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        --     callback = function()
        --         lint.try_lint()
        --     end,
        -- })

        -- Optional: Add a keymap to trigger linting manually
        vim.keymap.set('n', '<leader>cl', function()
            lint.try_lint()
        end, { desc = 'Trigger linting' })
    end,
}
