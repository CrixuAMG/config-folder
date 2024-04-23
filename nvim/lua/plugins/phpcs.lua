return {
    {
        'stephpy/vim-php-cs-fixer',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function() 
            -- Add an autocmd to execute a function when a PHP file is written
            vim.cmd([[
            augroup php_autocmds
            autocmd!
            autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
            augroup END
            ]])
        end
    },
    {
        'beanworks/vim-phpfmt',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.cmd([[
            let g:phpfmt_standard = '/var/www/html/brand-websites/phpcs/ruleset.xml'

            echo g:phpfmt_standard
            ]])
        end
    }
}
