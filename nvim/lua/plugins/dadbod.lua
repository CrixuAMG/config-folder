--- Parse .env bestand en return tabel met key-value pairs
---@param filepath string
---@return table<string, string>
local function parse_env_file(filepath)
    local env = {}
    local file = io.open(filepath, "r")
    if not file then
        return env
    end

    for line in file:lines() do
        -- Skip comments en lege regels
        if not line:match("^%s*#") and line:match("=") then
            local key, value = line:match("^%s*([%w_]+)%s*=%s*(.*)%s*$")
            if key and value then
                -- Strip quotes
                value = value:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
                env[key] = value
            end
        end
    end
    file:close()
    return env
end

--- Detecteer database driver uit version string of driver naam
---@param env table<string, string>
---@return string|nil
local function detect_driver(env)
    local driver = env.DB_CONNECTION or env.DB_DRIVER

    -- Check DATABASE_VERSION voor Doctrine/Symfony stijl
    local version = env.DATABASE_VERSION or ""
    if version:lower():match("mariadb") then
        return "mysql"
    elseif version:lower():match("mysql") then
        return "mysql"
    elseif version:lower():match("postgres") then
        return "postgresql"
    elseif version:lower():match("sqlite") then
        return "sqlite"
    end

    return driver
end

--- Bouw database URL van losse componenten
---@param env table<string, string>
---@return string|nil
local function build_db_url_from_components(env)
    local driver = detect_driver(env)
    -- Ondersteun zowel DB_* (Laravel) als DATABASE_* (Doctrine/Symfony)
    local host = env.DB_HOST or env.DATABASE_HOST
    local port = env.DB_PORT or env.DATABASE_PORT
    local database = env.DB_DATABASE or env.DB_NAME or env.DATABASE_NAME
    local username = env.DB_USERNAME or env.DB_USER or env.DATABASE_USER
    local password = env.DB_PASSWORD or env.DB_PASS or env.DATABASE_PASSWORD

    if not database then
        return nil
    end

    -- SQLite heeft geen host/user/pass nodig
    if driver == "sqlite" or driver == "sqlite3" then
        return string.format("sqlite:%s", database)
    end

    -- Geen driver maar wel host? Neem mysql aan
    if not driver and host then
        driver = "mysql"
    end

    if not driver then
        return nil
    end

    -- MySQL/MariaDB
    if driver == "mysql" or driver == "mariadb" then
        local url = "mysql://"
        if username then
            url = url .. username
            if password and password ~= "" then
                url = url .. ":" .. password
            end
            url = url .. "@"
        end
        url = url .. (host or "localhost")
        if port then
            url = url .. ":" .. port
        end
        url = url .. "/" .. database
        return url
    end

    -- PostgreSQL
    if driver == "pgsql" or driver == "postgres" or driver == "postgresql" then
        local url = "postgresql://"
        if username then
            url = url .. username
            if password and password ~= "" then
                url = url .. ":" .. password
            end
            url = url .. "@"
        end
        url = url .. (host or "localhost")
        if port then
            url = url .. ":" .. port
        end
        url = url .. "/" .. database
        return url
    end

    return nil
end

--- Laad database connecties uit .env bestand
---@return table[]
local function load_dbs_from_env()
    local dbs = {}
    local cwd = vim.fn.getcwd()
    local env_path = cwd .. "/.env"

    local env = parse_env_file(env_path)
    if vim.tbl_isempty(env) then
        return dbs
    end

    -- Check voor DATABASE_URL eerst (standaard in veel frameworks)
    local db_url = env.DATABASE_URL or env.DB_URL
    if db_url then
        table.insert(dbs, {
            name = "[env] " .. (env.DB_DATABASE or env.DB_NAME or "database"),
            url = db_url,
        })
        return dbs
    end

    -- Anders, bouw URL van losse componenten
    local url = build_db_url_from_components(env)
    if url then
        table.insert(dbs, {
            name = "[env] " .. (env.DB_DATABASE or env.DB_NAME or "database"),
            url = url,
        })
    end

    return dbs
end

