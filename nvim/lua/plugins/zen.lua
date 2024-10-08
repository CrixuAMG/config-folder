return {
    {
        "folke/twilight.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            options = {
                enabled = true,
                ruler = false,   -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
                -- you may turn on/off statusline in zen mode by setting 'laststatus'
                -- statusline will be shown only if 'laststatus' == 3
                laststatus = 0, -- turn off the statusline in zen mode
            },
            plugins = {
                twilight = {
                    enabled = true
                },
                todo = { enabled = false },
                gitsigns = { enabled = false },
                kitty = {
                    enabled = true,
                    font = "+4", -- font size increment
                },
            }
        },
        config = function()
            vim.keymap.set('n', 'zm', function() require("zen-mode").toggle() end, { desc = "Toggle zenmode" })
        end
    }
}
