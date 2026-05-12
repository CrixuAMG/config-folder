return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_opencode = require("cmp_opencode")

            -- Register the custom OpenCode source with nvim-cmp
            cmp.register_source("opencode", cmp_opencode.source.new())

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Normal,CursorLine:Visual,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Normal,CursorLine:Visual,Search:None",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Esc>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "path",     priority = 950 },
                    { name = "opencode", priority = 900 },
                    { name = "vim-dadbod-completion", priority = 875 },
                    { name = "luasnip",  priority = 700 },
                    { name = "buffer",   priority = 500, keyword_length = 3, max_item_count = 10 },
                },
                experimental = {
                    ghost_text = true,
                },
                performance = {
                    debounce = 60,
                    throttle = 30,
                    fetching_timeout = 500,
                },
            })

            -- Cmdline completion for ":"
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            -- Toggle commands
            vim.api.nvim_create_user_command("OpenCodeToggle", function()
                cmp_opencode.toggle()
            end, { desc = "Toggle OpenCode cmp source" })

            vim.api.nvim_create_user_command("ToggleOpenCode", function()
                cmp_opencode.toggle()
            end, { desc = "Toggle OpenCode cmp source" })

            vim.api.nvim_create_user_command("OpenCodeMultiline", function(args)
                local enable = args.args == "1" or args.args == "true" or args.args == ""
                cmp_opencode.set_multiline(enable)
            end, {
                desc = "Toggle OpenCode multiline suggestions (1/true/on or 0/false/off)",
                nargs = "?",
                complete = function()
                    return { "1", "0", "true", "false", "on", "off" }
                end,
            })

            vim.api.nvim_create_user_command("OpenCodeEager", function(args)
                local enable = args.args == "1" or args.args == "true" or args.args == ""
                cmp_opencode.set_eager(enable)
            end, {
                desc = "Toggle OpenCode eager multiline generation (1/true/on or 0/false/off)",
                nargs = "?",
                complete = function()
                    return { "1", "0", "true", "false", "on", "off" }
                end,
            })
        end,
    },
}
