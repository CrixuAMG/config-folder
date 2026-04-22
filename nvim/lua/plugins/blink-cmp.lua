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
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nerd_fonts = true,
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,CursorLine:Visual,Search:None',
                    },
                },
                list = {
                    selection = {
                        auto_insert = true,
                    },
                },
                menu = {
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,CursorLine:Visual,Search:None',
                },
            },
            snippets = {
                preset = 'luasnip',
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
            cmdline = {
                start_sources = { 'cmdline' },
            },
        },
        opts_extend = {
            'sources.default'
        }
    }
}
