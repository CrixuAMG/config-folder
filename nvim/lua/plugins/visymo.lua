return {
    {
        'CrixuAMG/brand-websites-phpunit.nvim',
        config = function()
            local runner = require('brand-websites-phpunit')

            vim.keymap.set('n', "<leader>pr", function()
                runner.set_brand()
            end, { desc = 'Run PHPUnit suite for brand' })
        end
    }
}
