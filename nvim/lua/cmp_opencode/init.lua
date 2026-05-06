local M = {}

-- ---------------------------------------------------------------------------
-- Config
-- ---------------------------------------------------------------------------

M.config = {
    enabled = true,

    model = "qwen2.5-coder:7b",

    model_args = {
        "--temperature", "0.2",
        "--max-tokens", "256",
        "--top-p", "0.9",
    },

    command = { "opencode", "complete" },

    debounce_ms = 80,
    timeout = 3000,
    min_keyword_length = 0,

    multiline = {
        enabled = true,
        eager = true,
        debounce_ms = 200,
        max_lines = 10,
        accept_keymap = "<M-Tab>",
        dismiss_keymap = "<M-e>",
    },

    -- 🚀 FIM request (BELANGRIJKSTE FIX)
    build_request = function(context)
        local bufnr = context.bufnr
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        local row = context.cursor.row
        local col = context.cursor.col

        local before = vim.list_slice(lines, 1, row)
        local after = vim.list_slice(lines, row + 1, #lines)

        local current = lines[row] or ""

        local prefix =
            table.concat(before, "\n") ..
            "\n" ..
            current:sub(1, col)

        local suffix =
            current:sub(col + 1) ..
            "\n" ..
            table.concat(after, "\n")

        -- Trim voor performance
        prefix = prefix:sub(-3000)

        return vim.json.encode({
            prefix = prefix,
            suffix = suffix,
            filepath = vim.api.nvim_buf_get_name(bufnr),
        })
    end,

    parse_response = function(lines)
        local items = {}
        local text = table.concat(lines, "\n")

        local ok, decoded = pcall(vim.json.decode, text)
        if ok and type(decoded) == "table" then
            if vim.islist(decoded) then
                for _, item in ipairs(decoded) do
                    local t = type(item) == "table" and (item.text or item.label) or item
                    if t then
                        table.insert(items, M._make_item(t, item))
                    end
                end
                return items
            elseif decoded.text or decoded.label then
                table.insert(items, M._make_item(decoded.text or decoded.label, decoded))
                return items
            end
        end

        text = vim.trim(text)
        if text ~= "" then
            table.insert(items, M._make_item(text))
        end

        return items
    end,
}

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

local function build_command()
    local cmd = vim.deepcopy(M.config.command)

    table.insert(cmd, "--model")
    table.insert(cmd, M.config.model)

    for _, arg in ipairs(M.config.model_args) do
        table.insert(cmd, arg)
    end

    return cmd
end

M._make_item = function(text, extra)
    extra = extra or {}

    local is_multiline = text:find("\n") ~= nil

    return {
        label = extra.label or text:gsub("\n", "↳ "),
        insertText = text,
        kind = is_multiline
            and vim.lsp.protocol.CompletionItemKind.Snippet
            or vim.lsp.protocol.CompletionItemKind.Text,
        insertTextFormat = is_multiline
            and vim.lsp.protocol.InsertTextFormat.Snippet
            or nil,
        documentation = extra.documentation,
    }
end

-- ---------------------------------------------------------------------------
-- State
-- ---------------------------------------------------------------------------

local is_enabled = true
local current_job = nil
local timer = nil

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

M.is_enabled = function()
    return is_enabled
end

M.toggle = function()
    is_enabled = not is_enabled
    vim.notify("OpenCode " .. (is_enabled and "enabled" or "disabled"))
end

M.setup = function(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- ---------------------------------------------------------------------------
-- Source
-- ---------------------------------------------------------------------------

local source = {}

function source.new()
    return setmetatable({}, { __index = source })
end

function source.is_available()
    return M.is_enabled()
end

function source.get_trigger_characters()
    return {}
end

function source.complete(_, params, callback)
    if not M.is_enabled() then
        return callback({ items = {} })
    end

    local ctx = params.context
    if #vim.trim(ctx.cursor_before_line) < M.config.min_keyword_length then
        return callback({ items = {} })
    end

    if current_job then
        pcall(vim.fn.jobstop, current_job)
    end

    if timer then
        timer:stop()
        timer:close()
    end

    local stdout = {}
    local request = M.config.build_request(ctx)

    timer = vim.loop.new_timer()
    timer:start(M.config.debounce_ms, 0, vim.schedule_wrap(function()
        timer:stop()
        timer:close()
        timer = nil

        current_job = vim.fn.jobstart(build_command(), {
            on_stdout = function(_, data)
                if data then vim.list_extend(stdout, data) end
            end,
            on_exit = function(_, code)
                current_job = nil

                if code ~= 0 then
                    return callback({ items = {} })
                end

                local items = M.config.parse_response(stdout)

                callback({
                    items = items,
                    isIncomplete = false,
                })
            end,
        })

        if current_job <= 0 then
            current_job = nil
            return callback({ items = {} })
        end

        vim.fn.chansend(current_job, request)
        vim.fn.chanclose(current_job, "stdin")
    end))
end

M.source = source

return M
