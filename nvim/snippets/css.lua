-- CSS Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.add_snippets("css", {
    -- Media query
    s("mq", {
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
    -- CSS Variable
    s("var", {
        t("var(--"),
        i(1, "variable"),
        c(2, {
            t(")"),
            sn(nil, { t(", "), i(1, "fallback"), t(")") }),
        }),
    }),
    -- Define CSS Variable
    s("--", {
        t("--"),
        i(1, "variable"),
        t(": "),
        i(2, "value"),
        t(";"),
    }),
    -- Root variables
    s("root", {
        t({ ":root {", "    --" }),
        i(1, "variable"),
        t(": "),
        i(2, "value"),
        t({ ";", "}" }),
    }),
    -- Class selector
    s(".", {
        t("."),
        i(1, "class"),
        t({ " {", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- Keyframes
    s("keyframes", {
        t("@keyframes "),
        i(1, "name"),
        t({ " {", "    0% {", "        " }),
        i(2),
        t({ "", "    }", "    100% {", "        " }),
        i(3),
        t({ "", "    }", "}" }),
    }),
    -- Animation shorthand
    s("anim", {
        t("animation: "),
        i(1, "name"),
        t(" "),
        i(2, "1s"),
        t(" "),
        c(3, {
            t("ease"),
            t("linear"),
            t("ease-in"),
            t("ease-out"),
            t("ease-in-out"),
        }),
        t(";"),
    }),
    -- Transition
    s("trans", {
        t("transition: "),
        c(1, {
            t("all"),
            i(nil, "property"),
        }),
        t(" "),
        i(2, "0.3s"),
        t(" "),
        c(3, {
            t("ease"),
            t("linear"),
            t("ease-in-out"),
        }),
        t(";"),
    }),
    -- Transform
    s("transform", {
        t("transform: "),
        c(1, {
            sn(nil, { t("translateX("), i(1, "0"), t(")") }),
            sn(nil, { t("translateY("), i(1, "0"), t(")") }),
            sn(nil, { t("translate("), i(1, "0"), t(", "), i(2, "0"), t(")") }),
            sn(nil, { t("scale("), i(1, "1"), t(")") }),
            sn(nil, { t("rotate("), i(1, "0deg"), t(")") }),
        }),
        t(";"),
    }),
    -- Position absolute center
    s("abscenter", {
        t({ "position: absolute;", "top: 50%;", "left: 50%;", "transform: translate(-50%, -50%);" }),
    }),
    -- Position sticky
    s("sticky", {
        t({ "position: sticky;", "top: " }),
        i(1, "0"),
        t(";"),
    }),
    -- Visually hidden (accessibility)
    s("vishidden", {
        t({ "position: absolute;", "width: 1px;", "height: 1px;", "padding: 0;", "margin: -1px;", "overflow: hidden;", "clip: rect(0, 0, 0, 0);", "white-space: nowrap;", "border: 0;" }),
    }),
    -- Truncate text
    s("truncate", {
        t({ "overflow: hidden;", "text-overflow: ellipsis;", "white-space: nowrap;" }),
    }),
})

