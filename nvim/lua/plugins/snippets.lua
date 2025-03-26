return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")

            -- Settings
            ls.config.set_config({
                history = true, -- Keep around last snippet local to jump back
                updateevents = "TextChanged,TextChangedI", -- Update dynamic snippets as you type
                enable_autosnippets = true,
                ext_opts = {
                    [require("luasnip.util.types").choiceNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxOrange" } },
                        },
                    },
                },
            })

            -- Key mappings
            vim.keymap.set({"i", "s"}, "<C-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({"i", "s"}, "<C-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })

            vim.keymap.set({"i", "s"}, "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })

            ls.config.set_config({
                store_selection_keys = "<Tab>",
                ft_func = require("luasnip.extras.filetype_functions").from_cursor,
            })

            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets"})
        end,
        dependencies = {
            "rafamadriz/friendly-snippets", -- Optional: Add community snippets
        },
    }
}
