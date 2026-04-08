local M = {}

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

function M.setup()
    vim.keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
    vim.keymap.set("n", "<leader>De", function()
        local dbs = load_dbs_from_env()
        if #dbs == 0 then
            vim.notify("Geen database config gevonden in .env", vim.log.levels.WARN)
            return
        end
        vim.g.dbs = dbs
        vim.notify("Geladen: " .. dbs[1].name, vim.log.levels.INFO)
        vim.cmd("DBUIToggle")
    end, { desc = "Load DB from .env" })

    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_execute_on_save = 0

    -- Vaste opslag voor queries, niet afhankelijk van cwd
    vim.g.db_ui_save_location = vim.fn.expand("~/.local/share/nvim/db_queries")

    -- Auto-load .env bij opstarten indien aanwezig
    local dbs = load_dbs_from_env()
    if #dbs > 0 then
        vim.g.dbs = dbs
    end

    vim.g.db_ui_table_helpers = {
        mysql = {
            Count = "SELECT COUNT(*) FROM {table}",
            Indexes = "SHOW INDEX FROM {table}",
            Structure = "DESCRIBE {table}",
        },
        postgresql = {
            Count = "SELECT COUNT(*) FROM {table}",
            Indexes = "SELECT indexname, indexdef FROM pg_indexes WHERE tablename = '{table}'",
            Structure = "\\d {table}",
        },
        sqlite = {
            Count = "SELECT COUNT(*) FROM {table}",
            Indexes = "PRAGMA index_list({table})",
            Structure = "PRAGMA table_info({table})",
        },
    }

    -- DirChanged: herlaad .env connecties als je van project wisselt
    vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
            local dbs = load_dbs_from_env()
            if #dbs > 0 then
                vim.g.dbs = dbs
            end
        end,
    })

    local dbui_group = vim.api.nvim_create_augroup("DbUI", { clear = true })

    -- Resultaat venster: folds uit, nowrap, comfortabele hoogte
    vim.api.nvim_create_autocmd("FileType", {
        group = dbui_group,
        pattern = "dbout",
        callback = function()
            vim.opt_local.foldenable = false
            vim.opt_local.wrap = false
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = "no"
            -- Vergroot venster zodat resultaten goed leesbaar zijn
            local win = vim.api.nvim_get_current_win()
            local total = vim.o.lines
            local target = math.floor(total * 0.4)
            vim.api.nvim_win_set_height(win, target)
        end,
    })

    -- SQL query buffer: handige lokale keymaps
    vim.api.nvim_create_autocmd("FileType", {
        group = dbui_group,
        pattern = { "sql", "mysql", "plsql" },
        callback = function(args)
            -- Voer selectie uit met <leader>S in visual mode
            vim.keymap.set("v", "<leader>S", ":'<,'>DB<CR>", {
                buffer = args.buf,
                desc = "Voer geselecteerde SQL uit",
                silent = true,
            })
            -- Schakel omnifunc in voor SQL bestanden
            vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
        end,
    })
end

return M
