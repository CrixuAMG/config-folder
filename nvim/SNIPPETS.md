# Snippets Documentatie

De snippets zijn opgeslagen in `~/.config/nvim/snippets/` en worden automatisch geladen door LuaSnip.
Snippets worden geïntegreerd met blink.cmp voor een naadloze autocomplete ervaring.

## Gebruik

- **Snippet picker**: `<leader>fs` opent een Snacks picker met alle beschikbare snippets
- **Trigger snippet**: Selecteer uit autocomplete of typ de trigger en Tab
- **Navigeer tussen placeholders**: `Ctrl+k` (volgende) of `Ctrl+j` (vorige)
- **Kies opties**: Druk op `Ctrl+l` om door choice nodes te cyclen

### Snippet Triggers per Taal/Framework

#### PHP

| Trigger | Beschrijving |
|---------|--------------|
| `class` | PHP class met strict_types |
| `fclass` | Final class |
| `roclass` | Readonly class met constructor |
| `interface` | PHP interface |
| `fn` | Functie (public/private/protected) |
| `ctor` | Constructor property promotion |
| `prop` | Property |
| `route` | Symfony Route attribute |
| `action` | Symfony controller action |
| `test` | PHPUnit test method |
| `ae` | assertEquals |
| `as` | assertSame |
| `at` | assertTrue |
| `af` | assertFalse |
| `[` | Multi-line array |
| `match` | Match expression |
| `arrow` | Arrow function |
| `throw` | Throw exception |
| `try` | Try-catch block |

#### Vue.js

| Trigger | Beschrijving |
|---------|--------------|
| `vue` | Volledig Vue SFC component |
| `script` | `<script setup>` tag |
| `template` | `<template>` tag |
| `style` | `<style scoped lang="scss">` tag |
| `ref` | Vue ref (met optioneel type) |
| `reactive` | Vue reactive |
| `computed` | Vue computed |
| `computedgs` | Computed met getter/setter |
| `watch` | Vue watch |
| `watchopt` | Watch met options |
| `watcheffect` | Vue watchEffect |
| `props` | Props met defaults |
| `defineprops` | Simpele defineProps |
| `emit` | Vue defineEmits |
| `onmounted` | Vue onMounted hook |
| `onunmounted` | Vue onUnmounted hook |
| `composable` | Vue composable function |
| `vfor` | v-for directive |
| `vif` | v-if directive |
| `velif` | v-else-if directive |
| `vshow` | v-show directive |
| `vmodel` | v-model directive |
| `@click` | @click handler |
| `:class` | Dynamic class binding |
| `provide` | Vue provide |
| `inject` | Vue inject |
| `routerlink` | Vue RouterLink |
| `useroute` | useRoute() |
| `userouter` | useRouter() |

#### SCSS

| Trigger | Beschrijving |
|---------|--------------|
| `mmin` | Media query min-width (brand-websites/helix) |
| `mmax` | Media query max-width (brand-websites/helix) |
| `media` | Media query exact range |
| `usemq` | @use 'mediaQueries' as * |
| `usedef` | @use 'defaultVariables' as * |
| `usemap` | @use 'sass:map' |
| `mqraw` | Raw media query |
| `bem` | BEM block structure |
| `__` | BEM element |
| `--` | BEM modifier |
| `mix` | Mixin definition |
| `inc` | Include mixin |
| `use` | Use module |
| `fwd` | Forward module |
| `$` | Variable |
| `flex` | Flexbox container |
| `grid` | Grid container |

#### CSS

| Trigger | Beschrijving |
|---------|--------------|
| `mq` | Media query |
| `flex` | Flexbox container |
| `grid` | Grid container |
| `var` | CSS variable |
| `--` | Define CSS variable |
| `root` | :root variables |
| `.` | Class selector |
| `keyframes` | Keyframes animation |
| `anim` | Animation shorthand |
| `trans` | Transition |
| `transform` | Transform |
| `abscenter` | Absolute center |
| `sticky` | Position sticky |
| `vishidden` | Visually hidden (a11y) |
| `truncate` | Text truncate |

#### Twig

| Trigger | Beschrijving |
|---------|--------------|
| `block` | Twig block |
| `extends` | Twig extends |
| `include` | Twig include |
| `if` | Twig if |
| `ifelse` | Twig if/else |
| `for` | Twig for loop |
| `forloop` | Twig for met loop variabelen |
| `macro` | Twig macro |
| `import` | Twig import |
| `set` | Twig set variabele |
| `trans` | Twig translate |
| `dump` | Twig dump |
| `path` | Symfony path() functie |
| `url` | Symfony url() functie |
| `asset` | Symfony asset() functie |
| `csrf` | Symfony csrf_token |
| `form_row` | Twig form row |
| `form_start` | Twig form start |
| `form_end` | Twig form end |

#### HTML

| Trigger | Beschrijving |
|---------|--------------|
| `html5` | HTML5 boilerplate |
| `script` | `<script>` tag |
| `sc` | Script met src |
| `scm` | Script met type="module" |
| `style` | `<style>` tag |
| `link` | Link stylesheet |
| `meta` | Meta tag keuze |
| `div` | Div met class/id |
| `section` | Section tag |
| `a` | Anchor link |
| `img` | Image tag |
| `imgset` | Image met srcset |
| `button` | Button |
| `input` | Input veld |
| `label` | Label |
| `table` | Table structuur |
| `ul` | Unordered list |
| `class` | class attribute |
| `data` | data-* attribute |
| `comment` | HTML comment |
| `iframe` | Iframe |

#### Lua (Neovim config)

| Trigger | Beschrijving |
|---------|--------------|
| `fun` | Functie |
| `lfun` | Lokale functie |
| `req` | Require statement |
| `mod` | Module definitie |
| `tbl` | Table |
| `pairs` | Pairs loop |
| `ipairs` | IPairs loop |
| `if` | If statement |
| `ife` | If/else |
| `while` | While loop |
| `repeat` | Repeat/until |
| `class` | Class-like pattern (metatable) |
| `print` | Print statement |
| `vimcmd` | vim.cmd() |
| `keymap` | vim.keymap.set() |
| `au` | autocmd |
| `aug` | augroup |
| `lazy` | Lazy.nvim plugin spec |
| `plug` | Plugin config |

## Snippets Uitbreiden

Voeg nieuwe snippets toe in de relevante `snippets/<filetype>.lua` bestand:
1. Open het bestand
2. Voeg een nieuwe `s("trigger", {...})` toe
3. Herstart Neovim of run `:LuaSnipUnlinkCurrent` en reopen het bestand

### Snippet Syntax

- `t("text")` - Statische tekst
- `i(n)` - Invoeg placeholder (n = positie)
- `c(n, {...})` - Keuze menu (cycle met Ctrl+l)
- `f(fn, ...)` - Functie node
- `d(n, ...)` - Dynamische node
- `sn(n, ...)` - Geneste snippet

Voor meer info: https://github.com/L3MON4D3/LuaSnip