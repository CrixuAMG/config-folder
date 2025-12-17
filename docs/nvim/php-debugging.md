# PHP Debugging in Neovim

## Overview

This guide covers PHPUnit testing and Xdebug step debugging in Neovim inside the Docker container `dev.ldev.nl`.

## PHPUnit (neotest)

### Keybindings

| Key | Description |
|-----|-------------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run current file |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Open test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop test |
| `[t` | Jump to previous failed test |
| `]t` | Jump to next failed test |

### Configuration

The PHPUnit adapter is configured in `nvim/lua/plugins/neotest.lua`. It automatically uses:
- `bin/phpunit` for most projects
- `bin/phpunit-all` for brand-websites

## Step Debugging (DAP + Xdebug)

### Prerequisites

1. Install the PHP debug adapter in Neovim:
   ```
   :MasonInstall php-debug-adapter
   ```

2. Ensure Xdebug is configured in the container (`/etc/php.d/15-xdebug.ini`):
   ```ini
   zend_extension=xdebug.so
   xdebug.mode=debug
   xdebug.start_with_request=trigger
   xdebug.client_host=host.docker.internal
   xdebug.client_port=9003
   xdebug.idekey=VSCODE
   ```

### DAP Keybindings

| Key | Description |
|-----|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Eval (normal/visual mode) |

### Xdebug Shell Commands

Run these inside the Docker container:

| Command | Alias | Description |
|---------|-------|-------------|
| `xdebug-enable` | `xde` | Enable Xdebug |
| `xdebug-disable` | `xdd` | Disable Xdebug |
| `xdebug-status` | `xds` | Check Xdebug status |
| `xdebug-toggle` | `xd` | Toggle Xdebug on/off |

## Debugging Workflow

### Step 1: Enable Xdebug
```bash
xde  # or xdebug-enable
```

### Step 2: Set Breakpoints
In Neovim, navigate to the line where you want to break and press:
```
<leader>db
```
A red dot (●) will appear in the sign column.

### Step 3: Start Listening
Press `<leader>dc` to start the debugger. It will listen on port 9003.

### Step 4: Trigger the Code

**For PHPUnit tests:**
```
<leader>tt
```

**For web requests:**
Add `XDEBUG_TRIGGER=1` to your request:
```bash
curl "http://localhost/your-endpoint?XDEBUG_TRIGGER=1"
```

Or use a browser extension to set the Xdebug cookie.

### Step 5: Debug
Once the breakpoint is hit:
- `<leader>di` - Step into function calls
- `<leader>do` - Step over current line
- `<leader>dO` - Step out of current function
- `<leader>dc` - Continue to next breakpoint
- `<leader>de` - Evaluate expression under cursor

### Step 6: Disable Xdebug
When done debugging, disable Xdebug for better performance:
```bash
xdd  # or xdebug-disable
```

## Troubleshooting

### Breakpoints not hitting
1. Check Xdebug is enabled: `xds`
2. Verify path mappings in `nvim/lua/plugins/dap.lua`
3. Ensure port 9003 is not blocked

### DAP UI not opening
Run `:MasonInstall php-debug-adapter` to ensure the adapter is installed.

### Connection refused
Make sure `xdebug.client_host` is set to `host.docker.internal` in the container.

