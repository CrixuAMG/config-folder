return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    -- '.git',
                    -- '.DS_Store',
                    -- 'thumbs.db',
                },
                never_show = {},
            },
            window = {
                mappings = {
                    ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
                    ["i"] = "show_fs_stat",
                }
            },
            commands = {
                show_fs_stat = function(state)
                    local node = state.tree:get_node()
                    local stat = vim.loop.fs_stat(node.path)
                    local str = ""
                    str = str .. string.format("Type: %s\n", stat.type)
                    str = str .. string.format("Size: %s\n", utils.format_size(stat.size))
                    str = str .. string.format("Time: %s\n", utils.format_time(stat.mtime.sec))
                    str = str .. string.format("Mode: %s\n", utils.format_mode(stat.mode, stat.type))
                    vim.notify(str)
                end,
            },
        },
    },
    config = function()
        vim.keymap.set('n', '<leader>nt', ':Neotree filesystem toggle left <CR>', {})
        vim.keymap.set('n', '<leader>nf', ':Neotree filesystem focus left <CR>', {})
        vim.keymap.set('n', '<leader>nn', ':Neotree filesystem close <CR>', {})
        vim.keymap.set('n', '<leader>nr', ':Neotree filesystem reveal left <CR>', {})
    end
}
