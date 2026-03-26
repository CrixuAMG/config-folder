--- Get all available snippets for the current filetype
---@return table[] List of snippet items for picker
local function get_snippets_for_picker()
    local ls = require("luasnip")
    local items = {}
    local ft = vim.bo.filetype

    -- Get filetypes to check (including extended filetypes)
    local fts = ls.get_snippet_filetypes()
    if not vim.tbl_contains(fts, ft) then
        table.insert(fts, 1, ft)
    end
    table.insert(fts, "all")

    local seen = {}
    for _, filetype in ipairs(fts) do
        local snippets = ls.get_snippets(filetype)
        for _, snip in ipairs(snippets or {}) do
            local key = snip.trigger
            if not seen[key] then
                seen[key] = true
                -- Get the docstring (expanded preview) of the snippet
                local docstring = snip:get_docstring()
                local preview_lines = type(docstring) == "table" and docstring or { docstring or "" }

                table.insert(items, {
                    text      = snip.trigger,
                    trigger   = snip.trigger,
                    name      = snip.name or snip.trigger,
                    desc      = snip.description and table.concat(snip.description, " ") or "",
                    ft        = filetype,
                    snippet   = snip,
                    preview   = preview_lines,
                })
            end
        end
    end

    table.sort(items, function(a, b)
        return a.trigger < b.trigger
    end)

    return items
end

--- Open Snacks picker for snippets
local function pick_snippets()
    local items = get_snippets_for_picker()
    local current_ft = vim.bo.filetype

    if #items == 0 then
        vim.notify("No snippets available for filetype: " .. current_ft, vim.log.levels.WARN)
        return
    end

    Snacks.picker({
        title   = "Snippets (" .. current_ft .. ")",
        items   = items,
        format  = function(item)
            return {
                { item.trigger, "SnacksPickerLabel" },
                { " " },
                { item.name ~= item.trigger and item.name or "", "SnacksPickerComment" },
                { item.desc ~= "" and (" - " .. item.desc) or "", "SnacksPickerComment" },
            }
        end,
        preview = function(ctx)
            local item = ctx.item
            local lines = item.preview or {}
            local preview_ft = item.ft ~= "all" and item.ft or current_ft

            ctx.preview:set_lines(lines)
            ctx.preview:highlight({ ft = preview_ft })
        end,
        confirm = function(picker, item)
            picker:close()
            if item then
                vim.schedule(function()
                    local ls = require("luasnip")
                    ls.snip_expand(item.snippet)
                end)
            end
        end,
    })
end

return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        lazy = true,
        keys = {
            { "<leader>fs", pick_snippets, desc = "Find Snippets", mode = { "n", "i" } },
        },
        config = function()
            local ls = require("luasnip")

            ls.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                store_selection_keys = "<Tab>",
                ft_func = require("luasnip.extras.filetype_functions").from_cursor,
                ext_opts = {
                    [require("luasnip.util.types").choiceNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxOrange" } },
                        },
                    },
                },
            })

            -- Choice node cycling with Ctrl+l
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })

            -- Load snippets from all sources
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_lua").load({ paths = vim.fn.expand("~/.config/nvim/snippets") })

            -- Extend filetypes for better snippet availability
            ls.filetype_extend("vue", { "html", "javascript", "typescript" })
            ls.filetype_extend("twig", { "html" })
        end,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    }
}
