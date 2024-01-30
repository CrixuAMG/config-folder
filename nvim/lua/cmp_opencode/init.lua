local M = {}

-- ============================================================================
-- CONFIG
-- ============================================================================

M.config = {
    enabled = true,

    server_url = "http://127.0.0.1:4096",

    model = "ollama/qwen2.5-coder:7b",

    debounce_ms = 120,
    timeout = 10000,

    log_file = vim.fn.stdpath("cache")
        .. "/opencode-cmp.log",

    filetypes = {
        php = true,
        lua = true,
        javascript = true,
        typescript = true,
        python = true,
    },

    context = {
        max_prefix_chars = 6000,
    },

    generation = {
        temperature = 0.15,
        top_p = 0.95,
        max_tokens = 128,
    },
}

-- ============================================================================
-- STATE
-- ============================================================================

local enabled = true
local current_job = nil
local current_timer = nil

-- ============================================================================
-- LOGGING
-- ============================================================================

local function append_log(lines)
    vim.fn.writefile(
        lines,
        M.config.log_file,
        "a"
    )
end

local function log(...)
    local parts = {}

    for i = 1, select("#", ...) do
        local value = select(i, ...)

        if type(value) == "table" then
            value = vim.inspect(value)
        else
            value = tostring(value)
        end

        table.insert(parts, value)
    end

    append_log({
        os.date("[%Y-%m-%d %H:%M:%S] ")
            .. table.concat(parts, " ")
    })
end

local function log_block(title, content)
    local lines = {
        "",
        ("========== %s =========="):format(
            title
        ),
    }

    if type(content) == "string" then
        vim.list_extend(
            lines,
            vim.split(content, "\n", {
                plain = true,
            })
        )
    else
        table.insert(lines, vim.inspect(content))
    end

    table.insert(
        lines,
        "==================================="
    )

    table.insert(lines, "")

    append_log(lines)
end

local function clear_log()
    vim.fn.writefile({}, M.config.log_file)
end

-- ============================================================================
-- HELPERS
-- ============================================================================

local function sanitize(text)
    text = text or ""

    text = text:gsub("^```[%w]*\n", "")
    text = text:gsub("\n```$", "")

    return vim.trim(text)
end

local function get_context(ctx)
    local prefix =
        ctx.cursor_before_line or ""

    local suffix =
        ctx.cursor_after_line or ""

    prefix = prefix:sub(
        -M.config.context.max_prefix_chars
    )

    return prefix, suffix
end

local function build_prompt(ctx)
    local prefix, suffix =
        get_context(ctx)

    return table.concat({
        "<|fim_prefix|>",
        prefix,
        "<|fim_suffix|>",
        suffix,
        "<|fim_middle|>",
    }, "\n")
end

local function build_body(prompt)
    return vim.json.encode({
        model = M.config.model,

        prompt = prompt,

        stream = false,

        options = {
            temperature =
                M.config.generation.temperature,

            top_p =
                M.config.generation.top_p,

            num_predict =
                M.config.generation.max_tokens,
        },
    })
end

local function build_command(body)
    return {
        "curl",

        "-s",

        "-X",
        "POST",

        M.config.server_url .. "/api/generate",

        "-H",
        "Content-Type: application/json",

        "-d",
        body,
    }
end

local function make_item(text)
    local multiline =
        text:find("\n") ~= nil

    return {
        label = text:gsub("\n", " ↩ "),

        insertText = text,

        filterText = "",

        kind = multiline
            and vim.lsp.protocol
                .CompletionItemKind.Snippet
            or vim.lsp.protocol
                .CompletionItemKind.Text,

        insertTextFormat = multiline
            and vim.lsp.protocol
                .InsertTextFormat.Snippet
            or vim.lsp.protocol
                .InsertTextFormat.PlainText,
    }
end

