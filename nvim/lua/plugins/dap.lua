local M = {}

function M.setup()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Keymaps
    vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        { desc = "Conditional Breakpoint" })
    vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
    vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
    vim.keymap.set({ "n", "v" }, "<leader>de", function() require("dapui").eval() end, { desc = "Eval" })

    -- Setup DAP UI
    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes",      size = 0.25 },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 0.25 },
                },
                position = "left",
                size = 40,
            },
            {
                elements = {
                    { id = "repl",    size = 0.5 },
                    { id = "console", size = 0.5 },
                },
                position = "bottom",
                size = 10,
            },
        },
    })

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- PHP/Xdebug configuration
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
    }

    dap.configurations.php = {
        {
            type      = "php",
            request   = "launch",
            name      = "Listen for Xdebug",
            port      = 9003,
            pathMappings = {
                -- Map Docker paths to local paths
                ["/var/www/html"] = "${workspaceFolder}",
            },
            log       = true,
            stopOnEntry = false,
        },
        {
            type      = "php",
            request   = "launch",
            name      = "Listen for Xdebug (stop on entry)",
            port      = 9003,
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}",
            },
            log       = true,
            stopOnEntry = true,
        },
    }

    -- Breakpoint signs
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

    -- Highlight groups
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })
end

return M