return {
    {
        "tpope/vim-dadbod",
        cmd = "DB",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "tpope/vim-dotenv", lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        keys = {
            { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
            { "<leader>De", function()
                local dbs = load_dbs_from_env()
                if #dbs == 0 then
                    vim.notify("Geen database config gevonden in .env", vim.log.levels.WARN)
                    return
                end
                vim.g.dbs = dbs
                vim.notify("Geladen: " .. dbs[1].name, vim.log.levels.INFO)
                vim.cmd("DBUIToggle")
            end, desc = "Load DB from .env" },
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 1

            -- Gebruik bestaande window voor nieuwe buffers (overschrijf pane)
            vim.g.db_ui_use_nvim_notify = 1
            vim.g.db_ui_execute_on_save = 0

            -- Bewaar queries in project-specifieke folder
            vim.g.db_ui_save_location = vim.fn.getcwd() .. "/.db_queries"

            -- Auto-load .env bij opstarten indien aanwezig
            local dbs = load_dbs_from_env()
            if #dbs > 0 then
                vim.g.dbs = dbs
            end

            -- Tabel helpers voor snelle queries
            vim.g.db_ui_table_helpers = {
                mysql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Structure = "DESCRIBE {table}",
                    Indexes = "SHOW INDEX FROM {table}",
                },
                sqlite = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Structure = "PRAGMA table_info({table})",
                    Indexes = "PRAGMA index_list({table})",
                },
            }

            -- Autocmd groep voor DBUI gedrag
            local dbui_group = vim.api.nvim_create_augroup("DbUI", { clear = true })

            -- Sluit andere dbout buffers bij openen nieuwe (overschrijf gedrag)
            vim.api.nvim_create_autocmd("BufReadPost", {
                group = dbui_group,
                pattern = "*.dbout",
                callback = function(args)
                    -- Vind en sluit andere dbout buffers
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if buf ~= args.buf and vim.api.nvim_buf_is_loaded(buf) then
                            local name = vim.api.nvim_buf_get_name(buf)
                            if name:match("%.dbout$") then
                                vim.api.nvim_buf_delete(buf, { force = true })
                            end
                        end
                    end
                    -- Vergroot result window
                    vim.defer_fn(function()
                        local win = vim.fn.bufwinid(args.buf)
                        if win ~= -1 then
                            vim.api.nvim_win_set_height(win, 25)
                        end
                    end, 50)
                end,
            })

            -- Auto-expand result folds en sticky header
            vim.api.nvim_create_autocmd("FileType", {
                group = dbui_group,
                pattern = "dbout",
                callback = function(args)
                    vim.opt_local.foldenable = false
                    vim.opt_local.foldmethod = "manual"

                    -- Sticky header: maak split met kolomnamen
                    vim.defer_fn(function()
                        local buf = args.buf
                        local win = vim.fn.bufwinid(buf)
                        if win == -1 then return end

                        -- Haal eerste 3 regels op (header)
                        local lines = vim.api.nvim_buf_get_lines(buf, 0, 3, false)
                        if #lines < 3 then return end

                        -- Maak header buffer
                        local header_buf = vim.api.nvim_create_buf(false, true)
                        vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, lines)
                        vim.api.nvim_set_option_value("modifiable", false, { buf = header_buf })
                        vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = header_buf })
                        vim.api.nvim_set_option_value("filetype", "dbout", { buf = header_buf })

                        -- Split bovenaan voor header
                        vim.api.nvim_set_current_win(win)
                        vim.cmd("aboveleft split")
                        local header_win = vim.api.nvim_get_current_win()
                        vim.api.nvim_win_set_buf(header_win, header_buf)
                        vim.api.nvim_win_set_height(header_win, 3)

                        -- Header window opties
                        vim.api.nvim_set_option_value("winfixheight", true, { win = header_win })
                        vim.api.nvim_set_option_value("scrolloff", 0, { win = header_win })
                        vim.api.nvim_set_option_value("cursorline", false, { win = header_win })
                        vim.api.nvim_set_option_value("number", false, { win = header_win })
                        vim.api.nvim_set_option_value("relativenumber", false, { win = header_win })
                        vim.api.nvim_set_option_value("signcolumn", "no", { win = header_win })

                        -- Terug naar data window en scroll voorbij header
                        vim.api.nvim_set_current_win(win)
                        vim.api.nvim_win_set_cursor(win, { 4, 0 })
                        vim.cmd("normal! zt")

                        -- Sync horizontale scroll tussen header en data
                        vim.api.nvim_create_autocmd("WinScrolled", {
                            buffer = buf,
                            callback = function()
                                if not vim.api.nvim_win_is_valid(header_win) then return true end
                                local leftcol = vim.fn.winsaveview().leftcol
                                vim.api.nvim_win_call(header_win, function()
                                    vim.fn.winrestview({ leftcol = leftcol })
                                end)
                            end,
                        })

                        -- Sluit header wanneer data buffer sluit
                        vim.api.nvim_create_autocmd("BufWipeout", {
                            buffer = buf,
                            callback = function()
                                if vim.api.nvim_buf_is_valid(header_buf) then
                                    vim.api.nvim_buf_delete(header_buf, { force = true })
                                end
                            end,
                        })
                    end, 100)
                end,
            })
        end,
    },
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "vim-dadbod" },
        ft = { "sql", "mysql", "plsql" },
    },
    -- Blink.cmp source voor dadbod completions
    {
        "saghen/blink.cmp",
        optional = true,
        dependencies = {
            "kristijanhusak/vim-dadbod-completion",
        },
        opts = {
            sources = {
                default = { "dadbod" },
                providers = {
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                        fallbacks = { "buffer" },
                    },
                },
            },
        },
    },
}
