return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        adapters = {
            opencode = function()
                return require("codecompanion.adapters").extend("opencode", {})
            end,
        },

        interactions = {
            chat = {
                adapter = "opencode",
            },
            inline = {
                adapter = "opencode",
            },
            cmd = {
                adapter = "opencode",
            },
        },

        log_level = "DEBUG",
    },
    config = function(_, opts)
        require("codecompanion").setup(opts)

        -- Keymaps for CodeCompanion
        local set = vim.keymap.set

        set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat<cr>", {
            desc = "OpenCode Chat",
            noremap = true,
        })

        set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", {
            desc = "OpenCode Inline",
            noremap = true,
        })

        set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", {
            desc = "OpenCode Actions",
            noremap = true,
        })

        set("v", "<leader>ce", "<cmd>CodeCompanion /explain<cr>", {
            desc = "OpenCode Explain",
            noremap = true,
        })

        set("v", "<leader>cf", "<cmd>CodeCompanion /fix<cr>", {
            desc = "OpenCode Fix",
            noremap = true,
        })
    end,
}
