--- Custom nvim-cmp source for OpenCode CLI completions
--- Provides Copilot-like inline suggestions via `opencode complete`
---
--- Configurable via require('cmp_opencode').setup({ ... })

local M = {}

--- Default configuration
M.config = {
    enabled = true,
    --- Command to run for completions (list of strings)
    command = { "opencode", "complete" },
    --- Max time to wait for a response (ms)
    timeout = 5000,
    --- Debounce delay before calling OpenCode (ms)
    debounce_ms = 300,
    --- Minimum keyword length before triggering
    min_keyword_length = 2,
    --- Build the request payload from cmp context
    ---@param context table nvim-cmp context
    ---@return string
    build_request = function(context)
        local bufnr = context.bufnr
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local cursor_row = context.cursor.row
        local cursor_col = context.cursor.col
        return vim.json.encode({
            filepath = vim.api.nvim_buf_get_name(bufnr),
            cursor = {
                line = cursor_row - 1,          -- 0-indexed
                character = cursor_col - 1,
            },
            text = table.concat(lines, "\n"),
        })
    end,
    --- Parse stdout lines into nvim-cmp completion items
    --- Tries JSON array first, then falls back to line-per-completion
    ---@param lines string[]
    ---@return table[]
    parse_response = function(lines)
        local items = {}
        local text = table.concat(lines, "\n")

        -- Attempt JSON array/object response
        local ok, decoded = pcall(vim.json.decode, text)
        if ok and type(decoded) == "table" then
            if vim.islist(decoded) then
                for _, item in ipairs(decoded) do
                    if type(item) == "string" then
                        table.insert(items, {
                            label = item,
                            insertText = item,
                            kind = vim.lsp.protocol.CompletionItemKind.Text,
                        })
                    elseif type(item) == "table" and (item.text or item.label) then
                        table.insert(items, {
                            label = item.label or item.text,
                            insertText = item.text or item.label,
                            kind = item.kind or vim.lsp.protocol.CompletionItemKind.Text,
                            documentation = item.documentation,
                        })
                    end
                end
                return items
            elseif decoded.text or decoded.label then
                -- Single object response
                table.insert(items, {
                    label = decoded.label or decoded.text,
                    insertText = decoded.text or decoded.label,
                    kind = decoded.kind or vim.lsp.protocol.CompletionItemKind.Text,
                    documentation = decoded.documentation,
                })
                return items
            end
        end

        -- Fallback: each non-empty line is a completion candidate
        for _, line in ipairs(lines) do
            line = vim.trim(line)
            if line ~= "" then
                table.insert(items, {
                    label = line,
                    insertText = line,
                    kind = vim.lsp.protocol.CompletionItemKind.Text,
                })
            end
        end
        return items
    end,
}

-- Internal state
local is_enabled = true
local timer = nil
local current_job = nil

--- Check if the source is currently enabled
M.is_enabled = function()
    return is_enabled
end

--- Toggle the source on/off
M.toggle = function()
    is_enabled = not is_enabled
    vim.notify("OpenCode cmp source " .. (is_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

--- Override default configuration
---@param opts table
M.setup = function(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- nvim-cmp source interface -------------------------------------------------

local source = {}

source.new = function()
    return setmetatable({}, { __index = source })
end

source.is_available = function()
    return M.is_enabled()
end

source.get_trigger_characters = function()
    return {}
end

source.complete = function(_, params, callback)
    if not M.is_enabled() then
        callback({ items = {}, isIncomplete = false })
        return
    end

    local ctx = params.context
    local cursor_before = ctx.cursor_before_line

    -- Avoid triggering on empty or very short input
    if #vim.trim(cursor_before) < M.config.min_keyword_length then
        callback({ items = {}, isIncomplete = false })
        return
    end

    -- Tear down any in-flight request
    if current_job then
        pcall(vim.fn.jobstop, current_job)
        current_job = nil
    end
    if timer then
        pcall(function()
            timer:stop()
            timer:close()
        end)
        timer = nil
    end

    local request_body = M.config.build_request(ctx)
    local stdout_lines = {}
    local stderr_lines = {}

    local function finish()
        if not M.is_enabled() then
            callback({ items = {}, isIncomplete = false })
            return
        end
        local items = M.config.parse_response(stdout_lines)
        callback({
            items = items,
            isIncomplete = false,
        })
    end

    -- Debounce the OpenCode call
    timer = vim.loop.new_timer()
    timer:start(M.config.debounce_ms, 0, vim.schedule_wrap(function()
        if timer then
            pcall(function()
                timer:stop()
                timer:close()
            end)
            timer = nil
        end

        current_job = vim.fn.jobstart(M.config.command, {
            on_stdout = function(_, data)
                if data then
                    vim.list_extend(stdout_lines, data)
                end
            end,
            on_stderr = function(_, data)
                if data then
                    vim.list_extend(stderr_lines, data)
                end
            end,
            on_exit = function(_, code)
                current_job = nil
                if code ~= 0 and #stdout_lines == 0 then
                    -- Command failed and produced no usable output
                    callback({ items = {}, isIncomplete = false })
                    return
                end
                finish()
            end,
        })

        if current_job <= 0 then
            current_job = nil
            callback({ items = {}, isIncomplete = false })
            return
        end

        -- Feed context via stdin and close it so the process terminates
        vim.fn.chansend(current_job, request_body)
        vim.fn.chanclose(current_job, "stdin")
    end))
end

M.source = source

return M
