return {
    "mistricky/codesnap.nvim",
    build = "make",
    config = function ()
        require("codesnap").setup({
            mac_window_bar = false,
            has_breadcrumbs = true,
            bg_theme = "peach"
        })
    end
}

