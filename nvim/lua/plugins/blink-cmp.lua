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
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = {
                    auto_show = true,
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
            },
            fuzzy = {
                implementation = 'lua'
            }
        },
        opts_extend = {
            'sources.default'
        }
    }
}
