local function parse_env_vars(filepath)
    local env = {}
    local file = io.open(filepath, "r")
    if not file then return env end

    for line in file:lines() do
        line = line:gsub("%s*#.*$", "")
        line = line:match("^%s*(.-)%s*$")
        if line and line ~= "" then
            local key, value = line:match("^export%s+([%w_]+)%s*=%s*(.*)$")
            if not key then
                key, value = line:match("^([%w_]+)%s*=%s*(.*)$")
            end
            if key and value then
                value = value:gsub("^['\"](.-)['\"]$", "%1")
                env[key] = value
            end
        end
    end
    file:close()
    return env
end

local function url_encode(s)
    return s and s:gsub("[^a-zA-Z0-9_.~-]", function(c)
        return string.format("%%%02X", string.byte(c))
    end) or ""
end

local function build_dadbod_connections()
    local cwd = vim.fn.getcwd()
    local env = parse_env_vars(cwd .. "/.env")
    local env_local = parse_env_vars(cwd .. "/.env.local")

    for k, v in pairs(env_local) do
        env[k] = v
    end

    if vim.tbl_isempty(env) then return {} end

    local project = vim.fn.fnamemodify(cwd, ":t")
    local url = env["DATABASE_URL"]
        or string.format("mysql://%s:%s@%s:%s/%s",
            env.DATABASE_USER or "root",
            url_encode(env.DATABASE_PASSWORD or ""),
            env.DATABASE_HOST or "127.0.0.1",
            env.DATABASE_PORT or "3306",
            env.DATABASE_NAME or "")

    return { [project] = { url = url } }
end

vim.api.nvim_create_user_command("DadbodReload", function()
    local c = build_dadbod_connections()
    if not vim.tbl_isempty(c) then
        vim.g.dadbod = c
        vim.notify("Dadbod connections loaded from .env", vim.log.levels.INFO)
    else
        vim.notify("No .env found in " .. vim.fn.getcwd(), vim.log.levels.WARN)
    end
end, { desc = "Reload dadbod connections from .env" })

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("DadbodEnv", { clear = true }),
    callback = function()
        local connections = build_dadbod_connections()
        if not vim.tbl_isempty(connections) then
            vim.g.dadbod = connections
        end
    end,
})

local map = vim.keymap.set

map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle dadbod UI" })
map("n", "<leader>dq", "<cmd>DB<CR>", { desc = "Dadbod query" })
map("n", "<leader>dr", "<cmd>DadbodReload<CR>", { desc = "Reload dadbod .env connections" })

map("x", "<leader>dq", ":DB<CR>", { desc = "Run selected text as dadbod query" })

return {
    { "tpope/vim-dadbod", lazy = false },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = true
        end,
    },
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "tpope/vim-dadbod" },
    },
}
