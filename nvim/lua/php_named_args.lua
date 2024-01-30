local M = {}

local function get_argument_nodes(args_node)
    local args = {}
    for child in args_node:iter_children() do
        if child:type() == "argument" then
            table.insert(args, child)
        end
    end
    return args
end

local function extract_param_name(label)
    -- Remove default value part if any
    local clean = label:match("^([^=]+)") or label
    clean = vim.trim(clean)
    -- Try to capture the variable name ($foo -> foo)
    local name = clean:match("%$([%w_]+)$") or clean:match("%$([%w_]+)")
    if not name then
        -- Fallback: last word
        name = clean:match("([%w_]+)$") or clean
    end
    return name
end

local function get_param_names_from_signature(signature)
    local params = {}
    for _, param in ipairs(signature.parameters or {}) do
        local label = param.label
        if type(label) == "string" then
            table.insert(params, extract_param_name(label))
        elseif type(label) == "table" and #label == 2 then
            local sig_label = signature.label or ""
            local param_str = sig_label:sub(label[1] + 1, label[2])
            table.insert(params, extract_param_name(param_str))
        end
    end
    return params
end

local function parse_params_from_label(label)
    local params = {}
    local args_str = label:match("%((.*)%)")
    if not args_str then
        return params
    end
    -- Split by comma (PHP signatures are simple enough for this)
    for part in args_str:gmatch("([^,]+)") do
        table.insert(params, extract_param_name(part))
    end
    return params
end

function M.add_named_args()
    local bufnr = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1 -- 0-indexed for TS and LSP

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "php")
    if not ok or not parser then
        vim.notify("No PHP Treesitter parser found", vim.log.levels.ERROR)
        return
    end

    local tree = parser:parse()[1]
    if not tree then
        vim.notify("Failed to parse PHP file", vim.log.levels.ERROR)
        return
    end

    local root = tree:root()
    local node = root:named_descendant_for_range(row, col, row, col)

    -- Find arguments node and enclosing call node
    local args_node = nil
    local call_node = nil
    while node do
        local nt = node:type()
        if nt == "arguments" then
            args_node = node
        elseif nt == "function_call_expression"
            or nt == "member_call_expression"
            or nt == "scoped_call_expression" then
            call_node = node
            if not args_node then
                for child in node:iter_children() do
                    if child:type() == "arguments" then
                        args_node = child
                        break
                    end
                end
            end
            break
        end
        node = node:parent()
    end

    if not args_node then
        vim.notify("Cursor is not inside a function call's arguments", vim.log.levels.WARN)
        return
    end

    local arg_nodes = get_argument_nodes(args_node)
    if #arg_nodes == 0 then
        vim.notify("No arguments found to name", vim.log.levels.WARN)
        return
    end

    -- Check if any LSP client supports signatureHelp
    local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/signatureHelp" })
    if #clients == 0 then
        vim.notify("No LSP client supporting signatureHelp attached", vim.log.levels.ERROR)
        return
    end

    local params = vim.lsp.util.make_position_params(0)
    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/signatureHelp", params, 1000)
    if not results or vim.tbl_isempty(results) then
        vim.notify("No signature help received from LSP", vim.log.levels.ERROR)
        return
    end

    local signature = nil
    for _, res in pairs(results) do
        if res.result and res.result.signatures and #res.result.signatures > 0 then
            -- Prefer a signature with enough parameters
            for _, sig in ipairs(res.result.signatures) do
                local param_count = #(sig.parameters or {})
                if param_count >= #arg_nodes then
                    signature = sig
                    break
                end
            end
            if not signature then
                signature = res.result.signatures[1]
            end
            break
        end
    end

    if not signature then
        vim.notify("Could not resolve function signature", vim.log.levels.ERROR)
        return
    end

    local param_names = get_param_names_from_signature(signature)
    if #param_names < #arg_nodes then
        local fallback = parse_params_from_label(signature.label or "")
        if #fallback >= #arg_nodes then
            param_names = fallback
        else
            vim.notify(
                "Signature has fewer parameters (" .. #param_names .. ") than arguments (" .. #arg_nodes .. ")",
                vim.log.levels.ERROR
            )
            return
        end
    end

    -- Build edits
    local edits = {}
    for i, arg_node in ipairs(arg_nodes) do
        local name = param_names[i]
        if not name or name == "" then
            goto continue
        end

        local start_row, start_col = arg_node:range()
        -- Check if already named
        local arg_text = vim.treesitter.get_node_text(arg_node, bufnr)
        if arg_text:match("^%s*[%w_]+%s*:") then
            goto continue
        end

        table.insert(edits, {
            row = start_row,
            col = start_col,
            text = name .. ": ",
        })

        ::continue::
    end

    -- Apply from bottom/right to top/left so positions don't shift
    table.sort(edits, function(a, b)
        if a.row ~= b.row then
            return a.row > b.row
        end
        return a.col > b.col
    end)

    for _, edit in ipairs(edits) do
        vim.api.nvim_buf_set_text(bufnr, edit.row, edit.col, edit.row, edit.col, { edit.text })
    end

    if #edits == 0 then
        vim.notify("All arguments already named or no names could be resolved", vim.log.levels.INFO)
    else
        vim.notify("Named " .. #edits .. " argument(s)", vim.log.levels.INFO)
    end
end

return M
