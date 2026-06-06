#!/usr/bin/env nu
# vim: ft=nu
# Dynamisch keymap-overzicht voor geïnstalleerde software.
# Genereert tabellen van alle toetscombinaties uit configuratiebestanden.
# Usage: nu ~/.config/docs/keymaps.nu

def main [] {
    print "╔══════════════════════════════════════════════════════╗"
    print "║         KEYMAP OVERZICHT — TOETSCOMBINATIES         ║"
    print "╚══════════════════════════════════════════════════════╝\n"

    parse-skhdrc
    parse-kitty
    parse-lazygit
    parse-yabai

    print "\n╔══════════════════════════════════════════════════════╗"
    print "║  Legenda:  alt = ⌥ option  |  ctrl = ⌃ control     ║"
    print "║           shift = ⇧       |  cmd  = ⌘ command      ║"
    print "╚══════════════════════════════════════════════════════╝"
}

def fmt-key [raw] {
    $raw
    | str replace --all "alt" $"(ansi blue)⌥(ansi reset)"
    | str replace --all "ctrl" $"(ansi purple)⌃(ansi reset)"
    | str replace --all "shift" $"(ansi green)⇧(ansi reset)"
}

def parse-skhdrc [] {
    let path = ([$env.HOME ".config" "skhd" "skhdrc"] | path join)
    if (not ($path | path exists)) {
        print $"(ansi yellow)⚠ skhdrc niet gevonden(op $path)(ansi reset)\n"
        return
    }

    let raw = open $path | lines
    let bindings = $raw | reduce -f [] {|line, acc|
        let trimmed = ($line | str trim)
        if ($trimmed | str contains " : ") {
            let parts = ($trimmed | split row " : ")
            let key = ($parts.0 | str trim)
            let cmd = if (($parts | length) >= 2) { (($parts | skip 1 | str join " : ") | str trim) } else { "" }
            $acc | append { key: $key, cmd: $cmd }
        } else { $acc }
    }

    if (($bindings | length) == 0) { return }

    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print "  (ansi green)skhd(yansi reset) — vensterbeheer & sneltoetsen"
    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    $bindings | each {|b|
        let parts = ($b.key | split row "+")
        let mods = ($parts | each {|p| fmt-key ($p | str trim)} | str join "")
        let cmd_short = ($b.cmd
            | str replace "yabai -m " ""
            | str replace "open -a " "")
        print $"  (ansi cyan)($mods)(ansi reset)  →  (ansi yellow)($cmd_short)(ansi reset)"
    }
    print ""
}

def parse-kitty [] {
    let path = ([$env.HOME ".config" "kitty" "kitty.conf"] | path join)
    if (not ($path | path exists)) {
        print $"(ansi yellow)⚠ kitty.conf niet gevonden(op $path)(ansi reset)\n"
        return
    }

    let lines = (open $path | lines | where ($in | str starts-with "map "))
    if (($lines | length) == 0) { return }

    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print "  (ansi green)kitty(yansi reset) — terminal mappings"
    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    $lines | each {|line|
        let rest = ($line | str replace "map " "")
        let parts = ($rest | split row " ")
        let key = ($parts.0)
        let cmd = ($parts | skip 1 | str join " ")
        let key_fmt = ($key
            | str replace "ctrl+shift" $"(ansi purple)⌃⇧(ansi reset)"
            | str replace "ctrl" $"(ansi purple)⌃(ansi reset)")
        print $"  (ansi cyan)($key_fmt)(ansi reset)  →  (ansi yellow)($cmd)(ansi reset)"
    }
    print ""
}

def parse-lazygit [] {
    let path = ([$env.HOME ".config" "lazygit" "config.yml"] | path join)
    if (not ($path | path exists)) {
        print $"(ansi yellow)⚠ lazygit config niet gevonden(op $path)(ansi reset)\n"
        return
    }

    let data = (open $path)
    let custom = (try { $data.customCommands } catch { return })

    if (($custom | length) == 0) { return }

    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print "  (ansi green)lazygit(yansi reset) — custom commands"
    print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    $custom | each {|c|
        let key = ($c.key
            | str replace "<c-g>" $"(ansi purple)⌃G(ansi reset)"
            | str replace "<c-" $"(ansi purple)⌃(ansi reset)"
            | str replace ">" "")
        print $"  (ansi cyan)($key)(ansi reset)  →  (ansi yellow)($c.description)(ansi reset)  (ansi dark_gray)[($c.context)](ansi reset)"
    }
    print ""
}

def parse-yabai [] {
    let path = ([$env.HOME ".config" "yabai" "yabairc"] | path join)
    if (not ($path | path exists)) {
        print $"(ansi yellow)⚠ yabairc niet gevonden(op $path)(ansi reset)\n"
        return
    }

    let lines = (open $path | lines)
    let configs = ($lines | where ($in | str starts-with "yabai -m config "))
    let rules = ($lines | where ($in | str starts-with "yabai -m rule "))

    if (($configs | length) > 0) {
        print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        print "  (ansi green)yabai(yansi reset) — configuratie"
        print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $configs | each {|line|
            let trimmed = ($line | str replace "yabai -m config " "")
            let parts = ($trimmed | split row " ")
            let val = ($parts | skip 1 | str join " ")
            print $"  (ansi cyan)($parts.0)(ansi reset) = (ansi yellow)($val)(ansi reset)"
        }
        print ""
    }
}
