return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        adapters = {
            acp = {
                opencode = function()
                    return require("codecompanion.adapters").extend("opencode", {
                        command = "opencode",
                        args = { "acp" },
                    })
                end,
            },
        },

        interactions = {
            chat = {
                adapter = "opencode",
            },
        },

        log_level = "DEBUG",
    },
}
