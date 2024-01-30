# http-ui - Nushell HTTP Request TUI

An interactive terminal UI for running JetBrains/IntelliJ `.http` files using native Nushell `http` commands.

## What it does

- Scans `/var/www/html/_http` for `.http` request files and `http-client.env.json` environments
- Presents a searchable sidebar with all requests, color-coded by HTTP method
- Resolves `{{variable}}` placeholders using the selected environment
- Executes requests with **native Nushell `http get|post|put|patch|delete|head|options`**
- Returns structured data that you can pipe directly into `where`, `select`, `sort-by`, etc.

## Installation

The module lives in `~/.config/nushell/http-ui/` and is auto-loaded via your `config.nu`:

```nu
use ~/.config/nushell/http-ui
```

A Python virtual environment at `~/.config/nushell/http-ui/venv/` provides the [Textual](https://textual.textualize.io/) TUI framework.

## Usage

```nu
# Run the TUI, pick a request, and get the parsed JSON body
http-ui

# Get the full response record: {urls, headers, body, status}
http-ui --full

# Get raw string output instead of parsed tables
http-ui --raw

# Combine flags
http-ui --full --raw --allow-errors --insecure
```

### Piping examples (the native Nushell superpower)

```nu
# Filter results by status field in the body
http-ui | get body | where status == 'done'

# Sort and select nested fields
http-ui | get items | sort-by public_id | select name public_id

# Search inside results
http-ui | get results | select url title | where title =~ 'example'

# Inspect response headers
http-ui --full | get headers | get response

# Get just the status code
http-ui --full | get status

# Chain with native nushell data manipulation
http-ui --raw | from json | get data | transpose key value | where value =~ "error"
```

## TUI Controls

| Key | Action |
|-----|--------|
| `j` / `↓` | Next request |
| `k` / `↑` | Previous request |
| `g` | Jump to first request |
| `G` | Jump to last request |
| `/` | Search/filter requests |
| `Enter` | Execute selected request |
| `e` | Switch environment (dev/local/production) |
| `c` | View current environment variables |
| `?` | Show help overlay (which-key style) |
| `q` / `Esc` | Quit without running |

## File Format

The TUI expects the same layout as JetBrains HTTP Client:

```
/var/www/html/_http/
├── artemis/
│   ├── partner-api.http
│   └── http-client.env.json
└── serp-cms/
    ├── content-api.http
    ├── image-api.http
    └── http-client.env.json
```

### `.http` file format

```http
### Request name shown in the sidebar
POST {{host}}/api/example
Content-Type: application/json

{
  "key": "{{variable}}"
}

### Another request
GET {{host}}/api/example?id=123
```

### `http-client.env.json` format

```json
{
  "dev": {
    "host": "https://api.example.com",
    "variable": "dev-value"
  },
  "local": {
    "host": "http://localhost:8000",
    "variable": "local-value"
  }
}
```

## Architecture

- **`http_tui.py`** - Python [Textual](https://textual.textualize.io/) app that parses files, renders the sidebar/preview, and prints the resolved request as JSON
- **`mod.nu`** - Nushell module that launches the TUI, reads the JSON, constructs the native `http` command, and returns structured data
- **History** - Last-run request is saved to `~/.config/nushell/http-ui/history.json` and re-selected on next launch

## Updating

If the Python dependencies ever need updating:

```bash
/root/.config/nushell/http-ui/venv/bin/pip install --upgrade textual
```
