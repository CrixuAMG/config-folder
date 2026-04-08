local M = {}

function M.setup()
    -- Snacks.nvim
    require("snacks").setup({
        dashboard = { enabled = false },
        debug = { enabled = true },
        git = { enabled = true },
        gitbrowse = { enabled = true },
        image = { enabled = true },
        indent = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scratch = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    })

    -- Keymaps for Snacks (Manually register since we are not using lazy.nvim's `keys`)
    local set = vim.keymap.set
    -- Top Pickers & Explorer
    set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
    set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
    set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
    set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
    -- find
    set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
    set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
    set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
    set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
    set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
    -- git
    set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
    set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
    set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
    set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
    set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
    set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
    set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
    -- Grep
    set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
    set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
    set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
    set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
    -- search
    set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
    set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
    set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
    set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
    set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
    set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
    set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
    set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
    set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
    set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
    set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
    set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
    set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
    set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
    set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
    set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
    set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
    set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
    set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
    set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
    set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
    -- LSP
    set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
    set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
    set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "Goto References" })
    set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
    set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
    set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
    set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
    -- Other
    set("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
    set("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
    set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
    set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
    set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
    set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
    set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
    set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
    set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
    set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
    set("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
    set("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
    set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
    set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
    set("n", "<leader>N", function()
        Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
                spell = false,
                wrap = false,
                signcolumn = "yes",
                statuscolumn = " ",
                conceallevel = 3,
            },
        })
    end, { desc = "Neovim News" })
    -- (Add other keys as needed from the original file)

    -- Which-key
    require("which-key").setup({
        preset = 'modern'
    })

    -- Noice
    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    })
end

return M
