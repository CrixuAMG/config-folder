-- PHP / Symfony Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local f = ls.function_node

ls.add_snippets("php", {
    -- Class definition
    s("class", {
        t({ "<?php", "", "declare(strict_types=1);", "", "namespace " }),
        i(1, "App"),
        t({ ";", "", "class " }),
        i(2, "ClassName"),
        t({ "", "{", "    " }),
        i(3),
        t({ "", "}" }),
    }),
    -- Final class
    s("fclass", {
        t({ "<?php", "", "declare(strict_types=1);", "", "namespace " }),
        i(1, "App"),
        t({ ";", "", "final class " }),
        i(2, "ClassName"),
        t({ "", "{", "    " }),
        i(3),
        t({ "", "}" }),
    }),
    -- Readonly class
    s("roclass", {
        t({ "<?php", "", "declare(strict_types=1);", "", "namespace " }),
        i(1, "App"),
        t({ ";", "", "final readonly class " }),
        i(2, "ClassName"),
        t({ "", "{", "    public function __construct(", "        " }),
        i(3),
        t({ ",", "    ) {", "    }", "}" }),
    }),
    -- Interface
    s("interface", {
        t({ "<?php", "", "declare(strict_types=1);", "", "namespace " }),
        i(1, "App"),
        t({ ";", "", "interface " }),
        i(2, "InterfaceName"),
        t({ "", "{", "    " }),
        i(3),
        t({ "", "}" }),
    }),
    -- Function
    s("fn", {
        c(1, {
            t("public "),
            t("private "),
            t("protected "),
        }),
        t("function "),
        i(2, "name"),
        t("("),
        i(3),
        t("): "),
        i(4, "void"),
        t({ "", "{", "    " }),
        i(5),
        t({ "", "}" }),
    }),
    -- Constructor property promotion
    s("ctor", {
        t({ "public function __construct(", "    " }),
        c(1, {
            t("private "),
            t("public "),
            t("protected "),
            t("private readonly "),
        }),
        i(2, "Type"),
        t(" $"),
        i(3, "name"),
        t({ ",", ") {", "}" }),
    }),
    -- Property
    s("prop", {
        c(1, {
            t("private "),
            t("public "),
            t("protected "),
            t("private readonly "),
        }),
        i(2, "Type"),
        t(" $"),
        i(3, "name"),
        t(";"),
    }),
    -- Route attribute
    s("route", {
        t("#[Route('/"),
        i(1, "path"),
        t("', name: '"),
        i(2, "name"),
        t("'"),
        c(3, {
            t(")]"),
            sn(nil, { t(", methods: ['"), i(1, "GET"), t("'])]") }),
        }),
    }),
    -- Symfony controller action
    s("action", {
        t("#[Route('/"),
        i(1, "path"),
        t("', name: '"),
        i(2, "name"),
        t({ "')]", "public function " }),
        i(3, "index"),
        t("("),
        i(4),
        t("): "),
        c(5, {
            t("Response"),
            t("JsonResponse"),
            t("RedirectResponse"),
        }),
        t({ "", "{", "    " }),
        i(6),
        t({ "", "}" }),
    }),
    -- Test method
    s("test", {
        t({ "public function test" }),
        i(1, "MethodName"),
        t({ "(): void", "{", "    " }),
        i(2),
        t({ "", "}" }),
    }),
    -- PHPUnit assert
    s("ae", {
        t("$this->assertEquals("),
        i(1, "expected"),
        t(", "),
        i(2, "actual"),
        t(");"),
    }),
    s("as", {
        t("$this->assertSame("),
        i(1, "expected"),
        t(", "),
        i(2, "actual"),
        t(");"),
    }),
    s("at", {
        t("$this->assertTrue("),
        i(1, "condition"),
        t(");"),
    }),
    s("af", {
        t("$this->assertFalse("),
        i(1, "condition"),
        t(");"),
    }),
    -- Array
    s("[", {
        t("["),
        t({ "", "    " }),
        i(1),
        t({ "", "]" }),
    }),
    -- Match expression
    s("match", {
        t("match ("),
        i(1, "expression"),
        t({ ") {", "    " }),
        i(2, "value"),
        t(" => "),
        i(3, "result"),
        t({ ",", "    default => " }),
        i(4, "default"),
        t({ ",", "};" }),
    }),
    -- Arrow function
    s("arrow", {
        t("fn ("),
        i(1),
        t(") => "),
        i(2),
    }),
    -- Throw exception
    s("throw", {
        t("throw new "),
        c(1, {
            t("Exception"),
            t("InvalidArgumentException"),
            t("RuntimeException"),
            t("LogicException"),
        }),
        t("('"),
        i(2, "message"),
        t("');"),
    }),
    -- Try-catch
    s("try", {
        t({ "try {", "    " }),
        i(1),
        t({ "", "} catch (" }),
        i(2, "Exception"),
        t({ " $e) {", "    " }),
        i(3),
        t({ "", "}" }),
    }),
})