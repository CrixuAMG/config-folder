#!/usr/bin/env python3
"""
http_tui.py - A Textual TUI for selecting and executing .http requests.

Usage:
    python http_tui.py

Prints a single JSON line to stdout describing the selected request, then exits.
If the user quits without selecting, nothing is printed.

Environment:
    HTTP_DIR    - Directory containing .http files (default: /var/www/html/_http)
"""

import json
import os
import re
from pathlib import Path

from textual.app import App, ComposeResult
from textual.containers import Horizontal, Vertical
from textual.screen import ModalScreen
from textual.widgets import Footer, Input, Label, ListItem, ListView, Static
from rich.text import Text

HTTP_DIR = Path(os.environ.get("HTTP_DIR", "/var/www/html/_http"))
HISTORY_FILE = Path.home() / ".config/nushell/http-ui/history.json"

METHOD_COLORS = {
    "GET": "#98c379",
    "POST": "#e5c07b",
    "PUT": "#61afef",
    "PATCH": "#c586c0",
    "DELETE": "#e06c75",
    "HEAD": "#56b6c2",
    "OPTIONS": "#abb2bf",
}


def make_label(req: dict) -> Text:
    method = req["method"]
    color = METHOD_COLORS.get(method, "white")
    t = Text()
    t.append(f"[{method}] ", style=f"bold {color}")
    t.append(f"{req['project']}/{req['file']} - {req['name']}")
    return t


class HelpScreen(ModalScreen):
    """Overlay showing all keybindings in a which-key style."""

    def compose(self) -> ComposeResult:
        yield Static(
            """
[bold white on green] HTTP UI Key Bindings [/bold white on green]

  [yellow]j / Down[/yellow]  Next request
  [yellow]k / Up[/yellow]    Previous request
  [yellow]g[/yellow]         First request
  [yellow]G[/yellow]         Last request
  [yellow]/[/yellow]         Search/filter requests
  [yellow]Enter[/yellow]     Execute selected request
  [yellow]e[/yellow]         Switch environment
  [yellow]c[/yellow]         View current env config
  [yellow]?[/yellow]         Show this help
  [yellow]q / Esc[/yellow]   Quit without running

Press any key to close this help.
""",
            id="help",
        )

    def on_key(self, event) -> None:
        self.dismiss()


class ConfigScreen(ModalScreen):
    """Overlay showing the current environment variables."""

    def __init__(self, config: dict, env_name: str) -> None:
        self.config = config
        self.env_name = env_name
        super().__init__()

    def compose(self) -> ComposeResult:
        text = f"[bold]Environment:[/bold] {self.env_name}\n\n"
        text += "[bold]Variables:[/bold]\n"
        text += json.dumps(self.config, indent=2)
        yield Static(text, id="config")

    def on_key(self, event) -> None:
        self.dismiss()


class EnvScreen(ModalScreen):
    """Modal for picking an environment."""

    def __init__(self, envs: list, current: str) -> None:
        self.envs = envs
        self.current = current
        super().__init__()

    def compose(self) -> ComposeResult:
        yield Static("[bold]Select Environment[/bold] (j/k to move, Enter to pick, Esc to cancel)")
        lv = ListView(id="env-list")
        for env in self.envs:
            marker = " * " if env == self.current else "   "
            style = "bold yellow" if env == self.current else ""
            label = Text(f"{marker}{env}", style=style)
            lv.append(ListItem(Label(label)))
        yield lv

    def on_list_view_selected(self, event: ListView.Selected) -> None:
        if 0 <= event.list_view.index < len(self.envs):
            self.dismiss(self.envs[event.list_view.index])

    def on_key(self, event) -> None:
        if event.key == "escape":
            self.dismiss(None)


class SearchScreen(ModalScreen):
    """Live-filter search modal."""

    def __init__(self, all_requests: list) -> None:
        self.all_requests = all_requests
        self.filtered = list(all_requests)
        super().__init__()

    def compose(self) -> ComposeResult:
        yield Input(placeholder="Type to filter requests...", id="search-input")
        lv = ListView(id="search-list")
        self._populate(lv)
        yield lv

    def _populate(self, lv: ListView) -> None:
        lv.clear()
        for req in self.filtered:
            lv.append(ListItem(Label(make_label(req))))

    def on_input_changed(self, event: Input.Changed) -> None:
        q = event.value.lower()
        self.filtered = [
            r
            for r in self.all_requests
            if q in r["name"].lower()
            or q in r["project"].lower()
            or q in r["file"].lower()
        ]
        lv = self.query_one("#search-list", ListView)
        self._populate(lv)
        if self.filtered:
            lv.index = 0

    def on_list_view_selected(self, event: ListView.Selected) -> None:
        if 0 <= event.list_view.index < len(self.filtered):
            self.dismiss(self.filtered[event.list_view.index])

    def on_key(self, event) -> None:
        if event.key == "escape":
            self.dismiss(None)
        elif event.key == "down":
            lv = self.query_one("#search-list", ListView)
            if lv.index is not None and lv.index < len(self.filtered) - 1:
                lv.index += 1
            event.stop()
        elif event.key == "up":
            lv = self.query_one("#search-list", ListView)
            if lv.index is not None and lv.index > 0:
                lv.index -= 1
            event.stop()
        elif event.key == "enter":
            lv = self.query_one("#search-list", ListView)
            if lv.index is not None and 0 <= lv.index < len(self.filtered):
                self.dismiss(self.filtered[lv.index])
            event.stop()


