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

       vim.keymap.set({"x","s"}, "<leader>ss", ":CodeSnap<cr>", { desc = "Take a Codesnap screenshot", silent=true })
    end
}