local function parse_response(lines)
    local raw = table.concat(lines, "\n")

    log_block("RAW RESPONSE", raw)

    if raw == "" then
        log("EMPTY RESPONSE")

        return {}
    end

    local ok, decoded =
        pcall(vim.json.decode, raw)

    if not ok then
        log("JSON PARSE FAILED")

        return {}
    end

    local text =
        decoded.response
        or decoded.content
        or decoded.text

    if not text then
        log("NO TEXT FIELD FOUND")

        return {}
    end

    text = sanitize(text)

    if text == "" then
        log("EMPTY COMPLETION")

        return {}
    end

    log_block("COMPLETION", text)

    return {
        make_item(text),
    }
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

function M.setup(opts)
    M.config = vim.tbl_deep_extend(
        "force",
        M.config,
        opts or {}
    )

    clear_log()

    log("OPENCODE CMP INITIALIZED")
    log("SERVER:", M.config.server_url)
    log("MODEL:", M.config.model)
end

function M.toggle()
    enabled = not enabled

    vim.notify(
        ("OpenCode completion %s"):format(
            enabled and "enabled"
                or "disabled"
        )
    )

    log(
        "TOGGLE:",
        enabled and "enabled"
            or "disabled"
    )
end

function M.is_enabled()
    return enabled
end

function M.open_log()
    vim.cmd(
        "edit "
            .. vim.fn.fnameescape(
                M.config.log_file
            )
    )
end

-- ============================================================================
-- SOURCE
-- ============================================================================

local source = {}

function source.new()
    return setmetatable({}, {
        __index = source,
    })
end

function source:is_available()
    return enabled
end

function source:get_trigger_characters()
    return {
        ".", ":", ">", "$",
        "(", "{", "[",
        " ", "\n",
    }
end

function source:complete(params, callback)
    if not enabled then
        return callback({
            items = {},
        })
    end

    local ctx = params.context

    if not M.config.filetypes[ctx.filetype] then
        return callback({
            items = {},
        })
    end

    log("")
    log(
        "========================================"
    )

    log("COMPLETE REQUEST")
    log("FILETYPE:", ctx.filetype)
    log("BEFORE:", ctx.cursor_before_line)

    if current_job then
        pcall(vim.fn.jobstop, current_job)

        current_job = nil
    end

    if current_timer then
        current_timer:stop()
        current_timer:close()

        current_timer = nil
    end

    local prompt = build_prompt(ctx)

    log_block("PROMPT", prompt)

    local body = build_body(prompt)

    log_block("REQUEST BODY", body)

    local stdout = {}

    current_timer = vim.loop.new_timer()

    current_timer:start(
        M.config.debounce_ms,
        0,
        vim.schedule_wrap(function()
            current_timer:stop()
            current_timer:close()

            current_timer = nil

            local cmd =
                build_command(body)

            log_block(
                "CURL COMMAND",
                vim.inspect(cmd)
            )

            current_job = vim.fn.jobstart(
                cmd,
                {
                    stdout_buffered = true,

                    on_stdout = function(_, data)
                        if not data then
                            return
                        end

                        vim.list_extend(
                            stdout,
                            data
                        )
                    end,

                    on_stderr = function(_, data)
                        if not data then
                            return
                        end

                        log_block(
                            "STDERR",
                            vim.inspect(data)
                        )
                    end,

                    on_exit = function(_, code)
                        log("JOB EXIT:", code)

                        current_job = nil

                        if code ~= 0 then
                            log("REQUEST FAILED")

                            return callback({
                                items = {},
                            })
                        end

                        local items =
                            parse_response(
                                stdout
                            )

                        log(
                            "ITEM COUNT:",
                            #items
                        )

                        callback({
                            items = items,
                            isIncomplete = false,
                        })
                    end,
                }
            )

            if current_job <= 0 then
                log("FAILED TO START JOB")

                current_job = nil

                return callback({
                    items = {},
                })
            end

            log(
                "JOB STARTED:",
                current_job
            )
        end)
    )
end

-- ============================================================================
-- EXPORT
-- ============================================================================

M.source = source

return M
