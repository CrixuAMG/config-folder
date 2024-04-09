return {
    "mistricky/codesnap.nvim",
    build = "make",
    config = function ()
        require("codesnap").setup({
            has_breadcrumbs = true,
            bg_theme = "peach"
        })
    end
}

