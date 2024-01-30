-- Vue / Vue.js Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.add_snippets("vue", {
    -- Vue Component (full)
    s("vue", {
        t({ "<script setup lang=\"ts\">", "" }),
        i(1),
        t({ "", "</script>", "", "<template>", "    <div>" }),
        t({ "", "        " }),
        i(2),
        t({ "", "    </div>", "</template>", "", "<style scoped lang=\"scss\">", "" }),
        i(3),
        t({ "", "</style>" }),
    }),
    -- Vue Component Script
    s("script", {
        t("<script setup lang=\"ts\">"),
        t({ "", "" }),
        i(1),
        t({ "", "</script>" }),
    }),
    -- Vue Component Template
    s("template", {
        t("<template>"),
        t({ "", "    " }),
        i(1),
        t({ "", "</template>" }),
    }),
    -- Vue Component Style (SCSS)
    s("style", {
        t("<style scoped lang=\"scss\">"),
        t({ "", "" }),
        i(1),
        t({ "", "</style>" }),
    }),
    -- Ref
    s("ref", {
        t("const "),
        i(1, "name"),
        t(" = ref"),
        c(2, {
            sn(nil, { t("<"), i(1, "Type"), t(">") }),
            t(""),
        }),
        t("("),
        i(3),
        t(");"),
    }),
    -- Reactive
    s("reactive", {
        t("const "),
        i(1, "state"),
        t(" = reactive({"),
        t({ "", "    " }),
        i(2),
        t({ "", "});" }),
    }),
    -- Computed
    s("computed", {
        t("const "),
        i(1, "name"),
        t(" = computed(() => "),
        i(2),
        t(");"),
    }),
    -- Computed with getter/setter
    s("computedgs", {
        t("const "),
        i(1, "name"),
        t({ " = computed({", "    get: () => " }),
        i(2),
        t({ ",", "    set: (value) => {", "        " }),
        i(3),
        t({ "", "    },", "});" }),
    }),
    -- Watch
    s("watch", {
        t("watch("),
        i(1, "source"),
        t({ ", (newValue, oldValue) => {", "    " }),
        i(2),
        t({ "", "});" }),
    }),
    -- Watch with options
    s("watchopt", {
        t("watch("),
        i(1, "source"),
        t({ ", (newValue, oldValue) => {", "    " }),
        i(2),
        t({ "", "}, { " }),
        c(3, {
            t("immediate: true"),
            t("deep: true"),
            t("immediate: true, deep: true"),
        }),
        t(" });"),
    }),
    -- WatchEffect
    s("watcheffect", {
        t({ "watchEffect(() => {", "    " }),
        i(1),
        t({ "", "});" }),
    }),
    -- Props with defaults
    s("props", {
        t({ "interface Props {", "    " }),
        i(1, "name"),
        t(": "),
        i(2, "string"),
        t({ ";", "}", "", "const props = withDefaults(defineProps<Props>(), {", "    " }),
        i(3),
        t({ "", "});" }),
    }),
    -- Props simple
    s("defineprops", {
        t("const props = defineProps<{"),
        t({ "", "    " }),
        i(1, "name"),
        t(": "),
        i(2, "string"),
        t({ ";", "}>();" }),
    }),
    -- Emits
    s("emit", {
        t({ "const emit = defineEmits<{", "    " }),
        i(1, "eventName"),
        t(": ["),
        i(2, "payload"),
        t(": "),
        i(3, "Type"),
        t({ "];", "}>();" }),
    }),
    -- onMounted
    s("onmounted", {
        t({ "onMounted(() => {", "    " }),
        i(1),
        t({ "", "});" }),
    }),
    -- onUnmounted
    s("onunmounted", {
        t({ "onUnmounted(() => {", "    " }),
        i(1),
        t({ "", "});" }),
    }),
    -- Composable
    s("composable", {
        t("export function use"),
        i(1, "Name"),
        t({ "() {", "    " }),
        i(2),
        t({ "", "", "    return {", "        " }),
        i(3),
        t({ "", "    };", "}" }),
    }),
    -- v-for
    s("vfor", {
        t("v-for=\""),
        i(1, "item"),
        t(" in "),
        i(2, "items"),
        t("\" :key=\""),
        i(3, "item.id"),
        t("\""),
    }),
    -- v-if
    s("vif", {
        t("v-if=\""),
        i(1, "condition"),
        t("\""),
    }),
    -- v-else-if
    s("velif", {
        t("v-else-if=\""),
        i(1, "condition"),
        t("\""),
    }),
    -- v-show
    s("vshow", {
        t("v-show=\""),
        i(1, "condition"),
        t("\""),
    }),
    -- v-model
    s("vmodel", {
        t("v-model=\""),
        i(1),
        t("\""),
    }),
    -- @click
    s("@click", {
        t("@click=\""),
        i(1),
        t("\""),
    }),
    -- :class
    s(":class", {
        t(":class=\"{ '"),
        i(1, "class-name"),
        t("': "),
        i(2, "condition"),
        t(" }\""),
    }),
    -- Provide
    s("provide", {
        t("provide("),
        i(1, "key"),
        t(", "),
        i(2, "value"),
        t(");"),
    }),
    -- Inject
    s("inject", {
        t("const "),
        i(1, "name"),
        t(" = inject<"),
        i(2, "Type"),
        t(">("),
        i(3, "key"),
        t(");"),
    }),
    -- RouterLink
    s("routerlink", {
        t("<RouterLink :to=\"{ name: '"),
        i(1, "routeName"),
        t("' }\">"),
        i(2),
        t("</RouterLink>"),
    }),
    -- useRoute
    s("useroute", {
        t("const route = useRoute();"),
    }),
    -- useRouter
    s("userouter", {
        t("const router = useRouter();"),
    }),
})