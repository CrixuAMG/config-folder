local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true);

-- Create an autocmd to register the console.log macro only for specific filetypes
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"js", "ts", "vue", "mjs", "cjs"},
    callback = function()
        -- Register 'l' macro for console.log wrapper
        -- When applied to selected text, it will create: console.log('selectedText:', selectedText)
        vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc)
    end
})

-- Create an autocmd for PHP files
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"php"},
    callback = function()
        -- Register 'd' macro for dd() wrapper
        -- When applied to selected text, it will create: dd($selectedText);
        vim.fn.setreg("d", "yodd(" .. esc .. "pa);" .. esc)

        -- Register 'p' macro for dump() wrapper
        -- When applied to selected text, it will create: dump($selectedText);
        vim.fn.setreg("p", "yodump(" .. esc .. "pa);" .. esc)
    end
})

