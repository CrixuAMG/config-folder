# http-ui Nushell module
# Provides an interactive TUI for running JetBrains/IntelliJ .http files
# using native Nushell http commands.

# Path to the Python TUI script
const SCRIPT = ($nu.default-config-dir | path join "http-ui" "http_tui.py")
const PYTHON = ($nu.default-config-dir | path join "http-ui" "venv" "bin" "python")

# Run the interactive HTTP request selector and execute the chosen request
# with native Nushell http capabilities.
#
# The TUI reads files from /var/www/html/_http and supports environment
# variables defined in http-client.env.json files.
#
# Examples:
#   http-ui                              # Run a request, get parsed body
#   http-ui --full                       # Get {urls, headers, body, status}
#   http-ui --raw                        # Get raw string body
#   http-ui --full --raw                 # Get full response with raw body
#   http-ui | get body | where status == 'done'
#   http-ui | get items | sort-by public_id | select name public_id
#   http-ui | get results | select url title | where title =~ 'example'
#   http-ui --full | get headers | get response
#   http-ui --allow-errors               # Don't fail on 4xx/5xx
#   http-ui --insecure                   # Skip SSL verification
#
# TUI Key Bindings:
#   j/Down    Next request
#   k/Up      Previous request
#   g         First request
#   G         Last request
#   /         Search/filter requests
#   Enter     Execute selected request
#   e         Switch environment (dev/local/production)
#   c         View current environment config
#   ?         Show help overlay
#   q/Esc     Quit without running
export def main [
    --full (-f)          # Return full response record with status, headers, and body
    --raw (-r)           # Return raw string instead of parsed table
    --allow-errors (-e)  # Do not fail if the server returns an error code
    --insecure (-k)      # Allow insecure server connections when using SSL
] {
    # Run the TUI script. It prints a JSON line with the resolved request on success.
    let output = (run-external $PYTHON $SCRIPT | complete)

    if $output.exit_code != 0 {
        error make {
            msg: "http-ui TUI failed",
            label: { text: $output.stderr }
        }
    }

    let stdout = ($output.stdout | str trim)

    # Empty output means the user quit without selecting a request.
    if ($stdout | is-empty) {
        return
    }

    let request = ($stdout | from json)

    let url = $request.url
    let method = ($request.method | str downcase)
    let headers = $request.headers
    let body = $request.body
    let content_type = ($request.content_type? | default "")

    # Build the inner nushell command as a string.
    # We always pass --full internally so we can decide later whether to
    # return the whole record or just the body.
    mut inner = $'http ($method) --full'

    if $raw {
        $inner = $'($inner) --raw'
    }
    if $allow_errors {
        $inner = $'($inner) --allow-errors'
    }
    if $insecure {
        $inner = $'($inner) --insecure'
    }

    if ($headers | is-not-empty) {
        let h = ($headers | to nuon)
        $inner = $'($inner) --headers ($h)'
    }

    if ($content_type | is-not-empty) {
        let ct = ($content_type | to nuon)
        $inner = $'($inner) --content-type ($ct)'
    }

    # DELETE uses --data flag for its body.
    if ($method == "delete") and ($body | is-not-empty) {
        let b = ($body | to nuon)
        $inner = $'($inner) --data ($b)'
    }

    # Add URL (always positional).
    $inner = $'($inner) ($url | to nuon)'

    # POST/PUT/PATCH body is positional.
    if ($method in ["post" "put" "patch"]) and ($body | is-not-empty) {
        let b = ($body | to nuon)
        $inner = $'($inner) ($b)'
    }

    # Serialize to JSON so the outer shell can parse it back into structured data.
    $inner = $'($inner) | to json'

    # Execute the inner command in a clean nushell subprocess (-n = no config file).
    let result_json = (nu -n -c $inner)
    let result = ($result_json | from json)

    # Return full record when requested, otherwise just the body for easy piping.
    if $full {
        $result
    } else {
        $result.body
    }
}
