return {
    'crixuamg/visual-complexity.nvim',
    enabled = false,
    config = function()
        require('visual-complexity').setup({
            enabled_filetypes = {
                "lua", "javascript", "typescript", "vue", "php"
            },
            virtual_text_format = "Complexity: %.1f | Func: %d | Cond: %d",
            highlight_group = "Comment",
            show_bar = true,
            weights = {
                line = 1.0,
                func = 2.0,
                conditional = 1.5,
                indent = 0.1,
                clump = 1.0,
            },
            severity_thresholds = {
                { max = 10, group = "Comment" },
                { max = 25, group = "WarningMsg" },
                { max = math.huge, group = "ErrorMsg" },
            }
        })
    end
}
