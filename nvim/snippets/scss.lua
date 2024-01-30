-- SCSS Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local f = ls.function_node

ls.add_snippets("scss", {
    -- Media query with map.get (brand-websites/helix pattern)
    s("mmin", {
        t("@media #{map.get($media-min, "),
        c(1, {
            t("b"),
            t("c"),
            t("d"),
            t("e"),
            t("f"),
        }),
        t(")} {"),
        t({ "", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    s("mmax", {
        t("@media #{map.get($media-max, "),
        c(1, {
            t("a"),
            t("b"),
            t("c"),
            t("d"),
            t("e"),
        }),
        t(")} {"),
        t({ "", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    s("media", {
        t("@media #{map.get($media, "),
        c(1, {
            t("a"),
            t("b"),
            t("c"),
            t("d"),
            t("e"),
            t("f"),
        }),
        t(")} {"),
        t({ "", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- Import media queries helper
    s("usemq", {
        t("@use 'mediaQueries' as *;"),
    }),
    s("usedef", {
        t("@use 'defaultVariables' as *;"),
    }),
    s("usemap", {
        t("@use 'sass:map';"),
    }),
    -- Standard media query
    s("mqraw", {
        t("@media ("),
        c(1, {
            sn(nil, { t("max-width: "), i(1, "767px") }),
            sn(nil, { t("min-width: "), i(1, "768px") }),
            sn(nil, { t("min-width: "), i(1, "768px"), t(") and (max-width: "), i(2, "991px") }),
        }),
        t(") {"),
        t({ "", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- BEM-style class
    s("bem", {
        t("."),
        i(1, "block"),
        t({ " {", "    " }),
        i(2),
        t({ "", "", "    &__" }),
        i(3, "element"),
        t({ " {", "        " }),
        i(4),
        t({ "", "    }", "", "    &--" }),
        i(5, "modifier"),
        t({ " {", "        " }),
        i(6),
        t({ "", "    }", "}" }),
    }),
    -- BEM element
    s("__", {
        t("&__"),
        i(1, "element"),
        t({ " {", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- BEM modifier
    s("--", {
        t("&--"),
        i(1, "modifier"),
        t({ " {", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- Mixin
    s("mix", {
        t("@mixin "),
        i(1, "name"),
        t("("),
        i(2),
        t(") {"),
        t({ "", "    " }),
        i(3),
        t({ "", "}" }),
    }),
    -- Include mixin
    s("inc", {
        t("@include "),
        i(1, "mixin-name"),
        t("("),
        i(2),
        t(");"),
    }),
    -- Use module
    s("use", {
        t("@use '"),
        i(1, "module"),
        t("'"),
        c(2, {
            t(";"),
            sn(nil, { t(" as "), i(1, "*"), t(";") }),
        }),
    }),
    -- Forward module
    s("fwd", {
        t("@forward '"),
        i(1, "module"),
        t("';"),
    }),
    -- Variable
    s("$", {
        t("$"),
        i(1, "variable"),
        t(": "),
        i(2, "value"),
        t(";"),
    }),
    -- Flexbox container
    s("flex", {
        t({ "display: flex;", "" }),
        c(1, {
            t(""),
            sn(nil, { t("flex-direction: "), i(1, "row"), t(";") }),
            sn(nil, { t("flex-direction: column;") }),
        }),
        c(2, {
            t(""),
            sn(nil, { t({ "", "justify-content: " }), i(1, "center"), t(";") }),
        }),
        c(3, {
            t(""),
            sn(nil, { t({ "", "align-items: " }), i(1, "center"), t(";") }),
        }),
        c(4, {
            t(""),
            sn(nil, { t({ "", "gap: " }), i(1, "1rem"), t(";") }),
        }),
    }),
    -- Grid container
    s("grid", {
        t({ "display: grid;", "grid-template-columns: " }),
        i(1, "repeat(3, 1fr)"),
        t({ ";", "gap: " }),
        i(2, "1rem"),
        t(";"),
    }),
})

