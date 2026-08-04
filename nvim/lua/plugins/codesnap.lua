return {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0",
    event = "BufReadPre",
    init = function()
        -- Prefer downloaded platform library over stale generator.so from another architecture.
        local uname = (vim.uv or vim.loop).os_uname()
        local os = uname.sysname == "Darwin" and "mac" or uname.sysname:lower()
        local arch = uname.machine == "arm64" and "aarch64" or uname.machine:lower()
        local library = vim.fn.stdpath("data")
            .. "/lazy/codesnap.nvim/lua/libs/"
            .. os
            .. "-"
            .. arch
            .. "_generator.so"

        if vim.fn.filereadable(library) == 1 then
            package.preload.generator = function()
                return assert(package.loadlib(library, "luaopen_generator"))()
            end
        end
    end,
    config = function ()
        require("codesnap").setup({
            mac_window_bar = true,
            has_breadcrumbs = true,
            has_line_number = true,
            bg_theme = "peach"
        })

        local function copy_snapshot_to_kitty()
            local path = "/tmp/codesnap.nvim.png"
            local config = require("codesnap.config").get_config()
            local generator = require("generator")

            local ok, err = pcall(generator.save, path, config)
            if not ok then
                vim.notify("CodeSnap failed: " .. tostring(err), vim.log.levels.ERROR)
                return
            end

            local encoded = vim.fn.system({ "base64", path }):gsub("%s", "")
            if vim.v.shell_error ~= 0 then
                vim.notify("Could not encode CodeSnap PNG", vim.log.levels.ERROR)
                return
            end

            local mime = vim.base64.encode("image/png")
            local packet = "\027]5522;type=write\027\\"
            for index = 1, #encoded, 5460 do
                packet = packet
                    .. "\027]5522;type=wdata:mime="
                    .. mime
                    .. ";"
                    .. encoded:sub(index, index + 5459)
                    .. "\027\\"
            end
            packet = packet .. "\027]5522;type=wdata\027\\"
            vim.api.nvim_ui_send(packet)
            vim.cmd("delmarks <>")
            vim.notify("CodeSnap screenshot copied to clipboard")
        end

        vim.keymap.set({ "x", "s" }, "<leader>ss", copy_snapshot_to_kitty, {
            desc = "Take a Codesnap screenshot",
            silent = true,
        })
    end
}
