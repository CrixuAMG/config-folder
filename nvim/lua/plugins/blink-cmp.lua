return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
        },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
                ['<C-k>'] = { 'snippet_forward', 'fallback' },
                ['<C-j>'] = { 'snippet_backward', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<Esc>'] = { 'cancel', 'fallback' },
                ['<C-q>'] = { 'toggle_quick_menu', 'fallback' },
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nerd_fonts = true,
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                menu_behavior = 'insert',
                accept = {
                    execute_on_select = false,
                },
            },
            snippets = {
                preset = 'luasnip',
                expand = 'auto',
                parents = 'expand',
            },
            sources = {
                default = {
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                },
                providers = {
                    lsp = {
                        score_offset = 15,
                        fallback_for = { 'omni' },
                    },
                    path = {
                        score_offset = 10,
                    },
                    buffer = {
                        min_keyword_length = 3,
                        max_items = 10,
                    },
                    snippets = {
                        score_offset = -5,
                        opts = {
                            extended_filetypes = {
                                vue = { 'html', 'javascript', 'typescript' },
                                twig = { 'html' },
                                blade = { 'html', 'php' },
                                javascriptreact = { 'javascript' },
                                typescriptreact = { 'typescript', 'javascript' },
                            },
                        },
                    },
                },
                include_keyword_in_items = true,
            },
            fuzzy = {
                implementation = 'lua',
            },
            window = {
                completion = {
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,CursorLine:Visual,Search:None',
                    col_offset = 0,
                    side_padding = 1,
                },
                documentation = {
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,CursorLine:Visual,Search:None',
                },
            },
            cmdline = {
                start_sources = { 'cmdline' },
            },
        },
        opts_extend = {
            'sources.default'
        }
    }
}
