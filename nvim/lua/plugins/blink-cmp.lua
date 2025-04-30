return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                nerd_font_variant = 'momo',
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
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
