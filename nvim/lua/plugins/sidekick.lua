return {
    "folke/sidekick.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    opts = {
        cli = {
            tools = {
                opencode = {},
            },
        },
    },
    keys = {
        {
            "<leader>aa",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            desc = "Select CLI",
        },
        {
            "<leader>ap",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
        {
            "<leader>ao",
            function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
            desc = "Sidekick Toggle OpenCode",
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function() require("sidekick.cli").send({ msg = "{file}" }) end,
            desc = "Send File",
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<c-.>",
            function() require("sidekick.cli").focus() end,
            desc = "Sidekick Focus",
            mode = { "n", "t", "i", "x" },
        },
    },
}
