-- Twig Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.add_snippets("twig", {
    -- Twig Block
    s("block", {
        t("{% block "),
        i(1, "block_name"),
        t(" %}"),
        t({ "", "  " }),
        i(2),
        t({ "", "{% endblock %}" }),
    }),
    -- Twig Extends
    s("extends", {
        t("{% extends \""),
        i(1, "template"),
        t("\" %}"),
    }),
    -- Twig Include
    s("include", {
        t("{% include \""),
        i(1, "template"),
        t("\""),
        c(2, {
            sn(nil, { t(" with {"), i(1), t(" }") }),
            sn(nil, { t(" only") }),
            sn(nil, { t("") }),
        }),
        t(" %}"),
    }),
    -- Twig If
    s("if", {
        t("{% if "),
        i(1, "condition"),
        t(" %}"),
        t({ "", "  " }),
        i(2),
        t({ "", "{% endif %}" }),
    }),
    -- Twig If Else
    s("ifelse", {
        t("{% if "),
        i(1, "condition"),
        t(" %}"),
        t({ "", "  " }),
        i(2),
        t({ "", "{% else %}", "  " }),
        i(3),
        t({ "", "{% endif %}" }),
    }),
    -- Twig For
    s("for", {
        t("{% for "),
        i(1, "item"),
        t(" in "),
        i(2, "items"),
        t(" %}"),
        t({ "", "  " }),
        i(3),
        t({ "", "{% endfor %}" }),
    }),
    -- Twig For Loop
    s("forloop", {
        t("{% for "),
        i(1, "item"),
        t(" in "),
        i(2, "items"),
        t(" %}"),
        t({ "", "  " }),
        i(3),
        t({ "", "  {{ loop.index }}", "{% endfor %}" }),
    }),
    -- Twig Macro
    s("macro", {
        t("{% macro "),
        i(1, "macroName"),
        t("("),
        i(2, "params"),
        t(") %}"),
        t({ "", "  " }),
        i(3),
        t({ "", "{% endmacro %}" }),
    }),
    -- Twig Import
    s("import", {
        t("{% import \""),
        i(1, "template"),
        t("\" as "),
        i(2),
        t(" %}"),
    }),
    -- Twig Set
    s("set", {
        t("{% set "),
        i(1, "variable"),
        t(" = "),
        i(2, "value"),
        t(" %}"),
    }),
    -- Twig Trans (Translation)
    s("trans", {
        t("{{ \""),
        i(1, "text"),
        t("\"|trans }}"),
    }),
    -- Twig Dump
    s("dump", {
        t("{{ dump("),
        i(1),
        t(") }}"),
    }),
    -- Twig Path (Symfony)
    s("path", {
        t("{{ path('"),
        i(1, "route_name"),
        t("'"),
        c(2, {
            sn(nil, { t(", {"), i(1), t("}") }),
            sn(nil, { t("") }),
        }),
        t(") }}"),
    }),
    -- Twig URL (Symfony)
    s("url", {
        t("{{ url('"),
        i(1, "route_name"),
        t("'"),
        c(2, {
            sn(nil, { t(", {"), i(1), t("}") }),
            sn(nil, { t("") }),
        }),
        t(") }}"),
    }),
    -- Twig Asset
    s("asset", {
        t("{{ asset('"),
        i(1, "path"),
        t("') }}"),
    }),
    -- Twig CSRF Token
    s("csrf", {
        t("{{ csrf_token('"),
        i(1, "token_id"),
        t("') }}"),
    }),
    -- Twig Form Field
    s("form_row", {
        t("{{ form_row(form."),
        i(1, "field_name"),
        t(") }}"),
    }),
    -- Twig Form Start
    s("form_start", {
        t("{{ form_start(form) }}"),
    }),
    -- Twig Form End
    s("form_end", {
        t("{{ form_end(form) }}"),
    }),
    -- Twig Filter
    s("filter", {
        t("{% filter "),
        i(1, "filter_name"),
        t(" %}", "  "),
        i(2),
        t({ "", "{% endfilter %}" }),
    }),
})