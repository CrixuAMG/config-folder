return {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        filesystem = {
            filtered_items = {
                --visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    ".github",
                },
                never_show = { ".git" },
            },
        },
    },
}
