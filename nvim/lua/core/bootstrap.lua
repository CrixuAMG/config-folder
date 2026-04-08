local M = {}

local pack_path = vim.fn.stdpath("config") .. "/pack/plugins"

function M.bootstrap()
    local plugins = require("core.plugins")
    local needs_reload = false

    for _, plugin in ipairs(plugins) do
        local name = plugin.name or plugin.repo:match(".*/(.*)")
        local path = string.format("%s/%s/%s", pack_path, plugin.type, name)

        if vim.fn.empty(vim.fn.glob(path)) > 0 then
            print("Cloning " .. name .. "...")
            local url = "https://github.com/" .. plugin.repo
            vim.fn.system({ "git", "clone", "--depth", "1", url, path })
            needs_reload = true
        end

        -- Ensure plugin is on the RTP
        if vim.fn.empty(vim.fn.glob(path)) == 0 then
            vim.cmd("packadd " .. name)
        end

        -- Handle lazy loading logic for 'opt' plugins
        if plugin.type == "opt" then
            if plugin.ft then
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = plugin.ft,
                    callback = function()
                        vim.cmd("packadd " .. name)
                    end,
                })
            end
            if plugin.cmd then
                -- Handle both string and table cmd values
                local cmd_name = type(plugin.cmd) == "table" and plugin.cmd[1] or plugin.cmd
                vim.api.nvim_create_user_command(cmd_name, function(opts)
                    vim.cmd("packadd " .. name)
                    if type(plugin.cmd) == "table" then
                        -- For table cmd, use the first command and pass args
                        vim.cmd(table.concat({plugin.cmd[1], opts.args}, " "))
                    else
                        -- For string cmd, use as before
                        vim.cmd(plugin.cmd .. " " .. opts.args)
                    end
                end, { nargs = "*" })
            end
        end
    end

    if needs_reload then
        print("Plugins installed. Please restart Neovim.")
    end
end

function M.update()
    local plugins = require("core.plugins")
    for _, plugin in ipairs(plugins) do
        local name = plugin.name or plugin.repo:match(".*/(.*)")
        local path = string.format("%s/%s/%s", pack_path, plugin.type, name)
        if vim.fn.empty(vim.fn.glob(path)) == 0 then
            print("Updating " .. name .. "...")
            vim.fn.system({ "git", "-C", path, "pull" })
        end
    end
    print("Update complete.")
end

vim.api.nvim_create_user_command("PlugUpdate", M.update, {})

return M