class HttpApp(App):
    """Main TUI application."""

    CSS = """
    Screen { align: center middle; }
    #main { height: 100%; }
    #sidebar { width: 45%; border-right: solid $primary; }
    #preview { width: 55%; padding: 1 2; }
    #help, #config {
        width: 60;
        height: auto;
        max-height: 80%;
        border: thick $primary;
        padding: 1 2;
        background: $surface;
    }
    ListView { height: 100%; }
    ListView:focus > ListItem.--highlight {
        background: $primary 20%;
    }
    Footer { height: 1; }
    """

    BINDINGS = [
        ("q", "quit", "Quit"),
        ("?", "help", "Help"),
        ("e", "env", "Env"),
        ("c", "config", "Config"),
        ("j", "next", "Next"),
        ("k", "prev", "Prev"),
        ("g", "first", "First"),
        ("G", "last", "Last"),
        ("/", "search", "Search"),
        ("enter", "execute", "Execute"),
        ("escape", "quit", "Quit"),
    ]

    def __init__(self) -> None:
        self.requests: list[dict] = []
        self.projects: dict[str, dict] = {}
        self.current_env = "dev"
        self.last_selection: dict | None = None
        super().__init__()

    def compose(self) -> ComposeResult:
        with Horizontal(id="main"):
            with Vertical(id="sidebar"):
                yield ListView(id="request-list")
            yield Static("", id="preview")
        yield Footer()

    def on_mount(self) -> None:
        self.load_projects()
        self.load_history()
        self.populate_sidebar()
        self.select_history()
        lv = self.query_one("#request-list", ListView)
        if lv.index is None and self.requests:
            lv.index = 0
        self.update_preview()
        lv.focus()

    def load_projects(self) -> None:
        if not HTTP_DIR.exists():
            return
        for project_dir in sorted(HTTP_DIR.iterdir()):
            if not project_dir.is_dir():
                continue
            env_file = project_dir / "http-client.env.json"
            envs: dict = {}
            if env_file.exists():
                try:
                    with open(env_file, encoding="utf-8") as f:
                        envs = json.load(f)
                except Exception:
                    pass
            reqs: list[dict] = []
            for hf in sorted(project_dir.glob("*.http")):
                reqs.extend(self.parse_http_file(hf, project_dir.name, envs))
            self.projects[project_dir.name] = {"envs": envs, "requests": reqs}
            self.requests.extend(reqs)

    def parse_http_file(self, path: Path, project: str, envs: dict) -> list[dict]:
        text = path.read_text(encoding="utf-8")
        parts = re.split(r"(?m)^###\s+", text)
        results = []
        for part in parts:
            part = part.strip()
            if not part:
                continue
            lines = part.splitlines()
            name = lines[0].strip()
            method = "GET"
            url = ""
            headers: dict[str, str] = {}
            body_lines: list[str] = []
            stage = "find_method"
            for line in lines[1:]:
                stripped = line.strip()
                if stage == "find_method":
                    m = re.match(
                        r"^(GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS)\s+(.+)$",
                        stripped,
                        re.IGNORECASE,
                    )
                    if m:
                        method = m.group(1).upper()
                        url = m.group(2).strip()
                        stage = "headers"
                    continue
                if stage == "headers":
                    if stripped == "":
                        stage = "body"
                        continue
                    if ":" in stripped:
                        k, v = stripped.split(":", 1)
                        headers[k.strip()] = v.strip()
                    else:
                        stage = "body"
                        body_lines.append(line)
                    continue
                if stage == "body":
                    body_lines.append(line)
            body = "\n".join(body_lines).strip()
            results.append(
                {
                    "project": project,
                    "file": path.name,
                    "name": name,
                    "method": method,
                    "url": url,
                    "headers": headers,
                    "body": body,
                    "envs": envs,
                }
            )
        return results

    def resolve(self, req: dict) -> dict:
        env = req["envs"].get(self.current_env, {})
        resolved = dict(req)
        resolved["url"] = self._substitute(req["url"], env)
        resolved["body"] = self._substitute(req["body"], env)
        resolved["env"] = self.current_env
        return resolved

    def _substitute(self, text: str, env: dict) -> str:
        for k, v in env.items():
            text = text.replace(f"{{{{{k}}}}}", str(v))
        return text

    def populate_sidebar(self) -> None:
        lv = self.query_one("#request-list", ListView)
        lv.clear()
        for req in self.requests:
            lv.append(ListItem(Label(make_label(req))))

    def select_history(self) -> None:
        if not self.last_selection:
            return
        lv = self.query_one("#request-list", ListView)
        for i, req in enumerate(self.requests):
            if (
                req["project"] == self.last_selection.get("project")
                and req["file"] == self.last_selection.get("file")
                and req["name"] == self.last_selection.get("name")
            ):
                lv.index = i
                return

    def update_preview(self) -> None:
        lv = self.query_one("#request-list", ListView)
        preview = self.query_one("#preview", Static)
        if lv.index is None or not (0 <= lv.index < len(self.requests)):
            preview.update("No request selected.")
            return
        req = self.resolve(self.requests[lv.index])
        lines = [
            f"[bold]Request:[/bold]  {req['name']}",
            f"[bold]Project:[/bold]  {req['project']}",
            f"[bold]File:[/bold]     {req['file']}",
            f"[bold]Env:[/bold]      {req['env']}",
            "",
            f"[bold]{req['method']}[/bold] {req['url']}",
            "",
            "[bold]Headers:[/bold]",
        ]
        for k, v in req["headers"].items():
            lines.append(f"  {k}: {v}")
        if req["body"]:
            lines.append("")
            lines.append("[bold]Body:[/bold]")
            b = req["body"]
            if len(b) > 1200:
                b = b[:1200] + "\n... (truncated)"
            lines.append(b)
        preview.update("\n".join(lines))

    def on_list_view_selected(self, event: ListView.Selected) -> None:
        self.action_execute()

    def on_list_view_highlighted(self, event: ListView.Highlighted) -> None:
        self.update_preview()

    def action_next(self) -> None:
        focused = self.screen.focused
        if isinstance(focused, Input):
            return
        lv = self.query_one("#request-list", ListView)
        if lv.index is not None and lv.index < len(self.requests) - 1:
            lv.index += 1

    def action_prev(self) -> None:
        focused = self.screen.focused
        if isinstance(focused, Input):
            return
        lv = self.query_one("#request-list", ListView)
        if lv.index is not None and lv.index > 0:
            lv.index -= 1

    def action_first(self) -> None:
        focused = self.screen.focused
        if isinstance(focused, Input):
            return
        lv = self.query_one("#request-list", ListView)
        if self.requests:
            lv.index = 0

    def action_last(self) -> None:
        focused = self.screen.focused
        if isinstance(focused, Input):
            return
        lv = self.query_one("#request-list", ListView)
        if self.requests:
            lv.index = len(self.requests) - 1

    def action_search(self) -> None:
        def on_result(req: dict | None) -> None:
            if req is None:
                return
            lv = self.query_one("#request-list", ListView)
            for i, r in enumerate(self.requests):
                if r is req or (
                    r["project"] == req["project"]
                    and r["file"] == req["file"]
                    and r["name"] == req["name"]
                ):
                    lv.index = i
                    self.update_preview()
                    lv.focus()
                    return

        self.push_screen(SearchScreen(self.requests), callback=on_result)

    def action_execute(self) -> None:
        lv = self.query_one("#request-list", ListView)
        if lv.index is None or not (0 <= lv.index < len(self.requests)):
            return
        req = self.resolve(self.requests[lv.index])
        self.save_history(req)
        output = {
            "project": req["project"],
            "file": req["file"],
            "request_name": req["name"],
            "method": req["method"],
            "url": req["url"],
            "headers": req["headers"],
            "body": req["body"],
            "content_type": req["headers"].get("Content-Type", ""),
        }
        print(json.dumps(output))
        self.exit()

    def action_help(self) -> None:
        self.push_screen(HelpScreen())

    def action_env(self) -> None:
        lv = self.query_one("#request-list", ListView)
        if lv.index is None:
            return
        req = self.requests[lv.index]
        envs = list(req["envs"].keys())
        if not envs:
            return

        def on_result(selected: str | None) -> None:
            if selected:
                self.current_env = selected
                self.update_preview()

        self.push_screen(EnvScreen(envs, self.current_env), callback=on_result)

    def action_config(self) -> None:
        lv = self.query_one("#request-list", ListView)
        if lv.index is None:
            return
        req = self.requests[lv.index]
        config = req["envs"].get(self.current_env, {})
        self.push_screen(ConfigScreen(config, self.current_env))

    def load_history(self) -> None:
        if HISTORY_FILE.exists():
            try:
                with open(HISTORY_FILE, encoding="utf-8") as f:
                    self.last_selection = json.load(f)
            except Exception:
                pass

    def save_history(self, req: dict) -> None:
        HISTORY_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(HISTORY_FILE, "w", encoding="utf-8") as f:
            json.dump(
                {
                    "project": req["project"],
                    "file": req["file"],
                    "name": req["name"],
                },
                f,
            )


if __name__ == "__main__":
    app = HttpApp()
    app.run()
