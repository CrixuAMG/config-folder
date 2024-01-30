-- HTML Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.add_snippets("html", {
    s("html5", {
        t("<!DOCTYPE html>"),
        t({"", "<html lang=\"en\">", ""}),
        t("<head>"),
        t({"", "  <meta charset=\"UTF-8\">", "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "  <title>"}),
        i(1, "Document"),
        t({"</title>", ""}),
        t("</head>"),
        t({"", "<body>"}),
        t({"", "  "}),
        i(2),
        t({"", "", "</body>", "", "</html>"}),
    }),
    s("script", {
        t("<script"),
        c(1, {
            sn(nil, {t(" src=\""), i(1), t("\"")}),
            sn(nil, {t(" type=\"module\"")}),
            sn(nil, {t("")}),
        }),
        t(">"),
        t({"", "  "}),
        i(2),
        t({"", "</script>"}),
    }),
    s("sc", {
        t("<script src=\""),
        i(1),
        t("\"></script>"),
    }),
    s("scm", {
        t("<script type=\"module\" src=\""),
        i(1),
        t("\"></script>"),
    }),
    s("style", {
        t("<style>"),
        t({"", "  "}),
        i(1),
        t({"", "</style>"}),
    }),
    s("link", {
        t("<link rel=\"stylesheet\" href=\""),
        i(1),
        t("\">"),
    }),
    s("favicon", {
        t("<link rel=\"icon\" type=\"image/x-icon\" href=\"/favicon.ico\">"),
    }),
    s("meta", {
        c(1, {
            sn(nil, {t("<meta charset=\"UTF-8\">")}),
            sn(nil, {t("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">")}),
            sn(nil, {t("<meta name=\"description\" content=\""), i(1), t("\">")}),
            sn(nil, {t("<meta name=\"keywords\" content=\""), i(1), t("\">")}),
            sn(nil, {t("<meta name=\"author\" content=\""), i(1), t("\">")}),
            sn(nil, {t("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">")}),
        }),
    }),
    s("div", {
        t("<div"),
        c(1, {
            sn(nil, {t(" class=\""), i(1), t("\"")}),
            sn(nil, {t(" id=\""), i(1), t("\"")}),
            sn(nil, {t("")}),
        }),
        t(">"),
        i(2),
        t("</div>"),
    }),
    s("section", {
        t("<section"),
        c(1, {
            sn(nil, {t(" class=\""), i(1), t("\"")}),
            sn(nil, {t(" id=\""), i(1), t("\"")}),
            sn(nil, {t("")}),
        }),
        t(">"),
        t({"", "  "}),
        i(2),
        t({"", "</section>"}),
    }),
    s("a", {
        t("<a href=\""),
        i(1),
        t("\">"),
        i(2),
        t("</a>"),
    }),
    s("img", {
        t("<img src=\""),
        i(1),
        t("\" alt=\""),
        i(2),
        t("\">"),
    }),
    s("imgset", {
        t("<img"),
        t({"", "  srcset=\""}),
        i(1),
        t({"\"", "  alt=\""}),
        i(2),
        t({"\"", "  loading=\"lazy\">"}),
    }),
    s("button", {
        t("<button"),
        c(1, {
            sn(nil, {t(" class=\""), i(1), t("\"")}),
            sn(nil, {t(" type=\"button\"")}),
            sn(nil, {t("")}),
        }),
        t(">"),
        i(2),
        t("</button>"),
    }),
    s("input", {
        t("<input type=\""),
        i(1, "text"),
        t("\" name=\""),
        i(2),
        t("\""),
        c(3, {
            sn(nil, {t(" id=\""), i(1), t("\"")}),
            sn(nil, {t(" placeholder=\""), i(1), t("\"")}),
            sn(nil, {t(" required")}),
            sn(nil, {t("")}),
        }),
        t(">"),
    }),
    s("label", {
        t("<label for=\""),
        i(1),
        t("\">"),
        i(2),
        t("</label>"),
    }),
    s("table", {
        t("<table>"),
        t({"", "  <thead>", "    <tr>", "      <th>"}),
        i(1),
        t({"</th>", "    </tr>", "  </thead>", "  <tbody>", "    <tr>", "      <td>"}),
        i(2),
        t({"</td>", "    </tr>", "  </tbody>", "</table>"}),
    }),
    s("ul", {
        t("<ul>"),
        t({"", "  <li>"}),
        i(1),
        t({"</li>", "</ul>"}),
    }),
    s("class", {
        t("class=\""),
        i(1),
        t("\""),
    }),
    s("data", {
        t("data-"),
        i(1),
        t("=\""),
        i(2),
        t("\""),
    }),
    s("comment", {
        t("<!-- "),
        i(1),
        t(" -->"),
    }),
    s("iframe", {
        t("<iframe"),
        t({"", "  src=\""}),
        i(1),
        t({"\"", "  title=\""}),
        i(2),
        t({"\"", "  width=\"600\"", "  height=\"400\">", "</iframe>"}),
    }),
})